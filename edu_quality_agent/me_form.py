"""
Me-Form 解析：将「我 / 我们学院 / 我关注的」转为带权限边界的物理 ID 过滤条件
"""

from __future__ import annotations

import re
from typing import Any

from edu_quality_agent.state import ResolvedFilters, UserProfile, UserRole


# 口语代词 → 解析策略
ME_PATTERNS = [
    (re.compile(r"我(?:的)?"), "self"),
    (re.compile(r"我们(?:学院|院系|单位)"), "own_college"),
    (re.compile(r"本院|我院"), "own_college"),
    (re.compile(r"全校"), "all_school"),
    (re.compile(r"我(?:重点)?关注(?:的)?(?:课程|老师|教师)?"), "watched"),
    (re.compile(r"我下周|我本周|我的听课"), "self_supervision_tasks"),
]


def resolve_me_form(query: str, profile: UserProfile) -> tuple[str, ResolvedFilters]:
    """
    返回 (rewritten_query, resolved_filters)。
    原则：
    1. 只收窄到用户 org_scope 内，绝不扩大权限。
    2. 「全校」仅校领导可解析；院领导/督导尝试则回落到 org_scope_ids。
    3. 重写后的 query 供 LLM 使用，物理条件写入 resolved_filters 供 SQL 参数化。
    """
    filters = ResolvedFilters()
    rewritten = query

    for pattern, kind in ME_PATTERNS:
        if not pattern.search(query):
            continue

        if kind == "self":
            # 「我的听课任务」vs「我的评教得分」由下游 intent 区分；此处标记 user_id
            filters.teacher_user_id = None  # 被评场景不用 user_id 当 teacher
            rewritten = pattern.sub(
                f"用户[{profile.display_name}|ID={profile.user_id}]",
                rewritten,
                count=1,
            )

        elif kind == "own_college":
            cid = profile.college_id
            if cid is None:
                continue
            if not profile.can_access_college(cid):
                raise PermissionError("无权访问该学院数据")
            filters.college_id = cid
            filters.college_ids = [cid]
            rewritten = pattern.sub(f"学院[ID={cid}]", rewritten, count=1)

        elif kind == "all_school":
            if profile.role != UserRole.SCHOOL_LEADER:
                # 非校领导：「全校」降级为可访问范围
                filters.college_ids = list(profile.org_scope_ids)
                rewritten = pattern.sub(
                    f"可访问院系范围{profile.org_scope_ids}", rewritten, count=1
                )
            else:
                filters.college_ids = []  # 空表示不限制学院

        elif kind == "watched":
            filters.course_ids = list(profile.watched_course_ids)
            rewritten = pattern.sub(
                f"重点关注课程IDs={profile.watched_course_ids}", rewritten, count=1
            )

        elif kind == "self_supervision_tasks":
            filters.include_self_tasks = True
            rewritten = pattern.sub(
                f"督导用户[ID={profile.user_id}]的听课任务", rewritten, count=1
            )

    # 默认学院范围：院领导/督导未指定学院时，implicit scope
    if not filters.college_ids and profile.role != UserRole.SCHOOL_LEADER:
        filters.college_ids = list(profile.org_scope_ids)

    return rewritten, filters


def filters_to_sql_params(filters: ResolvedFilters, profile: UserProfile) -> dict[str, Any]:
    """生成只读查询参数 dict，禁止字符串拼接进 SQL"""
    params: dict[str, Any] = {
        "tenant_id": profile.tenant_id,
        "org_scope_ids": profile.org_scope_ids or filters.college_ids,
    }
    if filters.college_id is not None:
        params["college_id"] = filters.college_id
    if filters.acte_id is not None:
        params["acte_id"] = filters.acte_id
    if filters.teacher_user_id is not None:
        params["teacher_user_id"] = filters.teacher_user_id
    if filters.include_self_tasks:
        params["sup_user_id"] = profile.user_id
    if filters.course_ids:
        params["course_ids"] = filters.course_ids
    return params
