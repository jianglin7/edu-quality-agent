# 环境部署说明（dev / test）

## 1. 运行环境

| 项 | 要求 |
|----|------|
| Python | 3.11+ |
| 推荐 | Conda 环境 `edu_quality_agent` |
| 服务器示例 | `10.80.5.197`（按实际部署机填写） |

## 2. Conda 安装（推荐）

```bash
git clone https://github.com/jianglin7/edu-quality-agent.git
cd edu-quality-agent

conda create -n edu_quality_agent python=3.11 -y
conda activate edu_quality_agent

pip install -U pip
pip install -r requirements-dev.txt
pip install -e .
```

## 3. 配置

```bash
cp .env.example .env
# 编辑 .env：LLM_API_BASE / LLM_API_KEY / LLM_MODEL 等
```

| 变量 | 阶段 | 说明 |
|------|------|------|
| `LLM_API_*` | P0-01 | 默认 `http://10.80.5.128:8855/v1`，模型 `qwen3-32b` |
| `JWT_*` | P0-02 | 统一认证 |
| `DB_READONLY_URL` | P0-07/08 | 只读数仓 |
| `LIFECYCLE_DB_URL` | P0-06 | 埋点表 |

## 4. 验证

```bash
conda activate edu_quality_agent
cd edu-quality-agent

python scripts/smoke_compile.py
python scripts/test_llm_gateway.py
pytest tests/ -v
```

预期：`compile_app OK`、`ainvoke OK`、LLM 返回简短中文、`pytest` 全部通过。

### LLM 网关连通（内网）

```bash
cp .env.example .env   # 一般无需改 LLM_*，除非换机或换模型
python scripts/test_llm_gateway.py
```

需能访问 `10.80.5.128:8855`（与 API 服务同网段或 VPN）。

## 5. CI

推送 `main` / `dev` 后，GitHub Actions 自动执行：  
https://github.com/jianglin7/edu-quality-agent/actions
