#!/usr/bin/env python3
"""P0-01 冒烟：compile_app() 可编译并成功 ainvoke 一次。"""

from __future__ import annotations

import asyncio
import sys
from pathlib import Path

# 保证从任意 cwd 执行脚本时都能 import edu_quality_agent
_ROOT = Path(__file__).resolve().parents[1]
if str(_ROOT) not in sys.path:
    sys.path.insert(0, str(_ROOT))


async def main() -> int:
    from edu_quality_agent import AgentState, UserProfile, UserRole, compile_app

    app = compile_app()
    print("compile_app OK:", type(app).__name__)

    state = AgentState(
        thread_id="smoke-001",
        raw_query="我们学院本学期思政课平均分",
        user_profile=UserProfile(
            user_id="U001",
            role=UserRole.COLLEGE_LEADER,
            tenant_id="T001",
            college_id=201,
            org_scope_ids=[201],
        ),
    )
    result = await app.ainvoke(
        state.model_dump(),
        config={"configurable": {"thread_id": "smoke-001"}},
    )
    intent = result.get("intent")
    answer = (result.get("final_answer") or "")[:300]
    print("ainvoke OK: intent =", intent)
    print("final_answer (truncated):", answer or "(empty)")
    return 0


if __name__ == "__main__":
    try:
        raise SystemExit(asyncio.run(main()))
    except Exception as exc:
        print("SMOKE FAILED:", exc, file=sys.stderr)
        raise SystemExit(1) from exc
