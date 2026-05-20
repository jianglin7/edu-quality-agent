# API 网关（P0-02）

本目录用于 **FastAPI** 对外服务，计划交付：

- `POST /chat` — 问答入口
- JWT 校验 → 注入 `UserProfile`
- `trace_id` 生成与请求审计
- 调用 `edu_quality_agent.compile_app()` 执行 LangGraph

P0-01 仅保留目录占位；实现见任务 **P0-02**。
