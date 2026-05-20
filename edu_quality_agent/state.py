"""
全局状态定义 — AI+校务质量监测多 Agent 系统
"""

from __future__ import annotations

import operator
from enum import Enum
from typing import Annotated, Any, Optional

from pydantic import BaseModel, Field


# ---------------------------------------------------------------------------
# 枚举
# ---------------------------------------------------------------------------


class UserRole(str, Enum):
    SUPERVISOR = "supervisor"       # 教学质量督导
    COLLEGE_LEADER = "college_leader"  # 院领导
    SCHOOL_LEADER = "school_leader"    # 校领导


class IntentCategory(str, Enum):
    STRUCTURED = "structured_data"
    QUALITATIVE = "qualitative_text"
    HYBRID = "hybrid"               # 结构化 + 质性并行
    CAMPUS_KB = "campus_knowledge"
    BLOCKED = "blocked"


class ClarificationLevel(int, Enum):
    L0_COMPLETE = 0
    L1_SOFT = 1
    L2_HARD = 2
    L3_AMBIGUOUS = 3


class ParallelBranch(str, Enum):
    SQL = "sql"
    TEXT = "text"


# ---------------------------------------------------------------------------
# 用户身份（Me-Form 解析依赖）
# ---------------------------------------------------------------------------


class UserProfile(BaseModel):
    """从 Session / JWT 注入，全程只读（节点不得篡改权限边界）"""

    user_id: str
    user_code: str = ""
    display_name: str = ""
    role: UserRole = UserRole.SUPERVISOR

    # 组织与数据权限 scope（物理 ID，已在校验层解析完毕）
    tenant_id: str = ""
    college_id: Optional[int] = None          # 所属学院
    college_ids: list[int] = Field(default_factory=list)  # 可访问学院列表
    org_scope_ids: list[int] = Field(default_factory=list)  # 行级权限全集

    # 业务上下文
    supervised_teacher_ids: list[int] = Field(default_factory=list)  # 督导关注教师
    watched_course_ids: list[int] = Field(default_factory=list)      # 重点关注课程
    baseline_date: str = "2026-05-20"

    def can_access_college(self, college_id: int) -> bool:
        if self.role == UserRole.SCHOOL_LEADER:
            return True
        return college_id in self.org_scope_ids


class ResolvedFilters(BaseModel):
    """Me-Form 解析后的物理过滤条件（仅含用户有权访问的范围）"""

    teacher_user_id: Optional[int] = None
    teacher_user_ids: list[int] = Field(default_factory=list)
    college_id: Optional[int] = None
    college_ids: list[int] = Field(default_factory=list)
    acte_id: Optional[int] = None
    time_range: Optional[dict[str, str]] = None
    course_ids: list[int] = Field(default_factory=list)
    metric_codes: list[str] = Field(default_factory=list)
    include_self_tasks: bool = False  # 「我下周听课任务」


# ---------------------------------------------------------------------------
# 并行分支产物
# ---------------------------------------------------------------------------


class SqlBranchResult(BaseModel):
    branch: ParallelBranch = ParallelBranch.SQL
    success: bool = False
    sql: str = ""
    rows: list[dict[str, Any]] = Field(default_factory=list)
    row_count: int = 0
    execution_ms: int = 0
    error: Optional[str] = None
    retry_count: int = 0


class TextBranchResult(BaseModel):
    branch: ParallelBranch = ParallelBranch.TEXT
    success: bool = False
    snippets: list[dict[str, str]] = Field(default_factory=list)
    summary: str = ""
    themes: list[str] = Field(default_factory=list)
    sentiment: Optional[str] = None
    error: Optional[str] = None


# ---------------------------------------------------------------------------
# 可观测性快照（写入 log_ai_qa_lifecycle）
# ---------------------------------------------------------------------------


