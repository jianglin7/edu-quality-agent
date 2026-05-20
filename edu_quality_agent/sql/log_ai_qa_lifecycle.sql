-- 问答流水监控表：支撑可观测性、Badcase 分析、Few-Shot 挖掘
-- 建议：热数据 90 天放 OLTP；历史分区归档到 ClickHouse / OSS

CREATE TABLE IF NOT EXISTS `log_ai_qa_lifecycle` (
  `id`                    BIGINT       NOT NULL AUTO_INCREMENT COMMENT '自增主键',
  `trace_id`              VARCHAR(64)  NOT NULL COMMENT '全链路追踪ID（UUID）',
  `thread_id`             VARCHAR(64)  NOT NULL COMMENT 'LangGraph 会话线程ID',
  `tenant_id`             VARCHAR(50)  NOT NULL COMMENT '租户',

  -- 用户上下文
  `user_id`               VARCHAR(64)  NOT NULL COMMENT '用户ID',
  `user_role`             VARCHAR(32)  NOT NULL COMMENT 'supervisor|college_leader|school_leader',
  `college_id`            BIGINT       DEFAULT NULL COMMENT '用户所属学院',
  `org_scope_ids`         JSON         DEFAULT NULL COMMENT '行级权限学院列表',

  -- 提问与解析
  `raw_query`             TEXT         NOT NULL COMMENT '用户原始提问',
  `rewritten_query`       TEXT         DEFAULT NULL COMMENT 'Me-Form 重写后问题',
  `intent`                VARCHAR(32)  DEFAULT NULL COMMENT 'structured|qualitative|hybrid|campus_kb|blocked',
  `intent_confidence`     DECIMAL(5,4) DEFAULT NULL,
  `domains`               JSON         DEFAULT NULL COMMENT '业务域标签数组',
  `resolved_filters_json` JSON         DEFAULT NULL COMMENT '物理过滤条件快照',
  `clarification_rounds`  TINYINT      DEFAULT 0 COMMENT '追问轮次',

  -- 并行分支
  `parallel_branches`     JSON         DEFAULT NULL COMMENT '["sql","text"]',
  `branches_completed`    JSON         DEFAULT NULL COMMENT '完成的分支列表',

  -- SQL 分支（可追溯写错 SQL）
  `generated_sql`         MEDIUMTEXT   DEFAULT NULL COMMENT 'Agent 生成的 SQL',
  `sql_audit_passed`      TINYINT(1)   DEFAULT NULL COMMENT '静态审计是否通过',
  `sql_audit_errors`      JSON         DEFAULT NULL COMMENT '审计错误列表',
  `sql_error`             TEXT         DEFAULT NULL COMMENT '数据库执行报错信息',
  `sql_error_code`        VARCHAR(32)  DEFAULT NULL COMMENT '如 1064, 1146',
  `db_execution_ms`       INT          DEFAULT NULL COMMENT 'DB 执行耗时 ms',
  `sql_retry_count`       TINYINT      DEFAULT 0 COMMENT 'SQL 纠错循环次数',
  `source_tables`         JSON         DEFAULT NULL COMMENT 'Schema RAG 选表',
  `result_row_count`      INT          DEFAULT NULL COMMENT '返回行数',

  -- Text 分支
  `text_retrieval_count`  INT          DEFAULT NULL COMMENT '检索片段数',
  `text_summary`          TEXT         DEFAULT NULL COMMENT '质性摘要',
  `text_themes`           JSON         DEFAULT NULL COMMENT '主题标签',

  -- 融合与输出
  `fusion_conflicts`      JSON         DEFAULT NULL COMMENT '交叉验证告警',
  `final_answer`          MEDIUMTEXT   DEFAULT NULL COMMENT '最终答复',
  `total_loop_count`      TINYINT      DEFAULT 0 COMMENT '图节点总步数',
  `total_tokens`          INT          DEFAULT NULL COMMENT '可选：LLM token 消耗',
  `total_latency_ms`      INT          DEFAULT NULL COMMENT '端到端耗时',

  -- 用户反馈飞轮
  `user_feedback`         VARCHAR(16)  DEFAULT NULL COMMENT 'thumbs_up|thumbs_down|rewrite',
  `feedback_comment`      VARCHAR(500) DEFAULT NULL COMMENT '用户点踩备注',
  `feedback_at`           DATETIME     DEFAULT NULL,
  `is_badcase`            TINYINT(1)   NOT NULL DEFAULT 0 COMMENT '是否进入 Badcase 池',
  `badcase_reason`        VARCHAR(64)  DEFAULT NULL COMMENT 'sql_retry_exhausted|user_thumbs_down|loop_exhausted',
  `badcase_status`        VARCHAR(16)  DEFAULT 'pending' COMMENT 'pending|labeled|merged_to_fewshot|closed',

  `created_at`            DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at`            DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,

  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_trace_id` (`trace_id`),
  KEY `idx_tenant_created` (`tenant_id`, `created_at`),
  KEY `idx_user_created` (`user_id`, `created_at`),
  KEY `idx_badcase` (`is_badcase`, `badcase_status`, `created_at`),
  KEY `idx_intent` (`intent`, `created_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='AI 问答生命周期监控表';

-- Badcase 异步队列（离线飞轮消费）
CREATE TABLE IF NOT EXISTS `log_ai_qa_badcase_queue` (
  `id`           BIGINT      NOT NULL AUTO_INCREMENT,
  `trace_id`     VARCHAR(64) NOT NULL,
  `reason`       VARCHAR(64) NOT NULL,
  `snapshot_json` JSON       NOT NULL COMMENT '完整 lifecycle 快照',
  `cluster_id`   VARCHAR(32) DEFAULT NULL COMMENT '相似问题聚类ID',
  `label_status` VARCHAR(16) DEFAULT 'pending',
  `labeled_by`   VARCHAR(64) DEFAULT NULL,
  `fewshot_patch_id` VARCHAR(64) DEFAULT NULL COMMENT '合入 Few-Shot 版本号',
  `created_at`   DATETIME    NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_trace` (`trace_id`),
  KEY `idx_cluster` (`cluster_id`, `label_status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='Badcase 离线处理队列';
