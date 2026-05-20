"""
AI+校务质量监测 — LangGraph 多 Agent 协同（含并行分支 + 用户身份感知）
依赖: langgraph>=0.3, pydantic>=2.0
"""

from __future__ import annotations

import operator
import re
import uuid
from typing import Annotated, Any, Literal, Sequence

from langgraph.graph import END, START, StateGraph
from langgraph.types import Send

from edu_quality_agent.me_form import filters_to_sql_params, resolve_me_form
from edu_quality_agent.observability import InMemoryLifecycleWriter, flush_lifecycle
from edu_quality_agent.state import (
    AgentState,
    ClarificationLevel,
    IntentCategory,
    ParallelBranch,
    SqlBranchResult,
    TextBranchResult,
    UserProfile,
    UserRole,
)

# 生产：PostgresSaver / AsyncPostgresSaver
_lifecycle_writer = InMemoryLifecycleWriter()


# ---------------------------------------------------------------------------
# 流控
# ---------------------------------------------------------------------------


def _bump_loop(state: AgentState) -> dict[str, Any]:
    n = state.total_loop_count + 1
    if n > state.max_total_loops:
        return {
            "total_loop_count": n,
            "blocked_reason": "超过最大推理步数，已安全终止。",
            "intent": IntentCategory.BLOCKED,
        }
    return {"total_loop_count": n}


# ---------------------------------------------------------------------------
# 节点 1：网关 + Me-Form 意图解析（Intent_Parse）
# ---------------------------------------------------------------------------


async def intent_parse_node(state: AgentState) -> dict[str, Any]:
    """
    合并原 gateway + Me-Form：
    1. 规则防御（注入/无关/敏感）
    2. resolve_me_form(user_profile) → rewritten_query + resolved_filters
    3. LLM 意图分类 + 槽位抽取
    4. 判定是否 hybrid → enable_parallel
    """
    updates = _bump_loop(state)
    profile = state.user_profile
    query = state.raw_query.strip()

    if not profile.user_id:
        return {
            **updates,
            "intent": IntentCategory.BLOCKED,
            "blocked_reason": "未登录或 Session 无效。",
        }

    # --- Me-Form ---
    try:
        rewritten, filters = resolve_me_form(query, profile)
    except PermissionError as e:
        return {
            **updates,
            "intent": IntentCategory.BLOCKED,
            "blocked_reason": str(e),
        }

    trace_id = state.trace_id or str(uuid.uuid4())

    # --- 复合意图检测（规则 + LLM）---
    needs_sql = bool(
        re.search(r"抬头率|出勤|均分|排名|趋势|异常|雷达|对比|多少", rewritten)
    )
    needs_text = bool(
        re.search(r"评语|建议|印象|文字|反馈|抱怨|表扬|主题", rewritten)
    )

    if needs_sql and needs_text:
        intent = IntentCategory.HYBRID
        enable_parallel = True
        branches = [ParallelBranch.SQL, ParallelBranch.TEXT]
    elif needs_text:
        intent = IntentCategory.QUALITATIVE
        enable_parallel = False
        branches = [ParallelBranch.TEXT]
    elif needs_sql or True:
        intent = IntentCategory.STRUCTURED
        enable_parallel = False
        branches = [ParallelBranch.SQL]
    else:
        intent = IntentCategory.CAMPUS_KB
        enable_parallel = False
        branches = []

    clarification = ClarificationLevel.L0_COMPLETE
    if "老师" in query and not filters.teacher_user_id and "孙" in query:
        clarification = ClarificationLevel.L2_HARD

    return {
        **updates,
        "trace_id": trace_id,
        "rewritten_query": rewritten,
        "resolved_filters": filters,
        "intent": intent,
        "intent_confidence": 0.88,
        "enable_parallel": enable_parallel,
        "parallel_branches": branches,
        "domains": ["supervision", "behavior"] if needs_sql else ["survey_text"],
        "clarification_level": clarification,
        "lifecycle_log": {
            "trace_id": trace_id,
            "thread_id": state.thread_id,
            "raw_query": query,
            "rewritten_query": rewritten,
        },
    }


# ---------------------------------------------------------------------------
# 并行 Fan-Out：Send API 动态派发
# ---------------------------------------------------------------------------


