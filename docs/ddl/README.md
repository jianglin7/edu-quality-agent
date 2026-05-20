# ODS 参考 DDL

本阶段将业务库结构 DDL 放在仓库根目录，供 Schema RAG 与数仓视图设计参考：

| 文件 | 库名 | 说明 |
|------|------|------|
| [../../jy_course_he.sql](../../jy_course_he.sql) | `jy_course_he` | 课表、教师、组织等（约 60 表） |
| [../../jy_application_tqmp.sql](../../jy_application_tqmp.sql) | `jy_application_tqmp` | 评教、督导、听课任务等（约 145 表） |

AI 查询应优先走 **`edu_ai_dw` 语义层视图**，避免 LLM 直接 JOIN 全量 ODS（见架构文档 §8）。
