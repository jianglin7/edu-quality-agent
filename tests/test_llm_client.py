"""LLM 客户端单元测试（mock HTTP，CI 不依赖内网网关）。"""

from __future__ import annotations

from typing import Any

import pytest

from edu_quality_agent.llm_client import (
    DEFAULT_API_BASE,
    DEFAULT_MODEL,
    LlmSettings,
    chat_completion,
    get_llm_settings,
)


def test_default_settings_from_env(monkeypatch: pytest.MonkeyPatch):
    monkeypatch.delenv("LLM_API_BASE", raising=False)
    monkeypatch.delenv("LLM_MODEL", raising=False)
    cfg = get_llm_settings()
    assert cfg.api_base == DEFAULT_API_BASE
    assert cfg.model == DEFAULT_MODEL
    assert cfg.chat_completions_url == f"{DEFAULT_API_BASE}/chat/completions"


def test_chat_completions_url_normalization():
    cfg = LlmSettings(
        api_base="http://10.80.5.128:8855/v1",
        api_key="k",
        model="qwen3-32b",
        timeout_sec=30,
    )
    assert cfg.chat_completions_url == "http://10.80.5.128:8855/v1/chat/completions"


@pytest.mark.asyncio
async def test_chat_completion_parses_response(monkeypatch: pytest.MonkeyPatch):
    class FakeResponse:
        def raise_for_status(self) -> None:
            pass

        def json(self) -> dict:
            return {
                "choices": [{"message": {"content": "连通测试成功"}}],
            }

    class FakeClient:
        def __init__(self, *args: Any, **kwargs: Any) -> None:
            pass

        async def __aenter__(self) -> FakeClient:
            return self

        async def __aexit__(self, *args: Any) -> None:
            pass

        async def post(self, url: str, **kwargs: Any) -> FakeResponse:
            assert url.endswith("/chat/completions")
            return FakeResponse()

    import httpx

    monkeypatch.setattr(httpx, "AsyncClient", FakeClient)
    cfg = LlmSettings(
        api_base=DEFAULT_API_BASE,
        api_key="",
        model=DEFAULT_MODEL,
        timeout_sec=5,
    )
    text = await chat_completion(
        [{"role": "user", "content": "hi"}],
        settings=cfg,
    )
    assert "连通" in text
