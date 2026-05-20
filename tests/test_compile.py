"""P0-01：图可编译、可 invoke。"""

from __future__ import annotations

import pytest

from edu_quality_agent import AgentState, UserProfile, UserRole, compile_app


@pytest.fixture
def sample_state() -> AgentState:
    return AgentState(
        thread_id="test-001",
        raw_query="我们学院本学期思政课平均分",
        user_profile=UserProfile(
            user_id="U001",
            role=UserRole.COLLEGE_LEADER,
            tenant_id="T001",
            college_id=201,
            org_scope_ids=[201],
        ),
    )


def test_compile_app_returns_runnable():
    app = compile_app()
    assert app is not None
    assert hasattr(app, "ainvoke")


@pytest.mark.asyncio
async def test_ainvoke_college_leader_query(sample_state: AgentState):
    app = compile_app()
    result = await app.ainvoke(
        sample_state.model_dump(),
        config={"configurable": {"thread_id": "test-001"}},
    )
    assert result is not None
    assert "intent" in result
