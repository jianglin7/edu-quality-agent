"""
LLM 网关客户端 — OpenAI 兼容 Chat Completions API。

默认对接内网：http://10.80.5.128:8855/v1 ，模型 qwen3-32b。
配置来自环境变量或 .env（见 load_dotenv_optional）。
"""

from __future__ import annotations

import json
import os
from dataclasses import dataclass
from typing import Any

import httpx

DEFAULT_API_BASE = "http://10.80.5.128:8855/v1"
DEFAULT_MODEL = "qwen3-32b"


def load_dotenv_optional() -> None:
    """若已安装 python-dotenv 且存在 .env，则加载（不覆盖已有环境变量）。"""
    try:
        from dotenv import load_dotenv

        load_dotenv(override=False)
    except ImportError:
        pass


@dataclass(frozen=True)
class LlmSettings:
    api_base: str
    api_key: str
    model: str
    timeout_sec: float

    @property
    def chat_completions_url(self) -> str:
        base = self.api_base.rstrip("/")
        if base.endswith("/v1"):
            return f"{base}/chat/completions"
        return f"{base}/v1/chat/completions"


def get_llm_settings() -> LlmSettings:
    load_dotenv_optional()
    api_key = os.getenv("LLM_API_KEY", "").strip()
    return LlmSettings(
        api_base=os.getenv("LLM_API_BASE", DEFAULT_API_BASE).strip(),
        api_key=api_key or "not-needed",
        model=os.getenv("LLM_MODEL", DEFAULT_MODEL).strip(),
        timeout_sec=float(os.getenv("LLM_TIMEOUT_SEC", "60")),
    )


async def chat_completion(
    messages: list[dict[str, str]],
    *,
    settings: LlmSettings | None = None,
    temperature: float = 0.2,
    max_tokens: int | None = 512,
    extra_body: dict[str, Any] | None = None,
) -> str:
    """
    调用 LLM 聊天补全，返回 assistant 文本内容。
    失败时抛出 httpx.HTTPError 或 ValueError（响应格式异常）。
    """
    cfg = settings or get_llm_settings()
    payload: dict[str, Any] = {
        "model": cfg.model,
        "messages": messages,
        "temperature": temperature,
    }
    if max_tokens is not None:
        payload["max_tokens"] = max_tokens
    if extra_body:
        payload.update(extra_body)

    headers = {"Content-Type": "application/json"}
    if cfg.api_key and cfg.api_key not in ("", "not-needed", "replace-me"):
        headers["Authorization"] = f"Bearer {cfg.api_key}"

    async with httpx.AsyncClient(timeout=cfg.timeout_sec) as client:
        resp = await client.post(
            cfg.chat_completions_url,
            headers=headers,
            json=payload,
        )
        resp.raise_for_status()
        data = resp.json()

    try:
        return data["choices"][0]["message"]["content"]
    except (KeyError, IndexError, TypeError) as exc:
        raise ValueError(f"Unexpected LLM response: {json.dumps(data)[:500]}") from exc


def chat_completion_sync(
    messages: list[dict[str, str]],
    **kwargs: Any,
) -> str:
    """同步封装，供脚本与简单测试使用。"""
    import asyncio

    return asyncio.run(chat_completion(messages, **kwargs))
