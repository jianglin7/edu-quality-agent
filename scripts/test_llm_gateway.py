#!/usr/bin/env python3
"""LLM 网关连通性测试：对内网 OpenAI 兼容接口发一条短消息。"""

from __future__ import annotations

import sys
from pathlib import Path

_ROOT = Path(__file__).resolve().parents[1]
if str(_ROOT) not in sys.path:
    sys.path.insert(0, str(_ROOT))

from edu_quality_agent.llm_client import chat_completion_sync, get_llm_settings


def main() -> int:
    cfg = get_llm_settings()
    print(f"LLM_API_BASE = {cfg.api_base}")
    print(f"LLM_MODEL    = {cfg.model}")
    print(f"URL          = {cfg.chat_completions_url}")
    print("Sending test message...")

    reply = chat_completion_sync(
        [{"role": "user", "content": "请用一句话回复：网关连通测试成功。"}],
        max_tokens=64,
        temperature=0,
    )
    print("--- response ---")
    print(reply.strip())
    print("--- OK ---")
    return 0


if __name__ == "__main__":
    try:
        raise SystemExit(main())
    except Exception as exc:
        print("LLM GATEWAY FAILED:", exc, file=sys.stderr)
        raise SystemExit(1) from exc
