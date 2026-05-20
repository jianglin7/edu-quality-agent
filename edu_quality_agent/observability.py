"""
问答生命周期埋点 + Badcase 飞轮
"""

from __future__ import annotations

import json
from datetime import datetime
from enum import Enum
from typing import Any, Optional, Protocol

from edu_quality_agent.state import AgentState, QaLifecycleLog


class FeedbackType(str, Enum):
    THUMBS_UP = "thumbs_up"
    THUMBS_DOWN = "thumbs_down"
    REWRITE = "rewrite"


class LifecycleWriter(Protocol):
    async def write(self, log: QaLifecycleLog) -> None: ...
    async def mark_badcase(self, trace_id: str, reason: str) -> None: ...


class InMemoryLifecycleWriter:
    """开发环境占位；生产替换为 async DB / Kafka producer"""

    def __init__(self) -> None:
        self._store: list[dict[str, Any]] = []

    async def write(self, log: QaLifecycleLog) -> None:
        self._store.append(log.model_dump())

    async def mark_badcase(self, trace_id: str, reason: str) -> None:
        for row in self._store:
            if row.get("trace_id") == trace_id:
                row["is_badcase"] = True
                row["badcase_reason"] = reason


def build_lifecycle_from_state(state: AgentState) -> QaLifecycleLog:
    sql = state.sql_result
    text = state.text_result
    log = state.lifecycle_log
    log.trace_id = state.trace_id or log.trace_id
    log.thread_id = state.thread_id
    log.tenant_id = state.user_profile.tenant_id
    log.user_id = state.user_profile.user_id
    log.user_role = state.user_profile.role.value
    log.raw_query = state.raw_query
    log.rewritten_query = state.rewritten_query
    log.intent = state.intent.value if state.intent else ""
    log.domains = state.domains
    log.resolved_filters_json = state.resolved_filters.model_dump()
    log.parallel_branches = [b.value for b in state.parallel_branches]
    log.generated_sql = sql.sql if sql else ""
    log.sql_audit_passed = sql.success if sql else False
    log.sql_error = sql.error or "" if sql else ""
    log.db_execution_ms = sql.execution_ms if sql else 0
    log.sql_retry_count = state.sql_retry_count
    log.text_retrieval_count = len(text.snippets) if text else 0
    log.total_loop_count = state.total_loop_count
    log.clarification_rounds = state.clarification_round
    log.final_answer = state.final_answer
    log.fusion_conflicts = state.cross_validation_warnings

    if state.sql_retry_count >= state.max_sql_retries:
        log.is_badcase = True
        log.badcase_reason = "sql_retry_exhausted"
    if state.blocked_reason and "最大推理" in (state.blocked_reason or ""):
        log.is_badcase = True
        log.badcase_reason = "loop_exhausted"
    return log


async def flush_lifecycle(state: AgentState, writer: LifecycleWriter) -> dict[str, Any]:
    log = build_lifecycle_from_state(state)
    await writer.write(log)
    if log.is_badcase:
        await enqueue_badcase_pipeline(log)
    return {"lifecycle_log": log}


async def enqueue_badcase_pipeline(log: QaLifecycleLog) -> None:
    """
    离线飞轮入口（异步队列）：
    1. 写入 badcase_queue 表 / Kafka topic: ai.qa.badcase
    2. Worker 聚类相似问题 → 生成 Few-Shot 候选 / Fine-tune JSONL
  3. 通知标注平台
    """
    payload = {
        "trace_id": log.trace_id,
        "reason": log.badcase_reason or "user_thumbs_down",
        "snapshot": log.model_dump(),
        "enqueued_at": datetime.utcnow().isoformat(),
    }
    # await kafka.send("ai.qa.badcase", json.dumps(payload).encode())
    _ = payload  # stub


async def record_user_feedback(
    trace_id: str,
    feedback: FeedbackType,
    comment: str,
    writer: LifecycleWriter,
) -> None:
    if feedback == FeedbackType.THUMBS_DOWN:
        await writer.mark_badcase(trace_id, f"user_feedback:{comment or 'thumbs_down'}")
        # 触发与 enqueue_badcase_pipeline 相同的离线流水线