def fan_out_parallel(state: AgentState) -> Sequence[Send]:
    """
    LangGraph 并行语法：返回多个 Send，运行时同时调度子节点。
    每个 Send 携带分支标识，子节点写回 sql_result / text_result。
    """
    sends: list[Send] = []
    payload = state.model_dump()

    for branch in state.parallel_branches:
        if branch == ParallelBranch.SQL:
            sends.append(Send("sql_expert", {**payload, "_branch": "sql"}))
        elif branch == ParallelBranch.TEXT:
            sends.append(Send("text_expert", {**payload, "_branch": "text"}))

    if not sends:
        sends.append(Send("campus_kb", payload))
    return sends


# ---------------------------------------------------------------------------
# Agent_A：SQL 结构化专家（可含 schema_rag 子步骤）
# ---------------------------------------------------------------------------


async def schema_rag_node(state: AgentState) -> dict[str, Any]:
    """裁剪 5% DDL；结合 resolved_filters 选表"""
    _ = filters_to_sql_params(state.resolved_filters, state.user_profile)
    return {
        "selected_schema_bundle": "-- vw_teacher_term_quality, fact_lesson_behavior ...",
        "source_tables": ["vw_teacher_term_quality", "fact_lesson_behavior"],
    }


async def sql_expert_node(state: AgentState) -> dict[str, Any]:
    """
    SQL 专家全流程：schema_rag → generate → audit → execute
    并行模式下作为独立分支，结果写入 sql_result
    """
    # 内联调用子逻辑（生产可拆 subgraph）
    bundle = "-- schema bundle placeholder"
    if not state.selected_schema_bundle:
        rag = await schema_rag_node(state)
        bundle = rag["selected_schema_bundle"]

    params = filters_to_sql_params(state.resolved_filters, state.user_profile)
    sql = f"""
    SELECT date_key, head_up_rate, attendance_rate
    FROM edu_ai_dw.fact_lesson_behavior
    WHERE tenant_id = :tenant_id
      AND teacher_user_id = :teacher_user_id
      AND college_id IN :org_scope_ids
    ORDER BY date_key
    LIMIT 200
    """.strip()

    # audit stub
    if re.search(r"\b(DELETE|DROP|INSERT)\b", sql, re.I):
        return {
            "sql_result": SqlBranchResult(success=False, error="禁止 DML"),
            "branch_errors": ["sql:audit_failed"],
            "branches_completed": ["sql"],
        }

    result = SqlBranchResult(
        success=True,
        sql=sql,
        rows=[],  # await db.fetch(sql, params)
        row_count=0,
        execution_ms=42,
        retry_count=state.sql_retry_count,
    )
    return {
        "sql_result": result,
        "branches_completed": ["sql"],
    }


# ---------------------------------------------------------------------------
# Agent_B：Text 质性专家
# ---------------------------------------------------------------------------


async def text_expert_node(state: AgentState) -> dict[str, Any]:
    """向量检索 + 主题聚类 + 情感摘要"""
    _ = state.rewritten_query
    result = TextBranchResult(
        success=True,
        snippets=[
            {"role": "student", "text": "老师讲解清晰，课堂互动多。"},
            {"role": "supervisor", "text": "建议增加板书与当堂练习。"},
        ],
        summary="学生整体评价偏正面，督导建议加强板书与练习。",
        themes=["互动", "板书", "练习"],
        sentiment="positive",
    )
    return {
        "text_result": result,
        "branches_completed": ["text"],
    }


async def campus_kb_node(state: AgentState) -> dict[str, Any]:
    return {
        "text_result": TextBranchResult(
            success=True,
            summary="评教任务由教务处每学期统一发起……",
            snippets=[{"source": "kb", "text": "..."}],
        ),
        "branches_completed": ["kb"],
    }


# ---------------------------------------------------------------------------
# Reduce / Fusion：多源汇合 + 交叉验证
# ---------------------------------------------------------------------------


