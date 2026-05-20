# AI 校务质量监测多 Agent 智能小助手

面向高校教学质量督导与校/院领导的智能问答系统，基于 **LangGraph** 多 Agent 编排，支持 Me-Form 身份感知、规则防御与全链路埋点。

| 文档 | 说明 |
|------|------|
| [系统架构设计](docs/AI校务质量监测多Agent系统架构设计.md) | 技术方案与节点拓扑 |
| [P0 验收文档](docs/acceptance/P0-验收文档.md) | 阶段交付与验收标准 |

## 环境要求

- Python **3.11+**
- Git
- （推荐）Conda

## 快速开始

### Conda（服务器推荐）

```bash
git clone https://github.com/jianglin7/edu-quality-agent.git
cd edu-quality-agent

conda create -n edu_quality_agent python=3.11 -y
conda activate edu_quality_agent

pip install -U pip
pip install -r requirements-dev.txt
pip install -e .

cp .env.example .env        # 按需填写 LLM / 数据库等

python scripts/smoke_compile.py
python scripts/test_llm_gateway.py   # 需能访问内网 LLM 10.80.5.128:8855
pytest tests/ -v
```

### venv（本地可选）

```bash
python3 -m venv .venv
source .venv/bin/activate
pip install -r requirements-dev.txt
pip install -e .
python scripts/smoke_compile.py
```

详细部署见 [docs/deploy/README.md](docs/deploy/README.md)。CI 见 [GitHub Actions](https://github.com/jianglin7/edu-quality-agent/actions)。

## 目录结构

```
.
├── edu_quality_agent/      # 核心包：LangGraph 主图、Me-Form、埋点
│   ├── graph.py            # compile_app() 入口
│   ├── state.py
│   ├── me_form.py
│   ├── observability.py
│   └── sql/
├── api/                    # FastAPI 网关（P0-02 实现 /chat）
├── scripts/                # 运维与冒烟脚本
├── tests/                  # pytest 单测
├── docs/                   # 架构与阶段验收文档
├── jy_course_he.sql        # ODS 参考 DDL（课表/组织）
└── jy_application_tqmp.sql # ODS 参考 DDL（评教/督导）
```

## 最小调用示例

```python
import asyncio
from edu_quality_agent import compile_app, AgentState, UserProfile, UserRole

async def main():
    app = compile_app()
    state = AgentState(
        thread_id="demo-001",
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
        config={"configurable": {"thread_id": "demo-001"}},
    )
    print(result.get("intent"), result.get("final_answer"))

asyncio.run(main())
```

## 分支策略

| 分支 | 用途 |
|------|------|
| `main` | 稳定可演示、验收基线 |
| `dev` | 日常开发集成 |
| `feature/*` | 单任务分支（如 `feature/p0-02-jwt`） |

## 实施阶段（摘要）

- **P0-01**（本仓库骨架）：依赖、冒烟、`compile_app()` 可运行
- **P0-02**：JWT → `UserProfile`，FastAPI `/chat`
- **P0-03～P0-10**：见 [P0 验收文档](docs/acceptance/P0-验收文档.md)

## 负责人

算法部 · P0 阶段负责人见验收文档「基本信息」表。