class QaLifecycleLog(BaseModel):
    trace_id: str
    thread_id: str
    tenant_id: str = ""
    user_id: str = ""
    user_role: str = ""

    raw_query: str = ""
    rewritten_query: str = ""
    intent: str = ""
    domains: list[str] = Field(default_factory=list)

    resolved_filters_json: dict[str, Any] = Field(default_factory=dict)
    parallel_branches: list[str] = Field(default_factory=list)

    generated_sql: str = ""
    sql_audit_passed: bool = False
    sql_error: str = ""
    db_execution_ms: int = 0
    sql_retry_count: int = 0

    text_retrieval_count: int = 0
    total_loop_count: int = 0
    clarification_rounds: int = 0

    final_answer: str = ""
    fusion_conflicts: list[str] = Field(default_factory=list)

    user_feedback: Optional[str] = None  # thumbs_up | thumbs_down | rewrite
    feedback_comment: str = ""
    is_badcase: bool = False
    badcase_reason: str = ""


# ---------------------------------------------------------------------------
# LangGraph 全局 State（Pydantic + Reducer 字段）
# ---------------------------------------------------------------------------


def _merge_sql_results(
    left: Optional[SqlBranchResult], right: Optional[SqlBranchResult]
) -> Optional[SqlBranchResult]:
    """并行汇合：后完成分支覆盖同键；生产可用 list[SqlBranchResult] + operator.add"""
    return right if right is not None else left


def _merge_text_results(
    left: Optional[TextBranchResult], right: Optional[TextBranchResult]
) -> Optional[TextBranchResult]:
    return right if right is not None else left


def _append_errors(left: list[str], right: list[str]) -> list[str]:
    return left + right


class AgentState(BaseModel):
    """LangGraph 全局状态。编译时使用 state_schema 或 TypedDict 映射均可。"""

    model_config = {"arbitrary_types_allowed": True}

    # --- 会话 ---
    thread_id: str = ""
    trace_id: str = ""  # 全链路追踪，= 埋点主键

    # --- 用户身份（核心扩展）---
    user_profile: UserProfile = Field(default_factory=lambda: UserProfile(user_id=""))

    # --- 输入 ---
    raw_query: str = ""
    rewritten_query: str = ""  # Me-Form 重写后
    messages: list[dict[str, str]] = Field(default_factory=list)

    # --- 网关 / 意图 ---
    intent: Optional[IntentCategory] = None
    intent_confidence: float = 0.0
    domains: list[str] = Field(default_factory=list)  # supervision, end_term, behavior...
    clarification_level: ClarificationLevel = ClarificationLevel.L0_COMPLETE
    clarification_round: int = 0
    clarification_questions: list[str] = Field(default_factory=list)
    slots: dict[str, Any] = Field(default_factory=dict)

    # --- Me-Form 解析产物 ---
    resolved_filters: ResolvedFilters = Field(default_factory=ResolvedFilters)

    # --- 并行控制 ---
    enable_parallel: bool = False
    parallel_branches: list[ParallelBranch] = Field(default_factory=list)
    branches_completed: Annotated[list[str], operator.add] = Field(default_factory=list)

    # --- 分支结果（汇合节点读取）---
    sql_result: Optional[SqlBranchResult] = None
    text_result: Optional[TextBranchResult] = None

    # --- Schema RAG（SQL 分支专用）---
    selected_schema_bundle: str = ""
    source_tables: list[str] = Field(default_factory=list)

    # --- 融合与输出 ---
    fusion_notes: str = ""
    cross_validation_warnings: list[str] = Field(default_factory=list)
    final_answer: str = ""

    # --- 安全 / 流控 ---
    blocked_reason: Optional[str] = None
    total_loop_count: int = 0
    sql_retry_count: int = 0
    max_sql_retries: int = 3
    max_clarification_rounds: int = 3
    max_total_loops: int = 15

    # --- 埋点（节点内累加，结束时刷盘）---
    lifecycle_log: QaLifecycleLog = Field(
        default_factory=lambda: QaLifecycleLog(trace_id="", thread_id="")
    )
    branch_errors: Annotated[list[str], _append_errors] = Field(default_factory=list)