async def fusion_node(state: AgentState) -> dict[str, Any]:
    """
    汇合节点（Reduce）：
    - 等待 parallel_branches 均出现在 branches_completed（由 Send 汇聚触发）
    - 数值与文本结论交叉验证
    - 生成 final_answer
    """
    warnings: list[str] = []
    parts: list[str] = []

    sql = state.sql_result
    text = state.text_result

    if sql and sql.success:
        parts.append(f"【结构化数据】共 {sql.row_count} 条时序记录（耗时 {sql.execution_ms}ms）。")
    elif sql and not sql.success:
        parts.append(f"【结构化数据】查询失败：{sql.error}")

    if text and text.success:
        parts.append(f"【质性摘要】{text.summary}")
        if text.themes:
            parts.append(f"高频主题：{', '.join(text.themes)}。")

    # 交叉验证示例：抬头率趋势下行 + 文本负面 → 一致
    if sql and text and sql.success and text.sentiment == "negative":
        warnings.append("数值趋势与文本情感均偏弱，建议重点关注。")
    elif sql and text and sql.success and text.sentiment == "positive":
        if "抬头率" in state.raw_query:
            warnings.append("文本偏正面但抬头率需结合时序图确认，避免单一维度误判。")

    role = state.user_profile.role
    prefix = "全校" if role == UserRole.SCHOOL_LEADER else "本院"
    answer = f"{prefix}质量监测结论：\n" + "\n".join(parts)
    if warnings:
        answer += "\n\n⚠ 交叉验证：\n" + "\n".join(f"- {w}" for w in warnings)

    return {
        "fusion_notes": "fusion_complete",
        "cross_validation_warnings": warnings,
        "final_answer": answer,
    }


# ---------------------------------------------------------------------------
# 澄清 / 拒答 / 埋点刷盘
# ---------------------------------------------------------------------------


async def clarify_node(state: AgentState) -> dict[str, Any]:
    q = [
        "请确认教师工号或所属学院。",
        "请指定学期（默认：当前学期）。",
    ]
    return {
        "clarification_questions": q,
        "clarification_round": state.clarification_round + 1,
        "final_answer": "\n".join(f"- {x}" for x in q),
    }


async def reject_node(state: AgentState) -> dict[str, Any]:
    return {"final_answer": f"无法处理：{state.blocked_reason or '超出服务范围'}"}


async def observability_flush_node(state: AgentState) -> dict[str, Any]:
    patch = await flush_lifecycle(state, _lifecycle_writer)
    return patch


# ---------------------------------------------------------------------------
# 路由
# ---------------------------------------------------------------------------


def route_after_intent(state: AgentState) -> str:
    if state.intent == IntentCategory.BLOCKED:
        return "reject"
    if state.clarification_level >= ClarificationLevel.L2_HARD:
        return "clarify"
    if state.intent == IntentCategory.HYBRID:
        return "parallel_fan_out"
    if state.intent == IntentCategory.STRUCTURED:
        return "sql_only"
    if state.intent == IntentCategory.QUALITATIVE:
        return "text_only"
    if state.intent == IntentCategory.CAMPUS_KB:
        return "kb_only"
    return "reject"


def route_after_clarify(state: AgentState) -> str:
    if state.clarification_round >= state.max_clarification_rounds:
        return "reject"
    if state.clarification_level >= ClarificationLevel.L2_HARD:
        return "await_user"
    return "intent_parse"


# ---------------------------------------------------------------------------
# 构图：含 Send 并行 + 单路降级
# ---------------------------------------------------------------------------


def build_graph() -> StateGraph:
    """
    拓扑（升级版）:

    START → intent_parse (Me-Form + 意图)
          ├─ reject → observability_flush → END
          ├─ clarify → (interrupt) END
          ├─ parallel_fan_out ──Send──┬→ sql_expert ──┐
          │                           └→ text_expert ─┤→ fusion → observability_flush → END
          ├─ sql_only → sql_expert → fusion → ...
          ├─ text_only → text_expert → fusion → ...
          └─ kb_only → campus_kb → fusion → ...
    """
    # LangGraph 推荐：并行汇合字段使用 TypedDict + Annotated reducer
    # 此处用 Pydantic AgentState；编译时可用 state_schema 适配
    builder = StateGraph(AgentState)

    builder.add_node("intent_parse", intent_parse_node)
    builder.add_node("clarify", clarify_node)
    builder.add_node("reject", reject_node)

    # 并行分支专家
    builder.add_node("sql_expert", sql_expert_node)
    builder.add_node("text_expert", text_expert_node)
    builder.add_node("campus_kb", campus_kb_node)

    # 汇合与刷盘
    builder.add_node("fusion", fusion_node)
    builder.add_node("observability_flush", observability_flush_node)

    builder.add_edge(START, "intent_parse")

    builder.add_conditional_edges(
        "intent_parse",
        route_after_intent,
        {
            "reject": "reject",
            "clarify": "clarify",
            "parallel_fan_out": "sql_expert",  # 第一路；Send 在下方 conditional 配置
            "sql_only": "sql_expert",
            "text_only": "text_expert",
            "kb_only": "campus_kb",
        },
    )

    # ★ 并行核心：hybrid 时通过 conditional_edges + Send  fan-out
    # LangGraph 0.3: 从 intent_parse 对 hybrid 走 Send 列表
    def hybrid_fan_out(state: AgentState):
        if state.intent == IntentCategory.HYBRID and state.enable_parallel:
            return fan_out_parallel(state)
        return "fusion"

    builder.add_conditional_edges(
        "intent_parse",
        lambda s: "parallel" if s.intent == IntentCategory.HYBRID and s.enable_parallel else "skip",
        {
            "parallel": "sql_expert",  # placeholder; 实际用 Send 见下
            "skip": "fusion",
        },
    )

    # 单路 SQL / Text 完成后进入 fusion
    builder.add_edge("sql_expert", "fusion")
    builder.add_edge("text_expert", "fusion")
    builder.add_edge("campus_kb", "fusion")

    builder.add_conditional_edges(
        "clarify",
        route_after_clarify,
        {"reject": "reject", "await_user": END, "intent_parse": "intent_parse"},
    )

    builder.add_edge("fusion", "observability_flush")
    builder.add_edge("reject", "observability_flush")
    builder.add_edge("observability_flush", END)

    return builder


def build_graph_with_send() -> StateGraph:
    """
    推荐生产拓扑：intent_parse 通过 Send 并行派发，fusion 自动等待所有 Send 完成。

    START → intent_parse
         → [Send(sql_expert), Send(text_expert)]  (hybrid)
         → fusion → observability_flush → END
    """
    builder = StateGraph(AgentState)

    for name, fn in [
        ("intent_parse", intent_parse_node),
        ("clarify", clarify_node),
        ("reject", reject_node),
        ("sql_expert", sql_expert_node),
        ("text_expert", text_expert_node),
        ("campus_kb", campus_kb_node),
        ("fusion", fusion_node),
        ("observability_flush", observability_flush_node),
    ]:
        builder.add_node(name, fn)

    builder.add_edge(START, "intent_parse")

    def dispatch(state: AgentState):
        if state.intent == IntentCategory.BLOCKED:
            return "reject"
        if state.clarification_level >= ClarificationLevel.L2_HARD:
            return "clarify"
        if state.intent == IntentCategory.HYBRID:
            return fan_out_parallel(state)  # list[Send] → 并行
        if state.intent == IntentCategory.STRUCTURED:
            return "sql_expert"
        if state.intent == IntentCategory.QUALITATIVE:
            return "text_expert"
        if state.intent == IntentCategory.CAMPUS_KB:
            return "campus_kb"
        return "reject"

    builder.add_conditional_edges(
        "intent_parse",
        dispatch,
        ["sql_expert", "text_expert", "campus_kb", "reject", "clarify"],
    )

    builder.add_edge("sql_expert", "fusion")
    builder.add_edge("text_expert", "fusion")
    builder.add_edge("campus_kb", "fusion")
    builder.add_edge("fusion", "observability_flush")
    builder.add_edge("reject", "observability_flush")
    builder.add_edge("observability_flush", END)

    builder.add_conditional_edges(
        "clarify",
        route_after_clarify,
        {"reject": "reject", "await_user": END, "intent_parse": "intent_parse"},
    )

    return builder


def compile_app(checkpointer=None):
    return build_graph_with_send().compile(
        checkpointer=checkpointer,
        interrupt_before=["clarify"],
    )
