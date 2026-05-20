/*
 Navicat Premium Dump SQL

 Source Server         : seacraft
 Source Server Type    : MySQL
 Source Server Version : 50744 (5.7.44-log)
 Source Host           : 10.80.6.54:3306
 Source Schema         : jy_application_tqmp

 Target Server Type    : MySQL
 Target Server Version : 50744 (5.7.44-log)
 File Encoding         : 65001

 Date: 15/05/2026 09:53:00
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for QRTZ_BLOB_TRIGGERS
-- ----------------------------
DROP TABLE IF EXISTS `QRTZ_BLOB_TRIGGERS`;
CREATE TABLE `QRTZ_BLOB_TRIGGERS` (
  `SCHED_NAME` varchar(120) NOT NULL COMMENT '调度器名称',
  `TRIGGER_NAME` varchar(190) NOT NULL COMMENT '触发器名称',
  `TRIGGER_GROUP` varchar(190) NOT NULL COMMENT '触发器组',
  `BLOB_DATA` blob COMMENT 'Blob数据',
  PRIMARY KEY (`SCHED_NAME`,`TRIGGER_NAME`,`TRIGGER_GROUP`),
  KEY `IDX_QRTZ_BLOB_TRIGGERS_SCHED_NAME` (`SCHED_NAME`,`TRIGGER_NAME`,`TRIGGER_GROUP`),
  CONSTRAINT `QRTZ_BLOB_TRIGGERS_ibfk_1` FOREIGN KEY (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`) REFERENCES `QRTZ_TRIGGERS` (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='Quartz Blob触发器表';

-- ----------------------------
-- Table structure for QRTZ_CALENDARS
-- ----------------------------
DROP TABLE IF EXISTS `QRTZ_CALENDARS`;
CREATE TABLE `QRTZ_CALENDARS` (
  `SCHED_NAME` varchar(120) NOT NULL COMMENT '调度器名称',
  `CALENDAR_NAME` varchar(190) NOT NULL COMMENT '日历名称',
  `CALENDAR` blob NOT NULL COMMENT '日历数据',
  PRIMARY KEY (`SCHED_NAME`,`CALENDAR_NAME`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='Quartz日历表';

-- ----------------------------
-- Table structure for QRTZ_CRON_TRIGGERS
-- ----------------------------
DROP TABLE IF EXISTS `QRTZ_CRON_TRIGGERS`;
CREATE TABLE `QRTZ_CRON_TRIGGERS` (
  `SCHED_NAME` varchar(120) NOT NULL COMMENT '调度器名称',
  `TRIGGER_NAME` varchar(190) NOT NULL COMMENT '触发器名称',
  `TRIGGER_GROUP` varchar(190) NOT NULL COMMENT '触发器组',
  `CRON_EXPRESSION` varchar(120) NOT NULL COMMENT 'Cron表达式',
  `TIME_ZONE_ID` varchar(80) DEFAULT NULL COMMENT '时区',
  PRIMARY KEY (`SCHED_NAME`,`TRIGGER_NAME`,`TRIGGER_GROUP`),
  CONSTRAINT `QRTZ_CRON_TRIGGERS_ibfk_1` FOREIGN KEY (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`) REFERENCES `QRTZ_TRIGGERS` (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='Quartz Cron触发器表';

-- ----------------------------
-- Table structure for QRTZ_FIRED_TRIGGERS
-- ----------------------------
DROP TABLE IF EXISTS `QRTZ_FIRED_TRIGGERS`;
CREATE TABLE `QRTZ_FIRED_TRIGGERS` (
  `SCHED_NAME` varchar(120) NOT NULL COMMENT '调度器名称',
  `ENTRY_ID` varchar(95) NOT NULL COMMENT '条目ID',
  `TRIGGER_NAME` varchar(190) NOT NULL COMMENT '触发器名称',
  `TRIGGER_GROUP` varchar(190) NOT NULL COMMENT '触发器组',
  `INSTANCE_NAME` varchar(190) NOT NULL COMMENT '实例名称',
  `FIRED_TIME` bigint(13) NOT NULL COMMENT '触发时间',
  `SCHED_TIME` bigint(13) NOT NULL COMMENT '调度时间',
  `PRIORITY` int(11) NOT NULL COMMENT '优先级',
  `STATE` varchar(16) NOT NULL COMMENT '状态',
  `JOB_NAME` varchar(190) DEFAULT NULL COMMENT '任务名称',
  `JOB_GROUP` varchar(190) DEFAULT NULL COMMENT '任务组',
  `IS_NONCONCURRENT` varchar(1) DEFAULT NULL COMMENT '是否非并发',
  `REQUESTS_RECOVERY` varchar(1) DEFAULT NULL COMMENT '是否请求恢复',
  PRIMARY KEY (`SCHED_NAME`,`ENTRY_ID`),
  KEY `IDX_QRTZ_FT_TRIG_INST_NAME` (`SCHED_NAME`,`INSTANCE_NAME`),
  KEY `IDX_QRTZ_FT_INST_JOB_REQ_RCVRY` (`SCHED_NAME`,`INSTANCE_NAME`,`REQUESTS_RECOVERY`),
  KEY `IDX_QRTZ_FT_J_G` (`SCHED_NAME`,`JOB_NAME`,`JOB_GROUP`),
  KEY `IDX_QRTZ_FT_JG` (`SCHED_NAME`,`JOB_GROUP`),
  KEY `IDX_QRTZ_FT_T_G` (`SCHED_NAME`,`TRIGGER_NAME`,`TRIGGER_GROUP`),
  KEY `IDX_QRTZ_FT_TG` (`SCHED_NAME`,`TRIGGER_GROUP`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='Quartz已触发的触发器表';

-- ----------------------------
-- Table structure for QRTZ_JOB_DETAILS
-- ----------------------------
DROP TABLE IF EXISTS `QRTZ_JOB_DETAILS`;
CREATE TABLE `QRTZ_JOB_DETAILS` (
  `SCHED_NAME` varchar(120) NOT NULL COMMENT '调度器名称',
  `JOB_NAME` varchar(190) NOT NULL COMMENT '任务名称',
  `JOB_GROUP` varchar(190) NOT NULL COMMENT '任务组',
  `DESCRIPTION` varchar(250) DEFAULT NULL COMMENT '任务描述',
  `JOB_CLASS_NAME` varchar(250) NOT NULL COMMENT '任务类全名',
  `IS_DURABLE` varchar(1) NOT NULL COMMENT '是否持久化',
  `IS_NONCONCURRENT` varchar(1) NOT NULL COMMENT '是否非并发执行',
  `IS_UPDATE_DATA` varchar(1) NOT NULL COMMENT '是否更新数据',
  `REQUESTS_RECOVERY` varchar(1) NOT NULL COMMENT '是否请求恢复',
  `JOB_DATA` blob COMMENT '任务数据',
  PRIMARY KEY (`SCHED_NAME`,`JOB_NAME`,`JOB_GROUP`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='Quartz任务详情表';

-- ----------------------------
-- Table structure for QRTZ_LOCKS
-- ----------------------------
DROP TABLE IF EXISTS `QRTZ_LOCKS`;
CREATE TABLE `QRTZ_LOCKS` (
  `SCHED_NAME` varchar(120) NOT NULL COMMENT '调度器名称',
  `LOCK_NAME` varchar(40) NOT NULL COMMENT '锁名称',
  PRIMARY KEY (`SCHED_NAME`,`LOCK_NAME`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='Quartz锁表';

-- ----------------------------
-- Table structure for QRTZ_PAUSED_TRIGGER_GRPS
-- ----------------------------
DROP TABLE IF EXISTS `QRTZ_PAUSED_TRIGGER_GRPS`;
CREATE TABLE `QRTZ_PAUSED_TRIGGER_GRPS` (
  `SCHED_NAME` varchar(120) NOT NULL COMMENT '调度器名称',
  `TRIGGER_GROUP` varchar(190) NOT NULL COMMENT '触发器组',
  PRIMARY KEY (`SCHED_NAME`,`TRIGGER_GROUP`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='Quartz暂停的触发器组表';

-- ----------------------------
-- Table structure for QRTZ_SCHEDULER_STATE
-- ----------------------------
DROP TABLE IF EXISTS `QRTZ_SCHEDULER_STATE`;
CREATE TABLE `QRTZ_SCHEDULER_STATE` (
  `SCHED_NAME` varchar(120) NOT NULL COMMENT '调度器名称',
  `INSTANCE_NAME` varchar(190) NOT NULL COMMENT '实例名称',
  `LAST_CHECKIN_TIME` bigint(13) NOT NULL COMMENT '最后签到时间',
  `CHECKIN_INTERVAL` bigint(13) NOT NULL COMMENT '签到间隔',
  PRIMARY KEY (`SCHED_NAME`,`INSTANCE_NAME`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='Quartz调度器状态表';

-- ----------------------------
-- Table structure for QRTZ_SIMPLE_TRIGGERS
-- ----------------------------
DROP TABLE IF EXISTS `QRTZ_SIMPLE_TRIGGERS`;
CREATE TABLE `QRTZ_SIMPLE_TRIGGERS` (
  `SCHED_NAME` varchar(120) NOT NULL COMMENT '调度器名称',
  `TRIGGER_NAME` varchar(190) NOT NULL COMMENT '触发器名称',
  `TRIGGER_GROUP` varchar(190) NOT NULL COMMENT '触发器组',
  `REPEAT_COUNT` bigint(7) NOT NULL COMMENT '重复次数',
  `REPEAT_INTERVAL` bigint(12) NOT NULL COMMENT '重复间隔',
  `TIMES_TRIGGERED` bigint(10) NOT NULL COMMENT '已触发次数',
  PRIMARY KEY (`SCHED_NAME`,`TRIGGER_NAME`,`TRIGGER_GROUP`),
  CONSTRAINT `QRTZ_SIMPLE_TRIGGERS_ibfk_1` FOREIGN KEY (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`) REFERENCES `QRTZ_TRIGGERS` (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='Quartz简单触发器表';

-- ----------------------------
-- Table structure for QRTZ_SIMPROP_TRIGGERS
-- ----------------------------
DROP TABLE IF EXISTS `QRTZ_SIMPROP_TRIGGERS`;
CREATE TABLE `QRTZ_SIMPROP_TRIGGERS` (
  `SCHED_NAME` varchar(120) NOT NULL COMMENT '调度器名称',
  `TRIGGER_NAME` varchar(190) NOT NULL COMMENT '触发器名称',
  `TRIGGER_GROUP` varchar(190) NOT NULL COMMENT '触发器组',
  `STR_PROP_1` varchar(512) DEFAULT NULL COMMENT '字符串属性1',
  `STR_PROP_2` varchar(512) DEFAULT NULL COMMENT '字符串属性2',
  `STR_PROP_3` varchar(512) DEFAULT NULL COMMENT '字符串属性3',
  `INT_PROP_1` int(11) DEFAULT NULL COMMENT '整数属性1',
  `INT_PROP_2` int(11) DEFAULT NULL COMMENT '整数属性2',
  `LONG_PROP_1` bigint(20) DEFAULT NULL COMMENT '长整数属性1',
  `LONG_PROP_2` bigint(20) DEFAULT NULL COMMENT '长整数属性2',
  `DEC_PROP_1` decimal(13,4) DEFAULT NULL COMMENT '小数属性1',
  `DEC_PROP_2` decimal(13,4) DEFAULT NULL COMMENT '小数属性2',
  `BOOL_PROP_1` varchar(1) DEFAULT NULL COMMENT '布尔属性1',
  `BOOL_PROP_2` varchar(1) DEFAULT NULL COMMENT '布尔属性2',
  PRIMARY KEY (`SCHED_NAME`,`TRIGGER_NAME`,`TRIGGER_GROUP`),
  CONSTRAINT `QRTZ_SIMPROP_TRIGGERS_ibfk_1` FOREIGN KEY (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`) REFERENCES `QRTZ_TRIGGERS` (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='Quartz简单属性触发器表';

-- ----------------------------
-- Table structure for QRTZ_TRIGGERS
-- ----------------------------
DROP TABLE IF EXISTS `QRTZ_TRIGGERS`;
CREATE TABLE `QRTZ_TRIGGERS` (
  `SCHED_NAME` varchar(120) NOT NULL COMMENT '调度器名称',
  `TRIGGER_NAME` varchar(190) NOT NULL COMMENT '触发器名称',
  `TRIGGER_GROUP` varchar(190) NOT NULL COMMENT '触发器组',
  `JOB_NAME` varchar(190) NOT NULL COMMENT '任务名称',
  `JOB_GROUP` varchar(190) NOT NULL COMMENT '任务组',
  `DESCRIPTION` varchar(250) DEFAULT NULL COMMENT '触发器描述',
  `NEXT_FIRE_TIME` bigint(13) DEFAULT NULL COMMENT '下次触发时间',
  `PREV_FIRE_TIME` bigint(13) DEFAULT NULL COMMENT '上次触发时间',
  `PRIORITY` int(11) DEFAULT NULL COMMENT '优先级',
  `TRIGGER_STATE` varchar(16) NOT NULL COMMENT '触发器状态',
  `TRIGGER_TYPE` varchar(8) NOT NULL COMMENT '触发器类型',
  `START_TIME` bigint(13) NOT NULL COMMENT '开始时间',
  `END_TIME` bigint(13) DEFAULT NULL COMMENT '结束时间',
  `CALENDAR_NAME` varchar(190) DEFAULT NULL COMMENT '日历名称',
  `MISFIRE_INSTR` smallint(2) DEFAULT NULL COMMENT '错过触发策略',
  `JOB_DATA` blob COMMENT '任务数据',
  PRIMARY KEY (`SCHED_NAME`,`TRIGGER_NAME`,`TRIGGER_GROUP`),
  KEY `IDX_QRTZ_T_J` (`SCHED_NAME`,`JOB_NAME`,`JOB_GROUP`),
  KEY `IDX_QRTZ_T_JG` (`SCHED_NAME`,`JOB_GROUP`),
  KEY `IDX_QRTZ_T_C` (`SCHED_NAME`,`CALENDAR_NAME`),
  KEY `IDX_QRTZ_T_G` (`SCHED_NAME`,`TRIGGER_GROUP`),
  KEY `IDX_QRTZ_T_STATE` (`SCHED_NAME`,`TRIGGER_STATE`),
  KEY `IDX_QRTZ_T_N_STATE` (`SCHED_NAME`,`TRIGGER_NAME`,`TRIGGER_GROUP`,`TRIGGER_STATE`),
  KEY `IDX_QRTZ_T_N_G_STATE` (`SCHED_NAME`,`TRIGGER_GROUP`,`TRIGGER_STATE`),
  KEY `IDX_QRTZ_T_NEXT_FIRE_TIME` (`SCHED_NAME`,`NEXT_FIRE_TIME`),
  KEY `IDX_QRTZ_T_NFT_ST` (`SCHED_NAME`,`TRIGGER_STATE`,`NEXT_FIRE_TIME`),
  KEY `IDX_QRTZ_T_NFT_MISFIRE` (`SCHED_NAME`,`MISFIRE_INSTR`,`NEXT_FIRE_TIME`),
  KEY `IDX_QRTZ_T_NFT_ST_MISFIRE` (`SCHED_NAME`,`MISFIRE_INSTR`,`NEXT_FIRE_TIME`,`TRIGGER_STATE`),
  KEY `IDX_QRTZ_T_NFT_ST_MISFIRE_GRP` (`SCHED_NAME`,`MISFIRE_INSTR`,`NEXT_FIRE_TIME`,`TRIGGER_GROUP`,`TRIGGER_STATE`),
  CONSTRAINT `QRTZ_TRIGGERS_ibfk_1` FOREIGN KEY (`SCHED_NAME`, `JOB_NAME`, `JOB_GROUP`) REFERENCES `QRTZ_JOB_DETAILS` (`SCHED_NAME`, `JOB_NAME`, `JOB_GROUP`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='Quartz触发器表';

-- ----------------------------
-- Table structure for flow_definition
-- ----------------------------
DROP TABLE IF EXISTS `flow_definition`;
CREATE TABLE `flow_definition` (
  `id` bigint(20) NOT NULL COMMENT '主键id',
  `flow_code` varchar(40) NOT NULL COMMENT '流程编码',
  `flow_name` varchar(100) NOT NULL COMMENT '流程名称',
  `model_value` varchar(40) NOT NULL DEFAULT 'CLASSICS' COMMENT '设计器模型（CLASSICS经典模型 MIMIC仿钉钉模型）',
  `category` varchar(100) DEFAULT NULL COMMENT '流程类别',
  `version` varchar(20) NOT NULL COMMENT '流程版本',
  `is_publish` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否发布（0未发布 1已发布 9失效）',
  `form_custom` char(1) DEFAULT 'N' COMMENT '审批表单是否自定义（Y是 N否）',
  `form_path` varchar(100) DEFAULT NULL COMMENT '审批表单路径',
  `activity_status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '流程激活状态（0挂起 1激活）',
  `listener_type` varchar(100) DEFAULT NULL COMMENT '监听器类型',
  `listener_path` varchar(400) DEFAULT NULL COMMENT '监听器路径',
  `ext` varchar(500) DEFAULT NULL COMMENT '业务详情 存业务表对象json字符串',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `del_flag` char(1) DEFAULT '0' COMMENT '删除标志',
  `tenant_id` varchar(40) DEFAULT NULL COMMENT '租户id',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_flow_code` (`flow_code`),
  KEY `idx_tenant_id` (`tenant_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='流程定义表';

-- ----------------------------
-- Table structure for flow_his_task
-- ----------------------------
DROP TABLE IF EXISTS `flow_his_task`;
CREATE TABLE `flow_his_task` (
  `id` bigint(20) NOT NULL COMMENT '主键id',
  `definition_id` bigint(20) NOT NULL COMMENT '对应flow_definition表的id',
  `instance_id` bigint(20) NOT NULL COMMENT '对应flow_instance表的id',
  `task_id` bigint(20) NOT NULL COMMENT '对应flow_task表的id',
  `node_code` varchar(100) DEFAULT NULL COMMENT '开始节点编码',
  `node_name` varchar(100) DEFAULT NULL COMMENT '开始节点名称',
  `node_type` tinyint(1) DEFAULT NULL COMMENT '开始节点类型（0开始节点 1中间节点 2结束节点 3互斥网关 4并行网关）',
  `target_node_code` varchar(200) DEFAULT NULL COMMENT '目标节点编码',
  `target_node_name` varchar(200) DEFAULT NULL COMMENT '结束节点名称',
  `approver` varchar(40) DEFAULT NULL COMMENT '审批者',
  `cooperate_type` tinyint(1) NOT NULL DEFAULT '0' COMMENT '协作方式(1审批 2转办 3委派 4会签 5票签 6加签 7减签)',
  `collaborator` varchar(500) DEFAULT NULL COMMENT '协作人',
  `skip_type` varchar(10) NOT NULL COMMENT '流转类型（PASS通过 REJECT退回 NONE无动作）',
  `flow_status` varchar(20) NOT NULL COMMENT '流程状态（0待提交 1审批中 2审批通过 4终止 5作废 6撤销 8已完成 9已退回 10失效 11拿回）',
  `form_custom` char(1) DEFAULT 'N' COMMENT '审批表单是否自定义（Y是 N否）',
  `form_path` varchar(100) DEFAULT NULL COMMENT '审批表单路径',
  `message` varchar(500) DEFAULT NULL COMMENT '审批意见',
  `variable` text COMMENT '任务变量',
  `ext` text COMMENT '业务详情 存业务表对象json字符串',
  `create_time` datetime DEFAULT NULL COMMENT '任务开始时间',
  `update_time` datetime DEFAULT NULL COMMENT '审批完成时间',
  `del_flag` char(1) DEFAULT '0' COMMENT '删除标志',
  `tenant_id` varchar(40) DEFAULT NULL COMMENT '租户id',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_instance_id` (`instance_id`),
  KEY `idx_task_id` (`task_id`),
  KEY `idx_approver` (`approver`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='历史任务记录表';

-- ----------------------------
-- Table structure for flow_instance
-- ----------------------------
DROP TABLE IF EXISTS `flow_instance`;
CREATE TABLE `flow_instance` (
  `id` bigint(20) NOT NULL COMMENT '主键id',
  `definition_id` bigint(20) NOT NULL COMMENT '对应flow_definition表的id',
  `business_id` varchar(40) NOT NULL COMMENT '业务id',
  `node_type` tinyint(1) NOT NULL COMMENT '节点类型（0开始节点 1中间节点 2结束节点 3互斥网关 4并行网关）',
  `node_code` varchar(40) NOT NULL COMMENT '流程节点编码',
  `node_name` varchar(100) DEFAULT NULL COMMENT '流程节点名称',
  `variable` text COMMENT '任务变量',
  `flow_status` varchar(20) NOT NULL COMMENT '流程状态（0待提交 1审批中 2审批通过 4终止 5作废 6撤销 8已完成 9已退回 10失效 11拿回）',
  `activity_status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '流程激活状态（0挂起 1激活）',
  `def_json` text COMMENT '流程定义json',
  `create_by` varchar(64) DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `ext` varchar(500) DEFAULT NULL COMMENT '扩展字段，预留给业务系统使用',
  `del_flag` char(1) DEFAULT '0' COMMENT '删除标志',
  `tenant_id` varchar(40) DEFAULT NULL COMMENT '租户id',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_definition_id` (`definition_id`),
  KEY `idx_business_id` (`business_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='流程实例表';

-- ----------------------------
-- Table structure for flow_node
-- ----------------------------
DROP TABLE IF EXISTS `flow_node`;
CREATE TABLE `flow_node` (
  `id` bigint(20) NOT NULL COMMENT '主键id',
  `node_type` tinyint(1) NOT NULL COMMENT '节点类型（0开始节点 1中间节点 2结束节点 3互斥网关 4并行网关）',
  `definition_id` bigint(20) NOT NULL COMMENT '流程定义id',
  `node_code` varchar(100) NOT NULL COMMENT '流程节点编码',
  `node_name` varchar(100) DEFAULT NULL COMMENT '流程节点名称',
  `permission_flag` varchar(200) DEFAULT NULL COMMENT '权限标识（权限类型:权限标识，可以多个，用@@隔开）',
  `node_ratio` decimal(6,3) DEFAULT NULL COMMENT '流程签署比例值',
  `coordinate` varchar(100) DEFAULT NULL COMMENT '坐标',
  `any_node_skip` varchar(100) DEFAULT NULL COMMENT '任意结点跳转',
  `listener_type` varchar(100) DEFAULT NULL COMMENT '监听器类型',
  `listener_path` varchar(400) DEFAULT NULL COMMENT '监听器路径',
  `handler_type` varchar(100) DEFAULT NULL COMMENT '处理器类型',
  `handler_path` varchar(400) DEFAULT NULL COMMENT '处理器路径',
  `form_custom` char(1) DEFAULT 'N' COMMENT '审批表单是否自定义（Y是 N否）',
  `form_path` varchar(100) DEFAULT NULL COMMENT '审批表单路径',
  `version` varchar(20) NOT NULL COMMENT '版本',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `ext` text COMMENT '节点扩展属性',
  `del_flag` char(1) DEFAULT '0' COMMENT '删除标志',
  `tenant_id` varchar(40) DEFAULT NULL COMMENT '租户id',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_definition_id` (`definition_id`),
  KEY `idx_node_code` (`node_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='流程节点表';

-- ----------------------------
-- Table structure for flow_skip
-- ----------------------------
DROP TABLE IF EXISTS `flow_skip`;
CREATE TABLE `flow_skip` (
  `id` bigint(20) NOT NULL COMMENT '主键id',
  `definition_id` bigint(20) NOT NULL COMMENT '流程定义id',
  `now_node_code` varchar(100) NOT NULL COMMENT '当前流程节点的编码',
  `now_node_type` tinyint(1) DEFAULT NULL COMMENT '当前节点类型（0开始节点 1中间节点 2结束节点 3互斥网关 4并行网关）',
  `next_node_code` varchar(100) NOT NULL COMMENT '下一个流程节点的编码',
  `next_node_type` tinyint(1) DEFAULT NULL COMMENT '下一个节点类型（0开始节点 1中间节点 2结束节点 3互斥网关 4并行网关）',
  `skip_name` varchar(100) DEFAULT NULL COMMENT '跳转名称',
  `skip_type` varchar(40) DEFAULT NULL COMMENT '跳转类型（PASS审批通过 REJECT退回）',
  `skip_condition` varchar(200) DEFAULT NULL COMMENT '跳转条件',
  `coordinate` varchar(100) DEFAULT NULL COMMENT '坐标',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `del_flag` char(1) DEFAULT '0' COMMENT '删除标志',
  `tenant_id` varchar(40) DEFAULT NULL COMMENT '租户id',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_definition_id` (`definition_id`),
  KEY `idx_now_node_code` (`now_node_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='节点跳转关联表';

-- ----------------------------
-- Table structure for flow_task
-- ----------------------------
DROP TABLE IF EXISTS `flow_task`;
CREATE TABLE `flow_task` (
  `id` bigint(20) NOT NULL COMMENT '主键id',
  `definition_id` bigint(20) NOT NULL COMMENT '对应flow_definition表的id',
  `instance_id` bigint(20) NOT NULL COMMENT '对应flow_instance表的id',
  `node_code` varchar(100) NOT NULL COMMENT '节点编码',
  `node_name` varchar(100) DEFAULT NULL COMMENT '节点名称',
  `node_type` tinyint(1) NOT NULL COMMENT '节点类型（0开始节点 1中间节点 2结束节点 3互斥网关 4并行网关）',
  `flow_status` varchar(20) NOT NULL COMMENT '流程状态（0待提交 1审批中 2审批通过 4终止 5作废 6撤销 8已完成 9已退回 10失效 11拿回）',
  `form_custom` char(1) DEFAULT 'N' COMMENT '审批表单是否自定义（Y是 N否）',
  `form_path` varchar(100) DEFAULT NULL COMMENT '审批表单路径',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `del_flag` char(1) DEFAULT '0' COMMENT '删除标志',
  `tenant_id` varchar(40) DEFAULT NULL COMMENT '租户id',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_instance_id` (`instance_id`),
  KEY `idx_definition_id` (`definition_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='待办任务表';

-- ----------------------------
-- Table structure for flow_user
-- ----------------------------
DROP TABLE IF EXISTS `flow_user`;
CREATE TABLE `flow_user` (
  `id` bigint(20) NOT NULL COMMENT '主键id',
  `type` char(1) NOT NULL COMMENT '人员类型（1待办任务的审批人权限 2待办任务的转办人权限 3待办任务的委托人权限）',
  `processed_by` varchar(80) DEFAULT NULL COMMENT '权限人',
  `associated` bigint(20) NOT NULL COMMENT '任务表id',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `create_by` varchar(80) DEFAULT NULL COMMENT '创建人',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `del_flag` char(1) DEFAULT '0' COMMENT '删除标志',
  `tenant_id` varchar(40) DEFAULT NULL COMMENT '租户id',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `user_processed_type` (`processed_by`,`type`),
  KEY `user_associated` (`associated`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='流程用户表';

-- ----------------------------
-- Table structure for flyway_schema_history
-- ----------------------------
DROP TABLE IF EXISTS `flyway_schema_history`;
CREATE TABLE `flyway_schema_history` (
  `installed_rank` int(11) NOT NULL,
  `version` varchar(50) DEFAULT NULL,
  `description` varchar(200) NOT NULL,
  `type` varchar(20) NOT NULL,
  `script` varchar(1000) NOT NULL,
  `checksum` int(11) DEFAULT NULL,
  `installed_by` varchar(100) NOT NULL,
  `installed_on` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `execution_time` int(11) NOT NULL,
  `success` tinyint(1) NOT NULL,
  PRIMARY KEY (`installed_rank`),
  KEY `flyway_schema_history_s_idx` (`success`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for t_async_import_export_task
-- ----------------------------
DROP TABLE IF EXISTS `t_async_import_export_task`;
CREATE TABLE `t_async_import_export_task` (
  `id` bigint(20) NOT NULL COMMENT '主键ID（雪花算法）',
  `task_id` varchar(64) NOT NULL COMMENT '任务ID',
  `task_type` tinyint(4) NOT NULL COMMENT '任务类型（1-导出 2-导入）',
  `task_status` tinyint(4) NOT NULL DEFAULT '0' COMMENT '任务状态（0-待处理，1-处理中，2-完成，3-失败）',
  `progress` int(11) NOT NULL DEFAULT '0' COMMENT '任务进度（0-100）',
  `file_name` varchar(255) DEFAULT NULL COMMENT '文件名称',
  `file_path` varchar(512) DEFAULT NULL COMMENT '文件路径',
  `file_size` bigint(20) DEFAULT NULL COMMENT '文件大小（字节）',
  `error_msg` text COMMENT '错误信息JSON',
  `total_count` int(11) NOT NULL DEFAULT '0' COMMENT '总记录数',
  `success_count` int(11) NOT NULL DEFAULT '0' COMMENT '成功记录数',
  `fail_count` int(11) NOT NULL DEFAULT '0' COMMENT '失败记录数',
  `start_time` datetime DEFAULT NULL COMMENT '开始时间',
  `end_time` datetime DEFAULT NULL COMMENT '结束时间',
  `expire_time` datetime DEFAULT NULL COMMENT '过期时间',
  `download_flag` tinyint(4) NOT NULL DEFAULT '0' COMMENT '下载标记（0-否 1-是）',
  `timeout_minutes` int(11) NOT NULL DEFAULT '30' COMMENT '任务超时时间（分钟）',
  `retention_hours` int(11) NOT NULL DEFAULT '24' COMMENT '文件保留时长（小时）',
  `tenant_id` varchar(50) DEFAULT NULL COMMENT '租户ID',
  `create_user_id` bigint(20) DEFAULT NULL COMMENT '创建人id',
  `update_user_id` bigint(20) DEFAULT NULL COMMENT '更新人id',
  `version` int(11) NOT NULL DEFAULT '1' COMMENT '版本号',
  `created_date_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `created_by` varchar(64) DEFAULT NULL COMMENT '创建人',
  `last_modified_date_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `last_modified_by` varchar(64) DEFAULT NULL COMMENT '更新人',
  `delete_flag` tinyint(4) NOT NULL DEFAULT '0' COMMENT '删除标记',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_async_task_id` (`task_id`),
  KEY `idx_async_status` (`task_status`),
  KEY `idx_async_created` (`created_date_time`),
  KEY `idx_async_tenant` (`tenant_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='异步导入导出任务表';

-- ----------------------------
-- Table structure for t_config_data
-- ----------------------------
DROP TABLE IF EXISTS `t_config_data`;
CREATE TABLE `t_config_data` (
  `id` bigint(20) NOT NULL COMMENT '主键ID（雪花算法生成）',
  `config_key` varchar(255) DEFAULT NULL COMMENT '配置key',
  `config_value` text COMMENT '配置值',
  `create_user_id` bigint(20) DEFAULT NULL COMMENT '创建人id',
  `update_user_id` bigint(20) DEFAULT NULL COMMENT '更新人id',
  `version` int(11) NOT NULL DEFAULT '1' COMMENT '乐观锁版本号',
  `created_date_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `created_by` varchar(50) DEFAULT NULL COMMENT '创建人',
  `last_modified_date_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间',
  `last_modified_by` varchar(50) DEFAULT NULL COMMENT '最后修改人',
  `delete_flag` tinyint(4) NOT NULL DEFAULT '0' COMMENT '删除标志（0：正常，1：删除）',
  `tenant_id` varchar(50) NOT NULL COMMENT '租户编号',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_config_key` (`config_key`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='配置表';

-- ----------------------------
-- Table structure for t_end_term_record
-- ----------------------------
DROP TABLE IF EXISTS `t_end_term_record`;
CREATE TABLE `t_end_term_record` (
  `id` bigint(20) NOT NULL COMMENT '主键ID（雪花算法生成）',
  `task_id` bigint(20) DEFAULT NULL COMMENT '任务id',
  `evaluate_status` tinyint(4) DEFAULT NULL COMMENT '评价状态 0-未评 1-已评',
  `acte_id` bigint(20) DEFAULT NULL COMMENT '学期id',
  `tecl_id` bigint(20) DEFAULT NULL COMMENT '教学班id',
  `tecl_code` varchar(100) DEFAULT NULL COMMENT '教学班编码',
  `tecl_name` varchar(255) DEFAULT NULL COMMENT '教学班名称',
  `subj_id` bigint(20) DEFAULT NULL COMMENT '科目id',
  `subj_code` varchar(100) DEFAULT NULL COMMENT '科目编码',
  `subj_name` varchar(255) DEFAULT NULL COMMENT '科目名称',
  `educational_level` tinyint(4) DEFAULT NULL COMMENT '学历层次 1-本科 2-研究生',
  `evaluate_user_id` bigint(20) DEFAULT NULL COMMENT '评价用户id',
  `evaluate_user_code` varchar(100) DEFAULT NULL COMMENT '评价用户编码',
  `evaluate_user_name` varchar(255) DEFAULT NULL COMMENT '评价用户名称',
  `evaluated_user_id` bigint(20) DEFAULT NULL COMMENT '被评用户id',
  `evaluated_user_code` varchar(100) DEFAULT NULL COMMENT '被评用户编码',
  `evaluated_user_name` varchar(255) DEFAULT NULL COMMENT '被评用户名称',
  `tecl_org_id` bigint(20) DEFAULT NULL COMMENT '排课院系id',
  `tecl_org_code` varchar(100) DEFAULT NULL COMMENT '排课院系编码',
  `tecl_org_name` varchar(255) DEFAULT NULL COMMENT '排课院系名称',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `create_user_id` bigint(20) DEFAULT NULL COMMENT '创建人id',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `update_user_id` bigint(20) DEFAULT NULL COMMENT '更新人id',
  `version` int(11) NOT NULL DEFAULT '1' COMMENT '乐观锁版本号',
  `created_date_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `created_by` varchar(50) DEFAULT NULL COMMENT '创建人',
  `last_modified_date_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间',
  `last_modified_by` varchar(50) DEFAULT NULL COMMENT '最后修改人',
  `delete_flag` tinyint(4) NOT NULL DEFAULT '0' COMMENT '删除标志（0：正常，1：删除）',
  `tenant_id` varchar(50) NOT NULL COMMENT '租户编号',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_task_id` (`task_id`) USING BTREE,
  KEY `idx_acte_id` (`acte_id`) USING BTREE,
  KEY `idx_subj_id` (`subj_id`) USING BTREE,
  KEY `idx_evaluate_user_id` (`evaluate_user_id`) USING BTREE,
  KEY `idx_evaluated_user_id` (`evaluated_user_id`) USING BTREE,
  KEY `idx_tecl_id` (`tecl_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='期末评价-评价记录';

-- ----------------------------
-- Table structure for t_end_term_record_survey
-- ----------------------------
DROP TABLE IF EXISTS `t_end_term_record_survey`;
CREATE TABLE `t_end_term_record_survey` (
  `id` bigint(20) NOT NULL COMMENT '主键ID（雪花算法生成）',
  `task_id` bigint(20) DEFAULT NULL COMMENT '任务id',
  `record_id` bigint(20) DEFAULT NULL COMMENT '记录id',
  `survey_id` varchar(255) DEFAULT NULL COMMENT '问卷id',
  `survey_name` varchar(255) DEFAULT NULL COMMENT '问卷名称',
  `survey_data_id` varchar(255) DEFAULT NULL COMMENT '问卷填写数据id',
  `survey_submit_status` tinyint(4) DEFAULT NULL COMMENT '问卷提交状态 草稿：-1 ，已提交：1',
  `survey_submit_time` datetime DEFAULT NULL COMMENT '问卷提交时间',
  `survey_score` decimal(5,2) DEFAULT NULL COMMENT '问卷结果得分',
  `reason_type` tinyint(4) DEFAULT NULL COMMENT '理由类型- 1-低 2-高',
  `reason` varchar(2000) DEFAULT NULL COMMENT '理由',
  `create_user_id` bigint(20) DEFAULT NULL COMMENT '创建人id',
  `update_user_id` bigint(20) DEFAULT NULL COMMENT '更新人id',
  `version` int(11) NOT NULL DEFAULT '1' COMMENT '乐观锁版本号',
  `created_date_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `created_by` varchar(50) DEFAULT NULL COMMENT '创建人',
  `last_modified_date_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间',
  `last_modified_by` varchar(50) DEFAULT NULL COMMENT '最后修改人',
  `delete_flag` tinyint(4) NOT NULL DEFAULT '0' COMMENT '删除标志（0：正常，1：删除）',
  `tenant_id` varchar(50) NOT NULL COMMENT '租户编号',
  `score_level_id` bigint(20) DEFAULT NULL COMMENT '选中的评分等级id',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_task_id` (`task_id`) USING BTREE,
  KEY `idx_record_id` (`record_id`) USING BTREE,
  KEY `idx_survey_id` (`survey_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='期末评价-评价-问卷';

-- ----------------------------
-- Table structure for t_end_term_task
-- ----------------------------
DROP TABLE IF EXISTS `t_end_term_task`;
CREATE TABLE `t_end_term_task` (
  `id` bigint(20) NOT NULL COMMENT '主键ID（雪花算法生成）',
  `task_name` varchar(255) DEFAULT NULL COMMENT '任务名称',
  `educational_level` tinyint(4) DEFAULT NULL COMMENT '学历层次 1-本科 2-研究生',
  `task_level` tinyint(4) DEFAULT NULL COMMENT '任务级别 1-校级 2-院级',
  `task_org_id` bigint(20) DEFAULT NULL COMMENT '任务所属组织id',
  `acte_id` bigint(20) DEFAULT NULL COMMENT '学期id',
  `task_status` tinyint(4) DEFAULT NULL COMMENT '任务状态 0-未发布 1-已发布',
  `task_time_type` tinyint(4) DEFAULT NULL COMMENT '任务时间类型 1-统一设置 2-按开学周设置  3-按结课周设置',
  `task_start_time` datetime DEFAULT NULL COMMENT '任务开始时间-存放任务时间最小值',
  `task_end_time` datetime DEFAULT NULL COMMENT '任务结束时间-存放任务时间最大值',
  `reason_enable` tinyint(4) DEFAULT '0' COMMENT '评分是否需要填写理由',
  `reason_high_type` tinyint(4) DEFAULT NULL COMMENT '高分区间类型 1-大于 2-大于等于',
  `reason_high_score` decimal(5,2) DEFAULT NULL COMMENT '高分分值',
  `reason_low_type` tinyint(4) DEFAULT NULL COMMENT '低分区间类型 1-大于 2-大于等于',
  `reason_low_score` decimal(5,2) DEFAULT NULL COMMENT '低分分值',
  `full_score_enable` tinyint(4) DEFAULT '1' COMMENT '是否允许满分评价',
  `same_select_enable` tinyint(4) DEFAULT '1' COMMENT '是否允许相同选项',
  `before_task_end_modify_enable` tinyint(4) DEFAULT '0' COMMENT '是否允许学生任务结束前修改评价结果',
  `college_admin_result_enable` tinyint(4) DEFAULT NULL COMMENT '院系管理员是否可查看校级任务内本院系的数据',
  `evaluated_user_result_enable` tinyint(4) DEFAULT '0' COMMENT '被评用户-是否允许查看任务结果（默认不允许）',
  `evaluated_user_result_view_types` varchar(50) DEFAULT NULL COMMENT '被评用户-查看任务结果颗粒度 1-课程 2-教学班 多个逗号隔开',
  `evaluated_user_result_view_fields` varchar(50) DEFAULT NULL COMMENT '被评用户-可查看的字段类型 1-参评率 2-评价得分 3-同问卷校排名 4-同问卷院系排名  多个逗号隔开',
  `opinion_communication_enable` tinyint(4) DEFAULT NULL COMMENT '配置意见反馈题时，允许评价者（匿名）与被评者实时沟通',
  `score_level_enable` tinyint(4) DEFAULT NULL COMMENT '是否开启评分区段',
  `create_user_id` bigint(20) DEFAULT NULL COMMENT '创建人id',
  `update_user_id` bigint(20) DEFAULT NULL COMMENT '更新人id',
  `version` int(11) NOT NULL DEFAULT '1' COMMENT '乐观锁版本号',
  `created_date_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `created_by` varchar(50) DEFAULT NULL COMMENT '创建人',
  `last_modified_date_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间',
  `last_modified_by` varchar(50) DEFAULT NULL COMMENT '最后修改人',
  `delete_flag` tinyint(4) NOT NULL DEFAULT '0' COMMENT '删除标志（0：正常，1：删除）',
  `tenant_id` varchar(50) NOT NULL COMMENT '租户编号',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='期末评价-任务表';

-- ----------------------------
-- Table structure for t_end_term_task_result_config_survey
-- ----------------------------
DROP TABLE IF EXISTS `t_end_term_task_result_config_survey`;
CREATE TABLE `t_end_term_task_result_config_survey` (
  `id` bigint(20) NOT NULL COMMENT '主键ID（雪花算法生成）',
  `config_user_type` tinyint(4) DEFAULT NULL COMMENT '配置用户类型：1-院系管理员  2-被评用户',
  `task_id` bigint(20) DEFAULT NULL COMMENT '任务id',
  `survey_id` varchar(255) DEFAULT NULL COMMENT '问卷id',
  `survey_name` varchar(255) DEFAULT NULL COMMENT '问卷名称',
  `create_user_id` bigint(20) DEFAULT NULL COMMENT '创建人id',
  `update_user_id` bigint(20) DEFAULT NULL COMMENT '更新人id',
  `version` int(11) NOT NULL DEFAULT '1' COMMENT '乐观锁版本号',
  `created_date_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `created_by` varchar(50) DEFAULT NULL COMMENT '创建人',
  `last_modified_date_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间',
  `last_modified_by` varchar(50) DEFAULT NULL COMMENT '最后修改人',
  `delete_flag` tinyint(4) NOT NULL DEFAULT '0' COMMENT '删除标志（0：正常，1：删除）',
  `tenant_id` varchar(50) NOT NULL COMMENT '租户编号',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='期末评价-任务结果配置允许查看的问卷';

-- ----------------------------
-- Table structure for t_end_term_task_score_level
-- ----------------------------
DROP TABLE IF EXISTS `t_end_term_task_score_level`;
CREATE TABLE `t_end_term_task_score_level` (
  `id` bigint(20) NOT NULL COMMENT '主键ID（雪花算法生成）',
  `task_id` bigint(20) DEFAULT NULL COMMENT '任务id',
  `level_name` varchar(255) DEFAULT NULL COMMENT '等级名称',
  `high_score_type` tinyint(4) DEFAULT NULL COMMENT '高分类型 1-小于 2-小于等于',
  `high_score` decimal(5,2) DEFAULT NULL COMMENT '高分',
  `low_score_type` tinyint(4) DEFAULT NULL COMMENT '低分类型 1-大于 2-大于等于',
  `low_score` decimal(5,2) DEFAULT NULL COMMENT '低分',
  `level_desc` varchar(500) DEFAULT NULL COMMENT '等级描述',
  `order_index` int(11) DEFAULT NULL COMMENT '排序',
  `create_user_id` bigint(20) DEFAULT NULL COMMENT '创建人id',
  `update_user_id` bigint(20) DEFAULT NULL COMMENT '更新人id',
  `version` int(11) NOT NULL DEFAULT '1' COMMENT '乐观锁版本号',
  `created_date_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `created_by` varchar(50) DEFAULT NULL COMMENT '创建人',
  `last_modified_date_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间',
  `last_modified_by` varchar(50) DEFAULT NULL COMMENT '最后修改人',
  `delete_flag` tinyint(4) NOT NULL DEFAULT '0' COMMENT '删除标志（0：正常，1：删除）',
  `tenant_id` varchar(50) NOT NULL COMMENT '租户编号',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_task_id` (`task_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='期末平均-任务-评分等级';

-- ----------------------------
-- Table structure for t_end_term_task_survey
-- ----------------------------
DROP TABLE IF EXISTS `t_end_term_task_survey`;
CREATE TABLE `t_end_term_task_survey` (
  `id` bigint(20) NOT NULL COMMENT '主键ID（雪花算法生成）',
  `group_id` bigint(20) DEFAULT NULL COMMENT '关联组id',
  `survey_id` varchar(255) DEFAULT NULL COMMENT '问卷id',
  `survey_name` varchar(255) DEFAULT NULL COMMENT '问卷名称',
  `score_flag` tinyint(4) DEFAULT '1' COMMENT '是否计分 0-否 1-是(默认)',
  `create_user_id` bigint(20) DEFAULT NULL COMMENT '创建人id',
  `update_user_id` bigint(20) DEFAULT NULL COMMENT '更新人id',
  `version` int(11) NOT NULL DEFAULT '1' COMMENT '乐观锁版本号',
  `created_date_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `created_by` varchar(50) DEFAULT NULL COMMENT '创建人',
  `last_modified_date_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间',
  `last_modified_by` varchar(50) DEFAULT NULL COMMENT '最后修改人',
  `delete_flag` tinyint(4) NOT NULL DEFAULT '0' COMMENT '删除标志（0：正常，1：删除）',
  `tenant_id` varchar(50) NOT NULL COMMENT '租户编号',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_group_id` (`group_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='期末评价-任务-问卷表';

-- ----------------------------
-- Table structure for t_end_term_task_teaching_class
-- ----------------------------
DROP TABLE IF EXISTS `t_end_term_task_teaching_class`;
CREATE TABLE `t_end_term_task_teaching_class` (
  `id` bigint(20) NOT NULL COMMENT '主键ID（雪花算法生成）',
  `group_id` bigint(20) DEFAULT NULL COMMENT '关联组id',
  `tecl_id` bigint(20) DEFAULT NULL COMMENT '教学班id',
  `create_user_id` bigint(20) DEFAULT NULL COMMENT '创建人id',
  `update_user_id` bigint(20) DEFAULT NULL COMMENT '更新人id',
  `version` int(11) NOT NULL DEFAULT '1' COMMENT '乐观锁版本号',
  `created_date_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `created_by` varchar(50) DEFAULT NULL COMMENT '创建人',
  `last_modified_date_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间',
  `last_modified_by` varchar(50) DEFAULT NULL COMMENT '最后修改人',
  `delete_flag` tinyint(4) NOT NULL DEFAULT '0' COMMENT '删除标志（0：正常，1：删除）',
  `tenant_id` varchar(50) NOT NULL COMMENT '租户编号',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_group_id` (`group_id`) USING BTREE,
  KEY `idx_tecl_id` (`tecl_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='期末评价-任务-教学班表';

-- ----------------------------
-- Table structure for t_end_term_task_tecl_survey_group
-- ----------------------------
DROP TABLE IF EXISTS `t_end_term_task_tecl_survey_group`;
CREATE TABLE `t_end_term_task_tecl_survey_group` (
  `id` bigint(20) NOT NULL COMMENT '主键ID（雪花算法生成）',
  `group_name` varchar(255) DEFAULT NULL COMMENT '组名',
  `task_id` bigint(20) DEFAULT NULL COMMENT '任务id',
  `sort_index` int(11) DEFAULT NULL COMMENT '排序',
  `create_user_id` bigint(20) DEFAULT NULL COMMENT '创建人id',
  `update_user_id` bigint(20) DEFAULT NULL COMMENT '更新人id',
  `version` int(11) NOT NULL DEFAULT '1' COMMENT '乐观锁版本号',
  `created_date_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `created_by` varchar(50) DEFAULT NULL COMMENT '创建人',
  `last_modified_date_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间',
  `last_modified_by` varchar(50) DEFAULT NULL COMMENT '最后修改人',
  `delete_flag` tinyint(4) NOT NULL DEFAULT '0' COMMENT '删除标志（0：正常，1：删除）',
  `tenant_id` varchar(50) NOT NULL COMMENT '租户编号',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_task_id` (`task_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='期末评价-任务-教学班问卷-组表';

-- ----------------------------
-- Table structure for t_end_term_task_time
-- ----------------------------
DROP TABLE IF EXISTS `t_end_term_task_time`;
CREATE TABLE `t_end_term_task_time` (
  `id` bigint(20) NOT NULL COMMENT '主键ID（雪花算法生成）',
  `task_id` bigint(20) DEFAULT NULL COMMENT '任务id',
  `start_time` datetime DEFAULT NULL COMMENT '任务开始时间',
  `end_time` datetime DEFAULT NULL COMMENT '任务结束时间',
  `week_num` int(11) DEFAULT NULL COMMENT '周次',
  `create_user_id` bigint(20) DEFAULT NULL COMMENT '创建人id',
  `update_user_id` bigint(20) DEFAULT NULL COMMENT '更新人id',
  `version` int(11) NOT NULL DEFAULT '1' COMMENT '乐观锁版本号',
  `created_date_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `created_by` varchar(50) DEFAULT NULL COMMENT '创建人',
  `last_modified_date_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间',
  `last_modified_by` varchar(50) DEFAULT NULL COMMENT '最后修改人',
  `delete_flag` tinyint(4) NOT NULL DEFAULT '0' COMMENT '删除标志（0：正常，1：删除）',
  `tenant_id` varchar(50) NOT NULL COMMENT '租户编号',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_task_id` (`task_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='期末评价-任务时间';

-- ----------------------------
-- Table structure for t_evaluate_type
-- ----------------------------
DROP TABLE IF EXISTS `t_evaluate_type`;
CREATE TABLE `t_evaluate_type` (
  `id` bigint(20) NOT NULL COMMENT '主键ID（雪花算法生成）',
  `type_code` tinyint(4) DEFAULT NULL COMMENT '类型编码',
  `type_name` varchar(255) DEFAULT NULL COMMENT '类型名称',
  `order_index` int(11) DEFAULT NULL COMMENT '排序值',
  `create_user_id` bigint(20) DEFAULT NULL COMMENT '创建人id',
  `update_user_id` bigint(20) DEFAULT NULL COMMENT '更新人id',
  `version` int(11) NOT NULL DEFAULT '1' COMMENT '乐观锁版本号',
  `created_date_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `created_by` varchar(50) DEFAULT NULL COMMENT '创建人',
  `last_modified_date_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间',
  `last_modified_by` varchar(50) DEFAULT NULL COMMENT '最后修改人',
  `delete_flag` tinyint(4) NOT NULL DEFAULT '0' COMMENT '删除标志（0：正常，1：删除）',
  `tenant_id` varchar(50) NOT NULL COMMENT '租户编号',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_type_code` (`type_code`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='评价类型表';

-- ----------------------------
-- Table structure for t_exemption_subject
-- ----------------------------
DROP TABLE IF EXISTS `t_exemption_subject`;
CREATE TABLE `t_exemption_subject` (
  `id` bigint(20) NOT NULL COMMENT '主键ID（雪花算法生成）',
  `subj_id` bigint(20) NOT NULL COMMENT '科目ID',
  `eval_scope` tinyint(4) NOT NULL COMMENT '不参评范围',
  `create_user_id` bigint(20) DEFAULT NULL COMMENT '创建人id',
  `update_user_id` bigint(20) DEFAULT NULL COMMENT '更新人id',
  `version` int(11) NOT NULL DEFAULT '1' COMMENT '乐观锁版本号',
  `created_date_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `created_by` varchar(50) DEFAULT NULL COMMENT '创建人',
  `last_modified_date_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间',
  `last_modified_by` varchar(50) DEFAULT NULL COMMENT '最后修改人',
  `delete_flag` tinyint(4) NOT NULL DEFAULT '0' COMMENT '删除标志（0：正常，1：删除）',
  `tenant_id` varchar(50) NOT NULL COMMENT '租户编号',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_subj_id_tenant_id_key` (`subj_id`,`tenant_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='不被评科目记录表';

-- ----------------------------
-- Table structure for t_exemption_teacher
-- ----------------------------
DROP TABLE IF EXISTS `t_exemption_teacher`;
CREATE TABLE `t_exemption_teacher` (
  `id` bigint(20) NOT NULL COMMENT '主键ID（雪花算法生成）',
  `user_id` bigint(20) NOT NULL COMMENT '用户ID',
  `eval_scope` tinyint(4) NOT NULL COMMENT '不参评范围',
  `create_user_id` bigint(20) DEFAULT NULL COMMENT '创建人id',
  `update_user_id` bigint(20) DEFAULT NULL COMMENT '更新人id',
  `version` int(11) NOT NULL DEFAULT '1' COMMENT '乐观锁版本号',
  `created_date_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `created_by` varchar(50) DEFAULT NULL COMMENT '创建人',
  `last_modified_date_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间',
  `last_modified_by` varchar(50) DEFAULT NULL COMMENT '最后修改人',
  `delete_flag` tinyint(4) NOT NULL DEFAULT '0' COMMENT '删除标志（0：正常，1：删除）',
  `tenant_id` varchar(50) NOT NULL COMMENT '租户编号',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_user_id_tenant_id_key` (`user_id`,`tenant_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='不被评教师记录表';

-- ----------------------------
-- Table structure for t_exemption_teaching_class
-- ----------------------------
DROP TABLE IF EXISTS `t_exemption_teaching_class`;
CREATE TABLE `t_exemption_teaching_class` (
  `id` bigint(20) NOT NULL COMMENT '主键ID（雪花算法生成）',
  `tecl_id` bigint(20) NOT NULL COMMENT '教学班ID',
  `eval_scope` tinyint(4) NOT NULL COMMENT '不参评范围',
  `create_user_id` bigint(20) DEFAULT NULL COMMENT '创建人id',
  `update_user_id` bigint(20) DEFAULT NULL COMMENT '更新人id',
  `version` int(11) NOT NULL DEFAULT '1' COMMENT '乐观锁版本号',
  `created_date_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `created_by` varchar(50) DEFAULT NULL COMMENT '创建人',
  `last_modified_date_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间',
  `last_modified_by` varchar(50) DEFAULT NULL COMMENT '最后修改人',
  `delete_flag` tinyint(4) NOT NULL DEFAULT '0' COMMENT '删除标志（0：正常，1：删除）',
  `tenant_id` varchar(50) NOT NULL COMMENT '租户编号',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_tecl_id_tenant_id_key` (`tecl_id`,`tenant_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='不被评教学班记录表';

-- ----------------------------
-- Table structure for t_expert_group
-- ----------------------------
DROP TABLE IF EXISTS `t_expert_group`;
CREATE TABLE `t_expert_group` (
  `id` bigint(20) NOT NULL COMMENT '主键ID（雪花算法生成）',
  `group_name` varchar(255) DEFAULT NULL COMMENT '专家组名称',
  `org_id` bigint(20) DEFAULT NULL COMMENT '管理组织id',
  `enable_status` tinyint(4) DEFAULT NULL COMMENT '启用状态 0-禁用 1-启用',
  `create_user_id` bigint(20) DEFAULT NULL COMMENT '创建人id',
  `update_user_id` bigint(20) DEFAULT NULL COMMENT '更新人id',
  `version` int(11) NOT NULL DEFAULT '1' COMMENT '乐观锁版本号',
  `created_date_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `created_by` varchar(50) DEFAULT NULL COMMENT '创建人',
  `last_modified_date_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间',
  `last_modified_by` varchar(50) DEFAULT NULL COMMENT '最后修改人',
  `delete_flag` tinyint(4) NOT NULL DEFAULT '0' COMMENT '删除标志（0：正常，1：删除）',
  `tenant_id` varchar(50) NOT NULL COMMENT '租户编号',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_org_id` (`org_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='专家组';

-- ----------------------------
-- Table structure for t_expert_group_member
-- ----------------------------
DROP TABLE IF EXISTS `t_expert_group_member`;
CREATE TABLE `t_expert_group_member` (
  `id` bigint(20) NOT NULL COMMENT '主键ID（雪花算法生成）',
  `expert_group_id` bigint(20) DEFAULT NULL COMMENT '专家组id',
  `user_id` bigint(20) DEFAULT NULL COMMENT '用户id',
  `leader_flag` tinyint(4) DEFAULT '0' COMMENT '是否为组长 0-否 1-是',
  `create_user_id` bigint(20) DEFAULT NULL COMMENT '创建人id',
  `update_user_id` bigint(20) DEFAULT NULL COMMENT '更新人id',
  `version` int(11) NOT NULL DEFAULT '1' COMMENT '乐观锁版本号',
  `created_date_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `created_by` varchar(50) DEFAULT NULL COMMENT '创建人',
  `last_modified_date_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间',
  `last_modified_by` varchar(50) DEFAULT NULL COMMENT '最后修改人',
  `delete_flag` tinyint(4) NOT NULL DEFAULT '0' COMMENT '删除标志（0：正常，1：删除）',
  `tenant_id` varchar(50) NOT NULL COMMENT '租户编号',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_expert_group_id` (`expert_group_id`) USING BTREE,
  KEY `idx_user_id` (`user_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='专家组成员';

-- ----------------------------
-- Table structure for t_extract_filter_classroom
-- ----------------------------
DROP TABLE IF EXISTS `t_extract_filter_classroom`;
CREATE TABLE `t_extract_filter_classroom` (
  `id` bigint(20) NOT NULL COMMENT '主键ID（雪花算法生成）',
  `clro_id` bigint(20) DEFAULT NULL COMMENT '需过滤的教室id',
  `create_user_id` bigint(20) DEFAULT NULL COMMENT '创建人id',
  `update_user_id` bigint(20) DEFAULT NULL COMMENT '更新人id',
  `version` int(11) NOT NULL DEFAULT '1' COMMENT '乐观锁版本号',
  `created_date_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `created_by` varchar(50) DEFAULT NULL COMMENT '创建人',
  `last_modified_date_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间',
  `last_modified_by` varchar(50) DEFAULT NULL COMMENT '最后修改人',
  `delete_flag` tinyint(4) NOT NULL DEFAULT '0' COMMENT '删除标志（0：正常，1：删除）',
  `tenant_id` varchar(50) NOT NULL COMMENT '租户编号',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_clro_id` (`clro_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='不抽取的教室表';

-- ----------------------------
-- Table structure for t_extract_task
-- ----------------------------
DROP TABLE IF EXISTS `t_extract_task`;
CREATE TABLE `t_extract_task` (
  `id` bigint(20) NOT NULL COMMENT '主键ID（雪花算法生成）',
  `task_name` varchar(200) DEFAULT NULL COMMENT '任务名称',
  `org_id` bigint(20) DEFAULT NULL COMMENT '管理组织id',
  `educational_levels` varchar(50) DEFAULT NULL COMMENT '学历层次 1-本科 2-研究生  多个,隔开',
  `task_status` int(11) DEFAULT '0' COMMENT '抽课任务状态 0-待导入 1-待抽取 2-待下发审查任务 3-待视频审查 4-待教师选课 5-待分配专家 6-待下发督导任务 7-已下发督导任务',
  `create_user_id` bigint(20) DEFAULT NULL COMMENT '创建人id',
  `update_user_id` bigint(20) DEFAULT NULL COMMENT '更新人id',
  `version` int(11) NOT NULL DEFAULT '1' COMMENT '乐观锁版本号',
  `created_date_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `created_by` varchar(50) DEFAULT NULL COMMENT '创建人',
  `last_modified_date_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间',
  `last_modified_by` varchar(50) DEFAULT NULL COMMENT '最后修改人',
  `delete_flag` tinyint(4) NOT NULL DEFAULT '0' COMMENT '删除标志（0：正常，1：删除）',
  `tenant_id` varchar(50) NOT NULL COMMENT '租户编号',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_org_id` (`org_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='抽课任务表';

-- ----------------------------
-- Table structure for t_extract_task_distribute_group_rule
-- ----------------------------
DROP TABLE IF EXISTS `t_extract_task_distribute_group_rule`;
CREATE TABLE `t_extract_task_distribute_group_rule` (
  `id` bigint(20) NOT NULL COMMENT '主键ID（雪花算法生成）',
  `extract_task_id` bigint(20) DEFAULT NULL COMMENT '抽课任务id',
  `expert_group_id` bigint(20) DEFAULT NULL COMMENT '专家组id',
  `inner_min_teacher_num` int(11) DEFAULT NULL COMMENT '校内专家分配教师人数下限',
  `outer_min_teacher_num` int(11) DEFAULT NULL COMMENT '校外专家分配教师人数下限',
  `create_user_id` bigint(20) DEFAULT NULL COMMENT '创建人id',
  `update_user_id` bigint(20) DEFAULT NULL COMMENT '更新人id',
  `version` int(11) NOT NULL DEFAULT '1' COMMENT '乐观锁版本号',
  `created_date_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `created_by` varchar(50) DEFAULT NULL COMMENT '创建人',
  `last_modified_date_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间',
  `last_modified_by` varchar(50) DEFAULT NULL COMMENT '最后修改人',
  `delete_flag` tinyint(4) NOT NULL DEFAULT '0' COMMENT '删除标志（0：正常，1：删除）',
  `tenant_id` varchar(50) NOT NULL COMMENT '租户编号',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_expert_group_id` (`expert_group_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='抽课任务专家组分配规则表';

-- ----------------------------
-- Table structure for t_extract_task_process
-- ----------------------------
DROP TABLE IF EXISTS `t_extract_task_process`;
CREATE TABLE `t_extract_task_process` (
  `id` bigint(20) NOT NULL COMMENT '主键ID（雪花算法生成）',
  `extract_task_id` bigint(20) DEFAULT NULL COMMENT '抽课任务id',
  `teacher_user_id` bigint(20) DEFAULT NULL COMMENT '教师用户id',
  `video_review_end_time` datetime DEFAULT NULL COMMENT '视频审查截止时间',
  `teacher_select_end_time` datetime DEFAULT NULL COMMENT '教师选课截止时间',
  `extract_course_limit` int(11) DEFAULT NULL COMMENT '每人抽取视频数',
  `teacher_select_course_limit` int(11) DEFAULT NULL COMMENT '每个教师最终参评视频数',
  `review_passed_count` int(11) DEFAULT NULL COMMENT '当前已审查通过数量',
  `review_end_flag` tinyint(4) DEFAULT '0' COMMENT '是否审核完成 0-否 1-是',
  `review_over_time_auto_flag` tinyint(4) DEFAULT '0' COMMENT '超时自动审核通过标识 0-否 1-是',
  `select_end_flag` tinyint(4) DEFAULT '0' COMMENT '教师是否选课完成 0-否 1-是',
  `select_result_type` tinyint(4) DEFAULT '0' COMMENT '教师选课结果类型 0-未选课 1-自选确认 2-超时自动确认 3-自选数不足自动确认 4-阻断(无视频)',
  `select_over_time_auto_flag` tinyint(4) DEFAULT '0' COMMENT '超时自动选课标识 0-否 1-是',
  `select_final_count` int(11) DEFAULT NULL COMMENT '教师选课最终数量',
  `create_user_id` bigint(20) DEFAULT NULL COMMENT '创建人id',
  `update_user_id` bigint(20) DEFAULT NULL COMMENT '更新人id',
  `version` int(11) NOT NULL DEFAULT '1' COMMENT '乐观锁版本号',
  `created_date_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `created_by` varchar(50) DEFAULT NULL COMMENT '创建人',
  `last_modified_date_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间',
  `last_modified_by` varchar(50) DEFAULT NULL COMMENT '最后修改人',
  `delete_flag` tinyint(4) NOT NULL DEFAULT '0' COMMENT '删除标志（0：正常，1：删除）',
  `tenant_id` varchar(50) NOT NULL COMMENT '租户编号',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_task_teacher` (`extract_task_id`,`teacher_user_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='抽课任务-任务进度表';

-- ----------------------------
-- Table structure for t_extract_task_rule
-- ----------------------------
DROP TABLE IF EXISTS `t_extract_task_rule`;
CREATE TABLE `t_extract_task_rule` (
  `id` bigint(20) NOT NULL COMMENT '主键ID（雪花算法生成）',
  `extract_task_id` bigint(20) DEFAULT NULL COMMENT '抽课任务id',
  `video_review_end_time` datetime DEFAULT NULL COMMENT '视频审查截止时间',
  `teacher_select_end_time` datetime DEFAULT NULL COMMENT '教师选课截止时间',
  `course_begin_time` datetime DEFAULT NULL COMMENT '抽课课程开始时间',
  `course_end_time` datetime DEFAULT NULL COMMENT '抽课课程结束时间',
  `educational_levels` varchar(50) DEFAULT NULL COMMENT '学历层次 1-本科 2-研究生  多个,隔开',
  `extract_course_limit` int(11) DEFAULT NULL COMMENT '每人抽取视频数',
  `teacher_select_course_limit` int(11) DEFAULT NULL COMMENT '每个教师最终参评视频数',
  `distribute_mode` tinyint(4) DEFAULT NULL COMMENT '分配模式: 1-校内外专家模式 2-单专家模式',
  `expert_distribute_min_teacher_num` int(11) DEFAULT NULL COMMENT '专家分配到的老师数最小值',
  `create_user_id` bigint(20) DEFAULT NULL COMMENT '创建人id',
  `update_user_id` bigint(20) DEFAULT NULL COMMENT '更新人id',
  `version` int(11) NOT NULL DEFAULT '1' COMMENT '乐观锁版本号',
  `created_date_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `created_by` varchar(50) DEFAULT NULL COMMENT '创建人',
  `last_modified_date_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间',
  `last_modified_by` varchar(50) DEFAULT NULL COMMENT '最后修改人',
  `delete_flag` tinyint(4) NOT NULL DEFAULT '0' COMMENT '删除标志（0：正常，1：删除）',
  `tenant_id` varchar(50) NOT NULL COMMENT '租户编号',
  `teacher_inner_expert_num` int(11) DEFAULT NULL COMMENT '每教师校内专家数',
  `teacher_outer_expert_num` int(11) DEFAULT NULL COMMENT '每教师校外专家数',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_extract_task_id` (`extract_task_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='抽课任务规则表';

-- ----------------------------
-- Table structure for t_extract_task_rule_filter_classroom
-- ----------------------------
DROP TABLE IF EXISTS `t_extract_task_rule_filter_classroom`;
CREATE TABLE `t_extract_task_rule_filter_classroom` (
  `id` bigint(20) NOT NULL COMMENT '主键ID（雪花算法生成）',
  `extract_task_rule_id` bigint(20) DEFAULT NULL COMMENT '抽课任务规则id',
  `clro_id` bigint(20) DEFAULT NULL COMMENT '不被抽的教室id',
  `create_user_id` bigint(20) DEFAULT NULL COMMENT '创建人id',
  `update_user_id` bigint(20) DEFAULT NULL COMMENT '更新人id',
  `version` int(11) NOT NULL DEFAULT '1' COMMENT '乐观锁版本号',
  `created_date_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `created_by` varchar(50) DEFAULT NULL COMMENT '创建人',
  `last_modified_date_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间',
  `last_modified_by` varchar(50) DEFAULT NULL COMMENT '最后修改人',
  `delete_flag` tinyint(4) NOT NULL DEFAULT '0' COMMENT '删除标志（0：正常，1：删除）',
  `tenant_id` varchar(50) NOT NULL COMMENT '租户编号',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_extract_task_rule_id` (`extract_task_rule_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='抽课任务-规则过滤教室表';

-- ----------------------------
-- Table structure for t_extract_task_rule_type_ratio
-- ----------------------------
DROP TABLE IF EXISTS `t_extract_task_rule_type_ratio`;
CREATE TABLE `t_extract_task_rule_type_ratio` (
  `id` bigint(20) NOT NULL COMMENT '主键ID（雪花算法生成）',
  `extract_task_rule_id` bigint(20) DEFAULT NULL COMMENT '抽课任务规则id',
  `teacher_extract_type` varchar(50) DEFAULT NULL COMMENT '教师抽取类型名',
  `ratio` int(11) DEFAULT NULL COMMENT '比例，如 30 表示 30%',
  `create_user_id` bigint(20) DEFAULT NULL COMMENT '创建人id',
  `update_user_id` bigint(20) DEFAULT NULL COMMENT '更新人id',
  `version` int(11) NOT NULL DEFAULT '1' COMMENT '乐观锁版本号',
  `created_date_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `created_by` varchar(50) DEFAULT NULL COMMENT '创建人',
  `last_modified_date_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间',
  `last_modified_by` varchar(50) DEFAULT NULL COMMENT '最后修改人',
  `delete_flag` tinyint(4) NOT NULL DEFAULT '0' COMMENT '删除标志（0：正常，1：删除）',
  `tenant_id` varchar(50) NOT NULL COMMENT '租户编号',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_extract_task_rule_id` (`extract_task_rule_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='抽课任务规则-教师类型比例表';

-- ----------------------------
-- Table structure for t_extract_task_sup
-- ----------------------------
DROP TABLE IF EXISTS `t_extract_task_sup`;
CREATE TABLE `t_extract_task_sup` (
  `id` bigint(20) NOT NULL COMMENT '主键ID（雪花算法生成）',
  `extract_task_id` bigint(20) DEFAULT NULL COMMENT '抽课任务id',
  `sup_task_id` bigint(20) DEFAULT NULL COMMENT '督导任务id',
  `educational_level` int(11) DEFAULT NULL COMMENT '学历层次 1-本科 2-研究生',
  `create_user_id` bigint(20) DEFAULT NULL COMMENT '创建人id',
  `update_user_id` bigint(20) DEFAULT NULL COMMENT '更新人id',
  `version` int(11) NOT NULL DEFAULT '1' COMMENT '乐观锁版本号',
  `created_date_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `created_by` varchar(50) DEFAULT NULL COMMENT '创建人',
  `last_modified_date_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间',
  `last_modified_by` varchar(50) DEFAULT NULL COMMENT '最后修改人',
  `delete_flag` tinyint(4) NOT NULL DEFAULT '0' COMMENT '删除标志（0：正常，1：删除）',
  `tenant_id` varchar(50) NOT NULL COMMENT '租户编号',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_extract_task_id` (`extract_task_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='抽课和督导任务关系表';

-- ----------------------------
-- Table structure for t_extract_task_teacher
-- ----------------------------
DROP TABLE IF EXISTS `t_extract_task_teacher`;
CREATE TABLE `t_extract_task_teacher` (
  `id` bigint(20) NOT NULL COMMENT '主键ID（雪花算法生成）',
  `extract_task_id` bigint(20) DEFAULT NULL COMMENT '抽课任务id',
  `teacher_user_id` bigint(20) DEFAULT NULL COMMENT '教师用户id',
  `teacher_user_code` varchar(100) DEFAULT NULL COMMENT '教师用户编号',
  `teacher_user_name` varchar(100) DEFAULT NULL COMMENT '教师用户名称',
  `teacher_extract_type` varchar(50) DEFAULT NULL COMMENT '教师抽取类型名',
  `expert_group_id` bigint(20) DEFAULT NULL COMMENT '专家组id',
  `drawn_flag` tinyint(4) NOT NULL DEFAULT '0' COMMENT '是否抽中 0-否 1-是',
  `create_user_id` bigint(20) DEFAULT NULL COMMENT '创建人id',
  `update_user_id` bigint(20) DEFAULT NULL COMMENT '更新人id',
  `version` int(11) NOT NULL DEFAULT '1' COMMENT '乐观锁版本号',
  `created_date_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `created_by` varchar(50) DEFAULT NULL COMMENT '创建人',
  `last_modified_date_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间',
  `last_modified_by` varchar(50) DEFAULT NULL COMMENT '最后修改人',
  `delete_flag` tinyint(4) NOT NULL DEFAULT '0' COMMENT '删除标志（0：正常，1：删除）',
  `tenant_id` varchar(50) NOT NULL COMMENT '租户编号',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_extract_task_id_drawn_flag` (`extract_task_id`,`drawn_flag`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='抽课任务教师表';

-- ----------------------------
-- Table structure for t_extract_task_teacher_expert
-- ----------------------------
DROP TABLE IF EXISTS `t_extract_task_teacher_expert`;
CREATE TABLE `t_extract_task_teacher_expert` (
  `id` bigint(20) NOT NULL COMMENT '主键ID（雪花算法生成）',
  `extract_task_teacher_id` bigint(20) DEFAULT NULL COMMENT '抽课任务老师表id',
  `expert_user_type` tinyint(4) DEFAULT NULL COMMENT '被分配专家用户类型 1-校内 2-校外',
  `expert_group_id` bigint(20) DEFAULT NULL COMMENT '专家组id',
  `expert_user_id` bigint(20) DEFAULT NULL COMMENT '被分配专家用户id',
  `expert_user_code` varchar(100) DEFAULT NULL COMMENT '被分配专家用户编码',
  `expert_user_name` varchar(255) DEFAULT NULL COMMENT '被分配专家用户名称',
  `create_user_id` bigint(20) DEFAULT NULL COMMENT '创建人id',
  `update_user_id` bigint(20) DEFAULT NULL COMMENT '更新人id',
  `version` int(11) NOT NULL DEFAULT '1' COMMENT '乐观锁版本号',
  `created_date_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `created_by` varchar(50) DEFAULT NULL COMMENT '创建人',
  `last_modified_date_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间',
  `last_modified_by` varchar(50) DEFAULT NULL COMMENT '最后修改人',
  `delete_flag` tinyint(4) NOT NULL DEFAULT '0' COMMENT '删除标志（0：正常，1：删除）',
  `tenant_id` varchar(50) NOT NULL COMMENT '租户编号',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_extract_task_teacher_id` (`extract_task_teacher_id`) USING BTREE,
  KEY `idx_expert_user_id` (`expert_user_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='抽课任务老师专家表';

-- ----------------------------
-- Table structure for t_extract_task_teacher_select_result
-- ----------------------------
DROP TABLE IF EXISTS `t_extract_task_teacher_select_result`;
CREATE TABLE `t_extract_task_teacher_select_result` (
  `id` bigint(20) NOT NULL COMMENT '主键ID（雪花算法生成）',
  `extract_task_id` bigint(20) DEFAULT NULL COMMENT '抽课任务id',
  `teacher_user_id` bigint(20) DEFAULT NULL COMMENT '教师用户id',
  `course_id` bigint(20) DEFAULT NULL COMMENT '课程id',
  `educational_level` int(11) DEFAULT NULL COMMENT '学历层次 1-本科 2-研究生',
  `select_result_type` tinyint(4) DEFAULT '0' COMMENT '教师选课结果类型 0-未选课 1-自选确认 2-超时自动确认 3-自选数不足自动确认 4-阻断(无视频)',
  `create_user_id` bigint(20) DEFAULT NULL COMMENT '创建人id',
  `update_user_id` bigint(20) DEFAULT NULL COMMENT '更新人id',
  `version` int(11) NOT NULL DEFAULT '1' COMMENT '乐观锁版本号',
  `created_date_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `created_by` varchar(50) DEFAULT NULL COMMENT '创建人',
  `last_modified_date_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间',
  `last_modified_by` varchar(50) DEFAULT NULL COMMENT '最后修改人',
  `delete_flag` tinyint(4) NOT NULL DEFAULT '0' COMMENT '删除标志（0：正常，1：删除）',
  `tenant_id` varchar(50) NOT NULL COMMENT '租户编号',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_task_teacher` (`extract_task_id`,`teacher_user_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='抽课任务-教师选评课结果表';

-- ----------------------------
-- Table structure for t_extract_task_video_review_result
-- ----------------------------
DROP TABLE IF EXISTS `t_extract_task_video_review_result`;
CREATE TABLE `t_extract_task_video_review_result` (
  `id` bigint(20) NOT NULL COMMENT '主键ID（雪花算法生成）',
  `extract_task_id` bigint(20) DEFAULT NULL COMMENT '抽课任务id',
  `teacher_user_id` bigint(20) DEFAULT NULL COMMENT '教师用户id',
  `course_id` bigint(20) DEFAULT NULL COMMENT '课程id',
  `review_result` tinyint(4) DEFAULT NULL COMMENT '审批结果 0-驳回 1-通过',
  `review_over_time_auto_flag` tinyint(4) DEFAULT '0' COMMENT '超时自动审核通过标识 0-否 1-是',
  `educational_level` int(11) DEFAULT NULL COMMENT '学历层次 1-本科 2-研究生',
  `create_user_id` bigint(20) DEFAULT NULL COMMENT '创建人id',
  `update_user_id` bigint(20) DEFAULT NULL COMMENT '更新人id',
  `version` int(11) NOT NULL DEFAULT '1' COMMENT '乐观锁版本号',
  `created_date_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `created_by` varchar(50) DEFAULT NULL COMMENT '创建人',
  `last_modified_date_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间',
  `last_modified_by` varchar(50) DEFAULT NULL COMMENT '最后修改人',
  `delete_flag` tinyint(4) NOT NULL DEFAULT '0' COMMENT '删除标志（0：正常，1：删除）',
  `tenant_id` varchar(50) NOT NULL COMMENT '租户编号',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_task_teacher_review_result` (`extract_task_id`,`teacher_user_id`,`review_result`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='抽课任务-视频审查结果表';

-- ----------------------------
-- Table structure for t_leader_course_record
-- ----------------------------
DROP TABLE IF EXISTS `t_leader_course_record`;
CREATE TABLE `t_leader_course_record` (
  `id` bigint(20) NOT NULL COMMENT '主键ID（雪花算法生成）',
  `sup_task_id` bigint(20) DEFAULT NULL COMMENT '督导任务id',
  `sup_status` tinyint(4) DEFAULT NULL COMMENT '督导评价 0-未评 1-已评',
  `cour_id` bigint(20) DEFAULT NULL COMMENT '课程id',
  `acte_id` bigint(20) DEFAULT NULL COMMENT '学期id',
  `subj_id` bigint(20) DEFAULT NULL COMMENT '科目id',
  `subj_code` varchar(100) DEFAULT NULL COMMENT '科目编码',
  `subj_name` varchar(255) DEFAULT NULL COMMENT '科目名称',
  `sup_user_id` bigint(20) DEFAULT NULL COMMENT '督导用户id',
  `sup_user_code` varchar(100) DEFAULT NULL COMMENT '督导用户编码',
  `sup_user_name` varchar(255) DEFAULT NULL COMMENT '督导用户名称',
  `sup_user_level` tinyint(4) DEFAULT NULL COMMENT '督导级别 1-校级督导 2-院级督导 3-校，院级督导',
  `by_sup_user_id` bigint(20) DEFAULT NULL COMMENT '被评用户id',
  `by_sup_user_code` varchar(100) DEFAULT NULL COMMENT '被评用户编码',
  `by_sup_user_name` varchar(255) DEFAULT NULL COMMENT '被评用户名称',
  `tecl_org_id` bigint(20) DEFAULT NULL COMMENT '排课院系id',
  `tecl_org_code` varchar(100) DEFAULT NULL COMMENT '排课院系编码',
  `tecl_org_name` varchar(255) DEFAULT NULL COMMENT '排课院系名称',
  `tecl_id` bigint(20) DEFAULT NULL COMMENT '教学班id',
  `tecl_code` varchar(100) DEFAULT NULL COMMENT '教学班编码',
  `tecl_name` varchar(255) DEFAULT NULL COMMENT '教学班名称',
  `cour_begin_time` datetime DEFAULT NULL COMMENT '课程开始时间',
  `cour_end_time` datetime DEFAULT NULL COMMENT '课程结束时间',
  `leti_number` int(11) DEFAULT NULL COMMENT '课程节次',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `create_user_id` bigint(20) DEFAULT NULL COMMENT '创建人id',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `update_user_id` bigint(20) DEFAULT NULL COMMENT '更新人id',
  `version` int(11) NOT NULL DEFAULT '1' COMMENT '乐观锁版本号',
  `created_date_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `created_by` varchar(50) DEFAULT NULL COMMENT '创建人',
  `last_modified_date_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间',
  `last_modified_by` varchar(50) DEFAULT NULL COMMENT '最后修改人',
  `delete_flag` tinyint(4) NOT NULL DEFAULT '0' COMMENT '删除标志（0：正常，1：删除）',
  `tenant_id` varchar(50) NOT NULL COMMENT '租户编号',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_sup_task_id` (`sup_task_id`) USING BTREE,
  KEY `idx_cour_id` (`cour_id`) USING BTREE,
  KEY `idx_acte_id` (`acte_id`) USING BTREE,
  KEY `idx_subj_id` (`subj_id`) USING BTREE,
  KEY `idx_sup_user_id` (`sup_user_id`) USING BTREE,
  KEY `idx_by_sup_user_id` (`by_sup_user_id`) USING BTREE,
  KEY `idx_tecl_id` (`tecl_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='领导评价-课程节次评价-记录';

-- ----------------------------
-- Table structure for t_leader_record_photo_review
-- ----------------------------
DROP TABLE IF EXISTS `t_leader_record_photo_review`;
CREATE TABLE `t_leader_record_photo_review` (
  `id` bigint(20) NOT NULL COMMENT '主键ID（雪花算法生成）',
  `sup_task_id` bigint(20) DEFAULT NULL COMMENT '督导任务id',
  `sup_user_id` bigint(20) DEFAULT NULL COMMENT '督导用户id',
  `subj_id` bigint(20) DEFAULT NULL COMMENT '科目id-评价到课程时有值',
  `teacher_user_id` bigint(20) DEFAULT NULL COMMENT '老师用户id-评价到课程时有值',
  `org_id` bigint(20) DEFAULT NULL COMMENT '院系id-评价到课程时有值',
  `review_type` tinyint(4) DEFAULT NULL COMMENT '点评类型 1-好评 2-差评',
  `review_content` text COMMENT '点评内容',
  `cour_id` bigint(20) DEFAULT NULL COMMENT '课程id',
  `process_start_time` varchar(255) DEFAULT NULL COMMENT '进度时间-开始 格式 yyyy-MM-dd HH:mm:ss',
  `process_end_time` varchar(255) DEFAULT NULL COMMENT '进度时间-结束 格式 yyyy-MM-dd HH:mm:ss',
  `play_start_time` varchar(255) DEFAULT NULL COMMENT '播放进度时间-开始 格式 HH:mm:ss',
  `play_end_time` varchar(255) DEFAULT NULL COMMENT '播放进度时间-结束 格式 HH:mm:ss',
  `create_user_id` bigint(20) DEFAULT NULL COMMENT '创建人id',
  `update_user_id` bigint(20) DEFAULT NULL COMMENT '更新人id',
  `version` int(11) NOT NULL DEFAULT '1' COMMENT '乐观锁版本号',
  `created_date_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `created_by` varchar(50) DEFAULT NULL COMMENT '创建人',
  `last_modified_date_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间',
  `last_modified_by` varchar(50) DEFAULT NULL COMMENT '最后修改人',
  `delete_flag` tinyint(4) NOT NULL DEFAULT '0' COMMENT '删除标志（0：正常，1：删除）',
  `tenant_id` varchar(50) NOT NULL COMMENT '租户编号',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_sup_task_id` (`sup_task_id`) USING BTREE,
  KEY `idx_cour_id` (`cour_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='领导评价-评价-拍照点评表';

-- ----------------------------
-- Table structure for t_leader_record_photo_review_file
-- ----------------------------
DROP TABLE IF EXISTS `t_leader_record_photo_review_file`;
CREATE TABLE `t_leader_record_photo_review_file` (
  `id` bigint(20) NOT NULL COMMENT '主键ID（雪花算法生成）',
  `sup_record_photo_review_id` bigint(20) NOT NULL COMMENT '拍照点评id',
  `file_id` bigint(20) NOT NULL COMMENT '文件id',
  `file_name` varchar(255) NOT NULL COMMENT '文件名称',
  `file_url` varchar(500) NOT NULL COMMENT '文件url',
  `file_size` bigint(20) DEFAULT NULL COMMENT '文件大小',
  `create_user_id` bigint(20) DEFAULT NULL COMMENT '创建人id',
  `update_user_id` bigint(20) DEFAULT NULL COMMENT '更新人id',
  `version` int(11) NOT NULL DEFAULT '1' COMMENT '乐观锁版本号',
  `created_date_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `created_by` varchar(50) DEFAULT NULL COMMENT '创建人',
  `last_modified_date_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间',
  `last_modified_by` varchar(50) DEFAULT NULL COMMENT '最后修改人',
  `delete_flag` tinyint(4) NOT NULL DEFAULT '0' COMMENT '删除标志（0：正常，1：删除）',
  `tenant_id` varchar(50) NOT NULL COMMENT '租户编号',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_sup_record_photo_review_id` (`sup_record_photo_review_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='领导评价-评价-拍照点评-文件表';

-- ----------------------------
-- Table structure for t_leader_record_survey
-- ----------------------------
DROP TABLE IF EXISTS `t_leader_record_survey`;
CREATE TABLE `t_leader_record_survey` (
  `id` bigint(20) NOT NULL COMMENT '主键ID（雪花算法生成）',
  `sup_task_id` bigint(20) DEFAULT NULL COMMENT '督导任务id',
  `sup_record_id` bigint(20) DEFAULT NULL COMMENT '督导记录id',
  `sup_dim_code` tinyint(4) DEFAULT NULL COMMENT '评价维度 1-评价到教学班 2-评价到课程',
  `survey_id` varchar(255) DEFAULT NULL COMMENT '问卷id',
  `survey_name` varchar(255) DEFAULT NULL COMMENT '问卷名称',
  `survey_data_id` varchar(255) DEFAULT NULL COMMENT '问卷填写数据id',
  `survey_submit_status` tinyint(4) DEFAULT NULL COMMENT '问卷提交状态 草稿：-1 ，已提交：1',
  `survey_submit_time` datetime DEFAULT NULL COMMENT '问卷提交时间',
  `sup_result_score` decimal(5,2) DEFAULT NULL COMMENT '问卷结果得分',
  `reason` varchar(2000) DEFAULT NULL COMMENT '理由',
  `create_user_id` bigint(20) DEFAULT NULL COMMENT '创建人id',
  `update_user_id` bigint(20) DEFAULT NULL COMMENT '更新人id',
  `version` int(11) NOT NULL DEFAULT '1' COMMENT '乐观锁版本号',
  `created_date_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `created_by` varchar(50) DEFAULT NULL COMMENT '创建人',
  `last_modified_date_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间',
  `last_modified_by` varchar(50) DEFAULT NULL COMMENT '最后修改人',
  `delete_flag` tinyint(4) NOT NULL DEFAULT '0' COMMENT '删除标志（0：正常，1：删除）',
  `tenant_id` varchar(50) NOT NULL COMMENT '租户编号',
  `reason_type` tinyint(4) DEFAULT NULL COMMENT '理由类型- 1-低 2-高',
  `score_level_id` bigint(20) DEFAULT NULL COMMENT '选中的评分等级id',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_sup_task_id` (`sup_task_id`) USING BTREE,
  KEY `idx_sup_record_id` (`sup_record_id`) USING BTREE,
  KEY `idx_survey_id` (`survey_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='领导评价-评价-问卷';

-- ----------------------------
-- Table structure for t_leader_subject_record
-- ----------------------------
DROP TABLE IF EXISTS `t_leader_subject_record`;
CREATE TABLE `t_leader_subject_record` (
  `id` bigint(20) NOT NULL COMMENT '主键ID（雪花算法生成）',
  `sup_task_id` bigint(20) DEFAULT NULL COMMENT '督导任务id',
  `sup_status` tinyint(4) DEFAULT NULL COMMENT '督导评价 0-未评 1-已评',
  `acte_id` bigint(20) DEFAULT NULL COMMENT '学期id',
  `subj_id` bigint(20) DEFAULT NULL COMMENT '科目id',
  `subj_code` varchar(100) DEFAULT NULL COMMENT '科目编码',
  `subj_name` varchar(255) DEFAULT NULL COMMENT '科目名称',
  `org_id` bigint(20) DEFAULT NULL COMMENT '院系id',
  `org_code` varchar(100) DEFAULT NULL COMMENT '院系编码',
  `org_name` varchar(255) DEFAULT NULL COMMENT '院系名称',
  `sup_user_id` bigint(20) DEFAULT NULL COMMENT '督导用户id',
  `sup_user_code` varchar(100) DEFAULT NULL COMMENT '督导用户编码',
  `sup_user_name` varchar(255) DEFAULT NULL COMMENT '督导用户名称',
  `sup_user_level` tinyint(4) DEFAULT NULL COMMENT '督导级别 1-校级督导 2-院级督导 3-校，院级督导',
  `by_sup_user_id` bigint(20) DEFAULT NULL COMMENT '被评用户id',
  `by_sup_user_code` varchar(100) DEFAULT NULL COMMENT '被评用户编码',
  `by_sup_user_name` varchar(255) DEFAULT NULL COMMENT '被评用户名称',
  `create_user_id` bigint(20) DEFAULT NULL COMMENT '创建人id',
  `update_user_id` bigint(20) DEFAULT NULL COMMENT '更新人id',
  `version` int(11) NOT NULL DEFAULT '1' COMMENT '乐观锁版本号',
  `created_date_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `created_by` varchar(50) DEFAULT NULL COMMENT '创建人',
  `last_modified_date_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间',
  `last_modified_by` varchar(50) DEFAULT NULL COMMENT '最后修改人',
  `delete_flag` tinyint(4) NOT NULL DEFAULT '0' COMMENT '删除标志（0：正常，1：删除）',
  `tenant_id` varchar(50) NOT NULL COMMENT '租户编号',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_sup_task_id` (`sup_task_id`) USING BTREE,
  KEY `idx_acte_id` (`acte_id`) USING BTREE,
  KEY `idx_subj_id` (`subj_id`) USING BTREE,
  KEY `idx_org_id` (`org_id`) USING BTREE,
  KEY `idx_sup_user_id` (`sup_user_id`) USING BTREE,
  KEY `idx_by_sup_user_id` (`by_sup_user_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='领导评价-课程(科目)评价-记录';

-- ----------------------------
-- Table structure for t_leader_task
-- ----------------------------
DROP TABLE IF EXISTS `t_leader_task`;
CREATE TABLE `t_leader_task` (
  `id` bigint(20) NOT NULL COMMENT '主键ID（雪花算法生成）',
  `task_name` varchar(255) DEFAULT NULL COMMENT '任务名称',
  `sup_dim_code` tinyint(4) DEFAULT NULL COMMENT '评价维度 1-评价到教学班 2-评价到课程',
  `educational_level` tinyint(4) DEFAULT NULL COMMENT '学历层次 1-本科 2-研究生',
  `task_level` tinyint(4) DEFAULT NULL COMMENT '任务级别 1-校级 2-院级',
  `task_org_id` bigint(20) DEFAULT NULL COMMENT '任务所属组织id',
  `acte_id` bigint(20) DEFAULT NULL COMMENT '学期id',
  `task_status` tinyint(4) DEFAULT NULL COMMENT '任务状态 0-未发布 1-已发布',
  `task_start_time` datetime DEFAULT NULL COMMENT '任务开始时间',
  `task_end_time` datetime DEFAULT NULL COMMENT '任务结束时间',
  `sup_online_type` tinyint(4) DEFAULT NULL COMMENT '在线听课类型 1-不允许在线听课 2-仅允许观看直播 3-仅允许观看点播 4-允许同时观看直播和点播',
  `sup_reason_enable` tinyint(4) DEFAULT NULL COMMENT '评分是否需要填写理由',
  `sup_reason_high_type` tinyint(4) DEFAULT NULL COMMENT '高分区间类型 1-大于 2-大于等于',
  `sup_reason_high_score` decimal(5,2) DEFAULT NULL COMMENT '高分分值',
  `sup_reason_low_type` tinyint(4) DEFAULT NULL COMMENT '低分区间类型 1-大于 2-大于等于',
  `sup_reason_low_score` decimal(5,2) DEFAULT NULL COMMENT '低分分值',
  `college_admin_result_enable` tinyint(4) DEFAULT NULL COMMENT '院系管理员是否可查看校级任务内本院系的数据',
  `college_admin_result_anonymous` tinyint(4) DEFAULT '0' COMMENT '院系管理员-督导信息匿名 0-匿名（默认） 1-不匿名',
  `by_sup_user_result_enable` tinyint(4) DEFAULT '0' COMMENT '被评用户-是否允许查看任务结果（默认不允许）',
  `by_sup_user_result_type` tinyint(4) DEFAULT NULL COMMENT '被评用户-可查看结果类型 1-仅查看文本意见 2-查看整个评价表',
  `opinion_communication_enable` tinyint(4) DEFAULT NULL COMMENT '配置意见反馈题时，允许评价者（匿名）与被评者实时沟通',
  `score_level_enable` tinyint(4) DEFAULT NULL COMMENT '是否开启评分区段',
  `claim_limit_type` tinyint(4) DEFAULT NULL COMMENT '认领上限类型 1-不设置认领上限 2-设置同一教师被认领次数上限 3-设置同一教师同一课程被认领次数上限',
  `claim_limit_num` int(11) DEFAULT NULL COMMENT '认领上限次数',
  `claim_course_time_range_enable` tinyint(4) DEFAULT NULL COMMENT '是否设置认领的课表日期范围 0-否 1-是',
  `claim_course_time_range_front_day` int(11) DEFAULT NULL COMMENT '督导可认领当日及前N天课表',
  `claim_course_time_range_back_day` int(11) DEFAULT NULL COMMENT '督导可认领当日及后N天课表',
  `claim_task_time_validity_enable` tinyint(4) DEFAULT NULL COMMENT '是否设置任务自动释放的时效 0-否 1-是',
  `claim_task_time_validity_day` int(11) DEFAULT NULL COMMENT '教师上课后N天督导未评价或保存，系统自动释放任务',
  `create_user_id` bigint(20) DEFAULT NULL COMMENT '创建人id',
  `update_user_id` bigint(20) DEFAULT NULL COMMENT '更新人id',
  `version` int(11) NOT NULL DEFAULT '1' COMMENT '乐观锁版本号',
  `created_date_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `created_by` varchar(50) DEFAULT NULL COMMENT '创建人',
  `last_modified_date_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间',
  `last_modified_by` varchar(50) DEFAULT NULL COMMENT '最后修改人',
  `delete_flag` tinyint(4) NOT NULL DEFAULT '0' COMMENT '删除标志（0：正常，1：删除）',
  `tenant_id` varchar(50) NOT NULL COMMENT '租户编号',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='领导评价-任务表';

-- ----------------------------
-- Table structure for t_leader_task_course_field_config
-- ----------------------------
DROP TABLE IF EXISTS `t_leader_task_course_field_config`;
CREATE TABLE `t_leader_task_course_field_config` (
  `id` bigint(20) NOT NULL COMMENT '主键ID（雪花算法生成）',
  `sup_task_id` bigint(20) DEFAULT NULL COMMENT '督导任务id',
  `field_name` varchar(255) DEFAULT NULL COMMENT '字段名称',
  `field_code` varchar(100) DEFAULT NULL COMMENT '字段编码',
  `show_enable` tinyint(4) DEFAULT NULL COMMENT '是否显示',
  `export_enable` tinyint(4) DEFAULT NULL COMMENT '是否导出',
  `order_index` int(11) DEFAULT NULL COMMENT '排序值',
  `create_user_id` bigint(20) DEFAULT NULL COMMENT '创建人id',
  `update_user_id` bigint(20) DEFAULT NULL COMMENT '更新人id',
  `version` int(11) NOT NULL DEFAULT '1' COMMENT '乐观锁版本号',
  `created_date_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `created_by` varchar(50) DEFAULT NULL COMMENT '创建人',
  `last_modified_date_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间',
  `last_modified_by` varchar(50) DEFAULT NULL COMMENT '最后修改人',
  `delete_flag` tinyint(4) NOT NULL DEFAULT '0' COMMENT '删除标志（0：正常，1：删除）',
  `tenant_id` varchar(50) NOT NULL COMMENT '租户编号',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_sup_task_id` (`sup_task_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='领导评价-任务-课程信息展示-配置';

-- ----------------------------
-- Table structure for t_leader_task_plan
-- ----------------------------
DROP TABLE IF EXISTS `t_leader_task_plan`;
CREATE TABLE `t_leader_task_plan` (
  `id` bigint(20) NOT NULL COMMENT '主键ID（雪花算法生成）',
  `sup_task_id` bigint(20) DEFAULT NULL COMMENT '领导评价任务id',
  `sup_user_id` bigint(20) DEFAULT NULL COMMENT '领导用户id',
  `subj_id` bigint(20) DEFAULT NULL COMMENT '科目id',
  `subj_type_id` bigint(20) DEFAULT NULL COMMENT '课程类型id',
  `teacher_user_id` bigint(20) DEFAULT NULL COMMENT '教师用户id',
  `org_id` bigint(20) DEFAULT NULL COMMENT '院系id',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `create_user_id` bigint(20) DEFAULT NULL COMMENT '创建人id',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `update_user_id` bigint(20) DEFAULT NULL COMMENT '更新人id',
  `version` int(11) NOT NULL DEFAULT '1' COMMENT '乐观锁版本号',
  `created_date_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `created_by` varchar(50) DEFAULT NULL COMMENT '创建人',
  `last_modified_date_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间',
  `last_modified_by` varchar(50) DEFAULT NULL COMMENT '最后修改人',
  `delete_flag` tinyint(4) NOT NULL DEFAULT '0' COMMENT '删除标识（0：正常，1：删除）',
  `tenant_id` varchar(50) NOT NULL COMMENT '租户编号',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_leader_task_id` (`sup_task_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='领导评价-任务规划';

-- ----------------------------
-- Table structure for t_leader_task_plan_survey
-- ----------------------------
DROP TABLE IF EXISTS `t_leader_task_plan_survey`;
CREATE TABLE `t_leader_task_plan_survey` (
  `id` bigint(20) NOT NULL COMMENT '主键ID（雪花算法生成）',
  `leader_task_plan_id` bigint(20) DEFAULT NULL COMMENT '领导评价任务规划id',
  `survey_id` varchar(255) DEFAULT NULL COMMENT '问卷id',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `create_user_id` bigint(20) DEFAULT NULL COMMENT '创建人id',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `update_user_id` bigint(20) DEFAULT NULL COMMENT '更新人id',
  `version` int(11) NOT NULL DEFAULT '1' COMMENT '乐观锁版本号',
  `created_date_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `created_by` varchar(50) DEFAULT NULL COMMENT '创建人',
  `last_modified_date_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间',
  `last_modified_by` varchar(50) DEFAULT NULL COMMENT '最后修改人',
  `delete_flag` tinyint(4) NOT NULL DEFAULT '0' COMMENT '删除标识（0：正常，1：删除）',
  `tenant_id` varchar(50) NOT NULL COMMENT '租户编号',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_leader_task_plan_id` (`leader_task_plan_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='领导评价-任务规划问卷';

-- ----------------------------
-- Table structure for t_leader_task_score_level
-- ----------------------------
DROP TABLE IF EXISTS `t_leader_task_score_level`;
CREATE TABLE `t_leader_task_score_level` (
  `id` bigint(20) NOT NULL COMMENT '主键ID（雪花算法生成）',
  `sup_task_id` bigint(20) DEFAULT NULL COMMENT '督导任务id',
  `level_name` varchar(255) DEFAULT NULL COMMENT '等级名称',
  `high_score_type` tinyint(4) DEFAULT NULL COMMENT '高分类型 1-小于 2-小于等于',
  `high_score` decimal(5,2) DEFAULT NULL COMMENT '高分',
  `low_score_type` tinyint(4) DEFAULT NULL COMMENT '低分类型 1-大于 2-大于等于',
  `low_score` decimal(5,2) DEFAULT NULL COMMENT '低分',
  `level_desc` varchar(500) DEFAULT NULL COMMENT '等级描述',
  `order_index` int(11) DEFAULT NULL COMMENT '排序',
  `create_user_id` bigint(20) DEFAULT NULL COMMENT '创建人id',
  `update_user_id` bigint(20) DEFAULT NULL COMMENT '更新人id',
  `version` int(11) NOT NULL DEFAULT '1' COMMENT '乐观锁版本号',
  `created_date_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `created_by` varchar(50) DEFAULT NULL COMMENT '创建人',
  `last_modified_date_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间',
  `last_modified_by` varchar(50) DEFAULT NULL COMMENT '最后修改人',
  `delete_flag` tinyint(4) NOT NULL DEFAULT '0' COMMENT '删除标志（0：正常，1：删除）',
  `tenant_id` varchar(50) NOT NULL COMMENT '租户编号',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_sup_task_id` (`sup_task_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='领导评价-任务-评分等级';

-- ----------------------------
-- Table structure for t_leader_task_subj_type
-- ----------------------------
DROP TABLE IF EXISTS `t_leader_task_subj_type`;
CREATE TABLE `t_leader_task_subj_type` (
  `id` bigint(20) NOT NULL COMMENT '主键ID（雪花算法生成）',
  `group_id` bigint(20) DEFAULT NULL COMMENT '关联组id',
  `type_id` bigint(20) DEFAULT NULL COMMENT '类型id',
  `type_name` varchar(255) DEFAULT NULL COMMENT '类型名称',
  `sort_index` int(11) DEFAULT NULL COMMENT '排序',
  `create_user_id` bigint(20) DEFAULT NULL COMMENT '创建人id',
  `update_user_id` bigint(20) DEFAULT NULL COMMENT '更新人id',
  `version` int(11) NOT NULL DEFAULT '1' COMMENT '乐观锁版本号',
  `created_date_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `created_by` varchar(50) DEFAULT NULL COMMENT '创建人',
  `last_modified_date_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间',
  `last_modified_by` varchar(50) DEFAULT NULL COMMENT '最后修改人',
  `delete_flag` tinyint(4) NOT NULL DEFAULT '0' COMMENT '删除标志（0：正常，1：删除）',
  `tenant_id` varchar(50) NOT NULL COMMENT '租户编号',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_group_id` (`group_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='领导评价-任务-课程类型表';

-- ----------------------------
-- Table structure for t_leader_task_subj_type_survey_group
-- ----------------------------
DROP TABLE IF EXISTS `t_leader_task_subj_type_survey_group`;
CREATE TABLE `t_leader_task_subj_type_survey_group` (
  `id` bigint(20) NOT NULL COMMENT '主键ID（雪花算法生成）',
  `group_name` varchar(255) DEFAULT NULL COMMENT '组名',
  `sup_task_id` bigint(20) DEFAULT NULL COMMENT '督导任务id',
  `all_subj_type_flag` tinyint(4) NOT NULL DEFAULT '0' COMMENT '是否全部课程类型 0-否（默认） 1-是 ',
  `sort_index` int(11) DEFAULT NULL COMMENT '排序',
  `create_user_id` bigint(20) DEFAULT NULL COMMENT '创建人id',
  `update_user_id` bigint(20) DEFAULT NULL COMMENT '更新人id',
  `version` int(11) NOT NULL DEFAULT '1' COMMENT '乐观锁版本号',
  `created_date_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `created_by` varchar(50) DEFAULT NULL COMMENT '创建人',
  `last_modified_date_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间',
  `last_modified_by` varchar(50) DEFAULT NULL COMMENT '最后修改人',
  `delete_flag` tinyint(4) NOT NULL DEFAULT '0' COMMENT '删除标志（0：正常，1：删除）',
  `tenant_id` varchar(50) NOT NULL COMMENT '租户编号',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_sup_task_id` (`sup_task_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='领导评价-任务-课程类型问卷-组表';

-- ----------------------------
-- Table structure for t_leader_task_survey
-- ----------------------------
DROP TABLE IF EXISTS `t_leader_task_survey`;
CREATE TABLE `t_leader_task_survey` (
  `id` bigint(20) NOT NULL COMMENT '主键ID（雪花算法生成）',
  `group_id` bigint(20) DEFAULT NULL COMMENT '关联组id',
  `survey_id` varchar(255) DEFAULT NULL COMMENT '问卷id',
  `survey_name` varchar(255) DEFAULT NULL COMMENT '问卷名称',
  `score_flag` tinyint(4) DEFAULT '1' COMMENT '是否计分 0-否 1-是(默认)',
  `sort_index` int(11) DEFAULT NULL COMMENT '排序值',
  `create_user_id` bigint(20) DEFAULT NULL COMMENT '创建人id',
  `update_user_id` bigint(20) DEFAULT NULL COMMENT '更新人id',
  `version` int(11) NOT NULL DEFAULT '1' COMMENT '乐观锁版本号',
  `created_date_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `created_by` varchar(50) DEFAULT NULL COMMENT '创建人',
  `last_modified_date_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间',
  `last_modified_by` varchar(50) DEFAULT NULL COMMENT '最后修改人',
  `delete_flag` tinyint(4) NOT NULL DEFAULT '0' COMMENT '删除标志（0：正常，1：删除）',
  `tenant_id` varchar(50) NOT NULL COMMENT '租户编号',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_group_id` (`group_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='领导评价-任务-问卷表';

-- ----------------------------
-- Table structure for t_leader_task_user
-- ----------------------------
DROP TABLE IF EXISTS `t_leader_task_user`;
CREATE TABLE `t_leader_task_user` (
  `id` bigint(20) NOT NULL COMMENT '主键ID（雪花算法生成）',
  `sup_task_id` bigint(20) DEFAULT NULL COMMENT '督导任务id',
  `user_id` bigint(20) DEFAULT NULL COMMENT '用户id',
  `user_code` varchar(100) DEFAULT NULL COMMENT '用户编码',
  `user_name` varchar(255) DEFAULT NULL COMMENT '用户名称',
  `org_id` bigint(20) DEFAULT NULL COMMENT '组织id',
  `org_code` varchar(100) DEFAULT NULL COMMENT '组织编码',
  `org_name` varchar(255) DEFAULT NULL COMMENT '组织名称',
  `range_all_org_flag` tinyint(4) DEFAULT '0' COMMENT '听课范围-院系维度-是否全部院系（0：否（默认），1：是）',
  `create_user_id` bigint(20) DEFAULT NULL COMMENT '创建人id',
  `update_user_id` bigint(20) DEFAULT NULL COMMENT '更新人id',
  `version` int(11) NOT NULL DEFAULT '1' COMMENT '乐观锁版本号',
  `created_date_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `created_by` varchar(50) DEFAULT NULL COMMENT '创建人',
  `last_modified_date_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间',
  `last_modified_by` varchar(50) DEFAULT NULL COMMENT '最后修改人',
  `delete_flag` tinyint(4) NOT NULL DEFAULT '0' COMMENT '删除标志（0：正常，1：删除）',
  `tenant_id` varchar(50) NOT NULL COMMENT '租户编号',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_sup_task_id` (`sup_task_id`) USING BTREE,
  KEY `idx_user_id` (`user_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='领导评价-任务-督导人员';

-- ----------------------------
-- Table structure for t_leader_task_user_claim
-- ----------------------------
DROP TABLE IF EXISTS `t_leader_task_user_claim`;
CREATE TABLE `t_leader_task_user_claim` (
  `id` bigint(20) NOT NULL COMMENT '主键ID（雪花算法生成）',
  `sup_task_id` bigint(20) DEFAULT NULL COMMENT '督导任务id',
  `user_id` bigint(20) DEFAULT NULL COMMENT '用户id',
  `subj_id` bigint(20) DEFAULT NULL COMMENT '科目id',
  `teacher_user_id` bigint(20) DEFAULT NULL COMMENT '老师用户id',
  `org_id` bigint(20) DEFAULT NULL COMMENT '院系id',
  `course_id` bigint(20) DEFAULT NULL COMMENT '课程id',
  `sup_record_id` bigint(20) DEFAULT NULL COMMENT '督导科目评价id',
  `sup_status` tinyint(4) DEFAULT '0' COMMENT '督导评价 0-未评 1-已评',
  `create_user_id` bigint(20) DEFAULT NULL COMMENT '创建人id',
  `update_user_id` bigint(20) DEFAULT NULL COMMENT '更新人id',
  `version` int(11) NOT NULL DEFAULT '1' COMMENT '乐观锁版本号',
  `created_date_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `created_by` varchar(50) DEFAULT NULL COMMENT '创建人',
  `last_modified_date_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间',
  `last_modified_by` varchar(50) DEFAULT NULL COMMENT '最后修改人',
  `delete_flag` tinyint(4) NOT NULL DEFAULT '0' COMMENT '删除标志（0：正常，1：删除）',
  `tenant_id` varchar(50) NOT NULL COMMENT '租户编号',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_sup_task_id` (`sup_task_id`) USING BTREE,
  KEY `idx_user_id` (`user_id`) USING BTREE,
  KEY `idx_subj_id` (`subj_id`) USING BTREE,
  KEY `idx_teacher_user_id` (`teacher_user_id`) USING BTREE,
  KEY `idx_course_id` (`course_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='领导评价-任务-科目老师或节次-认领';

-- ----------------------------
-- Table structure for t_leader_task_user_course_range
-- ----------------------------
DROP TABLE IF EXISTS `t_leader_task_user_course_range`;
CREATE TABLE `t_leader_task_user_course_range` (
  `id` bigint(20) NOT NULL COMMENT '主键ID（雪花算法生成）',
  `sup_task_id` bigint(20) DEFAULT NULL COMMENT '督导任务id',
  `user_id` bigint(20) DEFAULT NULL COMMENT '用户id',
  `course_id` bigint(20) DEFAULT NULL COMMENT '课程id',
  `must_sup_flag` tinyint(4) DEFAULT '0' COMMENT '听课要求 0-非必评（默认） 1-必评',
  `create_user_id` bigint(20) DEFAULT NULL COMMENT '创建人id',
  `update_user_id` bigint(20) DEFAULT NULL COMMENT '更新人id',
  `version` int(11) NOT NULL DEFAULT '1' COMMENT '乐观锁版本号',
  `created_date_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `created_by` varchar(50) DEFAULT NULL COMMENT '创建人',
  `last_modified_date_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间',
  `last_modified_by` varchar(50) DEFAULT NULL COMMENT '最后修改人',
  `delete_flag` tinyint(4) NOT NULL DEFAULT '0' COMMENT '删除标志（0：正常，1：删除）',
  `tenant_id` varchar(50) NOT NULL COMMENT '租户编号',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_sup_task_id` (`sup_task_id`) USING BTREE,
  KEY `idx_user_id` (`user_id`) USING BTREE,
  KEY `idx_course_id` (`course_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='领导评价-任务-听课范围-课程节次';

-- ----------------------------
-- Table structure for t_leader_task_user_interest
-- ----------------------------
DROP TABLE IF EXISTS `t_leader_task_user_interest`;
CREATE TABLE `t_leader_task_user_interest` (
  `id` bigint(20) NOT NULL COMMENT '主键ID（雪花算法生成）',
  `sup_task_id` bigint(20) DEFAULT NULL COMMENT '督导任务id',
  `user_id` bigint(20) DEFAULT NULL COMMENT '用户id',
  `subj_id` bigint(20) DEFAULT NULL COMMENT '科目id',
  `teacher_user_id` bigint(20) DEFAULT NULL COMMENT '老师用户id',
  `org_id` bigint(20) DEFAULT NULL COMMENT '院系id',
  `course_id` bigint(20) DEFAULT NULL COMMENT '课程id',
  `create_user_id` bigint(20) DEFAULT NULL COMMENT '创建人id',
  `update_user_id` bigint(20) DEFAULT NULL COMMENT '更新人id',
  `version` int(11) NOT NULL DEFAULT '1' COMMENT '乐观锁版本号',
  `created_date_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `created_by` varchar(50) DEFAULT NULL COMMENT '创建人',
  `last_modified_date_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间',
  `last_modified_by` varchar(50) DEFAULT NULL COMMENT '最后修改人',
  `delete_flag` tinyint(4) NOT NULL DEFAULT '0' COMMENT '删除标志（0：正常，1：删除）',
  `tenant_id` varchar(50) NOT NULL COMMENT '租户编号',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_sup_task_id` (`sup_task_id`) USING BTREE,
  KEY `idx_user_id` (`user_id`) USING BTREE,
  KEY `idx_subj_id` (`subj_id`) USING BTREE,
  KEY `idx_teacher_user_id` (`teacher_user_id`) USING BTREE,
  KEY `idx_course_id` (`course_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='领导评价-任务-科目老师或节次-关注';

-- ----------------------------
-- Table structure for t_leader_task_user_org_range
-- ----------------------------
DROP TABLE IF EXISTS `t_leader_task_user_org_range`;
CREATE TABLE `t_leader_task_user_org_range` (
  `id` bigint(20) NOT NULL COMMENT '主键ID（雪花算法生成）',
  `sup_task_id` bigint(20) DEFAULT NULL COMMENT '督导任务id',
  `user_id` bigint(20) DEFAULT NULL COMMENT '用户id',
  `org_id` bigint(20) DEFAULT NULL COMMENT '院系id',
  `create_user_id` bigint(20) DEFAULT NULL COMMENT '创建人id',
  `update_user_id` bigint(20) DEFAULT NULL COMMENT '更新人id',
  `version` int(11) NOT NULL DEFAULT '1' COMMENT '乐观锁版本号',
  `created_date_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `created_by` varchar(50) DEFAULT NULL COMMENT '创建人',
  `last_modified_date_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间',
  `last_modified_by` varchar(50) DEFAULT NULL COMMENT '最后修改人',
  `delete_flag` tinyint(4) NOT NULL DEFAULT '0' COMMENT '删除标志（0：正常，1：删除）',
  `tenant_id` varchar(50) NOT NULL COMMENT '租户编号',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_sup_task_id` (`sup_task_id`) USING BTREE,
  KEY `idx_user_id` (`user_id`) USING BTREE,
  KEY `idx_org_id` (`org_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='领导评价-任务-听课范围-院系';

-- ----------------------------
-- Table structure for t_leader_task_user_recommend_subject
-- ----------------------------
DROP TABLE IF EXISTS `t_leader_task_user_recommend_subject`;
CREATE TABLE `t_leader_task_user_recommend_subject` (
  `id` bigint(20) NOT NULL COMMENT '主键ID（雪花算法生成）',
  `sup_task_id` bigint(20) DEFAULT NULL COMMENT '督导任务id',
  `subj_id` bigint(20) DEFAULT NULL COMMENT '科目id',
  `user_id` bigint(20) DEFAULT NULL COMMENT '用户id',
  `recommend_reason_id` bigint(20) DEFAULT NULL COMMENT '推荐理由id',
  `create_user_id` bigint(20) DEFAULT NULL COMMENT '创建人id',
  `update_user_id` bigint(20) DEFAULT NULL COMMENT '更新人id',
  `version` int(11) NOT NULL DEFAULT '1' COMMENT '乐观锁版本号',
  `created_date_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `created_by` varchar(50) DEFAULT NULL COMMENT '创建人',
  `last_modified_date_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间',
  `last_modified_by` varchar(50) DEFAULT NULL COMMENT '最后修改人',
  `delete_flag` tinyint(4) NOT NULL DEFAULT '0' COMMENT '删除标志（0：正常，1：删除）',
  `tenant_id` varchar(50) NOT NULL COMMENT '租户编号',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_sup_task_id` (`sup_task_id`) USING BTREE,
  KEY `idx_user_id` (`user_id`) USING BTREE,
  KEY `idx_subj_id` (`subj_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='领导评价-任务-督导员-听课策略-推荐课程表';

-- ----------------------------
-- Table structure for t_leader_task_user_select_subject
-- ----------------------------
DROP TABLE IF EXISTS `t_leader_task_user_select_subject`;
CREATE TABLE `t_leader_task_user_select_subject` (
  `id` bigint(20) NOT NULL COMMENT '主键ID（雪花算法生成）',
  `sup_task_id` bigint(20) DEFAULT NULL COMMENT '督导任务id',
  `subj_id` bigint(20) DEFAULT NULL COMMENT '科目id',
  `user_id` bigint(20) DEFAULT NULL COMMENT '用户id',
  `recommend_reason_id` bigint(20) DEFAULT NULL COMMENT '推荐理由id',
  `create_user_id` bigint(20) DEFAULT NULL COMMENT '创建人id',
  `update_user_id` bigint(20) DEFAULT NULL COMMENT '更新人id',
  `version` int(11) NOT NULL DEFAULT '1' COMMENT '乐观锁版本号',
  `created_date_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `created_by` varchar(50) DEFAULT NULL COMMENT '创建人',
  `last_modified_date_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间',
  `last_modified_by` varchar(50) DEFAULT NULL COMMENT '最后修改人',
  `delete_flag` tinyint(4) NOT NULL DEFAULT '0' COMMENT '删除标志（0：正常，1：删除）',
  `tenant_id` varchar(50) NOT NULL COMMENT '租户编号',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_sup_task_id` (`sup_task_id`) USING BTREE,
  KEY `idx_user_id` (`user_id`) USING BTREE,
  KEY `idx_subj_id` (`subj_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='领导评价-任务-督导员-听课策略-选评课程表';

-- ----------------------------
-- Table structure for t_leader_task_user_strategy
-- ----------------------------
DROP TABLE IF EXISTS `t_leader_task_user_strategy`;
CREATE TABLE `t_leader_task_user_strategy` (
  `id` bigint(20) NOT NULL COMMENT '主键ID（雪花算法生成）',
  `sup_task_id` bigint(20) DEFAULT NULL COMMENT '督导任务id',
  `user_id` bigint(20) DEFAULT NULL COMMENT '用户id',
  `sup_times` int(11) DEFAULT NULL COMMENT '次数设置-要求评价次数',
  `sup_times_limit_enable` tinyint(4) DEFAULT NULL COMMENT '次数设置-到达评价次数是否可以继续评价',
  `pending_sup_max_num` int(11) DEFAULT NULL COMMENT '次数设置-待评上限数量',
  `sup_select_course_times` int(11) DEFAULT NULL COMMENT '选评课程-要求从选评课程中评价次数',
  `front_back_acte_id` bigint(20) DEFAULT NULL COMMENT '推荐老师-前后列-学期id',
  `front_rate` decimal(5,2) DEFAULT NULL COMMENT '推荐老师-期末学生评价：前N%老师',
  `back_rate` decimal(5,2) DEFAULT NULL COMMENT '推荐老师-期末学生评价：后N%老师',
  `sideline_enable` tinyint(4) DEFAULT '0' COMMENT '推荐老师-是否推荐兼职教师 默认 false',
  `new_min_year` int(11) DEFAULT NULL COMMENT '推荐老师-推荐入职时间小于N年的教师',
  `low_frequency_acte_id` bigint(20) DEFAULT NULL COMMENT '推荐老师-老师听评低频-学期id',
  `sup_low_frequency_min_num` int(11) DEFAULT NULL COMMENT '推荐老师-教师被听次数少于N次',
  `create_user_id` bigint(20) DEFAULT NULL COMMENT '创建人id',
  `update_user_id` bigint(20) DEFAULT NULL COMMENT '更新人id',
  `version` int(11) NOT NULL DEFAULT '1' COMMENT '乐观锁版本号',
  `created_date_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `created_by` varchar(50) DEFAULT NULL COMMENT '创建人',
  `last_modified_date_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间',
  `last_modified_by` varchar(50) DEFAULT NULL COMMENT '最后修改人',
  `delete_flag` tinyint(4) NOT NULL DEFAULT '0' COMMENT '删除标志（0：正常，1：删除）',
  `tenant_id` varchar(50) NOT NULL COMMENT '租户编号',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_sup_task_id` (`sup_task_id`) USING BTREE,
  KEY `idx_user_id` (`user_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='领导评价-任务-督导员-听课策略表';

-- ----------------------------
-- Table structure for t_leader_task_user_subject_range
-- ----------------------------
DROP TABLE IF EXISTS `t_leader_task_user_subject_range`;
CREATE TABLE `t_leader_task_user_subject_range` (
  `id` bigint(20) NOT NULL COMMENT '主键ID（雪花算法生成）',
  `sup_task_id` bigint(20) DEFAULT NULL COMMENT '督导任务id',
  `user_id` bigint(20) DEFAULT NULL COMMENT '用户id',
  `subj_id` bigint(20) DEFAULT NULL COMMENT '科目id',
  `create_user_id` bigint(20) DEFAULT NULL COMMENT '创建人id',
  `update_user_id` bigint(20) DEFAULT NULL COMMENT '更新人id',
  `version` int(11) NOT NULL DEFAULT '1' COMMENT '乐观锁版本号',
  `created_date_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `created_by` varchar(50) DEFAULT NULL COMMENT '创建人',
  `last_modified_date_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间',
  `last_modified_by` varchar(50) DEFAULT NULL COMMENT '最后修改人',
  `delete_flag` tinyint(4) NOT NULL DEFAULT '0' COMMENT '删除标志（0：正常，1：删除）',
  `tenant_id` varchar(50) NOT NULL COMMENT '租户编号',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_sup_task_id` (`sup_task_id`) USING BTREE,
  KEY `idx_user_id` (`user_id`) USING BTREE,
  KEY `idx_subj_id` (`subj_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='领导评价-任务-听课范围-科目';

-- ----------------------------
-- Table structure for t_leader_task_user_tecl_range
-- ----------------------------
DROP TABLE IF EXISTS `t_leader_task_user_tecl_range`;
CREATE TABLE `t_leader_task_user_tecl_range` (
  `id` bigint(20) NOT NULL COMMENT '主键ID（雪花算法生成）',
  `sup_task_id` bigint(20) DEFAULT NULL COMMENT '督导任务id',
  `user_id` bigint(20) DEFAULT NULL COMMENT '用户id',
  `tecl_id` bigint(20) DEFAULT NULL COMMENT '教学班id',
  `create_user_id` bigint(20) DEFAULT NULL COMMENT '创建人id',
  `update_user_id` bigint(20) DEFAULT NULL COMMENT '更新人id',
  `version` int(11) NOT NULL DEFAULT '1' COMMENT '乐观锁版本号',
  `created_date_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `created_by` varchar(50) DEFAULT NULL COMMENT '创建人',
  `last_modified_date_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间',
  `last_modified_by` varchar(50) DEFAULT NULL COMMENT '最后修改人',
  `delete_flag` tinyint(4) NOT NULL DEFAULT '0' COMMENT '删除标志（0：正常，1：删除）',
  `tenant_id` varchar(50) NOT NULL COMMENT '租户编号',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_sup_task_id` (`sup_task_id`) USING BTREE,
  KEY `idx_user_id` (`user_id`) USING BTREE,
  KEY `idx_tecl_id` (`tecl_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='领导评价-任务-听课范围-教学班';

-- ----------------------------
-- Table structure for t_non_evaluation_student
-- ----------------------------
DROP TABLE IF EXISTS `t_non_evaluation_student`;
CREATE TABLE `t_non_evaluation_student` (
  `id` bigint(20) NOT NULL COMMENT '主键ID（雪花算法生成）',
  `user_id` bigint(20) NOT NULL COMMENT '用户ID',
  `eval_scope` tinyint(4) NOT NULL COMMENT '不参评范围',
  `create_user_id` bigint(20) DEFAULT NULL COMMENT '创建人id',
  `update_user_id` bigint(20) DEFAULT NULL COMMENT '更新人id',
  `version` int(11) NOT NULL DEFAULT '1' COMMENT '乐观锁版本号',
  `created_date_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `created_by` varchar(50) DEFAULT NULL COMMENT '创建人',
  `last_modified_date_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间',
  `last_modified_by` varchar(50) DEFAULT NULL COMMENT '最后修改人',
  `delete_flag` tinyint(4) NOT NULL DEFAULT '0' COMMENT '删除标志（0：正常，1：删除）',
  `tenant_id` varchar(50) NOT NULL COMMENT '租户编号',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_user_id_tenant_id_key` (`user_id`,`tenant_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='不参评学生记录表';

-- ----------------------------
-- Table structure for t_non_evaluation_teacher
-- ----------------------------
DROP TABLE IF EXISTS `t_non_evaluation_teacher`;
CREATE TABLE `t_non_evaluation_teacher` (
  `id` bigint(20) NOT NULL COMMENT '主键ID（雪花算法生成）',
  `user_id` bigint(20) NOT NULL COMMENT '用户ID',
  `eval_scope` tinyint(4) NOT NULL COMMENT '不参评范围',
  `create_user_id` bigint(20) DEFAULT NULL COMMENT '创建人id',
  `update_user_id` bigint(20) DEFAULT NULL COMMENT '更新人id',
  `version` int(11) NOT NULL DEFAULT '1' COMMENT '乐观锁版本号',
  `created_date_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `created_by` varchar(50) DEFAULT NULL COMMENT '创建人',
  `last_modified_date_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间',
  `last_modified_by` varchar(50) DEFAULT NULL COMMENT '最后修改人',
  `delete_flag` tinyint(4) NOT NULL DEFAULT '0' COMMENT '删除标志（0：正常，1：删除）',
  `tenant_id` varchar(50) NOT NULL COMMENT '租户编号',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_user_id_tenant_id_key` (`user_id`,`tenant_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='不参评教师记录表';

-- ----------------------------
-- Table structure for t_peer_course_record
-- ----------------------------
DROP TABLE IF EXISTS `t_peer_course_record`;
CREATE TABLE `t_peer_course_record` (
  `id` bigint(20) NOT NULL COMMENT '主键ID（雪花算法生成）',
  `peer_task_id` bigint(20) DEFAULT NULL COMMENT '同行任务id',
  `evaluation_status` tinyint(4) DEFAULT NULL COMMENT '评价状态 0-未评 1-已评',
  `cour_id` bigint(20) DEFAULT NULL COMMENT '课程id',
  `acte_id` bigint(20) DEFAULT NULL COMMENT '学期id',
  `subj_id` bigint(20) DEFAULT NULL COMMENT '科目id',
  `subj_code` varchar(100) DEFAULT NULL COMMENT '科目编码',
  `subj_name` varchar(255) DEFAULT NULL COMMENT '科目名称',
  `evaluate_user_id` bigint(20) DEFAULT NULL COMMENT '评价用户id',
  `evaluate_user_code` varchar(100) DEFAULT NULL COMMENT '评价用户编号',
  `evaluate_user_name` varchar(255) DEFAULT NULL COMMENT '评价用户名称',
  `evaluate_user_level` tinyint(4) DEFAULT NULL COMMENT '评价级别 1-校级督导 2-院级督导 3-校/院级督导',
  `evaluated_user_id` bigint(20) DEFAULT NULL COMMENT '被评用户id',
  `evaluated_user_code` varchar(100) DEFAULT NULL COMMENT '被评用户编码',
  `evaluated_user_name` varchar(255) DEFAULT NULL COMMENT '被评用户名称',
  `tecl_org_id` bigint(20) DEFAULT NULL COMMENT '排课院系id',
  `tecl_org_code` varchar(100) DEFAULT NULL COMMENT '排课院系编码',
  `tecl_org_name` varchar(255) DEFAULT NULL COMMENT '排课院系名称',
  `tecl_id` bigint(20) DEFAULT NULL COMMENT '教学班id',
  `tecl_code` varchar(100) DEFAULT NULL COMMENT '教学班编码',
  `tecl_name` varchar(255) DEFAULT NULL COMMENT '教学班名称',
  `cour_begin_time` datetime DEFAULT NULL COMMENT '课程开始时间',
  `cour_end_time` datetime DEFAULT NULL COMMENT '课程结束时间',
  `leti_number` int(11) DEFAULT NULL COMMENT '课程节次',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `create_user_id` bigint(20) DEFAULT NULL COMMENT '创建人id',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `update_user_id` bigint(20) DEFAULT NULL COMMENT '更新人id',
  `version` int(11) NOT NULL DEFAULT '1' COMMENT '乐观锁版本号',
  `created_date_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `created_by` varchar(50) DEFAULT NULL COMMENT '创建人',
  `last_modified_date_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间',
  `last_modified_by` varchar(50) DEFAULT NULL COMMENT '最后修改人',
  `delete_flag` tinyint(4) NOT NULL DEFAULT '0' COMMENT '删除标志（0：正常，1：删除）',
  `tenant_id` varchar(50) NOT NULL COMMENT '租户编号',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_peer_task_id` (`peer_task_id`) USING BTREE,
  KEY `idx_cour_id` (`cour_id`) USING BTREE,
  KEY `idx_acte_id` (`acte_id`) USING BTREE,
  KEY `idx_subj_id` (`subj_id`) USING BTREE,
  KEY `idx_evaluate_user_id` (`evaluate_user_id`) USING BTREE,
  KEY `idx_evaluated_user_id` (`evaluated_user_id`) USING BTREE,
  KEY `idx_tecl_id` (`tecl_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='同行评价-课程节次评价-记录';

-- ----------------------------
-- Table structure for t_peer_record_photo_review
-- ----------------------------
DROP TABLE IF EXISTS `t_peer_record_photo_review`;
CREATE TABLE `t_peer_record_photo_review` (
  `id` bigint(20) NOT NULL COMMENT '主键ID（雪花算法生成）',
  `peer_task_id` bigint(20) DEFAULT NULL COMMENT '同行任务id',
  `evaluate_user_id` bigint(20) DEFAULT NULL COMMENT '评价用户id',
  `subj_id` bigint(20) DEFAULT NULL COMMENT '科目id-评价到课程时有值',
  `teacher_user_id` bigint(20) DEFAULT NULL COMMENT '老师用户id-评价到课程时有值',
  `org_id` bigint(20) DEFAULT NULL COMMENT '院系id-评价到课程时有值',
  `review_type` tinyint(4) DEFAULT NULL COMMENT '点评类型 1-好评 2-差评',
  `review_content` text COMMENT '点评内容',
  `cour_id` bigint(20) DEFAULT NULL COMMENT '课程id',
  `process_start_time` varchar(255) DEFAULT NULL COMMENT '进度时间-开始 格式 yyyy-MM-dd HH:mm:ss',
  `process_end_time` varchar(255) DEFAULT NULL COMMENT '进度时间-结束 格式 yyyy-MM-dd HH:mm:ss',
  `play_start_time` varchar(255) DEFAULT NULL COMMENT '播放进度时间-开始 格式 HH:mm:ss',
  `play_end_time` varchar(255) DEFAULT NULL COMMENT '播放进度时间-结束 格式 HH:mm:ss',
  `create_user_id` bigint(20) DEFAULT NULL COMMENT '创建人id',
  `update_user_id` bigint(20) DEFAULT NULL COMMENT '更新人id',
  `version` int(11) NOT NULL DEFAULT '1' COMMENT '乐观锁版本号',
  `created_date_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `created_by` varchar(50) DEFAULT NULL COMMENT '创建人',
  `last_modified_date_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间',
  `last_modified_by` varchar(50) DEFAULT NULL COMMENT '最后修改人',
  `delete_flag` tinyint(4) NOT NULL DEFAULT '0' COMMENT '删除标志（0：正常，1：删除）',
  `tenant_id` varchar(50) NOT NULL COMMENT '租户编号',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_peer_task_id` (`peer_task_id`) USING BTREE,
  KEY `idx_cour_id` (`cour_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='同行评价-评价-拍照点评表';

-- ----------------------------
-- Table structure for t_peer_record_photo_review_file
-- ----------------------------
DROP TABLE IF EXISTS `t_peer_record_photo_review_file`;
CREATE TABLE `t_peer_record_photo_review_file` (
  `id` bigint(20) NOT NULL COMMENT '主键ID（雪花算法生成）',
  `record_photo_review_id` bigint(20) NOT NULL COMMENT '拍照点评id',
  `file_id` bigint(20) NOT NULL COMMENT '文件id',
  `file_name` varchar(255) NOT NULL COMMENT '文件名称',
  `file_url` varchar(500) NOT NULL COMMENT '文件url',
  `file_size` bigint(20) DEFAULT NULL COMMENT '文件大小',
  `create_user_id` bigint(20) DEFAULT NULL COMMENT '创建人id',
  `update_user_id` bigint(20) DEFAULT NULL COMMENT '更新人id',
  `version` int(11) NOT NULL DEFAULT '1' COMMENT '乐观锁版本号',
  `created_date_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `created_by` varchar(50) DEFAULT NULL COMMENT '创建人',
  `last_modified_date_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间',
  `last_modified_by` varchar(50) DEFAULT NULL COMMENT '最后修改人',
  `delete_flag` tinyint(4) NOT NULL DEFAULT '0' COMMENT '删除标志（0：正常，1：删除）',
  `tenant_id` varchar(50) NOT NULL COMMENT '租户编号',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_record_photo_review_id` (`record_photo_review_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='同行评价-评价-拍照点评-文件表';

-- ----------------------------
-- Table structure for t_peer_record_survey
-- ----------------------------
DROP TABLE IF EXISTS `t_peer_record_survey`;
CREATE TABLE `t_peer_record_survey` (
  `id` bigint(20) NOT NULL COMMENT '主键ID（雪花算法生成）',
  `peer_task_id` bigint(20) DEFAULT NULL COMMENT '同行任务id',
  `record_id` bigint(20) DEFAULT NULL COMMENT '评价记录id',
  `evaluation_dim_code` tinyint(4) DEFAULT NULL COMMENT '评价维度 1-评价到教学班 2-评价到课程',
  `survey_id` varchar(255) DEFAULT NULL COMMENT '问卷id',
  `survey_name` varchar(255) DEFAULT NULL COMMENT '问卷名称',
  `survey_data_id` varchar(255) DEFAULT NULL COMMENT '问卷填写数据id',
  `survey_submit_status` tinyint(4) DEFAULT NULL COMMENT '问卷提交状态 草稿：-1 ，已提交：1',
  `survey_submit_time` datetime DEFAULT NULL COMMENT '问卷提交时间',
  `survey_score` decimal(5,2) DEFAULT NULL COMMENT '问卷结果得分',
  `reason` varchar(2000) DEFAULT NULL COMMENT '理由',
  `reason_type` tinyint(4) DEFAULT NULL COMMENT '理由类型- 1-低 2-高',
  `score_level_id` bigint(20) DEFAULT NULL COMMENT '选中的评分等级id',
  `create_user_id` bigint(20) DEFAULT NULL COMMENT '创建人id',
  `update_user_id` bigint(20) DEFAULT NULL COMMENT '更新人id',
  `version` int(11) NOT NULL DEFAULT '1' COMMENT '乐观锁版本号',
  `created_date_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `created_by` varchar(50) DEFAULT NULL COMMENT '创建人',
  `last_modified_date_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间',
  `last_modified_by` varchar(50) DEFAULT NULL COMMENT '最后修改人',
  `delete_flag` tinyint(4) NOT NULL DEFAULT '0' COMMENT '删除标志（0：正常，1：删除）',
  `tenant_id` varchar(50) NOT NULL COMMENT '租户编号',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_peer_task_id` (`peer_task_id`) USING BTREE,
  KEY `idx_record_id` (`record_id`) USING BTREE,
  KEY `idx_survey_id` (`survey_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='同行评价-评价-问卷';

-- ----------------------------
-- Table structure for t_peer_task
-- ----------------------------
DROP TABLE IF EXISTS `t_peer_task`;
CREATE TABLE `t_peer_task` (
  `id` bigint(20) NOT NULL COMMENT '主键ID（雪花算法生成）',
  `task_name` varchar(255) DEFAULT NULL COMMENT '任务名称',
  `evaluation_dim_code` tinyint(4) DEFAULT NULL COMMENT '评价维度 1-评价到教学班 2-评价到课程',
  `educational_level` tinyint(4) DEFAULT NULL COMMENT '学历层次 1-本科 2-研究生',
  `task_level` tinyint(4) DEFAULT NULL COMMENT '任务级别 1-校级 2-院级',
  `evaluation_range` tinyint(4) DEFAULT NULL COMMENT '评价范围 1-自定义',
  `evaluation_method` tinyint(4) DEFAULT NULL COMMENT '评价方式 1-自行认领',
  `task_org_id` bigint(20) DEFAULT NULL COMMENT '任务所属组织id',
  `acte_id` bigint(20) DEFAULT NULL COMMENT '学期id',
  `task_status` tinyint(4) DEFAULT NULL COMMENT '任务状态 0-未发布 1-已发布',
  `task_start_time` datetime DEFAULT NULL COMMENT '任务开始时间',
  `task_end_time` datetime DEFAULT NULL COMMENT '任务结束时间',
  `online_type` tinyint(4) DEFAULT NULL COMMENT '在线听课类型 1-不允许在线听课 2-仅允许观看直播 3-仅允许观看点播 4-允许同时观看直播和点播',
  `reason_enable` tinyint(4) DEFAULT NULL COMMENT '评分是否需要填写理由',
  `reason_high_type` tinyint(4) DEFAULT NULL COMMENT '高分区间类型 1-大于 2-大于等于',
  `reason_high_score` decimal(5,2) DEFAULT NULL COMMENT '高分分值',
  `reason_low_type` tinyint(4) DEFAULT NULL COMMENT '低分区间类型 1-大于 2-大于等于',
  `reason_low_score` decimal(5,2) DEFAULT NULL COMMENT '低分分值',
  `college_admin_result_enable` tinyint(4) DEFAULT NULL COMMENT '院系管理员是否可查看校级任务内本院系的数据',
  `college_admin_result_anonymous` tinyint(4) DEFAULT '0' COMMENT '院系管理员-评价人信息匿名 0-匿名（默认） 1-不匿名',
  `evaluated_user_result_enable` tinyint(4) DEFAULT '0' COMMENT '被评用户-是否允许查看任务结果（默认不允许）',
  `evaluated_user_result_type` tinyint(4) DEFAULT NULL COMMENT '被评用户-可查看结果类型 1-仅查看文本意见 2-查看整个评价表',
  `opinion_communication_enable` tinyint(4) DEFAULT NULL COMMENT '配置意见反馈题时，允许评价者（匿名）与被评者实时沟通',
  `score_level_enable` tinyint(4) DEFAULT NULL COMMENT '是否开启评分区段',
  `claim_limit_type` tinyint(4) DEFAULT NULL COMMENT '认领上限类型 1-不设置认领上限 2-设置同一教师被认领次数上限 3-设置同一教师同一课程被认领次数上限',
  `claim_limit_num` int(11) DEFAULT NULL COMMENT '认领上限次数',
  `claim_course_time_range_enable` tinyint(4) DEFAULT NULL COMMENT '是否设置认领的课表日期范围 0-否 1-是',
  `claim_course_time_range_front_day` int(11) DEFAULT NULL COMMENT '评价人可认领当日及前N天课表',
  `claim_course_time_range_back_day` int(11) DEFAULT NULL COMMENT '评价人可认领当日及后N天课表',
  `claim_task_time_validity_enable` tinyint(4) DEFAULT NULL COMMENT '是否设置任务自动释放的时效 0-否 1-是',
  `claim_task_time_validity_day` int(11) DEFAULT NULL COMMENT '教师上课后N天评价人未评价或保存，系统自动释放任务',
  `create_user_id` bigint(20) DEFAULT NULL COMMENT '创建人id',
  `update_user_id` bigint(20) DEFAULT NULL COMMENT '更新人id',
  `version` int(11) NOT NULL DEFAULT '1' COMMENT '乐观锁版本号',
  `created_date_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `created_by` varchar(50) DEFAULT NULL COMMENT '创建人',
  `last_modified_date_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间',
  `last_modified_by` varchar(50) DEFAULT NULL COMMENT '最后修改人',
  `delete_flag` tinyint(4) NOT NULL DEFAULT '0' COMMENT '删除标志（0：正常，1：删除）',
  `tenant_id` varchar(50) NOT NULL COMMENT '租户编号',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='同行评价-任务表';

-- ----------------------------
-- Table structure for t_peer_task_course_field_config
-- ----------------------------
DROP TABLE IF EXISTS `t_peer_task_course_field_config`;
CREATE TABLE `t_peer_task_course_field_config` (
  `id` bigint(20) NOT NULL COMMENT '主键ID（雪花算法生成）',
  `peer_task_id` bigint(20) DEFAULT NULL COMMENT '同行任务id',
  `field_name` varchar(255) DEFAULT NULL COMMENT '字段名称',
  `field_code` varchar(100) DEFAULT NULL COMMENT '字段编码',
  `show_enable` tinyint(4) DEFAULT NULL COMMENT '是否显示',
  `export_enable` tinyint(4) DEFAULT NULL COMMENT '是否导出',
  `order_index` int(11) DEFAULT NULL COMMENT '排序值',
  `create_user_id` bigint(20) DEFAULT NULL COMMENT '创建人id',
  `update_user_id` bigint(20) DEFAULT NULL COMMENT '更新人id',
  `version` int(11) NOT NULL DEFAULT '1' COMMENT '乐观锁版本号',
  `created_date_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `created_by` varchar(50) DEFAULT NULL COMMENT '创建人',
  `last_modified_date_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间',
  `last_modified_by` varchar(50) DEFAULT NULL COMMENT '最后修改人',
  `delete_flag` tinyint(4) NOT NULL DEFAULT '0' COMMENT '删除标志（0：正常，1：删除）',
  `tenant_id` varchar(50) NOT NULL COMMENT '租户编号',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_peer_task_id` (`peer_task_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='同行评价-任务-课程信息展示-配置';

-- ----------------------------
-- Table structure for t_peer_task_score_level
-- ----------------------------
DROP TABLE IF EXISTS `t_peer_task_score_level`;
CREATE TABLE `t_peer_task_score_level` (
  `id` bigint(20) NOT NULL COMMENT '主键ID（雪花算法生成）',
  `peer_task_id` bigint(20) DEFAULT NULL COMMENT '同行任务id',
  `level_name` varchar(255) DEFAULT NULL COMMENT '等级名称',
  `high_score_type` tinyint(4) DEFAULT NULL COMMENT '高分类型 1-小于 2-小于等于',
  `high_score` decimal(5,2) DEFAULT NULL COMMENT '高分',
  `low_score_type` tinyint(4) DEFAULT NULL COMMENT '低分类型 1-大于 2-大于等于',
  `low_score` decimal(5,2) DEFAULT NULL COMMENT '低分',
  `level_desc` varchar(500) DEFAULT NULL COMMENT '等级描述',
  `order_index` int(11) DEFAULT NULL COMMENT '排序',
  `create_user_id` bigint(20) DEFAULT NULL COMMENT '创建人id',
  `update_user_id` bigint(20) DEFAULT NULL COMMENT '更新人id',
  `version` int(11) NOT NULL DEFAULT '1' COMMENT '乐观锁版本号',
  `created_date_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `created_by` varchar(50) DEFAULT NULL COMMENT '创建人',
  `last_modified_date_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间',
  `last_modified_by` varchar(50) DEFAULT NULL COMMENT '最后修改人',
  `delete_flag` tinyint(4) NOT NULL DEFAULT '0' COMMENT '删除标志（0：正常，1：删除）',
  `tenant_id` varchar(50) NOT NULL COMMENT '租户编号',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_peer_task_id` (`peer_task_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='同行评价-任务-评分等级';

-- ----------------------------
-- Table structure for t_peer_task_subj_type
-- ----------------------------
DROP TABLE IF EXISTS `t_peer_task_subj_type`;
CREATE TABLE `t_peer_task_subj_type` (
  `id` bigint(20) NOT NULL COMMENT '主键ID（雪花算法生成）',
  `group_id` bigint(20) DEFAULT NULL COMMENT '关联组id',
  `type_id` bigint(20) DEFAULT NULL COMMENT '类型id',
  `type_name` varchar(255) DEFAULT NULL COMMENT '类型名称',
  `sort_index` int(11) DEFAULT NULL COMMENT '排序',
  `create_user_id` bigint(20) DEFAULT NULL COMMENT '创建人id',
  `update_user_id` bigint(20) DEFAULT NULL COMMENT '更新人id',
  `version` int(11) NOT NULL DEFAULT '1' COMMENT '乐观锁版本号',
  `created_date_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `created_by` varchar(50) DEFAULT NULL COMMENT '创建人',
  `last_modified_date_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间',
  `last_modified_by` varchar(50) DEFAULT NULL COMMENT '最后修改人',
  `delete_flag` tinyint(4) NOT NULL DEFAULT '0' COMMENT '删除标志（0：正常，1：删除）',
  `tenant_id` varchar(50) NOT NULL COMMENT '租户编号',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_group_id` (`group_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='同行评价-任务-课程类型表';

-- ----------------------------
-- Table structure for t_peer_task_subj_type_survey_group
-- ----------------------------
DROP TABLE IF EXISTS `t_peer_task_subj_type_survey_group`;
CREATE TABLE `t_peer_task_subj_type_survey_group` (
  `id` bigint(20) NOT NULL COMMENT '主键ID（雪花算法生成）',
  `group_name` varchar(255) DEFAULT NULL COMMENT '组名',
  `peer_task_id` bigint(20) DEFAULT NULL COMMENT '同行任务id',
  `all_subj_type_flag` tinyint(4) NOT NULL DEFAULT '0' COMMENT '是否全部课程类型 0-否（默认） 1-是 ',
  `sort_index` int(11) DEFAULT NULL COMMENT '排序',
  `create_user_id` bigint(20) DEFAULT NULL COMMENT '创建人id',
  `update_user_id` bigint(20) DEFAULT NULL COMMENT '更新人id',
  `version` int(11) NOT NULL DEFAULT '1' COMMENT '乐观锁版本号',
  `created_date_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `created_by` varchar(50) DEFAULT NULL COMMENT '创建人',
  `last_modified_date_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间',
  `last_modified_by` varchar(50) DEFAULT NULL COMMENT '最后修改人',
  `delete_flag` tinyint(4) NOT NULL DEFAULT '0' COMMENT '删除标志（0：正常，1：删除）',
  `tenant_id` varchar(50) NOT NULL COMMENT '租户编号',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_peer_task_id` (`peer_task_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='同行评价-任务-课程类型问卷-组表';

-- ----------------------------
-- Table structure for t_peer_task_survey
-- ----------------------------
DROP TABLE IF EXISTS `t_peer_task_survey`;
CREATE TABLE `t_peer_task_survey` (
  `id` bigint(20) NOT NULL COMMENT '主键ID（雪花算法生成）',
  `group_id` bigint(20) DEFAULT NULL COMMENT '关联组id',
  `survey_id` varchar(255) DEFAULT NULL COMMENT '问卷id',
  `survey_name` varchar(255) DEFAULT NULL COMMENT '问卷名称',
  `score_flag` tinyint(4) DEFAULT '1' COMMENT '是否计分 0-否 1-是(默认)',
  `sort_index` int(11) DEFAULT NULL COMMENT '排序值',
  `create_user_id` bigint(20) DEFAULT NULL COMMENT '创建人id',
  `update_user_id` bigint(20) DEFAULT NULL COMMENT '更新人id',
  `version` int(11) NOT NULL DEFAULT '1' COMMENT '乐观锁版本号',
  `created_date_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `created_by` varchar(50) DEFAULT NULL COMMENT '创建人',
  `last_modified_date_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间',
  `last_modified_by` varchar(50) DEFAULT NULL COMMENT '最后修改人',
  `delete_flag` tinyint(4) NOT NULL DEFAULT '0' COMMENT '删除标志（0：正常，1：删除）',
  `tenant_id` varchar(50) NOT NULL COMMENT '租户编号',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_group_id` (`group_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='同行评价-任务-问卷表';

-- ----------------------------
-- Table structure for t_peer_task_user
-- ----------------------------
DROP TABLE IF EXISTS `t_peer_task_user`;
CREATE TABLE `t_peer_task_user` (
  `id` bigint(20) NOT NULL COMMENT '主键ID（雪花算法生成）',
  `peer_task_id` bigint(20) DEFAULT NULL COMMENT '同行任务id',
  `user_id` bigint(20) DEFAULT NULL COMMENT '用户id',
  `user_code` varchar(100) DEFAULT NULL COMMENT '用户编码',
  `user_name` varchar(255) DEFAULT NULL COMMENT '用户名称',
  `org_id` bigint(20) DEFAULT NULL COMMENT '组织id',
  `org_code` varchar(100) DEFAULT NULL COMMENT '组织编码',
  `org_name` varchar(255) DEFAULT NULL COMMENT '组织名称',
  `range_all_org_flag` tinyint(4) DEFAULT '0' COMMENT '听课范围-院系维度-是否全部院系（0：否（默认），1：是）',
  `create_user_id` bigint(20) DEFAULT NULL COMMENT '创建人id',
  `update_user_id` bigint(20) DEFAULT NULL COMMENT '更新人id',
  `version` int(11) NOT NULL DEFAULT '1' COMMENT '乐观锁版本号',
  `created_date_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `created_by` varchar(50) DEFAULT NULL COMMENT '创建人',
  `last_modified_date_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间',
  `last_modified_by` varchar(50) DEFAULT NULL COMMENT '最后修改人',
  `delete_flag` tinyint(4) NOT NULL DEFAULT '0' COMMENT '删除标志（0：正常，1：删除）',
  `tenant_id` varchar(50) NOT NULL COMMENT '租户编号',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_peer_task_id` (`peer_task_id`) USING BTREE,
  KEY `idx_user_id` (`user_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='同行评价-任务-评价人员';

-- ----------------------------
-- Table structure for t_peer_task_user_claim
-- ----------------------------
DROP TABLE IF EXISTS `t_peer_task_user_claim`;
CREATE TABLE `t_peer_task_user_claim` (
  `id` bigint(20) NOT NULL COMMENT '主键ID（雪花算法生成）',
  `peer_task_id` bigint(20) DEFAULT NULL COMMENT '同行任务id',
  `user_id` bigint(20) DEFAULT NULL COMMENT '用户id',
  `subj_id` bigint(20) DEFAULT NULL COMMENT '科目id',
  `teacher_user_id` bigint(20) DEFAULT NULL COMMENT '老师用户id',
  `org_id` bigint(20) DEFAULT NULL COMMENT '院系id',
  `course_id` bigint(20) DEFAULT NULL COMMENT '课程id',
  `record_id` bigint(20) DEFAULT NULL COMMENT '评价记录id',
  `evaluation_status` tinyint(4) DEFAULT '0' COMMENT '评价状态 0-未评 1-已评',
  `create_user_id` bigint(20) DEFAULT NULL COMMENT '创建人id',
  `update_user_id` bigint(20) DEFAULT NULL COMMENT '更新人id',
  `version` int(11) NOT NULL DEFAULT '1' COMMENT '乐观锁版本号',
  `created_date_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `created_by` varchar(50) DEFAULT NULL COMMENT '创建人',
  `last_modified_date_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间',
  `last_modified_by` varchar(50) DEFAULT NULL COMMENT '最后修改人',
  `delete_flag` tinyint(4) NOT NULL DEFAULT '0' COMMENT '删除标志（0：正常，1：删除）',
  `tenant_id` varchar(50) NOT NULL COMMENT '租户编号',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_peer_task_id` (`peer_task_id`) USING BTREE,
  KEY `idx_user_id` (`user_id`) USING BTREE,
  KEY `idx_subj_id` (`subj_id`) USING BTREE,
  KEY `idx_teacher_user_id` (`teacher_user_id`) USING BTREE,
  KEY `idx_course_id` (`course_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='同行评价-任务-科目老师或节次-认领';

-- ----------------------------
-- Table structure for t_peer_task_user_course_range
-- ----------------------------
DROP TABLE IF EXISTS `t_peer_task_user_course_range`;
CREATE TABLE `t_peer_task_user_course_range` (
  `id` bigint(20) NOT NULL COMMENT '主键ID（雪花算法生成）',
  `peer_task_id` bigint(20) DEFAULT NULL COMMENT '同行任务id',
  `user_id` bigint(20) DEFAULT NULL COMMENT '用户id',
  `course_id` bigint(20) DEFAULT NULL COMMENT '课程id',
  `must_evaluation_flag` tinyint(4) DEFAULT '0' COMMENT '听课要求 0-非必评（默认） 1-必评',
  `create_user_id` bigint(20) DEFAULT NULL COMMENT '创建人id',
  `update_user_id` bigint(20) DEFAULT NULL COMMENT '更新人id',
  `version` int(11) NOT NULL DEFAULT '1' COMMENT '乐观锁版本号',
  `created_date_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `created_by` varchar(50) DEFAULT NULL COMMENT '创建人',
  `last_modified_date_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间',
  `last_modified_by` varchar(50) DEFAULT NULL COMMENT '最后修改人',
  `delete_flag` tinyint(4) NOT NULL DEFAULT '0' COMMENT '删除标志（0：正常，1：删除）',
  `tenant_id` varchar(50) NOT NULL COMMENT '租户编号',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_peer_task_id` (`peer_task_id`) USING BTREE,
  KEY `idx_user_id` (`user_id`) USING BTREE,
  KEY `idx_course_id` (`course_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='同行评价-任务-听课范围-课程节次';

-- ----------------------------
-- Table structure for t_peer_task_user_interest
-- ----------------------------
DROP TABLE IF EXISTS `t_peer_task_user_interest`;
CREATE TABLE `t_peer_task_user_interest` (
  `id` bigint(20) NOT NULL COMMENT '主键ID（雪花算法生成）',
  `peer_task_id` bigint(20) DEFAULT NULL COMMENT '同行任务id',
  `user_id` bigint(20) DEFAULT NULL COMMENT '用户id',
  `subj_id` bigint(20) DEFAULT NULL COMMENT '科目id',
  `teacher_user_id` bigint(20) DEFAULT NULL COMMENT '老师用户id',
  `org_id` bigint(20) DEFAULT NULL COMMENT '院系id',
  `course_id` bigint(20) DEFAULT NULL COMMENT '课程id',
  `create_user_id` bigint(20) DEFAULT NULL COMMENT '创建人id',
  `update_user_id` bigint(20) DEFAULT NULL COMMENT '更新人id',
  `version` int(11) NOT NULL DEFAULT '1' COMMENT '乐观锁版本号',
  `created_date_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `created_by` varchar(50) DEFAULT NULL COMMENT '创建人',
  `last_modified_date_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间',
  `last_modified_by` varchar(50) DEFAULT NULL COMMENT '最后修改人',
  `delete_flag` tinyint(4) NOT NULL DEFAULT '0' COMMENT '删除标志（0：正常，1：删除）',
  `tenant_id` varchar(50) NOT NULL COMMENT '租户编号',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_peer_task_id` (`peer_task_id`) USING BTREE,
  KEY `idx_user_id` (`user_id`) USING BTREE,
  KEY `idx_subj_id` (`subj_id`) USING BTREE,
  KEY `idx_teacher_user_id` (`teacher_user_id`) USING BTREE,
  KEY `idx_course_id` (`course_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='同行评价-任务-科目老师或节次-关注';

-- ----------------------------
-- Table structure for t_peer_task_user_org_range
-- ----------------------------
DROP TABLE IF EXISTS `t_peer_task_user_org_range`;
CREATE TABLE `t_peer_task_user_org_range` (
  `id` bigint(20) NOT NULL COMMENT '主键ID（雪花算法生成）',
  `peer_task_id` bigint(20) DEFAULT NULL COMMENT '同行任务id',
  `user_id` bigint(20) DEFAULT NULL COMMENT '用户id',
  `org_id` bigint(20) DEFAULT NULL COMMENT '院系id',
  `create_user_id` bigint(20) DEFAULT NULL COMMENT '创建人id',
  `update_user_id` bigint(20) DEFAULT NULL COMMENT '更新人id',
  `version` int(11) NOT NULL DEFAULT '1' COMMENT '乐观锁版本号',
  `created_date_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `created_by` varchar(50) DEFAULT NULL COMMENT '创建人',
  `last_modified_date_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间',
  `last_modified_by` varchar(50) DEFAULT NULL COMMENT '最后修改人',
  `delete_flag` tinyint(4) NOT NULL DEFAULT '0' COMMENT '删除标志（0：正常，1：删除）',
  `tenant_id` varchar(50) NOT NULL COMMENT '租户编号',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_peer_task_id` (`peer_task_id`) USING BTREE,
  KEY `idx_user_id` (`user_id`) USING BTREE,
  KEY `idx_org_id` (`org_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='同行评价-任务-听课范围-院系';

-- ----------------------------
-- Table structure for t_peer_task_user_recommend_subject
-- ----------------------------
DROP TABLE IF EXISTS `t_peer_task_user_recommend_subject`;
CREATE TABLE `t_peer_task_user_recommend_subject` (
  `id` bigint(20) NOT NULL COMMENT '主键ID（雪花算法生成）',
  `peer_task_id` bigint(20) DEFAULT NULL COMMENT '同行任务id',
  `subj_id` bigint(20) DEFAULT NULL COMMENT '科目id',
  `user_id` bigint(20) DEFAULT NULL COMMENT '用户id',
  `recommend_reason_id` bigint(20) DEFAULT NULL COMMENT '推荐理由id',
  `create_user_id` bigint(20) DEFAULT NULL COMMENT '创建人id',
  `update_user_id` bigint(20) DEFAULT NULL COMMENT '更新人id',
  `version` int(11) NOT NULL DEFAULT '1' COMMENT '乐观锁版本号',
  `created_date_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `created_by` varchar(50) DEFAULT NULL COMMENT '创建人',
  `last_modified_date_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间',
  `last_modified_by` varchar(50) DEFAULT NULL COMMENT '最后修改人',
  `delete_flag` tinyint(4) NOT NULL DEFAULT '0' COMMENT '删除标志（0：正常，1：删除）',
  `tenant_id` varchar(50) NOT NULL COMMENT '租户编号',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_peer_task_id` (`peer_task_id`) USING BTREE,
  KEY `idx_user_id` (`user_id`) USING BTREE,
  KEY `idx_subj_id` (`subj_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='同行评价-任务-评价人-听课策略-推荐课程表';

-- ----------------------------
-- Table structure for t_peer_task_user_select_subject
-- ----------------------------
DROP TABLE IF EXISTS `t_peer_task_user_select_subject`;
CREATE TABLE `t_peer_task_user_select_subject` (
  `id` bigint(20) NOT NULL COMMENT '主键ID（雪花算法生成）',
  `peer_task_id` bigint(20) DEFAULT NULL COMMENT '同行任务id',
  `subj_id` bigint(20) DEFAULT NULL COMMENT '科目id',
  `user_id` bigint(20) DEFAULT NULL COMMENT '用户id',
  `recommend_reason_id` bigint(20) DEFAULT NULL COMMENT '推荐理由id',
  `create_user_id` bigint(20) DEFAULT NULL COMMENT '创建人id',
  `update_user_id` bigint(20) DEFAULT NULL COMMENT '更新人id',
  `version` int(11) NOT NULL DEFAULT '1' COMMENT '乐观锁版本号',
  `created_date_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `created_by` varchar(50) DEFAULT NULL COMMENT '创建人',
  `last_modified_date_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间',
  `last_modified_by` varchar(50) DEFAULT NULL COMMENT '最后修改人',
  `delete_flag` tinyint(4) NOT NULL DEFAULT '0' COMMENT '删除标志（0：正常，1：删除）',
  `tenant_id` varchar(50) NOT NULL COMMENT '租户编号',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_peer_task_id` (`peer_task_id`) USING BTREE,
  KEY `idx_user_id` (`user_id`) USING BTREE,
  KEY `idx_subj_id` (`subj_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='同行评价-任务-评价人-听课策略-选评课程表';

-- ----------------------------
-- Table structure for t_peer_task_user_strategy
-- ----------------------------
DROP TABLE IF EXISTS `t_peer_task_user_strategy`;
CREATE TABLE `t_peer_task_user_strategy` (
  `id` bigint(20) NOT NULL COMMENT '主键ID（雪花算法生成）',
  `peer_task_id` bigint(20) DEFAULT NULL COMMENT '同行任务id',
  `user_id` bigint(20) DEFAULT NULL COMMENT '用户id',
  `evaluation_times` int(11) DEFAULT NULL COMMENT '次数设置-要求评价次数',
  `evaluation_times_limit_enable` tinyint(4) DEFAULT NULL COMMENT '次数设置-到达评价次数是否可以继续评价',
  `pending_evaluation_max_num` int(11) DEFAULT NULL COMMENT '次数设置-待评上限数量',
  `evaluation_select_course_times` int(11) DEFAULT NULL COMMENT '选评课程-要求从选评课程中评价次数',
  `front_back_acte_id` bigint(20) DEFAULT NULL COMMENT '推荐老师-前后列-学期id',
  `front_rate` decimal(5,2) DEFAULT NULL COMMENT '推荐老师-期末学生评价：前N%老师',
  `back_rate` decimal(5,2) DEFAULT NULL COMMENT '推荐老师-期末学生评价：后N%老师',
  `sideline_enable` tinyint(4) DEFAULT '0' COMMENT '推荐老师-是否推荐兼职教师 默认 false',
  `new_min_year` int(11) DEFAULT NULL COMMENT '推荐老师-推荐入职时间小于N年的教师',
  `low_frequency_acte_id` bigint(20) DEFAULT NULL COMMENT '推荐老师-老师听评低频-学期id',
  `evaluation_low_frequency_min_num` int(11) DEFAULT NULL COMMENT '推荐老师-教师被听次数少于N次',
  `create_user_id` bigint(20) DEFAULT NULL COMMENT '创建人id',
  `update_user_id` bigint(20) DEFAULT NULL COMMENT '更新人id',
  `version` int(11) NOT NULL DEFAULT '1' COMMENT '乐观锁版本号',
  `created_date_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `created_by` varchar(50) DEFAULT NULL COMMENT '创建人',
  `last_modified_date_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间',
  `last_modified_by` varchar(50) DEFAULT NULL COMMENT '最后修改人',
  `delete_flag` tinyint(4) NOT NULL DEFAULT '0' COMMENT '删除标志（0：正常，1：删除）',
  `tenant_id` varchar(50) NOT NULL COMMENT '租户编号',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_peer_task_id` (`peer_task_id`) USING BTREE,
  KEY `idx_user_id` (`user_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='同行评价-任务-评价人-听课策略表';

-- ----------------------------
-- Table structure for t_peer_task_user_subject_range
-- ----------------------------
DROP TABLE IF EXISTS `t_peer_task_user_subject_range`;
CREATE TABLE `t_peer_task_user_subject_range` (
  `id` bigint(20) NOT NULL COMMENT '主键ID（雪花算法生成）',
  `peer_task_id` bigint(20) DEFAULT NULL COMMENT '同行任务id',
  `user_id` bigint(20) DEFAULT NULL COMMENT '用户id',
  `subj_id` bigint(20) DEFAULT NULL COMMENT '科目id',
  `create_user_id` bigint(20) DEFAULT NULL COMMENT '创建人id',
  `update_user_id` bigint(20) DEFAULT NULL COMMENT '更新人id',
  `version` int(11) NOT NULL DEFAULT '1' COMMENT '乐观锁版本号',
  `created_date_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `created_by` varchar(50) DEFAULT NULL COMMENT '创建人',
  `last_modified_date_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间',
  `last_modified_by` varchar(50) DEFAULT NULL COMMENT '最后修改人',
  `delete_flag` tinyint(4) NOT NULL DEFAULT '0' COMMENT '删除标志（0：正常，1：删除）',
  `tenant_id` varchar(50) NOT NULL COMMENT '租户编号',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_peer_task_id` (`peer_task_id`) USING BTREE,
  KEY `idx_user_id` (`user_id`) USING BTREE,
  KEY `idx_subj_id` (`subj_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='同行评价-任务-听课范围-科目';

-- ----------------------------
-- Table structure for t_peer_task_user_tecl_range
-- ----------------------------
DROP TABLE IF EXISTS `t_peer_task_user_tecl_range`;
CREATE TABLE `t_peer_task_user_tecl_range` (
  `id` bigint(20) NOT NULL COMMENT '主键ID（雪花算法生成）',
  `peer_task_id` bigint(20) DEFAULT NULL COMMENT '同行任务id',
  `user_id` bigint(20) DEFAULT NULL COMMENT '用户id',
  `tecl_id` bigint(20) DEFAULT NULL COMMENT '教学班id',
  `create_user_id` bigint(20) DEFAULT NULL COMMENT '创建人id',
  `update_user_id` bigint(20) DEFAULT NULL COMMENT '更新人id',
  `version` int(11) NOT NULL DEFAULT '1' COMMENT '乐观锁版本号',
  `created_date_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `created_by` varchar(50) DEFAULT NULL COMMENT '创建人',
  `last_modified_date_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间',
  `last_modified_by` varchar(50) DEFAULT NULL COMMENT '最后修改人',
  `delete_flag` tinyint(4) NOT NULL DEFAULT '0' COMMENT '删除标志（0：正常，1：删除）',
  `tenant_id` varchar(50) NOT NULL COMMENT '租户编号',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_peer_task_id` (`peer_task_id`) USING BTREE,
  KEY `idx_user_id` (`user_id`) USING BTREE,
  KEY `idx_tecl_id` (`tecl_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='同行评价-任务-听课范围-教学班';

-- ----------------------------
-- Table structure for t_quota_dim
-- ----------------------------
DROP TABLE IF EXISTS `t_quota_dim`;
CREATE TABLE `t_quota_dim` (
  `id` bigint(20) NOT NULL COMMENT '主键ID（雪花算法生成）',
  `evaluate_type_code` tinyint(4) DEFAULT NULL COMMENT '评价类型编码',
  `quota_dim_name` varchar(255) DEFAULT NULL COMMENT '指标维度名称',
  `create_user_id` bigint(20) DEFAULT NULL COMMENT '创建人id',
  `update_user_id` bigint(20) DEFAULT NULL COMMENT '更新人id',
  `version` int(11) NOT NULL DEFAULT '1' COMMENT '乐观锁版本号',
  `created_date_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `created_by` varchar(50) DEFAULT NULL COMMENT '创建人',
  `last_modified_date_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间',
  `last_modified_by` varchar(50) DEFAULT NULL COMMENT '最后修改人',
  `delete_flag` tinyint(4) NOT NULL DEFAULT '0' COMMENT '删除标志（0：正常，1：删除）',
  `tenant_id` varchar(50) NOT NULL COMMENT '租户编号',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='指标维度表';

-- ----------------------------
-- Table structure for t_quota_point
-- ----------------------------
DROP TABLE IF EXISTS `t_quota_point`;
CREATE TABLE `t_quota_point` (
  `id` bigint(20) NOT NULL COMMENT '主键ID（雪花算法生成）',
  `evaluate_type_code` tinyint(4) DEFAULT NULL COMMENT '评价类型编码',
  `quota_dim_id` bigint(20) NOT NULL COMMENT '指标维度id',
  `quota_point_name` varchar(255) DEFAULT NULL COMMENT '指标点名称',
  `create_user_id` bigint(20) DEFAULT NULL COMMENT '创建人id',
  `update_user_id` bigint(20) DEFAULT NULL COMMENT '更新人id',
  `version` int(11) NOT NULL DEFAULT '1' COMMENT '乐观锁版本号',
  `created_date_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `created_by` varchar(50) DEFAULT NULL COMMENT '创建人',
  `last_modified_date_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间',
  `last_modified_by` varchar(50) DEFAULT NULL COMMENT '最后修改人',
  `delete_flag` tinyint(4) NOT NULL DEFAULT '0' COMMENT '删除标志（0：正常，1：删除）',
  `tenant_id` varchar(50) NOT NULL COMMENT '租户编号',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_quota_dim_id` (`quota_dim_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='指标点表';

-- ----------------------------
-- Table structure for t_recommend_reason
-- ----------------------------
DROP TABLE IF EXISTS `t_recommend_reason`;
CREATE TABLE `t_recommend_reason` (
  `id` bigint(20) NOT NULL COMMENT '主键ID（雪花算法生成）',
  `reason_name` varchar(255) DEFAULT NULL COMMENT '理由名称',
  `common_flag` tinyint(4) DEFAULT '0' COMMENT '是否公共，0-否 (默认)， 1-是',
  `create_user_id` bigint(20) DEFAULT NULL COMMENT '创建人id',
  `update_user_id` bigint(20) DEFAULT NULL COMMENT '更新人id',
  `version` int(11) NOT NULL DEFAULT '1' COMMENT '乐观锁版本号',
  `created_date_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `created_by` varchar(50) DEFAULT NULL COMMENT '创建人',
  `last_modified_date_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间',
  `last_modified_by` varchar(50) DEFAULT NULL COMMENT '最后修改人',
  `delete_flag` tinyint(4) NOT NULL DEFAULT '0' COMMENT '删除标志（0：正常，1：删除）',
  `tenant_id` varchar(50) NOT NULL COMMENT '租户编号',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='推荐理由表';

-- ----------------------------
-- Table structure for t_sup_course_record
-- ----------------------------
DROP TABLE IF EXISTS `t_sup_course_record`;
CREATE TABLE `t_sup_course_record` (
  `id` bigint(20) NOT NULL COMMENT '主键ID（雪花算法生成）',
  `sup_task_id` bigint(20) DEFAULT NULL COMMENT '督导任务id',
  `sup_status` tinyint(4) DEFAULT NULL COMMENT '督导评价 0-未评 1-已评',
  `cour_id` bigint(20) DEFAULT NULL COMMENT '课程id',
  `acte_id` bigint(20) DEFAULT NULL COMMENT '学期id',
  `subj_id` bigint(20) DEFAULT NULL COMMENT '科目id',
  `subj_code` varchar(100) DEFAULT NULL COMMENT '科目编码',
  `subj_name` varchar(255) DEFAULT NULL COMMENT '科目名称',
  `sup_user_id` bigint(20) DEFAULT NULL COMMENT '督导用户id',
  `sup_user_code` varchar(100) DEFAULT NULL COMMENT '督导用户编码',
  `sup_user_name` varchar(255) DEFAULT NULL COMMENT '督导用户名称',
  `sup_user_level` tinyint(4) DEFAULT NULL COMMENT '督导级别 1-校级督导 2-院级督导 3-校，院级督导',
  `by_sup_user_id` bigint(20) DEFAULT NULL COMMENT '被评用户id',
  `by_sup_user_code` varchar(100) DEFAULT NULL COMMENT '被评用户编码',
  `by_sup_user_name` varchar(255) DEFAULT NULL COMMENT '被评用户名称',
  `tecl_org_id` bigint(20) DEFAULT NULL COMMENT '排课院系id',
  `tecl_org_code` varchar(100) DEFAULT NULL COMMENT '排课院系编码',
  `tecl_org_name` varchar(255) DEFAULT NULL COMMENT '排课院系名称',
  `tecl_id` bigint(20) DEFAULT NULL COMMENT '教学班id',
  `tecl_code` varchar(100) DEFAULT NULL COMMENT '教学班编码',
  `tecl_name` varchar(255) DEFAULT NULL COMMENT '教学班名称',
  `cour_begin_time` datetime DEFAULT NULL COMMENT '课程开始时间',
  `cour_end_time` datetime DEFAULT NULL COMMENT '课程结束时间',
  `leti_number` int(11) DEFAULT NULL COMMENT '课程节次',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `create_user_id` bigint(20) DEFAULT NULL COMMENT '创建人id',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `update_user_id` bigint(20) DEFAULT NULL COMMENT '更新人id',
  `version` int(11) NOT NULL DEFAULT '1' COMMENT '乐观锁版本号',
  `created_date_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `created_by` varchar(50) DEFAULT NULL COMMENT '创建人',
  `last_modified_date_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间',
  `last_modified_by` varchar(50) DEFAULT NULL COMMENT '最后修改人',
  `delete_flag` tinyint(4) NOT NULL DEFAULT '0' COMMENT '删除标志（0：正常，1：删除）',
  `tenant_id` varchar(50) NOT NULL COMMENT '租户编号',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_sup_task_id` (`sup_task_id`) USING BTREE,
  KEY `idx_cour_id` (`cour_id`) USING BTREE,
  KEY `idx_acte_id` (`acte_id`) USING BTREE,
  KEY `idx_subj_id` (`subj_id`) USING BTREE,
  KEY `idx_sup_user_id` (`sup_user_id`) USING BTREE,
  KEY `idx_by_sup_user_id` (`by_sup_user_id`) USING BTREE,
  KEY `idx_tecl_id` (`tecl_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='督导评价-课程节次评价-记录';

-- ----------------------------
-- Table structure for t_sup_record_photo_review
-- ----------------------------
DROP TABLE IF EXISTS `t_sup_record_photo_review`;
CREATE TABLE `t_sup_record_photo_review` (
  `id` bigint(20) NOT NULL COMMENT '主键ID（雪花算法生成）',
  `sup_task_id` bigint(20) DEFAULT NULL COMMENT '督导任务id',
  `sup_user_id` bigint(20) DEFAULT NULL COMMENT '督导用户id',
  `subj_id` bigint(20) DEFAULT NULL COMMENT '科目id-评价到课程时有值',
  `teacher_user_id` bigint(20) DEFAULT NULL COMMENT '老师用户id-评价到课程时有值',
  `org_id` bigint(20) DEFAULT NULL COMMENT '院系id-评价到课程时有值',
  `review_type` tinyint(4) DEFAULT NULL COMMENT '点评类型 1-好评 2-差评',
  `review_content` text COMMENT '点评内容',
  `cour_id` bigint(20) DEFAULT NULL COMMENT '课程id',
  `process_start_time` varchar(255) DEFAULT NULL COMMENT '进度时间-开始 格式 yyyy-MM-dd HH:mm:ss',
  `process_end_time` varchar(255) DEFAULT NULL COMMENT '进度时间-结束 格式 yyyy-MM-dd HH:mm:ss',
  `play_start_time` varchar(255) DEFAULT NULL COMMENT '播放进度时间-开始 格式 HH:mm:ss',
  `play_end_time` varchar(255) DEFAULT NULL COMMENT '播放进度时间-结束 格式 HH:mm:ss',
  `create_user_id` bigint(20) DEFAULT NULL COMMENT '创建人id',
  `update_user_id` bigint(20) DEFAULT NULL COMMENT '更新人id',
  `version` int(11) NOT NULL DEFAULT '1' COMMENT '乐观锁版本号',
  `created_date_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `created_by` varchar(50) DEFAULT NULL COMMENT '创建人',
  `last_modified_date_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间',
  `last_modified_by` varchar(50) DEFAULT NULL COMMENT '最后修改人',
  `delete_flag` tinyint(4) NOT NULL DEFAULT '0' COMMENT '删除标志（0：正常，1：删除）',
  `tenant_id` varchar(50) NOT NULL COMMENT '租户编号',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_sup_task_id` (`sup_task_id`) USING BTREE,
  KEY `idx_cour_id` (`cour_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='督导评价-评价-拍照点评表';

-- ----------------------------
-- Table structure for t_sup_record_photo_review_file
-- ----------------------------
DROP TABLE IF EXISTS `t_sup_record_photo_review_file`;
CREATE TABLE `t_sup_record_photo_review_file` (
  `id` bigint(20) NOT NULL COMMENT '主键ID（雪花算法生成）',
  `sup_record_photo_review_id` bigint(20) NOT NULL COMMENT '拍照点评id',
  `file_id` bigint(20) NOT NULL COMMENT '文件id',
  `file_name` varchar(255) NOT NULL COMMENT '文件名称',
  `file_url` varchar(500) NOT NULL COMMENT '文件url',
  `file_size` bigint(20) DEFAULT NULL COMMENT '文件大小',
  `create_user_id` bigint(20) DEFAULT NULL COMMENT '创建人id',
  `update_user_id` bigint(20) DEFAULT NULL COMMENT '更新人id',
  `version` int(11) NOT NULL DEFAULT '1' COMMENT '乐观锁版本号',
  `created_date_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `created_by` varchar(50) DEFAULT NULL COMMENT '创建人',
  `last_modified_date_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间',
  `last_modified_by` varchar(50) DEFAULT NULL COMMENT '最后修改人',
  `delete_flag` tinyint(4) NOT NULL DEFAULT '0' COMMENT '删除标志（0：正常，1：删除）',
  `tenant_id` varchar(50) NOT NULL COMMENT '租户编号',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_sup_record_photo_review_id` (`sup_record_photo_review_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='督导评价-评价-拍照点评-文件表';

-- ----------------------------
-- Table structure for t_sup_record_survey
-- ----------------------------
DROP TABLE IF EXISTS `t_sup_record_survey`;
CREATE TABLE `t_sup_record_survey` (
  `id` bigint(20) NOT NULL COMMENT '主键ID（雪花算法生成）',
  `sup_task_id` bigint(20) DEFAULT NULL COMMENT '督导任务id',
  `sup_record_id` bigint(20) DEFAULT NULL COMMENT '督导记录id',
  `sup_dim_code` tinyint(4) DEFAULT NULL COMMENT '评价维度 1-评价到教学班 2-评价到课程',
  `survey_id` varchar(255) DEFAULT NULL COMMENT '问卷id',
  `survey_name` varchar(255) DEFAULT NULL COMMENT '问卷名称',
  `survey_data_id` varchar(255) DEFAULT NULL COMMENT '问卷填写数据id',
  `survey_submit_status` tinyint(4) DEFAULT NULL COMMENT '问卷提交状态 草稿：-1 ，已提交：1',
  `survey_submit_time` datetime DEFAULT NULL COMMENT '问卷提交时间',
  `sup_result_score` decimal(5,2) DEFAULT NULL COMMENT '问卷结果得分',
  `reason` varchar(2000) DEFAULT NULL COMMENT '理由',
  `create_user_id` bigint(20) DEFAULT NULL COMMENT '创建人id',
  `update_user_id` bigint(20) DEFAULT NULL COMMENT '更新人id',
  `version` int(11) NOT NULL DEFAULT '1' COMMENT '乐观锁版本号',
  `created_date_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `created_by` varchar(50) DEFAULT NULL COMMENT '创建人',
  `last_modified_date_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间',
  `last_modified_by` varchar(50) DEFAULT NULL COMMENT '最后修改人',
  `delete_flag` tinyint(4) NOT NULL DEFAULT '0' COMMENT '删除标志（0：正常，1：删除）',
  `tenant_id` varchar(50) NOT NULL COMMENT '租户编号',
  `reason_type` tinyint(4) DEFAULT NULL COMMENT '理由类型- 1-低 2-高',
  `score_level_id` bigint(20) DEFAULT NULL COMMENT '选中的评分等级id',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_sup_task_id` (`sup_task_id`) USING BTREE,
  KEY `idx_sup_record_id` (`sup_record_id`) USING BTREE,
  KEY `idx_survey_id` (`survey_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='督导评价-评价-问卷';

-- ----------------------------
-- Table structure for t_sup_subject_record
-- ----------------------------
DROP TABLE IF EXISTS `t_sup_subject_record`;
CREATE TABLE `t_sup_subject_record` (
  `id` bigint(20) NOT NULL COMMENT '主键ID（雪花算法生成）',
  `sup_task_id` bigint(20) DEFAULT NULL COMMENT '督导任务id',
  `sup_status` tinyint(4) DEFAULT NULL COMMENT '督导评价 0-未评 1-已评',
  `acte_id` bigint(20) DEFAULT NULL COMMENT '学期id',
  `subj_id` bigint(20) DEFAULT NULL COMMENT '科目id',
  `subj_code` varchar(100) DEFAULT NULL COMMENT '科目编码',
  `subj_name` varchar(255) DEFAULT NULL COMMENT '科目名称',
  `org_id` bigint(20) DEFAULT NULL COMMENT '院系id',
  `org_code` varchar(100) DEFAULT NULL COMMENT '院系编码',
  `org_name` varchar(255) DEFAULT NULL COMMENT '院系名称',
  `sup_user_id` bigint(20) DEFAULT NULL COMMENT '督导用户id',
  `sup_user_code` varchar(100) DEFAULT NULL COMMENT '督导用户编码',
  `sup_user_name` varchar(255) DEFAULT NULL COMMENT '督导用户名称',
  `sup_user_level` tinyint(4) DEFAULT NULL COMMENT '督导级别 1-校级督导 2-院级督导 3-校，院级督导',
  `by_sup_user_id` bigint(20) DEFAULT NULL COMMENT '被评用户id',
  `by_sup_user_code` varchar(100) DEFAULT NULL COMMENT '被评用户编码',
  `by_sup_user_name` varchar(255) DEFAULT NULL COMMENT '被评用户名称',
  `create_user_id` bigint(20) DEFAULT NULL COMMENT '创建人id',
  `update_user_id` bigint(20) DEFAULT NULL COMMENT '更新人id',
  `version` int(11) NOT NULL DEFAULT '1' COMMENT '乐观锁版本号',
  `created_date_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `created_by` varchar(50) DEFAULT NULL COMMENT '创建人',
  `last_modified_date_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间',
  `last_modified_by` varchar(50) DEFAULT NULL COMMENT '最后修改人',
  `delete_flag` tinyint(4) NOT NULL DEFAULT '0' COMMENT '删除标志（0：正常，1：删除）',
  `tenant_id` varchar(50) NOT NULL COMMENT '租户编号',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_sup_task_id` (`sup_task_id`) USING BTREE,
  KEY `idx_acte_id` (`acte_id`) USING BTREE,
  KEY `idx_subj_id` (`subj_id`) USING BTREE,
  KEY `idx_org_id` (`org_id`) USING BTREE,
  KEY `idx_sup_user_id` (`sup_user_id`) USING BTREE,
  KEY `idx_by_sup_user_id` (`by_sup_user_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='督导评价-课程(科目)评价-记录';

-- ----------------------------
-- Table structure for t_sup_task
-- ----------------------------
DROP TABLE IF EXISTS `t_sup_task`;
CREATE TABLE `t_sup_task` (
  `id` bigint(20) NOT NULL COMMENT '主键ID（雪花算法生成）',
  `task_name` varchar(255) DEFAULT NULL COMMENT '任务名称',
  `sup_dim_code` tinyint(4) DEFAULT NULL COMMENT '评价维度 1-评价到教学班 2-评价到课程',
  `educational_level` tinyint(4) DEFAULT NULL COMMENT '学历层次 1-本科 2-研究生',
  `task_level` tinyint(4) DEFAULT NULL COMMENT '任务级别 1-校级 2-院级',
  `task_org_id` bigint(20) DEFAULT NULL COMMENT '任务所属组织id',
  `acte_id` bigint(20) DEFAULT NULL COMMENT '学期id',
  `task_status` tinyint(4) DEFAULT NULL COMMENT '任务状态 0-未发布 1-已发布',
  `task_start_time` datetime DEFAULT NULL COMMENT '任务开始时间',
  `task_end_time` datetime DEFAULT NULL COMMENT '任务结束时间',
  `sup_online_type` tinyint(4) DEFAULT NULL COMMENT '在线听课类型 1-不允许在线听课 2-仅允许观看直播 3-仅允许观看点播 4-允许同时观看直播和点播',
  `sup_reason_enable` tinyint(4) DEFAULT NULL COMMENT '评分是否需要填写理由',
  `sup_reason_high_type` tinyint(4) DEFAULT NULL COMMENT '高分区间类型 1-大于 2-大于等于',
  `sup_reason_high_score` decimal(5,2) DEFAULT NULL COMMENT '高分分值',
  `sup_reason_low_type` tinyint(4) DEFAULT NULL COMMENT '低分区间类型 1-大于 2-大于等于',
  `sup_reason_low_score` decimal(5,2) DEFAULT NULL COMMENT '低分分值',
  `college_admin_result_enable` tinyint(4) DEFAULT NULL COMMENT '院系管理员是否可查看校级任务内本院系的数据',
  `college_admin_result_anonymous` tinyint(4) DEFAULT '0' COMMENT '院系管理员-督导信息匿名 0-匿名（默认） 1-不匿名',
  `by_sup_user_result_enable` tinyint(4) DEFAULT '0' COMMENT '被评用户-是否允许查看任务结果（默认不允许）',
  `by_sup_user_result_type` tinyint(4) DEFAULT NULL COMMENT '被评用户-可查看结果类型 1-仅查看文本意见 2-查看整个评价表',
  `opinion_communication_enable` tinyint(4) DEFAULT NULL COMMENT '配置意见反馈题时，允许评价者（匿名）与被评者实时沟通',
  `score_level_enable` tinyint(4) DEFAULT NULL COMMENT '是否开启评分区段',
  `claim_limit_type` tinyint(4) DEFAULT NULL COMMENT '认领上限类型 1-不设置认领上限 2-设置同一教师被认领次数上限 3-设置同一教师同一课程被认领次数上限',
  `claim_limit_num` int(11) DEFAULT NULL COMMENT '认领上限次数',
  `claim_course_time_range_enable` tinyint(4) DEFAULT NULL COMMENT '是否设置认领的课表日期范围 0-否 1-是',
  `claim_course_time_range_front_day` int(11) DEFAULT NULL COMMENT '督导可认领当日及前N天课表',
  `claim_course_time_range_back_day` int(11) DEFAULT NULL COMMENT '督导可认领当日及后N天课表',
  `claim_task_time_validity_enable` tinyint(4) DEFAULT NULL COMMENT '是否设置任务自动释放的时效 0-否 1-是',
  `claim_task_time_validity_day` int(11) DEFAULT NULL COMMENT '教师上课后N天督导未评价或保存，系统自动释放任务',
  `create_user_id` bigint(20) DEFAULT NULL COMMENT '创建人id',
  `update_user_id` bigint(20) DEFAULT NULL COMMENT '更新人id',
  `version` int(11) NOT NULL DEFAULT '1' COMMENT '乐观锁版本号',
  `created_date_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `created_by` varchar(50) DEFAULT NULL COMMENT '创建人',
  `last_modified_date_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间',
  `last_modified_by` varchar(50) DEFAULT NULL COMMENT '最后修改人',
  `delete_flag` tinyint(4) NOT NULL DEFAULT '0' COMMENT '删除标志（0：正常，1：删除）',
  `tenant_id` varchar(50) NOT NULL COMMENT '租户编号',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='督导评价-任务表';

-- ----------------------------
-- Table structure for t_sup_task_course_field_config
-- ----------------------------
DROP TABLE IF EXISTS `t_sup_task_course_field_config`;
CREATE TABLE `t_sup_task_course_field_config` (
  `id` bigint(20) NOT NULL COMMENT '主键ID（雪花算法生成）',
  `sup_task_id` bigint(20) DEFAULT NULL COMMENT '督导任务id',
  `field_name` varchar(255) DEFAULT NULL COMMENT '字段名称',
  `field_code` varchar(100) DEFAULT NULL COMMENT '字段编码',
  `show_enable` tinyint(4) DEFAULT NULL COMMENT '是否显示',
  `export_enable` tinyint(4) DEFAULT NULL COMMENT '是否导出',
  `order_index` int(11) DEFAULT NULL COMMENT '排序值',
  `create_user_id` bigint(20) DEFAULT NULL COMMENT '创建人id',
  `update_user_id` bigint(20) DEFAULT NULL COMMENT '更新人id',
  `version` int(11) NOT NULL DEFAULT '1' COMMENT '乐观锁版本号',
  `created_date_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `created_by` varchar(50) DEFAULT NULL COMMENT '创建人',
  `last_modified_date_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间',
  `last_modified_by` varchar(50) DEFAULT NULL COMMENT '最后修改人',
  `delete_flag` tinyint(4) NOT NULL DEFAULT '0' COMMENT '删除标志（0：正常，1：删除）',
  `tenant_id` varchar(50) NOT NULL COMMENT '租户编号',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_sup_task_id` (`sup_task_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='督导评价-任务-课程信息展示-配置';

-- ----------------------------
-- Table structure for t_sup_task_plan
-- ----------------------------
DROP TABLE IF EXISTS `t_sup_task_plan`;
CREATE TABLE `t_sup_task_plan` (
  `id` bigint(20) NOT NULL COMMENT '主键ID（雪花算法生成）',
  `sup_task_id` bigint(20) DEFAULT NULL COMMENT '督导任务id',
  `sup_user_id` bigint(20) DEFAULT NULL COMMENT '督导用户id',
  `subj_id` bigint(20) DEFAULT NULL COMMENT '科目id',
  `subj_type_id` bigint(20) DEFAULT NULL COMMENT '课程类型id',
  `teacher_user_id` bigint(20) DEFAULT NULL COMMENT '教师用户id',
  `org_id` bigint(20) DEFAULT NULL COMMENT '院系id',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `create_user_id` bigint(20) DEFAULT NULL COMMENT '创建人id',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `update_user_id` bigint(20) DEFAULT NULL COMMENT '更新人id',
  `version` int(11) NOT NULL DEFAULT '1' COMMENT '乐观锁版本号',
  `created_date_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `created_by` varchar(50) DEFAULT NULL COMMENT '创建人',
  `last_modified_date_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间',
  `last_modified_by` varchar(50) DEFAULT NULL COMMENT '最后修改人',
  `delete_flag` tinyint(4) NOT NULL DEFAULT '0' COMMENT '删除标志（0：正常，1：删除）',
  `tenant_id` varchar(50) NOT NULL COMMENT '租户编号',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_sup_task_id` (`sup_task_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='督导评价-任务规划';

-- ----------------------------
-- Table structure for t_sup_task_plan_survey
-- ----------------------------
DROP TABLE IF EXISTS `t_sup_task_plan_survey`;
CREATE TABLE `t_sup_task_plan_survey` (
  `id` bigint(20) NOT NULL COMMENT '主键ID（雪花算法生成）',
  `sup_task_plan_id` bigint(20) DEFAULT NULL COMMENT '督导评价-任务规划Id',
  `survey_id` varchar(255) DEFAULT NULL COMMENT '问卷id',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `create_user_id` bigint(20) DEFAULT NULL COMMENT '创建人id',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `update_user_id` bigint(20) DEFAULT NULL COMMENT '更新人id',
  `version` int(11) NOT NULL DEFAULT '1' COMMENT '乐观锁版本号',
  `created_date_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `created_by` varchar(50) DEFAULT NULL COMMENT '创建人',
  `last_modified_date_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间',
  `last_modified_by` varchar(50) DEFAULT NULL COMMENT '最后修改人',
  `delete_flag` tinyint(4) NOT NULL DEFAULT '0' COMMENT '删除标志（0：正常，1：删除）',
  `tenant_id` varchar(50) NOT NULL COMMENT '租户编号',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_sup_task_plan_id` (`sup_task_plan_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='督导评价-任务规划问卷';

-- ----------------------------
-- Table structure for t_sup_task_score_level
-- ----------------------------
DROP TABLE IF EXISTS `t_sup_task_score_level`;
CREATE TABLE `t_sup_task_score_level` (
  `id` bigint(20) NOT NULL COMMENT '主键ID（雪花算法生成）',
  `sup_task_id` bigint(20) DEFAULT NULL COMMENT '督导任务id',
  `level_name` varchar(255) DEFAULT NULL COMMENT '等级名称',
  `high_score_type` tinyint(4) DEFAULT NULL COMMENT '高分类型 1-小于 2-小于等于',
  `high_score` decimal(5,2) DEFAULT NULL COMMENT '高分',
  `low_score_type` tinyint(4) DEFAULT NULL COMMENT '低分类型 1-大于 2-大于等于',
  `low_score` decimal(5,2) DEFAULT NULL COMMENT '低分',
  `level_desc` varchar(500) DEFAULT NULL COMMENT '等级描述',
  `order_index` int(11) DEFAULT NULL COMMENT '排序',
  `create_user_id` bigint(20) DEFAULT NULL COMMENT '创建人id',
  `update_user_id` bigint(20) DEFAULT NULL COMMENT '更新人id',
  `version` int(11) NOT NULL DEFAULT '1' COMMENT '乐观锁版本号',
  `created_date_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `created_by` varchar(50) DEFAULT NULL COMMENT '创建人',
  `last_modified_date_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间',
  `last_modified_by` varchar(50) DEFAULT NULL COMMENT '最后修改人',
  `delete_flag` tinyint(4) NOT NULL DEFAULT '0' COMMENT '删除标志（0：正常，1：删除）',
  `tenant_id` varchar(50) NOT NULL COMMENT '租户编号',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_sup_task_id` (`sup_task_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='督导评价-任务-评分等级';

-- ----------------------------
-- Table structure for t_sup_task_subj_type
-- ----------------------------
DROP TABLE IF EXISTS `t_sup_task_subj_type`;
CREATE TABLE `t_sup_task_subj_type` (
  `id` bigint(20) NOT NULL COMMENT '主键ID（雪花算法生成）',
  `group_id` bigint(20) DEFAULT NULL COMMENT '关联组id',
  `type_id` bigint(20) DEFAULT NULL COMMENT '类型id',
  `type_name` varchar(255) DEFAULT NULL COMMENT '类型名称',
  `sort_index` int(11) DEFAULT NULL COMMENT '排序',
  `create_user_id` bigint(20) DEFAULT NULL COMMENT '创建人id',
  `update_user_id` bigint(20) DEFAULT NULL COMMENT '更新人id',
  `version` int(11) NOT NULL DEFAULT '1' COMMENT '乐观锁版本号',
  `created_date_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `created_by` varchar(50) DEFAULT NULL COMMENT '创建人',
  `last_modified_date_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间',
  `last_modified_by` varchar(50) DEFAULT NULL COMMENT '最后修改人',
  `delete_flag` tinyint(4) NOT NULL DEFAULT '0' COMMENT '删除标志（0：正常，1：删除）',
  `tenant_id` varchar(50) NOT NULL COMMENT '租户编号',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_group_id` (`group_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='督导评价-任务-课程类型表';

-- ----------------------------
-- Table structure for t_sup_task_subj_type_survey_group
-- ----------------------------
DROP TABLE IF EXISTS `t_sup_task_subj_type_survey_group`;
CREATE TABLE `t_sup_task_subj_type_survey_group` (
  `id` bigint(20) NOT NULL COMMENT '主键ID（雪花算法生成）',
  `group_name` varchar(255) DEFAULT NULL COMMENT '组名',
  `sup_task_id` bigint(20) DEFAULT NULL COMMENT '督导任务id',
  `all_subj_type_flag` tinyint(4) NOT NULL DEFAULT '0' COMMENT '是否全部课程类型 0-否（默认） 1-是 ',
  `sort_index` int(11) DEFAULT NULL COMMENT '排序',
  `create_user_id` bigint(20) DEFAULT NULL COMMENT '创建人id',
  `update_user_id` bigint(20) DEFAULT NULL COMMENT '更新人id',
  `version` int(11) NOT NULL DEFAULT '1' COMMENT '乐观锁版本号',
  `created_date_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `created_by` varchar(50) DEFAULT NULL COMMENT '创建人',
  `last_modified_date_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间',
  `last_modified_by` varchar(50) DEFAULT NULL COMMENT '最后修改人',
  `delete_flag` tinyint(4) NOT NULL DEFAULT '0' COMMENT '删除标志（0：正常，1：删除）',
  `tenant_id` varchar(50) NOT NULL COMMENT '租户编号',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_sup_task_id` (`sup_task_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='督导评价-任务-课程类型问卷-组表';

-- ----------------------------
-- Table structure for t_sup_task_survey
-- ----------------------------
DROP TABLE IF EXISTS `t_sup_task_survey`;
CREATE TABLE `t_sup_task_survey` (
  `id` bigint(20) NOT NULL COMMENT '主键ID（雪花算法生成）',
  `group_id` bigint(20) DEFAULT NULL COMMENT '关联组id',
  `survey_id` varchar(255) DEFAULT NULL COMMENT '问卷id',
  `survey_name` varchar(255) DEFAULT NULL COMMENT '问卷名称',
  `score_flag` tinyint(4) DEFAULT '1' COMMENT '是否计分 0-否 1-是(默认)',
  `sort_index` int(11) DEFAULT NULL COMMENT '排序值',
  `create_user_id` bigint(20) DEFAULT NULL COMMENT '创建人id',
  `update_user_id` bigint(20) DEFAULT NULL COMMENT '更新人id',
  `version` int(11) NOT NULL DEFAULT '1' COMMENT '乐观锁版本号',
  `created_date_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `created_by` varchar(50) DEFAULT NULL COMMENT '创建人',
  `last_modified_date_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间',
  `last_modified_by` varchar(50) DEFAULT NULL COMMENT '最后修改人',
  `delete_flag` tinyint(4) NOT NULL DEFAULT '0' COMMENT '删除标志（0：正常，1：删除）',
  `tenant_id` varchar(50) NOT NULL COMMENT '租户编号',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_group_id` (`group_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='督导评价-任务-问卷表';

-- ----------------------------
-- Table structure for t_sup_task_user
-- ----------------------------
DROP TABLE IF EXISTS `t_sup_task_user`;
CREATE TABLE `t_sup_task_user` (
  `id` bigint(20) NOT NULL COMMENT '主键ID（雪花算法生成）',
  `sup_task_id` bigint(20) DEFAULT NULL COMMENT '督导任务id',
  `user_id` bigint(20) DEFAULT NULL COMMENT '用户id',
  `user_code` varchar(100) DEFAULT NULL COMMENT '用户编码',
  `user_name` varchar(255) DEFAULT NULL COMMENT '用户名称',
  `org_id` bigint(20) DEFAULT NULL COMMENT '组织id',
  `org_code` varchar(100) DEFAULT NULL COMMENT '组织编码',
  `org_name` varchar(255) DEFAULT NULL COMMENT '组织名称',
  `range_all_org_flag` tinyint(4) DEFAULT '0' COMMENT '听课范围-院系维度-是否全部院系（0：否（默认），1：是）',
  `create_user_id` bigint(20) DEFAULT NULL COMMENT '创建人id',
  `update_user_id` bigint(20) DEFAULT NULL COMMENT '更新人id',
  `version` int(11) NOT NULL DEFAULT '1' COMMENT '乐观锁版本号',
  `created_date_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `created_by` varchar(50) DEFAULT NULL COMMENT '创建人',
  `last_modified_date_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间',
  `last_modified_by` varchar(50) DEFAULT NULL COMMENT '最后修改人',
  `delete_flag` tinyint(4) NOT NULL DEFAULT '0' COMMENT '删除标志（0：正常，1：删除）',
  `tenant_id` varchar(50) NOT NULL COMMENT '租户编号',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_sup_task_id` (`sup_task_id`) USING BTREE,
  KEY `idx_user_id` (`user_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='督导评价-任务-督导人员';

-- ----------------------------
-- Table structure for t_sup_task_user_claim
-- ----------------------------
DROP TABLE IF EXISTS `t_sup_task_user_claim`;
CREATE TABLE `t_sup_task_user_claim` (
  `id` bigint(20) NOT NULL COMMENT '主键ID（雪花算法生成）',
  `sup_task_id` bigint(20) DEFAULT NULL COMMENT '督导任务id',
  `user_id` bigint(20) DEFAULT NULL COMMENT '用户id',
  `subj_id` bigint(20) DEFAULT NULL COMMENT '科目id',
  `teacher_user_id` bigint(20) DEFAULT NULL COMMENT '老师用户id',
  `org_id` bigint(20) DEFAULT NULL COMMENT '院系id',
  `course_id` bigint(20) DEFAULT NULL COMMENT '课程id',
  `sup_record_id` bigint(20) DEFAULT NULL COMMENT '督导科目评价id',
  `sup_status` tinyint(4) DEFAULT '0' COMMENT '督导评价 0-未评 1-已评',
  `create_user_id` bigint(20) DEFAULT NULL COMMENT '创建人id',
  `update_user_id` bigint(20) DEFAULT NULL COMMENT '更新人id',
  `version` int(11) NOT NULL DEFAULT '1' COMMENT '乐观锁版本号',
  `created_date_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `created_by` varchar(50) DEFAULT NULL COMMENT '创建人',
  `last_modified_date_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间',
  `last_modified_by` varchar(50) DEFAULT NULL COMMENT '最后修改人',
  `delete_flag` tinyint(4) NOT NULL DEFAULT '0' COMMENT '删除标志（0：正常，1：删除）',
  `tenant_id` varchar(50) NOT NULL COMMENT '租户编号',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_sup_task_id` (`sup_task_id`) USING BTREE,
  KEY `idx_user_id` (`user_id`) USING BTREE,
  KEY `idx_subj_id` (`subj_id`) USING BTREE,
  KEY `idx_teacher_user_id` (`teacher_user_id`) USING BTREE,
  KEY `idx_course_id` (`course_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='督导评价-任务-科目老师或节次-认领';

-- ----------------------------
-- Table structure for t_sup_task_user_course_range
-- ----------------------------
DROP TABLE IF EXISTS `t_sup_task_user_course_range`;
CREATE TABLE `t_sup_task_user_course_range` (
  `id` bigint(20) NOT NULL COMMENT '主键ID（雪花算法生成）',
  `sup_task_id` bigint(20) DEFAULT NULL COMMENT '督导任务id',
  `user_id` bigint(20) DEFAULT NULL COMMENT '用户id',
  `course_id` bigint(20) DEFAULT NULL COMMENT '课程id',
  `must_sup_flag` tinyint(4) DEFAULT '0' COMMENT '听课要求 0-非必评（默认） 1-必评',
  `create_user_id` bigint(20) DEFAULT NULL COMMENT '创建人id',
  `update_user_id` bigint(20) DEFAULT NULL COMMENT '更新人id',
  `version` int(11) NOT NULL DEFAULT '1' COMMENT '乐观锁版本号',
  `created_date_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `created_by` varchar(50) DEFAULT NULL COMMENT '创建人',
  `last_modified_date_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间',
  `last_modified_by` varchar(50) DEFAULT NULL COMMENT '最后修改人',
  `delete_flag` tinyint(4) NOT NULL DEFAULT '0' COMMENT '删除标志（0：正常，1：删除）',
  `tenant_id` varchar(50) NOT NULL COMMENT '租户编号',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_sup_task_id` (`sup_task_id`) USING BTREE,
  KEY `idx_user_id` (`user_id`) USING BTREE,
  KEY `idx_course_id` (`course_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='督导评价-任务-听课范围-课程节次';

-- ----------------------------
-- Table structure for t_sup_task_user_interest
-- ----------------------------
DROP TABLE IF EXISTS `t_sup_task_user_interest`;
CREATE TABLE `t_sup_task_user_interest` (
  `id` bigint(20) NOT NULL COMMENT '主键ID（雪花算法生成）',
  `sup_task_id` bigint(20) DEFAULT NULL COMMENT '督导任务id',
  `user_id` bigint(20) DEFAULT NULL COMMENT '用户id',
  `subj_id` bigint(20) DEFAULT NULL COMMENT '科目id',
  `teacher_user_id` bigint(20) DEFAULT NULL COMMENT '老师用户id',
  `org_id` bigint(20) DEFAULT NULL COMMENT '院系id',
  `course_id` bigint(20) DEFAULT NULL COMMENT '课程id',
  `create_user_id` bigint(20) DEFAULT NULL COMMENT '创建人id',
  `update_user_id` bigint(20) DEFAULT NULL COMMENT '更新人id',
  `version` int(11) NOT NULL DEFAULT '1' COMMENT '乐观锁版本号',
  `created_date_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `created_by` varchar(50) DEFAULT NULL COMMENT '创建人',
  `last_modified_date_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间',
  `last_modified_by` varchar(50) DEFAULT NULL COMMENT '最后修改人',
  `delete_flag` tinyint(4) NOT NULL DEFAULT '0' COMMENT '删除标志（0：正常，1：删除）',
  `tenant_id` varchar(50) NOT NULL COMMENT '租户编号',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_sup_task_id` (`sup_task_id`) USING BTREE,
  KEY `idx_user_id` (`user_id`) USING BTREE,
  KEY `idx_subj_id` (`subj_id`) USING BTREE,
  KEY `idx_teacher_user_id` (`teacher_user_id`) USING BTREE,
  KEY `idx_course_id` (`course_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='督导评价-任务-科目老师或节次-关注';

-- ----------------------------
-- Table structure for t_sup_task_user_org_range
-- ----------------------------
DROP TABLE IF EXISTS `t_sup_task_user_org_range`;
CREATE TABLE `t_sup_task_user_org_range` (
  `id` bigint(20) NOT NULL COMMENT '主键ID（雪花算法生成）',
  `sup_task_id` bigint(20) DEFAULT NULL COMMENT '督导任务id',
  `user_id` bigint(20) DEFAULT NULL COMMENT '用户id',
  `org_id` bigint(20) DEFAULT NULL COMMENT '院系id',
  `create_user_id` bigint(20) DEFAULT NULL COMMENT '创建人id',
  `update_user_id` bigint(20) DEFAULT NULL COMMENT '更新人id',
  `version` int(11) NOT NULL DEFAULT '1' COMMENT '乐观锁版本号',
  `created_date_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `created_by` varchar(50) DEFAULT NULL COMMENT '创建人',
  `last_modified_date_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间',
  `last_modified_by` varchar(50) DEFAULT NULL COMMENT '最后修改人',
  `delete_flag` tinyint(4) NOT NULL DEFAULT '0' COMMENT '删除标志（0：正常，1：删除）',
  `tenant_id` varchar(50) NOT NULL COMMENT '租户编号',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_sup_task_id` (`sup_task_id`) USING BTREE,
  KEY `idx_user_id` (`user_id`) USING BTREE,
  KEY `idx_org_id` (`org_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='督导评价-任务-听课范围-院系';

-- ----------------------------
-- Table structure for t_sup_task_user_recommend_subject
-- ----------------------------
DROP TABLE IF EXISTS `t_sup_task_user_recommend_subject`;
CREATE TABLE `t_sup_task_user_recommend_subject` (
  `id` bigint(20) NOT NULL COMMENT '主键ID（雪花算法生成）',
  `sup_task_id` bigint(20) DEFAULT NULL COMMENT '督导任务id',
  `subj_id` bigint(20) DEFAULT NULL COMMENT '科目id',
  `user_id` bigint(20) DEFAULT NULL COMMENT '用户id',
  `recommend_reason_id` bigint(20) DEFAULT NULL COMMENT '推荐理由id',
  `create_user_id` bigint(20) DEFAULT NULL COMMENT '创建人id',
  `update_user_id` bigint(20) DEFAULT NULL COMMENT '更新人id',
  `version` int(11) NOT NULL DEFAULT '1' COMMENT '乐观锁版本号',
  `created_date_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `created_by` varchar(50) DEFAULT NULL COMMENT '创建人',
  `last_modified_date_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间',
  `last_modified_by` varchar(50) DEFAULT NULL COMMENT '最后修改人',
  `delete_flag` tinyint(4) NOT NULL DEFAULT '0' COMMENT '删除标志（0：正常，1：删除）',
  `tenant_id` varchar(50) NOT NULL COMMENT '租户编号',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_sup_task_id` (`sup_task_id`) USING BTREE,
  KEY `idx_user_id` (`user_id`) USING BTREE,
  KEY `idx_subj_id` (`subj_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='督导评价-任务-督导员-听课策略-推荐课程表';

-- ----------------------------
-- Table structure for t_sup_task_user_select_subject
-- ----------------------------
DROP TABLE IF EXISTS `t_sup_task_user_select_subject`;
CREATE TABLE `t_sup_task_user_select_subject` (
  `id` bigint(20) NOT NULL COMMENT '主键ID（雪花算法生成）',
  `sup_task_id` bigint(20) DEFAULT NULL COMMENT '督导任务id',
  `subj_id` bigint(20) DEFAULT NULL COMMENT '科目id',
  `user_id` bigint(20) DEFAULT NULL COMMENT '用户id',
  `recommend_reason_id` bigint(20) DEFAULT NULL COMMENT '推荐理由id',
  `create_user_id` bigint(20) DEFAULT NULL COMMENT '创建人id',
  `update_user_id` bigint(20) DEFAULT NULL COMMENT '更新人id',
  `version` int(11) NOT NULL DEFAULT '1' COMMENT '乐观锁版本号',
  `created_date_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `created_by` varchar(50) DEFAULT NULL COMMENT '创建人',
  `last_modified_date_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间',
  `last_modified_by` varchar(50) DEFAULT NULL COMMENT '最后修改人',
  `delete_flag` tinyint(4) NOT NULL DEFAULT '0' COMMENT '删除标志（0：正常，1：删除）',
  `tenant_id` varchar(50) NOT NULL COMMENT '租户编号',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_sup_task_id` (`sup_task_id`) USING BTREE,
  KEY `idx_user_id` (`user_id`) USING BTREE,
  KEY `idx_subj_id` (`subj_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='督导评价-任务-督导员-听课策略-选评课程表';

-- ----------------------------
-- Table structure for t_sup_task_user_strategy
-- ----------------------------
DROP TABLE IF EXISTS `t_sup_task_user_strategy`;
CREATE TABLE `t_sup_task_user_strategy` (
  `id` bigint(20) NOT NULL COMMENT '主键ID（雪花算法生成）',
  `sup_task_id` bigint(20) DEFAULT NULL COMMENT '督导任务id',
  `user_id` bigint(20) DEFAULT NULL COMMENT '用户id',
  `sup_times` int(11) DEFAULT NULL COMMENT '次数设置-要求评价次数',
  `sup_times_limit_enable` tinyint(4) DEFAULT NULL COMMENT '次数设置-到达评价次数是否可以继续评价',
  `pending_sup_max_num` int(11) DEFAULT NULL COMMENT '次数设置-待评上限数量',
  `sup_select_course_times` int(11) DEFAULT NULL COMMENT '选评课程-要求从选评课程中评价次数',
  `front_back_acte_id` bigint(20) DEFAULT NULL COMMENT '推荐老师-前后列-学期id',
  `front_rate` decimal(5,2) DEFAULT NULL COMMENT '推荐老师-期末学生评价：前N%老师',
  `back_rate` decimal(5,2) DEFAULT NULL COMMENT '推荐老师-期末学生评价：后N%老师',
  `sideline_enable` tinyint(4) DEFAULT '0' COMMENT '推荐老师-是否推荐兼职教师 默认 false',
  `new_min_year` int(11) DEFAULT NULL COMMENT '推荐老师-推荐入职时间小于N年的教师',
  `low_frequency_acte_id` bigint(20) DEFAULT NULL COMMENT '推荐老师-老师听评低频-学期id',
  `sup_low_frequency_min_num` int(11) DEFAULT NULL COMMENT '推荐老师-教师被听次数少于N次',
  `create_user_id` bigint(20) DEFAULT NULL COMMENT '创建人id',
  `update_user_id` bigint(20) DEFAULT NULL COMMENT '更新人id',
  `version` int(11) NOT NULL DEFAULT '1' COMMENT '乐观锁版本号',
  `created_date_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `created_by` varchar(50) DEFAULT NULL COMMENT '创建人',
  `last_modified_date_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间',
  `last_modified_by` varchar(50) DEFAULT NULL COMMENT '最后修改人',
  `delete_flag` tinyint(4) NOT NULL DEFAULT '0' COMMENT '删除标志（0：正常，1：删除）',
  `tenant_id` varchar(50) NOT NULL COMMENT '租户编号',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_sup_task_id` (`sup_task_id`) USING BTREE,
  KEY `idx_user_id` (`user_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='督导评价-任务-督导员-听课策略表';

-- ----------------------------
-- Table structure for t_sup_task_user_subject_range
-- ----------------------------
DROP TABLE IF EXISTS `t_sup_task_user_subject_range`;
CREATE TABLE `t_sup_task_user_subject_range` (
  `id` bigint(20) NOT NULL COMMENT '主键ID（雪花算法生成）',
  `sup_task_id` bigint(20) DEFAULT NULL COMMENT '督导任务id',
  `user_id` bigint(20) DEFAULT NULL COMMENT '用户id',
  `subj_id` bigint(20) DEFAULT NULL COMMENT '科目id',
  `create_user_id` bigint(20) DEFAULT NULL COMMENT '创建人id',
  `update_user_id` bigint(20) DEFAULT NULL COMMENT '更新人id',
  `version` int(11) NOT NULL DEFAULT '1' COMMENT '乐观锁版本号',
  `created_date_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `created_by` varchar(50) DEFAULT NULL COMMENT '创建人',
  `last_modified_date_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间',
  `last_modified_by` varchar(50) DEFAULT NULL COMMENT '最后修改人',
  `delete_flag` tinyint(4) NOT NULL DEFAULT '0' COMMENT '删除标志（0：正常，1：删除）',
  `tenant_id` varchar(50) NOT NULL COMMENT '租户编号',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_sup_task_id` (`sup_task_id`) USING BTREE,
  KEY `idx_user_id` (`user_id`) USING BTREE,
  KEY `idx_subj_id` (`subj_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='督导评价-任务-听课范围-科目';

-- ----------------------------
-- Table structure for t_sup_task_user_tecl_range
-- ----------------------------
DROP TABLE IF EXISTS `t_sup_task_user_tecl_range`;
CREATE TABLE `t_sup_task_user_tecl_range` (
  `id` bigint(20) NOT NULL COMMENT '主键ID（雪花算法生成）',
  `sup_task_id` bigint(20) DEFAULT NULL COMMENT '督导任务id',
  `user_id` bigint(20) DEFAULT NULL COMMENT '用户id',
  `tecl_id` bigint(20) DEFAULT NULL COMMENT '教学班id',
  `create_user_id` bigint(20) DEFAULT NULL COMMENT '创建人id',
  `update_user_id` bigint(20) DEFAULT NULL COMMENT '更新人id',
  `version` int(11) NOT NULL DEFAULT '1' COMMENT '乐观锁版本号',
  `created_date_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `created_by` varchar(50) DEFAULT NULL COMMENT '创建人',
  `last_modified_date_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间',
  `last_modified_by` varchar(50) DEFAULT NULL COMMENT '最后修改人',
  `delete_flag` tinyint(4) NOT NULL DEFAULT '0' COMMENT '删除标志（0：正常，1：删除）',
  `tenant_id` varchar(50) NOT NULL COMMENT '租户编号',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_sup_task_id` (`sup_task_id`) USING BTREE,
  KEY `idx_user_id` (`user_id`) USING BTREE,
  KEY `idx_tecl_id` (`tecl_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='督导评价-任务-听课范围-教学班';

-- ----------------------------
-- Table structure for t_survey_quota
-- ----------------------------
DROP TABLE IF EXISTS `t_survey_quota`;
CREATE TABLE `t_survey_quota` (
  `id` bigint(20) NOT NULL COMMENT '主键ID（雪花算法生成）',
  `evaluate_type_code` tinyint(4) DEFAULT NULL COMMENT '评价类型编码',
  `question_bank_item_id` bigint(20) NOT NULL COMMENT '题目id',
  `question_name` varchar(1000) DEFAULT NULL COMMENT '题目名称',
  `subj_type_id` bigint(20) DEFAULT NULL COMMENT '适用课程类型id',
  `subj_type_name` varchar(255) DEFAULT NULL COMMENT '适用课程类型名称',
  `all_subj_type_flag` tinyint(4) DEFAULT '0' COMMENT '是否适用全部课程类型  0-否 1-是 ',
  `quota_dim_id` bigint(20) DEFAULT NULL COMMENT '指标维度id',
  `quota_dim_name` varchar(255) DEFAULT NULL COMMENT '指标维度名称',
  `quota_point_id` bigint(20) DEFAULT NULL COMMENT '指标点id',
  `quota_point_name` varchar(255) DEFAULT NULL COMMENT '指标点名称',
  `system_flag` tinyint(4) DEFAULT '0' COMMENT '是否是系统自建 0-否 1-是',
  `share_flag` tinyint(4) DEFAULT '0' COMMENT '是否共享 0-否 1-是',
  `create_user_id` bigint(20) DEFAULT NULL COMMENT '创建人id',
  `update_user_id` bigint(20) DEFAULT NULL COMMENT '更新人id',
  `version` int(11) NOT NULL DEFAULT '1' COMMENT '乐观锁版本号',
  `created_date_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `created_by` varchar(50) DEFAULT NULL COMMENT '创建人',
  `last_modified_date_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间',
  `last_modified_by` varchar(50) DEFAULT NULL COMMENT '最后修改人',
  `delete_flag` tinyint(4) NOT NULL DEFAULT '0' COMMENT '删除标志（0：正常，1：删除）',
  `tenant_id` varchar(50) NOT NULL COMMENT '租户编号',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_question_bank_item_id` (`question_bank_item_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='指标题目表';

-- ----------------------------
-- Table structure for t_survey_template
-- ----------------------------
DROP TABLE IF EXISTS `t_survey_template`;
CREATE TABLE `t_survey_template` (
  `id` bigint(20) NOT NULL COMMENT '主键ID（雪花算法生成）',
  `evaluate_type_code` tinyint(4) DEFAULT NULL COMMENT '评价类型编码',
  `template_key` varchar(255) DEFAULT NULL COMMENT '模板唯一标识',
  `template_name` varchar(255) DEFAULT NULL COMMENT '模板名称',
  `subj_type_id` bigint(20) DEFAULT NULL COMMENT '适用课程类型id',
  `subj_type_name` varchar(255) DEFAULT NULL COMMENT '适用课程类型名称',
  `all_subj_type_flag` tinyint(4) DEFAULT '0' COMMENT '是否适用全部课程类型  0-否 1-是 ',
  `score_flag` tinyint(4) DEFAULT '1' COMMENT '是否计分 0-否 1-是',
  `system_flag` tinyint(4) DEFAULT '0' COMMENT '是否是系统自建 0-否 1-是',
  `share_flag` tinyint(4) DEFAULT '0' COMMENT '是否共享 0-否 1-是',
  `question_num` int(11) DEFAULT '0' COMMENT '题目数量',
  `use_count` int(11) DEFAULT '0' COMMENT '引用次数',
  `create_user_id` bigint(20) DEFAULT NULL COMMENT '创建人id',
  `update_user_id` bigint(20) DEFAULT NULL COMMENT '更新人id',
  `version` int(11) NOT NULL DEFAULT '1' COMMENT '乐观锁版本号',
  `created_date_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `created_by` varchar(50) DEFAULT NULL COMMENT '创建人',
  `last_modified_date_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间',
  `last_modified_by` varchar(50) DEFAULT NULL COMMENT '最后修改人',
  `delete_flag` tinyint(4) NOT NULL DEFAULT '0' COMMENT '删除标志（0：正常，1：删除）',
  `tenant_id` varchar(50) NOT NULL COMMENT '租户编号',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_template_key` (`template_key`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='问卷模板表';

-- ----------------------------
-- Table structure for t_syllabus_material
-- ----------------------------
DROP TABLE IF EXISTS `t_syllabus_material`;
CREATE TABLE `t_syllabus_material` (
  `id` bigint(20) NOT NULL COMMENT '主键ID（雪花算法生成）',
  `flow_instance_id` bigint(20) DEFAULT NULL COMMENT '流程实例ID',
  `task_id` bigint(20) DEFAULT NULL COMMENT '任务id，关联任务大纲管理表',
  `upload_way` tinyint(1) DEFAULT NULL COMMENT '上传方式（1：通过任务上传，2：直接上传（绕过任务））',
  `upload_user_id` bigint(20) DEFAULT NULL COMMENT '上传人id，关联用户表',
  `upload_user_name` varchar(255) DEFAULT NULL COMMENT '上传人名称',
  `upload_user_code` varchar(255) DEFAULT NULL COMMENT '上传人编码',
  `approver_user_id` bigint(20) DEFAULT NULL COMMENT '审批人id，关联用户表',
  `approver_user_name` varchar(255) DEFAULT NULL COMMENT '审批人名称',
  `approver_user_code` varchar(255) DEFAULT NULL COMMENT '审批人编码',
  `subj_id` bigint(20) DEFAULT NULL COMMENT '科目ID',
  `subj_code` varchar(100) DEFAULT NULL COMMENT '科目编码',
  `subj_name` varchar(100) DEFAULT NULL COMMENT '科目名称',
  `org_id` bigint(20) DEFAULT NULL COMMENT '科目所属院系ID',
  `org_code` varchar(255) DEFAULT NULL COMMENT '科目所属院系编码',
  `org_name` varchar(255) DEFAULT NULL COMMENT '科目所属院系名称',
  `file_id` varchar(64) NOT NULL COMMENT '文件唯一标识',
  `file_name` varchar(255) DEFAULT NULL COMMENT '文件显示名称（用户上传时的文件名）',
  `file_name_stored` varchar(255) DEFAULT NULL COMMENT '存储文件名称（系统生成的文件名）',
  `file_size` bigint(20) DEFAULT NULL COMMENT '文件大小',
  `file_enable` tinyint(1) DEFAULT '0' COMMENT '是否启用 0-不启用 1-启用',
  `approval_status` tinyint(4) NOT NULL DEFAULT '0' COMMENT '0-待审批、1-通过、2-驳回',
  `upload_date_time` datetime DEFAULT NULL COMMENT '上传时间',
  `approve_date_time` datetime DEFAULT NULL COMMENT '审批时间',
  `reject_reason` varchar(255) DEFAULT NULL COMMENT '拒绝理由',
  `create_user_id` bigint(20) DEFAULT NULL COMMENT '创建人id',
  `update_user_id` bigint(20) DEFAULT NULL COMMENT '更新人id',
  `version` int(11) NOT NULL DEFAULT '1' COMMENT '乐观锁版本号',
  `created_date_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `created_by` varchar(50) DEFAULT NULL COMMENT '创建人',
  `last_modified_date_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间',
  `last_modified_by` varchar(50) DEFAULT NULL COMMENT '最后修改人',
  `delete_flag` tinyint(4) NOT NULL DEFAULT '0' COMMENT '删除标志（0：正常，1：删除）',
  `tenant_id` varchar(50) NOT NULL COMMENT '租户编号',
  PRIMARY KEY (`id`),
  KEY `idx_task_id` (`task_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='教学大纲文件表';

-- ----------------------------
-- Table structure for t_syllabus_task
-- ----------------------------
DROP TABLE IF EXISTS `t_syllabus_task`;
CREATE TABLE `t_syllabus_task` (
  `id` bigint(20) NOT NULL COMMENT '主键ID（雪花算法生成）',
  `task_name` varchar(255) NOT NULL COMMENT '任务名称',
  `task_level` tinyint(1) DEFAULT NULL COMMENT '任务级别 1-校级 2-院级',
  `org_id` bigint(20) NOT NULL COMMENT '创建人所属院系ID',
  `org_code` varchar(255) DEFAULT NULL COMMENT '创建人所属院系编码',
  `org_name` varchar(255) DEFAULT NULL COMMENT '创建人所属院系名称',
  `task_start_time` datetime NOT NULL COMMENT '开始时间',
  `task_end_time` datetime DEFAULT NULL COMMENT '结束时间',
  `task_auto_close` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否自动关闭标志（0：否，1：是）',
  `create_user_name` varchar(255) DEFAULT NULL COMMENT '创建人名称',
  `create_user_code` varchar(255) DEFAULT NULL COMMENT '创建人编号',
  `create_user_id` bigint(20) DEFAULT NULL COMMENT '创建人id',
  `update_user_id` bigint(20) DEFAULT NULL COMMENT '更新人id',
  `version` int(11) NOT NULL DEFAULT '1' COMMENT '乐观锁版本号',
  `created_date_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `created_by` varchar(50) DEFAULT NULL COMMENT '创建人',
  `last_modified_date_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间',
  `last_modified_by` varchar(50) DEFAULT NULL COMMENT '最后修改人',
  `delete_flag` tinyint(4) NOT NULL DEFAULT '0' COMMENT '删除标志（0：正常，1：删除）',
  `tenant_id` varchar(50) NOT NULL COMMENT '租户编号',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='教学大纲任务表';

-- ----------------------------
-- Table structure for t_sync_tecl_subj_org
-- ----------------------------
DROP TABLE IF EXISTS `t_sync_tecl_subj_org`;
CREATE TABLE `t_sync_tecl_subj_org` (
  `id` bigint(20) NOT NULL COMMENT '主键ID（雪花算法生成）',
  `acte_id` bigint(20) DEFAULT NULL COMMENT '学期id',
  `acye_code` varchar(50) DEFAULT NULL COMMENT '学年code 示例 2025-2026',
  `acte_term` int(11) DEFAULT NULL COMMENT '第几学期',
  `tecl_id` bigint(20) DEFAULT NULL COMMENT '教学班id',
  `tecl_code` varchar(100) DEFAULT NULL COMMENT '教学班编码',
  `tecl_name` varchar(255) DEFAULT NULL COMMENT '教学班名称',
  `subj_id` bigint(20) DEFAULT NULL COMMENT '科目id',
  `subj_code` varchar(100) DEFAULT NULL COMMENT '科目编码',
  `subj_name` varchar(255) DEFAULT NULL COMMENT '科目名称',
  `subj_type_id` bigint(20) DEFAULT NULL COMMENT '科目类型id',
  `subj_type_name` varchar(255) DEFAULT NULL COMMENT '科目类型名称',
  `subj_nature_id` bigint(20) DEFAULT NULL COMMENT '科目性质id',
  `subj_nature_name` varchar(255) DEFAULT NULL COMMENT '科目性质名称',
  `subj_category_id` bigint(20) DEFAULT NULL COMMENT '科目类别id',
  `subj_category_name` varchar(255) DEFAULT NULL COMMENT '科目类别名称',
  `educational_level` tinyint(4) DEFAULT NULL COMMENT '学历层次 1-本科 2-研究生',
  `org_id` bigint(20) DEFAULT NULL COMMENT '院系id',
  `org_code` varchar(100) DEFAULT NULL COMMENT '院系编码',
  `org_name` varchar(255) DEFAULT NULL COMMENT '院系名称',
  `create_user_id` bigint(20) DEFAULT NULL COMMENT '创建人id',
  `update_user_id` bigint(20) DEFAULT NULL COMMENT '更新人id',
  `version` int(11) NOT NULL DEFAULT '1' COMMENT '乐观锁版本号',
  `created_date_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `created_by` varchar(50) DEFAULT NULL COMMENT '创建人',
  `last_modified_date_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间',
  `last_modified_by` varchar(50) DEFAULT NULL COMMENT '最后修改人',
  `delete_flag` tinyint(4) NOT NULL DEFAULT '0' COMMENT '删除标志（0：正常，1：删除）',
  `tenant_id` varchar(50) NOT NULL COMMENT '租户编号',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_acte_id` (`acte_id`) USING BTREE,
  KEY `idx_tecl_id` (`tecl_id`) USING BTREE,
  KEY `idx_subj_id` (`subj_id`) USING BTREE,
  KEY `idx_subj_code` (`subj_code`) USING BTREE,
  KEY `idx_org_id` (`org_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='教学班科目院系关系同步表';

-- ----------------------------
-- Table structure for t_sync_tecl_teacher
-- ----------------------------
DROP TABLE IF EXISTS `t_sync_tecl_teacher`;
CREATE TABLE `t_sync_tecl_teacher` (
  `id` bigint(20) NOT NULL COMMENT '主键ID（雪花算法生成）',
  `tecl_id` bigint(20) DEFAULT NULL COMMENT '教学班id',
  `teacher_user_id` bigint(20) DEFAULT NULL COMMENT '老师用户id',
  `teacher_user_code` varchar(100) DEFAULT NULL COMMENT '老师用户编码',
  `teacher_user_name` varchar(255) DEFAULT NULL COMMENT '老师用户名称',
  `teac_in_service_status` tinyint(4) DEFAULT NULL COMMENT '老师状态',
  `teacher_title` int(11) DEFAULT NULL COMMENT '老师职称编码',
  `employment_start_date` datetime DEFAULT NULL COMMENT '入职时间',
  `create_user_id` bigint(20) DEFAULT NULL COMMENT '创建人id',
  `update_user_id` bigint(20) DEFAULT NULL COMMENT '更新人id',
  `version` int(11) NOT NULL DEFAULT '1' COMMENT '乐观锁版本号',
  `created_date_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `created_by` varchar(50) DEFAULT NULL COMMENT '创建人',
  `last_modified_date_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间',
  `last_modified_by` varchar(50) DEFAULT NULL COMMENT '最后修改人',
  `delete_flag` tinyint(4) NOT NULL DEFAULT '0' COMMENT '删除标志（0：正常，1：删除）',
  `tenant_id` varchar(50) NOT NULL COMMENT '租户编号',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_tecl_id` (`tecl_id`) USING BTREE,
  KEY `idx_teacher_user_id` (`teacher_user_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='教学班-老师关系-同步表';

-- ----------------------------
-- Table structure for t_sync_tecl_teacher_org
-- ----------------------------
DROP TABLE IF EXISTS `t_sync_tecl_teacher_org`;
CREATE TABLE `t_sync_tecl_teacher_org` (
  `id` bigint(20) NOT NULL COMMENT '主键ID（雪花算法生成）',
  `teacher_user_id` bigint(20) DEFAULT NULL COMMENT '老师用户id',
  `org_id` bigint(20) DEFAULT NULL COMMENT '院系id',
  `org_code` varchar(100) DEFAULT NULL COMMENT '院系编码',
  `org_name` varchar(255) DEFAULT NULL COMMENT '院系名称',
  `create_user_id` bigint(20) DEFAULT NULL COMMENT '创建人id',
  `update_user_id` bigint(20) DEFAULT NULL COMMENT '更新人id',
  `version` int(11) NOT NULL DEFAULT '1' COMMENT '乐观锁版本号',
  `created_date_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `created_by` varchar(50) DEFAULT NULL COMMENT '创建人',
  `last_modified_date_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间',
  `last_modified_by` varchar(50) DEFAULT NULL COMMENT '最后修改人',
  `delete_flag` tinyint(4) NOT NULL DEFAULT '0' COMMENT '删除标志（0：正常，1：删除）',
  `tenant_id` varchar(50) NOT NULL COMMENT '租户编号',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_teacher_user_id` (`teacher_user_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='教学班-老师-院系关系-同步表';

-- ----------------------------
-- Table structure for t_tea_comp_eval_dimension
-- ----------------------------
DROP TABLE IF EXISTS `t_tea_comp_eval_dimension`;
CREATE TABLE `t_tea_comp_eval_dimension` (
  `id` bigint(20) NOT NULL COMMENT '主键ID（雪花算法生成）',
  `scheme_id` bigint(20) NOT NULL COMMENT '方案ID',
  `evaluate_type_code` int(11) NOT NULL COMMENT '评价类型编码',
  `dimension_name` varchar(50) NOT NULL COMMENT '维度名称',
  `dimension_enable` tinyint(4) NOT NULL DEFAULT '1' COMMENT '是否开启：0-否，1-是',
  `dimension_weight` decimal(5,2) NOT NULL COMMENT '维度权重（百分比）',
  `min_submit_rate` int(11) NOT NULL DEFAULT '0' COMMENT '最低提交率（百分比）',
  `trim_enable` tinyint(4) NOT NULL DEFAULT '0' COMMENT '是否开启去极值：0-否，1-是',
  `trim_low_percent` decimal(5,2) DEFAULT NULL COMMENT '剔除最低百分比',
  `trim_high_percent` decimal(5,2) DEFAULT NULL COMMENT '剔除最高百分比',
  `missing_algorithm` varchar(10) DEFAULT NULL COMMENT '缺省算法：A-全校均分，B-院系均分，C-不计入',
  `create_user_id` bigint(20) DEFAULT NULL COMMENT '创建人id',
  `update_user_id` bigint(20) DEFAULT NULL COMMENT '更新人id',
  `version` int(11) NOT NULL DEFAULT '1' COMMENT '乐观锁版本号',
  `created_date_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `created_by` varchar(50) DEFAULT NULL COMMENT '创建人',
  `last_modified_date_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间',
  `last_modified_by` varchar(50) DEFAULT NULL COMMENT '最后修改人',
  `delete_flag` tinyint(4) NOT NULL DEFAULT '0' COMMENT '删除标志（0：正常，1：删除）',
  `tenant_id` varchar(50) NOT NULL COMMENT '租户编号',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_scheme_id` (`scheme_id`) USING BTREE,
  KEY `idx_evaluate_type_code` (`evaluate_type_code`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='教师综合评价维度配置表';

-- ----------------------------
-- Table structure for t_tea_comp_eval_dimension_score
-- ----------------------------
DROP TABLE IF EXISTS `t_tea_comp_eval_dimension_score`;
CREATE TABLE `t_tea_comp_eval_dimension_score` (
  `id` bigint(20) NOT NULL COMMENT '主键ID（雪花算法生成）',
  `result_id` bigint(20) NOT NULL COMMENT '结果ID',
  `scheme_id` bigint(20) NOT NULL COMMENT '方案ID',
  `teacher_id` bigint(20) NOT NULL COMMENT '教师ID',
  `evaluate_type_code` int(11) NOT NULL COMMENT '评价类型编码',
  `dimension_name` varchar(50) NOT NULL COMMENT '维度名称',
  `dimension_score` decimal(5,2) DEFAULT NULL COMMENT '维度得分',
  `dimension_weight` decimal(5,2) NOT NULL COMMENT '维度权重（百分比）',
  `effective_weight` decimal(5,2) DEFAULT NULL COMMENT '综合分最终参与权重（百分比）',
  `sample_count` int(11) DEFAULT NULL COMMENT '有效样本数',
  `distributed_count` int(11) DEFAULT NULL COMMENT '分发总数',
  `submit_rate` decimal(5,2) DEFAULT NULL COMMENT '提交率（百分比）',
  `missing_flag` tinyint(4) NOT NULL DEFAULT '0' COMMENT '是否缺省：0-否，1-是',
  `missing_algorithm` varchar(10) DEFAULT NULL COMMENT '缺省算法',
  `missing_algorithm_desc` varchar(100) DEFAULT NULL COMMENT '缺省算法描述',
  `create_user_id` bigint(20) DEFAULT NULL COMMENT '创建人id',
  `update_user_id` bigint(20) DEFAULT NULL COMMENT '更新人id',
  `version` int(11) NOT NULL DEFAULT '1' COMMENT '乐观锁版本号',
  `created_date_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `created_by` varchar(50) DEFAULT NULL COMMENT '创建人',
  `last_modified_date_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间',
  `last_modified_by` varchar(50) DEFAULT NULL COMMENT '最后修改人',
  `delete_flag` tinyint(4) NOT NULL DEFAULT '0' COMMENT '删除标志（0：正常，1：删除）',
  `tenant_id` varchar(50) NOT NULL COMMENT '租户编号',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_result_id` (`result_id`) USING BTREE,
  KEY `idx_scheme_id_teacher_id` (`scheme_id`,`teacher_id`) USING BTREE,
  KEY `idx_scheme_id_teacher_id_type` (`scheme_id`,`teacher_id`,`evaluate_type_code`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='教师综合评价维度得分明细表';

-- ----------------------------
-- Table structure for t_tea_comp_eval_dimension_task
-- ----------------------------
DROP TABLE IF EXISTS `t_tea_comp_eval_dimension_task`;
CREATE TABLE `t_tea_comp_eval_dimension_task` (
  `id` bigint(20) NOT NULL COMMENT '主键ID（雪花算法生成）',
  `scheme_id` bigint(20) NOT NULL COMMENT '方案ID',
  `dimension_id` bigint(20) NOT NULL COMMENT '维度配置ID',
  `evaluate_type_code` int(11) NOT NULL COMMENT '评价类型编码',
  `task_id` bigint(20) DEFAULT NULL COMMENT '任务ID',
  `task_name` varchar(255) DEFAULT NULL COMMENT '任务名称',
  `task_level` int(11) DEFAULT NULL COMMENT '任务级别',
  `task_org_id` bigint(20) DEFAULT NULL COMMENT '管理组织ID',
  `task_org_name` varchar(255) DEFAULT NULL COMMENT '管理组织名称',
  `educational_level` int(11) DEFAULT NULL COMMENT '学历层次',
  `survey_id` varchar(255) DEFAULT NULL COMMENT '问卷ID',
  `survey_name` varchar(255) DEFAULT NULL COMMENT '问卷名称',
  `survey_scored` tinyint(4) DEFAULT NULL COMMENT '是否计分问卷：0-否，1-是',
  `create_user_id` bigint(20) DEFAULT NULL COMMENT '创建人id',
  `update_user_id` bigint(20) DEFAULT NULL COMMENT '更新人id',
  `version` int(11) NOT NULL DEFAULT '1' COMMENT '乐观锁版本号',
  `created_date_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `created_by` varchar(50) DEFAULT NULL COMMENT '创建人',
  `last_modified_date_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间',
  `last_modified_by` varchar(50) DEFAULT NULL COMMENT '最后修改人',
  `delete_flag` tinyint(4) NOT NULL DEFAULT '0' COMMENT '删除标志（0：正常，1：删除）',
  `tenant_id` varchar(50) NOT NULL COMMENT '租户编号',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_scheme_id` (`scheme_id`) USING BTREE,
  KEY `idx_dimension_id` (`dimension_id`) USING BTREE,
  KEY `idx_task_id` (`task_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='教师综合评价维度任务问卷关联表';

-- ----------------------------
-- Table structure for t_tea_comp_eval_grade_rule
-- ----------------------------
DROP TABLE IF EXISTS `t_tea_comp_eval_grade_rule`;
CREATE TABLE `t_tea_comp_eval_grade_rule` (
  `id` bigint(20) NOT NULL COMMENT '主键ID（雪花算法生成）',
  `scheme_id` bigint(20) NOT NULL COMMENT '方案ID',
  `grade_name` varchar(20) NOT NULL COMMENT '档位名称',
  `grade_mode` tinyint(4) NOT NULL COMMENT '分档模式：1-按分值，2-按比例',
  `score_low` decimal(5,2) DEFAULT NULL COMMENT '分值下限（含）',
  `score_high` decimal(5,2) DEFAULT NULL COMMENT '分值上限（含）',
  `percent_ratio` decimal(5,2) DEFAULT NULL COMMENT '比例（百分比）',
  `grade_desc` varchar(200) DEFAULT NULL COMMENT '档位说明',
  `create_user_id` bigint(20) DEFAULT NULL COMMENT '创建人id',
  `update_user_id` bigint(20) DEFAULT NULL COMMENT '更新人id',
  `version` int(11) NOT NULL DEFAULT '1' COMMENT '乐观锁版本号',
  `created_date_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `created_by` varchar(50) DEFAULT NULL COMMENT '创建人',
  `last_modified_date_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间',
  `last_modified_by` varchar(50) DEFAULT NULL COMMENT '最后修改人',
  `delete_flag` tinyint(4) NOT NULL DEFAULT '0' COMMENT '删除标志（0：正常，1：删除）',
  `tenant_id` varchar(50) NOT NULL COMMENT '租户编号',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_scheme_id` (`scheme_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='教师综合评价分档规则表';

-- ----------------------------
-- Table structure for t_tea_comp_eval_result
-- ----------------------------
DROP TABLE IF EXISTS `t_tea_comp_eval_result`;
CREATE TABLE `t_tea_comp_eval_result` (
  `id` bigint(20) NOT NULL COMMENT '主键ID（雪花算法生成）',
  `scheme_id` bigint(20) NOT NULL COMMENT '方案ID',
  `acte_id` bigint(20) NOT NULL COMMENT '学期ID',
  `teacher_id` bigint(20) NOT NULL COMMENT '教师ID',
  `teacher_name` varchar(255) NOT NULL COMMENT '教师姓名',
  `teacher_code` varchar(100) DEFAULT NULL COMMENT '教师工号',
  `org_id` bigint(20) DEFAULT NULL COMMENT '院系ID',
  `org_name` varchar(255) DEFAULT NULL COMMENT '院系名称',
  `title` varchar(255) DEFAULT NULL COMMENT '职称',
  `comprehensive_score` decimal(5,2) DEFAULT NULL COMMENT '综合得分',
  `grade_name` varchar(20) DEFAULT NULL COMMENT '等级名称',
  `rank_total` int(11) DEFAULT NULL COMMENT '全校排名',
  `rank_total_total` int(11) DEFAULT NULL COMMENT '全校参与人数',
  `rank_college` int(11) DEFAULT NULL COMMENT '院系排名',
  `rank_college_total` int(11) DEFAULT NULL COMMENT '院系参与人数',
  `missing_dimensions` varchar(500) DEFAULT NULL COMMENT '缺省维度列表（JSON数组）',
  `has_missing` tinyint(4) NOT NULL DEFAULT '0' COMMENT '是否含缺省维度：0-否，1-是',
  `create_user_id` bigint(20) DEFAULT NULL COMMENT '创建人id',
  `update_user_id` bigint(20) DEFAULT NULL COMMENT '更新人id',
  `version` int(11) NOT NULL DEFAULT '1' COMMENT '乐观锁版本号',
  `created_date_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `created_by` varchar(50) DEFAULT NULL COMMENT '创建人',
  `last_modified_date_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间',
  `last_modified_by` varchar(50) DEFAULT NULL COMMENT '最后修改人',
  `delete_flag` tinyint(4) NOT NULL DEFAULT '0' COMMENT '删除标志（0：正常，1：删除）',
  `tenant_id` varchar(50) NOT NULL COMMENT '租户编号',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_scheme_id_teacher_id` (`scheme_id`,`teacher_id`) USING BTREE,
  KEY `idx_teacher_id` (`teacher_id`) USING BTREE,
  KEY `idx_acte_id` (`acte_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='教师综合评价结果主表';

-- ----------------------------
-- Table structure for t_tea_comp_eval_scheme
-- ----------------------------
DROP TABLE IF EXISTS `t_tea_comp_eval_scheme`;
CREATE TABLE `t_tea_comp_eval_scheme` (
  `id` bigint(20) NOT NULL COMMENT '主键ID（雪花算法生成）',
  `scheme_name` varchar(200) NOT NULL COMMENT '方案名称',
  `scheme_desc` varchar(500) DEFAULT NULL COMMENT '方案说明',
  `acte_id` bigint(20) NOT NULL COMMENT '学期ID',
  `scheme_status` tinyint(4) NOT NULL DEFAULT '0' COMMENT '方案状态：0-草稿，1-已发布，2-评价中，3-已结束',
  `teacher_scope_type` tinyint(4) NOT NULL COMMENT '教师范围：1-全体教师，2-指定院系',
  `teacher_scope_orgs` text COMMENT '指定院系列表（JSON数组，格式：[{"orgId":1,"orgName":"xxx"}]）',
  `grade_enable` tinyint(4) NOT NULL DEFAULT '0' COMMENT '是否分档：0-否，1-是',
  `grade_mode` tinyint(4) DEFAULT NULL COMMENT '分档模式：1-按分值，2-按比例',
  `grade_count` int(11) DEFAULT NULL COMMENT '档位数',
  `publish_time` datetime DEFAULT NULL COMMENT '发布时间',
  `recalc_status` tinyint(4) NOT NULL DEFAULT '0' COMMENT '重算状态：0-无需重算，1-重算中，2-重算完成，3-重算失败',
  `recalc_user_id` bigint(20) DEFAULT NULL COMMENT '最近重算人ID',
  `recalc_user_name` varchar(50) DEFAULT NULL COMMENT '最近重算人姓名',
  `recalc_time` datetime DEFAULT NULL COMMENT '最近重算时间',
  `recalc_error_msg` varchar(500) DEFAULT NULL COMMENT '重算失败原因',
  `create_user_name` varchar(50) DEFAULT NULL COMMENT '创建人姓名',
  `update_user_name` varchar(50) DEFAULT NULL COMMENT '更新人姓名',
  `create_user_id` bigint(20) DEFAULT NULL COMMENT '创建人id',
  `update_user_id` bigint(20) DEFAULT NULL COMMENT '更新人id',
  `version` int(11) NOT NULL DEFAULT '1' COMMENT '乐观锁版本号',
  `created_date_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `created_by` varchar(50) DEFAULT NULL COMMENT '创建人',
  `last_modified_date_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间',
  `last_modified_by` varchar(50) DEFAULT NULL COMMENT '最后修改人',
  `delete_flag` tinyint(4) NOT NULL DEFAULT '0' COMMENT '删除标志（0：正常，1：删除）',
  `tenant_id` varchar(50) NOT NULL COMMENT '租户编号',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_acte_id` (`acte_id`) USING BTREE,
  KEY `idx_scheme_status` (`scheme_status`) USING BTREE,
  KEY `idx_tenant_id` (`tenant_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='教师综合评价方案表';

-- ----------------------------
-- Table structure for t_tea_comp_eval_survey_record
-- ----------------------------
DROP TABLE IF EXISTS `t_tea_comp_eval_survey_record`;
CREATE TABLE `t_tea_comp_eval_survey_record` (
  `id` bigint(20) NOT NULL COMMENT '主键ID（雪花算法生成）',
  `scheme_id` bigint(20) NOT NULL COMMENT '方案ID',
  `task_detail_id` bigint(20) NOT NULL COMMENT '任务明细ID',
  `teacher_id` bigint(20) NOT NULL COMMENT '被评教师ID',
  `evaluate_type_code` int(11) NOT NULL COMMENT '评价类型编码',
  `dim_code` tinyint(4) DEFAULT NULL COMMENT '评价维度编码',
  `record_id` bigint(20) DEFAULT NULL COMMENT '评价来源记录主键ID',
  `survey_id` varchar(255) NOT NULL COMMENT '问卷ID',
  `survey_name` varchar(255) NOT NULL COMMENT '问卷名称',
  `survey_data_id` varchar(255) DEFAULT NULL COMMENT '问卷填写数据ID',
  `survey_score` decimal(5,2) DEFAULT NULL COMMENT '问卷得分',
  `submit_time` datetime DEFAULT NULL COMMENT '提交时间',
  `evaluator_id` bigint(20) DEFAULT NULL COMMENT '评价人ID',
  `evaluator_name` varchar(255) DEFAULT NULL COMMENT '评价人姓名',
  `evaluator_code` varchar(100) DEFAULT NULL COMMENT '评价人用户编号',
  `trimmed_flag` tinyint(4) NOT NULL DEFAULT '0' COMMENT '是否被去极值剔除：0-否，1-是',
  `create_user_id` bigint(20) DEFAULT NULL COMMENT '创建人id',
  `update_user_id` bigint(20) DEFAULT NULL COMMENT '更新人id',
  `version` int(11) NOT NULL DEFAULT '1' COMMENT '乐观锁版本号',
  `created_date_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `created_by` varchar(50) DEFAULT NULL COMMENT '创建人',
  `last_modified_date_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间',
  `last_modified_by` varchar(50) DEFAULT NULL COMMENT '最后修改人',
  `delete_flag` tinyint(4) NOT NULL DEFAULT '0' COMMENT '删除标志（0：正常，1：删除）',
  `tenant_id` varchar(50) NOT NULL COMMENT '租户编号',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_scheme_id` (`scheme_id`) USING BTREE,
  KEY `idx_scheme_id_teacher_id_task_detail_id` (`scheme_id`,`teacher_id`,`task_detail_id`) USING BTREE,
  KEY `idx_record_id` (`record_id`) USING BTREE,
  KEY `idx_task_detail_id` (`task_detail_id`) USING BTREE,
  KEY `idx_teacher_id` (`teacher_id`) USING BTREE,
  KEY `idx_submit_time` (`submit_time`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='教师综合评价问卷提交记录表';

-- ----------------------------
-- Table structure for t_tea_comp_eval_task_detail
-- ----------------------------
DROP TABLE IF EXISTS `t_tea_comp_eval_task_detail`;
CREATE TABLE `t_tea_comp_eval_task_detail` (
  `id` bigint(20) NOT NULL COMMENT '主键ID（雪花算法生成）',
  `scheme_id` bigint(20) NOT NULL COMMENT '方案ID',
  `result_id` bigint(20) NOT NULL COMMENT '结果ID',
  `teacher_id` bigint(20) NOT NULL COMMENT '教师ID',
  `evaluate_type_code` int(11) NOT NULL COMMENT '评价类型编码',
  `dimension_name` varchar(50) NOT NULL COMMENT '维度名称',
  `task_id` bigint(20) DEFAULT NULL COMMENT '任务ID',
  `task_name` varchar(255) DEFAULT NULL COMMENT '任务名称',
  `survey_id` varchar(255) DEFAULT NULL COMMENT '问卷ID',
  `survey_name` varchar(255) DEFAULT NULL COMMENT '问卷名称',
  `avg_score` decimal(5,2) DEFAULT NULL COMMENT '均分',
  `valid_sample_count` int(11) DEFAULT NULL COMMENT '去极后有效样本数',
  `total_sample_count` int(11) DEFAULT NULL COMMENT '去极前样本数',
  `distributed_count` int(11) DEFAULT NULL COMMENT '分发总数',
  `trimmed_count` int(11) DEFAULT NULL COMMENT '被剔除样本数',
  `trim_low_count` int(11) DEFAULT NULL COMMENT '剔除低分样本数',
  `trim_high_count` int(11) DEFAULT NULL COMMENT '剔除高分样本数',
  `trimmed_flag` tinyint(4) NOT NULL DEFAULT '0' COMMENT '是否应用去极值：0-否，1-是',
  `create_user_id` bigint(20) DEFAULT NULL COMMENT '创建人id',
  `update_user_id` bigint(20) DEFAULT NULL COMMENT '更新人id',
  `version` int(11) NOT NULL DEFAULT '1' COMMENT '乐观锁版本号',
  `created_date_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `created_by` varchar(50) DEFAULT NULL COMMENT '创建人',
  `last_modified_date_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间',
  `last_modified_by` varchar(50) DEFAULT NULL COMMENT '最后修改人',
  `delete_flag` tinyint(4) NOT NULL DEFAULT '0' COMMENT '删除标志（0：正常，1：删除）',
  `tenant_id` varchar(50) NOT NULL COMMENT '租户编号',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_result_id` (`result_id`) USING BTREE,
  KEY `idx_scheme_id_teacher_id` (`scheme_id`,`teacher_id`) USING BTREE,
  KEY `idx_scheme_id_teacher_id_result_id` (`scheme_id`,`teacher_id`,`result_id`) USING BTREE,
  KEY `idx_task_id` (`task_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='教师综合评价任务得分明细表';

-- ----------------------------
-- Table structure for t_tse_record
-- ----------------------------
DROP TABLE IF EXISTS `t_tse_record`;
CREATE TABLE `t_tse_record` (
  `id` bigint(20) NOT NULL COMMENT '主键ID（雪花算法生成）',
  `tse_task_id` bigint(20) NOT NULL COMMENT '教师自评任务ID',
  `tse_dim_code` tinyint(4) NOT NULL COMMENT '评价维度 1-评价到人 2-评价到课程',
  `evaluate_status` tinyint(4) DEFAULT NULL COMMENT '评价状态 0-未评 1-已评',
  `acte_id` bigint(20) NOT NULL COMMENT '学年学期ID',
  `org_id` bigint(20) DEFAULT NULL COMMENT '记录对应组织ID',
  `org_code` varchar(100) DEFAULT NULL COMMENT '记录对应组织编码',
  `org_name` varchar(255) DEFAULT NULL COMMENT '记录对应组织名称',
  `teacher_user_id` bigint(20) NOT NULL COMMENT '教师用户ID',
  `teacher_user_code` varchar(100) DEFAULT NULL COMMENT '教师编码',
  `teacher_user_name` varchar(255) DEFAULT NULL COMMENT '教师姓名',
  `teacher_org_id` bigint(20) DEFAULT NULL COMMENT '教师所属组织ID',
  `teacher_org_code` varchar(100) DEFAULT NULL COMMENT '教师所属组织编码',
  `teacher_org_name` varchar(255) DEFAULT NULL COMMENT '教师所属组织名称',
  `subj_id` bigint(20) DEFAULT NULL COMMENT '科目ID',
  `subj_code` varchar(100) DEFAULT NULL COMMENT '科目编码',
  `subj_name` varchar(255) DEFAULT NULL COMMENT '科目名称',
  `create_user_id` bigint(20) DEFAULT NULL COMMENT '创建人ID',
  `update_user_id` bigint(20) DEFAULT NULL COMMENT '更新人ID',
  `version` int(11) NOT NULL DEFAULT '1' COMMENT '乐观锁版本号',
  `created_date_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `created_by` varchar(50) DEFAULT NULL COMMENT '创建人',
  `last_modified_date_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间',
  `last_modified_by` varchar(50) DEFAULT NULL COMMENT '最后修改人',
  `delete_flag` tinyint(4) NOT NULL DEFAULT '0' COMMENT '逻辑删除标记 0-正常 1-删除',
  `tenant_id` varchar(50) NOT NULL COMMENT '租户编号',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_tse_task_id` (`tse_task_id`) USING BTREE,
  KEY `idx_teacher_user_id` (`teacher_user_id`) USING BTREE,
  KEY `idx_tse_dim_code` (`tse_dim_code`) USING BTREE,
  KEY `idx_subj_id` (`subj_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='教师自评-评价记录表';

-- ----------------------------
-- Table structure for t_tse_record_survey
-- ----------------------------
DROP TABLE IF EXISTS `t_tse_record_survey`;
CREATE TABLE `t_tse_record_survey` (
  `id` bigint(20) NOT NULL COMMENT '主键ID（雪花算法生成）',
  `tse_task_id` bigint(20) NOT NULL COMMENT '教师自评任务ID',
  `tse_record_id` bigint(20) NOT NULL COMMENT '记录ID',
  `tse_dim_code` tinyint(4) NOT NULL COMMENT '评价维度 1-评价到人 2-评价到课程',
  `survey_id` varchar(255) NOT NULL COMMENT '问卷ID',
  `survey_name` varchar(255) DEFAULT NULL COMMENT '问卷名称',
  `survey_data_id` varchar(255) DEFAULT NULL COMMENT '问卷填写数据id',
  `survey_submit_status` tinyint(4) DEFAULT '0' COMMENT '问卷提交状态 草稿：-1 ，已提交：1',
  `survey_submit_time` datetime DEFAULT NULL COMMENT '提交时间',
  `tse_result_score` decimal(5,2) DEFAULT NULL COMMENT '问卷得分',
  `create_user_id` bigint(20) DEFAULT NULL COMMENT '创建人ID',
  `update_user_id` bigint(20) DEFAULT NULL COMMENT '更新人ID',
  `version` int(11) NOT NULL DEFAULT '1' COMMENT '乐观锁版本号',
  `created_date_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `created_by` varchar(50) DEFAULT NULL COMMENT '创建人',
  `last_modified_date_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间',
  `last_modified_by` varchar(50) DEFAULT NULL COMMENT '最后修改人',
  `delete_flag` tinyint(4) NOT NULL DEFAULT '0' COMMENT '逻辑删除标记 0-正常 1-删除',
  `tenant_id` varchar(50) NOT NULL COMMENT '租户编号',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_tse_task_id` (`tse_task_id`) USING BTREE,
  KEY `idx_tse_record_id` (`tse_record_id`) USING BTREE,
  KEY `idx_survey_id` (`survey_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='教师自评-记录问卷明细表';

-- ----------------------------
-- Table structure for t_tse_task
-- ----------------------------
DROP TABLE IF EXISTS `t_tse_task`;
CREATE TABLE `t_tse_task` (
  `id` bigint(20) NOT NULL COMMENT '主键ID（雪花算法生成）',
  `task_name` varchar(200) DEFAULT NULL COMMENT '任务名称',
  `tse_dim_code` tinyint(4) DEFAULT NULL COMMENT '评价维度 1-评价到人 2-评价到课程',
  `educational_level` tinyint(4) DEFAULT NULL COMMENT '学历层次 1-本科生 2-研究生',
  `task_level` tinyint(4) DEFAULT NULL COMMENT '任务级别 1-校级 2-院级',
  `task_org_id` bigint(20) DEFAULT NULL COMMENT '任务所属组织ID',
  `acte_id` bigint(20) DEFAULT NULL COMMENT '学年学期ID',
  `task_status` tinyint(4) NOT NULL DEFAULT '0' COMMENT '任务状态 0-未发布 1-已发布',
  `task_start_time` datetime DEFAULT NULL COMMENT '任务开始时间',
  `task_end_time` datetime DEFAULT NULL COMMENT '任务结束时间',
  `college_admin_result_enable` tinyint(4) DEFAULT '0' COMMENT '院系管理员是否可查看本院结果 0-否 1-是',
  `answer_show_score_enable` tinyint(4) DEFAULT '1' COMMENT '教师答卷时是否显示问卷分值 0-隐藏 1-显示',
  `sup_online_type` tinyint(4) DEFAULT NULL COMMENT '在线听课类型 1-不允许 2-仅直播 3-仅点播 4-直播和点播',
  `create_user_id` bigint(20) DEFAULT NULL COMMENT '创建人ID',
  `update_user_id` bigint(20) DEFAULT NULL COMMENT '更新人ID',
  `version` int(11) NOT NULL DEFAULT '1' COMMENT '乐观锁版本号',
  `created_date_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `created_by` varchar(50) DEFAULT NULL COMMENT '创建人',
  `last_modified_date_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间',
  `last_modified_by` varchar(50) DEFAULT NULL COMMENT '最后修改人',
  `delete_flag` tinyint(4) NOT NULL DEFAULT '0' COMMENT '逻辑删除标记 0-正常 1-删除',
  `tenant_id` varchar(50) NOT NULL COMMENT '租户编号',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_acte_id` (`acte_id`) USING BTREE,
  KEY `idx_task_org_id` (`task_org_id`) USING BTREE,
  KEY `idx_task_status` (`task_status`) USING BTREE,
  KEY `idx_tse_dim_code` (`tse_dim_code`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='教师自评-任务表';

-- ----------------------------
-- Table structure for t_tse_task_subj_type
-- ----------------------------
DROP TABLE IF EXISTS `t_tse_task_subj_type`;
CREATE TABLE `t_tse_task_subj_type` (
  `id` bigint(20) NOT NULL COMMENT '主键ID（雪花算法生成）',
  `group_id` bigint(20) NOT NULL COMMENT '问卷组ID',
  `subj_type_id` bigint(20) NOT NULL COMMENT '课程类型ID',
  `subj_type_name` varchar(255) DEFAULT NULL COMMENT '课程类型名称',
  `sort_index` int(11) DEFAULT NULL COMMENT '排序',
  `create_user_id` bigint(20) DEFAULT NULL COMMENT '创建人ID',
  `update_user_id` bigint(20) DEFAULT NULL COMMENT '更新人ID',
  `version` int(11) NOT NULL DEFAULT '1' COMMENT '乐观锁版本号',
  `created_date_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `created_by` varchar(50) DEFAULT NULL COMMENT '创建人',
  `last_modified_date_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间',
  `last_modified_by` varchar(50) DEFAULT NULL COMMENT '最后修改人',
  `delete_flag` tinyint(4) NOT NULL DEFAULT '0' COMMENT '逻辑删除标记 0-正常 1-删除',
  `tenant_id` varchar(50) NOT NULL COMMENT '租户编号',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_group_id` (`group_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='教师自评-任务问卷组课程类型关联表';

-- ----------------------------
-- Table structure for t_tse_task_subj_type_survey_group
-- ----------------------------
DROP TABLE IF EXISTS `t_tse_task_subj_type_survey_group`;
CREATE TABLE `t_tse_task_subj_type_survey_group` (
  `id` bigint(20) NOT NULL COMMENT '主键ID（雪花算法生成）',
  `group_name` varchar(255) NOT NULL COMMENT '分组名称',
  `tse_task_id` bigint(20) NOT NULL COMMENT '教师自评任务ID',
  `all_subj_type_flag` tinyint(4) NOT NULL DEFAULT '0' COMMENT '是否全部课程类型 0-否 1-是',
  `sort_index` int(11) DEFAULT NULL COMMENT '排序',
  `create_user_id` bigint(20) DEFAULT NULL COMMENT '创建人ID',
  `update_user_id` bigint(20) DEFAULT NULL COMMENT '更新人ID',
  `version` int(11) NOT NULL DEFAULT '1' COMMENT '乐观锁版本号',
  `created_date_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `created_by` varchar(50) DEFAULT NULL COMMENT '创建人',
  `last_modified_date_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间',
  `last_modified_by` varchar(50) DEFAULT NULL COMMENT '最后修改人',
  `delete_flag` tinyint(4) NOT NULL DEFAULT '0' COMMENT '逻辑删除标记 0-正常 1-删除',
  `tenant_id` varchar(50) NOT NULL COMMENT '租户编号',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_tse_task_id` (`tse_task_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='教师自评-任务问卷组表';

-- ----------------------------
-- Table structure for t_tse_task_survey
-- ----------------------------
DROP TABLE IF EXISTS `t_tse_task_survey`;
CREATE TABLE `t_tse_task_survey` (
  `id` bigint(20) NOT NULL COMMENT '主键ID（雪花算法生成）',
  `group_id` bigint(20) NOT NULL COMMENT '问卷组ID',
  `survey_id` varchar(255) NOT NULL COMMENT '问卷ID',
  `survey_name` varchar(255) DEFAULT NULL COMMENT '问卷名称',
  `score_flag` tinyint(4) DEFAULT '1' COMMENT '是否计分 0-否 1-是',
  `sort_index` int(11) DEFAULT NULL COMMENT '排序',
  `create_user_id` bigint(20) DEFAULT NULL COMMENT '创建人ID',
  `update_user_id` bigint(20) DEFAULT NULL COMMENT '更新人ID',
  `version` int(11) NOT NULL DEFAULT '1' COMMENT '乐观锁版本号',
  `created_date_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `created_by` varchar(50) DEFAULT NULL COMMENT '创建人',
  `last_modified_date_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间',
  `last_modified_by` varchar(50) DEFAULT NULL COMMENT '最后修改人',
  `delete_flag` tinyint(4) NOT NULL DEFAULT '0' COMMENT '逻辑删除标记 0-正常 1-删除',
  `tenant_id` varchar(50) NOT NULL COMMENT '租户编号',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_group_id` (`group_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='教师自评-任务问卷表';

-- ----------------------------
-- Table structure for t_tse_task_user
-- ----------------------------
DROP TABLE IF EXISTS `t_tse_task_user`;
CREATE TABLE `t_tse_task_user` (
  `id` bigint(20) NOT NULL COMMENT '主键ID（雪花算法生成）',
  `tse_task_id` bigint(20) NOT NULL COMMENT '教师自评任务ID',
  `user_id` bigint(20) NOT NULL COMMENT '教师用户ID',
  `user_code` varchar(100) DEFAULT NULL COMMENT '教师编码',
  `user_name` varchar(255) DEFAULT NULL COMMENT '教师姓名',
  `org_id` bigint(20) DEFAULT NULL COMMENT '教师所属组织ID',
  `org_code` varchar(100) DEFAULT NULL COMMENT '教师所属组织编码',
  `org_name` varchar(255) DEFAULT NULL COMMENT '教师所属组织名称',
  `create_user_id` bigint(20) DEFAULT NULL COMMENT '创建人ID',
  `update_user_id` bigint(20) DEFAULT NULL COMMENT '更新人ID',
  `version` int(11) NOT NULL DEFAULT '1' COMMENT '乐观锁版本号',
  `created_date_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `created_by` varchar(50) DEFAULT NULL COMMENT '创建人',
  `last_modified_date_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间',
  `last_modified_by` varchar(50) DEFAULT NULL COMMENT '最后修改人',
  `delete_flag` tinyint(4) NOT NULL DEFAULT '0' COMMENT '逻辑删除标记 0-正常 1-删除',
  `tenant_id` varchar(50) NOT NULL COMMENT '租户编号',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_tse_task_id` (`tse_task_id`) USING BTREE,
  KEY `idx_user_id` (`user_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='教师自评-任务指定教师表';

-- ----------------------------
-- Table structure for t_view_behavior_data_report_detail
-- ----------------------------
DROP TABLE IF EXISTS `t_view_behavior_data_report_detail`;
CREATE TABLE `t_view_behavior_data_report_detail` (
  `id` bigint(20) NOT NULL,
  `task_id` bigint(20) NOT NULL COMMENT '任务id',
  `uuid` varchar(50) NOT NULL DEFAULT '' COMMENT '上报业务键(媒体一次播放)',
  `report_type` tinyint(1) NOT NULL DEFAULT '0' COMMENT '汇报类型(0普通汇报,1拖拽汇报,2跳过汇报)',
  `seq` int(11) NOT NULL DEFAULT '0' COMMENT '步数器',
  `play_speed` varchar(8) NOT NULL DEFAULT '1' COMMENT '播放速度',
  `video_time` int(11) NOT NULL DEFAULT '0' COMMENT '视频播放时间点',
  `watch_timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '用户观看时间戳(等同于上报时间戳)',
  `drag_time_from` int(11) NOT NULL DEFAULT '0' COMMENT '用户拖拽起点',
  `drag_time_to` int(11) NOT NULL DEFAULT '0' COMMENT '用户拖拽终点',
  `skip_time_from` int(11) NOT NULL DEFAULT '0' COMMENT '用户跳过起点',
  `skip_time_to` int(11) NOT NULL DEFAULT '0' COMMENT '用户跳过终点',
  `create_user_id` bigint(20) DEFAULT NULL COMMENT '创建人id',
  `update_user_id` bigint(20) DEFAULT NULL COMMENT '更新人id',
  `version` int(11) NOT NULL DEFAULT '1' COMMENT '乐观锁版本号',
  `created_date_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `created_by` varchar(50) DEFAULT NULL COMMENT '创建人',
  `last_modified_date_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间',
  `last_modified_by` varchar(50) DEFAULT NULL COMMENT '最后修改人',
  `delete_flag` tinyint(4) NOT NULL DEFAULT '0' COMMENT '删除标志（0：正常，1：删除）',
  `tenant_id` varchar(50) NOT NULL COMMENT '租户编号',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_uuid` (`uuid`) USING BTREE COMMENT 'info唯一外键'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='上报数据详情表';

-- ----------------------------
-- Table structure for t_view_behavior_data_report_detail_merged
-- ----------------------------
DROP TABLE IF EXISTS `t_view_behavior_data_report_detail_merged`;
CREATE TABLE `t_view_behavior_data_report_detail_merged` (
  `id` bigint(20) NOT NULL,
  `task_id` bigint(20) NOT NULL COMMENT '任务id',
  `uuid` varchar(50) NOT NULL DEFAULT '' COMMENT '上报业务键(媒体一次播放)',
  `play_speed` varchar(8) NOT NULL DEFAULT '' COMMENT '播放速度',
  `play_length` int(11) NOT NULL DEFAULT '0' COMMENT '播放时长(秒)',
  `play_from` int(11) NOT NULL DEFAULT '0' COMMENT '播放起始(秒)',
  `play_to` int(11) NOT NULL DEFAULT '0' COMMENT '播放结束(秒)',
  `play_datetime` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '播放时间',
  `create_user_id` bigint(20) DEFAULT NULL COMMENT '创建人id',
  `update_user_id` bigint(20) DEFAULT NULL COMMENT '更新人id',
  `version` int(11) NOT NULL DEFAULT '1' COMMENT '乐观锁版本号',
  `created_date_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `created_by` varchar(50) DEFAULT NULL COMMENT '创建人',
  `last_modified_date_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间',
  `last_modified_by` varchar(50) DEFAULT NULL COMMENT '最后修改人',
  `delete_flag` tinyint(4) NOT NULL DEFAULT '0' COMMENT '删除标志（0：正常，1：删除）',
  `tenant_id` varchar(50) NOT NULL COMMENT '租户编号',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_uuid` (`uuid`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='上报数据详情表——合并时间段后';

-- ----------------------------
-- Table structure for t_view_behavior_data_report_info
-- ----------------------------
DROP TABLE IF EXISTS `t_view_behavior_data_report_info`;
CREATE TABLE `t_view_behavior_data_report_info` (
  `id` bigint(20) NOT NULL,
  `task_id` bigint(20) NOT NULL COMMENT '任务id',
  `uuid` varchar(50) NOT NULL DEFAULT '' COMMENT '上报业务键(媒体一次播放)',
  `sync_to_es` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否同步到ES；0：否，1：是',
  `count_end` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否计算结束；0：否，1：是',
  `watch_end` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否观看结束；0：否，1：是',
  `watch_percent` decimal(6,3) NOT NULL DEFAULT '0.000' COMMENT '观看百分比(完播率)',
  `watch_total_time_all` int(11) NOT NULL DEFAULT '0' COMMENT '观看总时间(秒)',
  `watch_total_time_section_all` varchar(4096) NOT NULL DEFAULT '' COMMENT '观看总时间片段',
  `watch_total_time` int(11) NOT NULL DEFAULT '0' COMMENT '观看总时间(排除反复播放时段)秒',
  `watch_total_time_section` varchar(4096) NOT NULL DEFAULT '' COMMENT '观看时间片段(排除反复播放时段)',
  `watch_hour_times` varchar(2048) NOT NULL DEFAULT '' COMMENT '观看时间段24小时48个点',
  `video_current_time` int(11) NOT NULL DEFAULT '0' COMMENT '视频当前播放到的时间轴点(从0开始,单位毫秒)',
  `video_start_timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '开始观看时间戳(同一个uuid第一次传入即可)',
  `video_end_timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '结束观看时间戳',
  `video_length` int(11) NOT NULL DEFAULT '0' COMMENT '视频时长(单位秒)',
  `course_id` bigint(20) NOT NULL COMMENT '课程id',
  `course_name` varchar(255) DEFAULT NULL,
  `course_start_time` datetime DEFAULT NULL COMMENT '课程开始时间',
  `course_end_time` datetime DEFAULT NULL COMMENT '课程结束时间',
  `teaching_class_id` bigint(20) NOT NULL COMMENT '教学班id',
  `teaching_class_code` varchar(128) DEFAULT '' COMMENT '教学班编码',
  `teaching_class_name` varchar(128) DEFAULT '' COMMENT '教学班名称',
  `teacher_id` bigint(20) NOT NULL COMMENT '授课老师id',
  `teacher_code` varchar(128) NOT NULL DEFAULT '' COMMENT '授课老师编码',
  `teacher_name` varchar(128) DEFAULT '' COMMENT '授课老师名称',
  `subject_id` bigint(20) DEFAULT NULL COMMENT '科目id',
  `subject_code` varchar(128) DEFAULT '' COMMENT '科目编码',
  `subject_name` varchar(128) DEFAULT '' COMMENT '科目名称',
  `play_type` tinyint(1) NOT NULL COMMENT '0直播/1点播',
  `user_id` bigint(20) NOT NULL COMMENT '用户id',
  `user_code` varchar(50) NOT NULL DEFAULT '' COMMENT '用户code',
  `user_name` varchar(50) DEFAULT '' COMMENT '用户姓名',
  `create_user_id` bigint(20) DEFAULT NULL COMMENT '创建人id',
  `update_user_id` bigint(20) DEFAULT NULL COMMENT '更新人id',
  `version` int(11) NOT NULL DEFAULT '1' COMMENT '乐观锁版本号',
  `created_date_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `created_by` varchar(50) DEFAULT NULL COMMENT '创建人',
  `last_modified_date_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间',
  `last_modified_by` varchar(50) DEFAULT NULL COMMENT '最后修改人',
  `delete_flag` tinyint(4) NOT NULL DEFAULT '0' COMMENT '删除标志（0：正常，1：删除）',
  `tenant_id` varchar(50) NOT NULL COMMENT '租户编号',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `idx_uuid` (`uuid`) USING BTREE COMMENT 'uuid唯一键'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='上报数据主体信息表';

-- ----------------------------
-- Table structure for t_view_behavior_data_report_process_error
-- ----------------------------
DROP TABLE IF EXISTS `t_view_behavior_data_report_process_error`;
CREATE TABLE `t_view_behavior_data_report_process_error` (
  `id` bigint(20) NOT NULL,
  `task_id` bigint(20) NOT NULL COMMENT '任务id',
  `uuid` varchar(50) DEFAULT '' COMMENT '上报业务键(媒体一次播放)',
  `body` varchar(4096) DEFAULT '' COMMENT '上报数据体',
  `create_user_id` bigint(20) DEFAULT NULL COMMENT '创建人id',
  `update_user_id` bigint(20) DEFAULT NULL COMMENT '更新人id',
  `version` int(11) NOT NULL DEFAULT '1' COMMENT '乐观锁版本号',
  `created_date_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `created_by` varchar(50) DEFAULT NULL COMMENT '创建人',
  `last_modified_date_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间',
  `last_modified_by` varchar(50) DEFAULT NULL COMMENT '最后修改人',
  `delete_flag` tinyint(4) NOT NULL DEFAULT '0' COMMENT '删除标志（0：正常，1：删除）',
  `tenant_id` varchar(50) NOT NULL COMMENT '租户编号',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_uuid` (`uuid`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='上报数据处理失败补偿表';

-- ----------------------------
-- View structure for view_academic_term
-- ----------------------------
DROP VIEW IF EXISTS `view_academic_term`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `view_academic_term` AS select `t`.`id` AS `acte_id`,`t`.`acte_begin_date` AS `acte_begin_date`,`t`.`acte_end_date` AS `acte_end_date`,`t`.`acte_term` AS `acte_term`,`y`.`acye_code` AS `acye_code`,`t`.`tenant_org_code` AS `tenant_id` from (`jy_course_he`.`t_academic_term` `t` join `jy_course_he`.`t_academic_year` `y` on((`y`.`id` = `t`.`acye_id`))) where ((`t`.`recycle_sign` = 0) and (`y`.`recycle_sign` = 0));

-- ----------------------------
-- View structure for view_administrative_class
-- ----------------------------
DROP VIEW IF EXISTS `view_administrative_class`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `view_administrative_class` AS select `jy_course_he`.`t_administrative_class`.`id` AS `id`,`jy_course_he`.`t_administrative_class`.`insert_time` AS `insert_time`,`jy_course_he`.`t_administrative_class`.`update_time` AS `update_time`,`jy_course_he`.`t_administrative_class`.`recycle_sign` AS `recycle_sign`,`jy_course_he`.`t_administrative_class`.`tenant_org_code` AS `tenant_org_code`,`jy_course_he`.`t_administrative_class`.`adcl_code` AS `adcl_code`,`jy_course_he`.`t_administrative_class`.`adcl_name` AS `adcl_name`,`jy_course_he`.`t_administrative_class`.`adcl_grade` AS `adcl_grade`,`jy_course_he`.`t_administrative_class`.`majo_id` AS `majo_id` from `jy_course_he`.`t_administrative_class`;

-- ----------------------------
-- View structure for view_course
-- ----------------------------
DROP VIEW IF EXISTS `view_course`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `view_course` AS select `c`.`id` AS `cour_id`,`c`.`cour_begin_time` AS `cour_begin_time`,`c`.`cour_end_time` AS `cour_end_time`,`lt`.`id` AS `leti_id`,`lt`.`leti_number` AS `leti_number`,`tc`.`id` AS `tecl_id`,`tc`.`tecl_code` AS `tecl_code`,`tc`.`tecl_name` AS `tecl_name`,`tc`.`acte_id` AS `acte_id`,`tc`.`total_hours` AS `tecl_total_hours`,`act`.`acte_begin_date` AS `acte_begin_date`,`act`.`acte_end_date` AS `acte_end_date`,`act`.`acte_term` AS `acte_term`,`y`.`acye_code` AS `acye_code`,`s`.`id` AS `subj_id`,`s`.`subj_code` AS `subj_code`,`s`.`subj_name` AS `subj_name`,`s`.`subj_source` AS `educational_level`,`s`.`subject_type_id` AS `subj_type_id`,`s`.`total_hours` AS `subj_total_hours`,`st`.`type_value` AS `subj_type_name`,`s`.`subject_nature_id` AS `subj_nature_id`,`sn`.`nature_value` AS `subj_nature_name`,`s`.`subject_category_id` AS `subj_category_id`,`sc`.`category_value` AS `subj_category_name`,`o`.`id` AS `org_id`,`o`.`orga_code` AS `org_code`,`o`.`orga_name` AS `org_name`,`cr`.`id` AS `clro_id`,`cr`.`clro_code` AS `clro_code`,`cr`.`clro_name` AS `clro_name`,`c`.`tenant_org_code` AS `tenant_id` from (((((((((((`jy_course_he`.`t_course` `c` join `jy_course_he`.`t_classroom` `cr` on(((`cr`.`id` = `c`.`clro_id`) and (`cr`.`recycle_sign` = 0)))) left join `jy_course_he`.`t_lesson_time` `lt` on(((`lt`.`id` = `c`.`leti_id`) and (`lt`.`recycle_sign` = 0)))) join `jy_course_he`.`t_teaching_class` `tc` on(((`tc`.`id` = `c`.`tecl_id`) and (`tc`.`recycle_sign` = 0)))) join `jy_course_he`.`t_academic_term` `act` on(((`act`.`id` = `tc`.`acte_id`) and (`act`.`recycle_sign` = 0)))) join `jy_course_he`.`t_academic_year` `y` on(((`y`.`id` = `act`.`acye_id`) and (`y`.`recycle_sign` = 0)))) join `jy_course_he`.`t_subject` `s` on(((`s`.`id` = `tc`.`subj_id`) and (`s`.`recycle_sign` = 0)))) left join `jy_course_he`.`t_subject_type` `st` on(((`st`.`id` = `s`.`subject_type_id`) and (`st`.`recycle_sign` = 0)))) left join `jy_course_he`.`t_subject_nature` `sn` on(((`sn`.`id` = `s`.`subject_nature_id`) and (`sn`.`recycle_sign` = 0)))) left join `jy_course_he`.`t_subject_category` `sc` on(((`sc`.`id` = `s`.`subject_category_id`) and (`sc`.`recycle_sign` = 0)))) left join `jy_course_he`.`t_teaching_class_organization_relation` `r` on(((`r`.`tecl_code` = `tc`.`tecl_code`) and (`r`.`recycle_sign` = 0)))) left join `jy_course_he`.`t_organization` `o` on(((`o`.`orga_code` = `r`.`orga_code`) and (`o`.`recycle_sign` = 0)))) where (`c`.`recycle_sign` = 0);

-- ----------------------------
-- View structure for view_course_teacher
-- ----------------------------
DROP VIEW IF EXISTS `view_course_teacher`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `view_course_teacher` AS select `ct`.`cour_id` AS `cour_id`,`u`.`id` AS `teacher_user_id`,`u`.`user_code` AS `teacher_user_code`,`u`.`user_name` AS `teacher_user_name`,`t`.`teac_in_service_status` AS `teac_in_service_status`,`t`.`teacher_title_id` AS `teacher_title_id`,`tt`.`title_code` AS `teacher_title_code`,`tt`.`title_value` AS `teacher_title_name`,`t`.`employment_start_date` AS `employment_start_date` from (((`jy_course_he`.`t_course_teacher` `ct` join `jy_course_he`.`t_teacher` `t` on(((`t`.`user_id` = `ct`.`user_id`) and (`t`.`recycle_sign` = 0)))) join `jy_course_he`.`t_user` `u` on(((`u`.`id` = `t`.`user_id`) and (`u`.`recycle_sign` = 0)))) left join `jy_course_he`.`t_teacher_title` `tt` on(((`tt`.`id` = `t`.`teacher_title_id`) and (`tt`.`recycle_sign` = 0)))) where (`ct`.`recycle_sign` = 0);

-- ----------------------------
-- View structure for view_major
-- ----------------------------
DROP VIEW IF EXISTS `view_major`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `view_major` AS select `jy_course_he`.`t_major`.`id` AS `id`,`jy_course_he`.`t_major`.`insert_time` AS `insert_time`,`jy_course_he`.`t_major`.`update_time` AS `update_time`,`jy_course_he`.`t_major`.`recycle_sign` AS `recycle_sign`,`jy_course_he`.`t_major`.`tenant_org_code` AS `tenant_org_code`,`jy_course_he`.`t_major`.`majo_code` AS `majo_code`,`jy_course_he`.`t_major`.`majo_name` AS `majo_name`,`jy_course_he`.`t_major`.`orga_id` AS `orga_id` from `jy_course_he`.`t_major`;

-- ----------------------------
-- View structure for view_organization
-- ----------------------------
DROP VIEW IF EXISTS `view_organization`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `view_organization` AS select `jy_course_he`.`t_organization`.`id` AS `id`,`jy_course_he`.`t_organization`.`insert_time` AS `insert_time`,`jy_course_he`.`t_organization`.`update_time` AS `update_time`,`jy_course_he`.`t_organization`.`recycle_sign` AS `recycle_sign`,`jy_course_he`.`t_organization`.`tenant_org_code` AS `tenant_org_code`,`jy_course_he`.`t_organization`.`orga_parent_id` AS `orga_parent_id`,`jy_course_he`.`t_organization`.`orga_level` AS `orga_level`,`jy_course_he`.`t_organization`.`orga_code` AS `orga_code`,`jy_course_he`.`t_organization`.`orga_name` AS `orga_name`,`jy_course_he`.`t_organization`.`show_state` AS `show_state`,`jy_course_he`.`t_organization`.`order_num` AS `order_num`,`jy_course_he`.`t_organization`.`lesson_org_sign` AS `lesson_org_sign` from `jy_course_he`.`t_organization`;

-- ----------------------------
-- View structure for view_organization_user
-- ----------------------------
DROP VIEW IF EXISTS `view_organization_user`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `view_organization_user` AS select `jy_course_he`.`t_organization_user`.`id` AS `id`,`jy_course_he`.`t_organization_user`.`insert_time` AS `insert_time`,`jy_course_he`.`t_organization_user`.`update_time` AS `update_time`,`jy_course_he`.`t_organization_user`.`recycle_sign` AS `recycle_sign`,`jy_course_he`.`t_organization_user`.`user_id` AS `user_id`,`jy_course_he`.`t_organization_user`.`orga_id` AS `orga_id` from `jy_course_he`.`t_organization_user`;

-- ----------------------------
-- View structure for view_role
-- ----------------------------
DROP VIEW IF EXISTS `view_role`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `view_role` AS select `jy_course_he`.`t_role`.`id` AS `id`,`jy_course_he`.`t_role`.`insert_time` AS `insert_time`,`jy_course_he`.`t_role`.`update_time` AS `update_time`,`jy_course_he`.`t_role`.`recycle_sign` AS `recycle_sign`,`jy_course_he`.`t_role`.`tenant_org_code` AS `tenant_org_code`,`jy_course_he`.`t_role`.`role_code` AS `role_code`,`jy_course_he`.`t_role`.`role_type` AS `role_type`,`jy_course_he`.`t_role`.`course_view` AS `course_view`,`jy_course_he`.`t_role`.`app_code` AS `app_code`,`jy_course_he`.`t_role`.`create_user_id` AS `create_user_id`,`jy_course_he`.`t_role`.`update_user_id` AS `update_user_id`,`jy_course_he`.`t_role`.`created_by` AS `created_by`,`jy_course_he`.`t_role`.`last_modified_by` AS `last_modified_by`,`jy_course_he`.`t_role`.`role_name` AS `role_name`,`jy_course_he`.`t_role`.`role_desc` AS `role_desc` from `jy_course_he`.`t_role`;

-- ----------------------------
-- View structure for view_student
-- ----------------------------
DROP VIEW IF EXISTS `view_student`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `view_student` AS select `jy_course_he`.`t_student`.`id` AS `id`,`jy_course_he`.`t_student`.`insert_time` AS `insert_time`,`jy_course_he`.`t_student`.`update_time` AS `update_time`,`jy_course_he`.`t_student`.`recycle_sign` AS `recycle_sign`,`jy_course_he`.`t_student`.`tenant_org_code` AS `tenant_org_code`,`jy_course_he`.`t_student`.`user_id` AS `user_id`,`jy_course_he`.`t_student`.`stud_registration_status` AS `stud_registration_status`,`jy_course_he`.`t_student`.`stud_in_school_status` AS `stud_in_school_status`,`jy_course_he`.`t_student`.`stud_type` AS `stud_type`,`jy_course_he`.`t_student`.`adcl_id` AS `adcl_id` from `jy_course_he`.`t_student`;

-- ----------------------------
-- View structure for view_subject
-- ----------------------------
DROP VIEW IF EXISTS `view_subject`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `view_subject` AS select `jy_course_he`.`t_subject`.`id` AS `id`,`jy_course_he`.`t_subject`.`insert_time` AS `insert_time`,`jy_course_he`.`t_subject`.`update_time` AS `update_time`,`jy_course_he`.`t_subject`.`recycle_sign` AS `recycle_sign`,`jy_course_he`.`t_subject`.`tenant_org_code` AS `tenant_org_code`,`jy_course_he`.`t_subject`.`orga_id` AS `orga_id`,`jy_course_he`.`t_subject`.`acte_id` AS `acte_id`,`jy_course_he`.`t_subject`.`subj_code` AS `subj_code`,`jy_course_he`.`t_subject`.`subj_name` AS `subj_name`,`jy_course_he`.`t_subject`.`subj_description` AS `subj_description`,`jy_course_he`.`t_subject`.`subj_img_url` AS `subj_img_url`,`jy_course_he`.`t_subject`.`subj_source` AS `subj_source`,`jy_course_he`.`t_subject`.`subject_type_id` AS `subject_type_id`,`jy_course_he`.`t_subject`.`subject_nature_id` AS `subject_nature_id`,`jy_course_he`.`t_subject`.`subject_category_id` AS `subject_category_id`,`jy_course_he`.`t_subject`.`total_hours` AS `total_hours` from `jy_course_he`.`t_subject`;

-- ----------------------------
-- View structure for view_subject_nature
-- ----------------------------
DROP VIEW IF EXISTS `view_subject_nature`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `view_subject_nature` AS select `jy_course_he`.`t_subject_nature`.`id` AS `id`,`jy_course_he`.`t_subject_nature`.`nature_code` AS `nature_code`,`jy_course_he`.`t_subject_nature`.`nature_value` AS `nature_value`,`jy_course_he`.`t_subject_nature`.`sort_order` AS `sort_order`,`jy_course_he`.`t_subject_nature`.`recycle_sign` AS `recycle_sign`,`jy_course_he`.`t_subject_nature`.`tenant_org_code` AS `tenant_org_code`,`jy_course_he`.`t_subject_nature`.`insert_time` AS `insert_time`,`jy_course_he`.`t_subject_nature`.`update_time` AS `update_time` from `jy_course_he`.`t_subject_nature`;

-- ----------------------------
-- View structure for view_subject_organization
-- ----------------------------
DROP VIEW IF EXISTS `view_subject_organization`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `view_subject_organization` AS select `jy_course_he`.`t_subject_organization`.`id` AS `id`,`jy_course_he`.`t_subject_organization`.`insert_time` AS `insert_time`,`jy_course_he`.`t_subject_organization`.`update_time` AS `update_time`,`jy_course_he`.`t_subject_organization`.`recycle_sign` AS `recycle_sign`,`jy_course_he`.`t_subject_organization`.`subj_id` AS `subj_id`,`jy_course_he`.`t_subject_organization`.`orga_id` AS `orga_id` from `jy_course_he`.`t_subject_organization`;

-- ----------------------------
-- View structure for view_subject_type
-- ----------------------------
DROP VIEW IF EXISTS `view_subject_type`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `view_subject_type` AS select `jy_course_he`.`t_subject_type`.`id` AS `id`,`jy_course_he`.`t_subject_type`.`type_code` AS `type_code`,`jy_course_he`.`t_subject_type`.`type_value` AS `type_value`,`jy_course_he`.`t_subject_type`.`sort_order` AS `sort_order`,`jy_course_he`.`t_subject_type`.`recycle_sign` AS `recycle_sign`,`jy_course_he`.`t_subject_type`.`tenant_org_code` AS `tenant_org_code`,`jy_course_he`.`t_subject_type`.`insert_time` AS `insert_time`,`jy_course_he`.`t_subject_type`.`update_time` AS `update_time` from `jy_course_he`.`t_subject_type`;

-- ----------------------------
-- View structure for view_teacher
-- ----------------------------
DROP VIEW IF EXISTS `view_teacher`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `view_teacher` AS select `jy_course_he`.`t_teacher`.`id` AS `id`,`jy_course_he`.`t_teacher`.`insert_time` AS `insert_time`,`jy_course_he`.`t_teacher`.`update_time` AS `update_time`,`jy_course_he`.`t_teacher`.`recycle_sign` AS `recycle_sign`,`jy_course_he`.`t_teacher`.`tenant_org_code` AS `tenant_org_code`,`jy_course_he`.`t_teacher`.`user_id` AS `user_id`,`jy_course_he`.`t_teacher`.`teac_in_service_status` AS `teac_in_service_status`,`jy_course_he`.`t_teacher`.`teacher_title` AS `teacher_title`,`jy_course_he`.`t_teacher`.`employment_start_date` AS `employment_start_date`,`jy_course_he`.`t_teacher`.`teacher_title_id` AS `teacher_title_id` from `jy_course_he`.`t_teacher`;

-- ----------------------------
-- View structure for view_teacher_title
-- ----------------------------
DROP VIEW IF EXISTS `view_teacher_title`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `view_teacher_title` AS select `jy_course_he`.`t_teacher_title`.`id` AS `id`,`jy_course_he`.`t_teacher_title`.`title_code` AS `title_code`,`jy_course_he`.`t_teacher_title`.`title_value` AS `title_value`,`jy_course_he`.`t_teacher_title`.`sort_order` AS `sort_order`,`jy_course_he`.`t_teacher_title`.`recycle_sign` AS `recycle_sign`,`jy_course_he`.`t_teacher_title`.`tenant_org_code` AS `tenant_org_code`,`jy_course_he`.`t_teacher_title`.`insert_time` AS `insert_time`,`jy_course_he`.`t_teacher_title`.`update_time` AS `update_time` from `jy_course_he`.`t_teacher_title`;

-- ----------------------------
-- View structure for view_teaching_class
-- ----------------------------
DROP VIEW IF EXISTS `view_teaching_class`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `view_teaching_class` AS select `jy_course_he`.`t_teaching_class`.`id` AS `id`,`jy_course_he`.`t_teaching_class`.`insert_time` AS `insert_time`,`jy_course_he`.`t_teaching_class`.`update_time` AS `update_time`,`jy_course_he`.`t_teaching_class`.`recycle_sign` AS `recycle_sign`,`jy_course_he`.`t_teaching_class`.`tenant_org_code` AS `tenant_org_code`,`jy_course_he`.`t_teaching_class`.`tecl_code` AS `tecl_code`,`jy_course_he`.`t_teaching_class`.`tecl_name` AS `tecl_name`,`jy_course_he`.`t_teaching_class`.`acte_id` AS `acte_id`,`jy_course_he`.`t_teaching_class`.`subj_id` AS `subj_id`,`jy_course_he`.`t_teaching_class`.`tecl_student_count` AS `tecl_student_count`,`jy_course_he`.`t_teaching_class`.`tecl_description` AS `tecl_description`,`jy_course_he`.`t_teaching_class`.`tecl_img_url` AS `tecl_img_url`,`jy_course_he`.`t_teaching_class`.`tecl_notice` AS `tecl_notice`,`jy_course_he`.`t_teaching_class`.`course_no` AS `course_no`,`jy_course_he`.`t_teaching_class`.`total_hours` AS `total_hours` from `jy_course_he`.`t_teaching_class`;

-- ----------------------------
-- View structure for view_teaching_class_organization_relation
-- ----------------------------
DROP VIEW IF EXISTS `view_teaching_class_organization_relation`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `view_teaching_class_organization_relation` AS select `jy_course_he`.`t_teaching_class_organization_relation`.`id` AS `id`,`jy_course_he`.`t_teaching_class_organization_relation`.`tecl_code` AS `tecl_code`,`jy_course_he`.`t_teaching_class_organization_relation`.`orga_code` AS `orga_code`,`jy_course_he`.`t_teaching_class_organization_relation`.`tenant_org_code` AS `tenant_org_code`,`jy_course_he`.`t_teaching_class_organization_relation`.`insert_time` AS `insert_time`,`jy_course_he`.`t_teaching_class_organization_relation`.`update_time` AS `update_time`,`jy_course_he`.`t_teaching_class_organization_relation`.`recycle_sign` AS `recycle_sign`,`jy_course_he`.`t_teaching_class_organization_relation`.`tecl_source` AS `tecl_source` from `jy_course_he`.`t_teaching_class_organization_relation`;

-- ----------------------------
-- View structure for view_teaching_class_student
-- ----------------------------
DROP VIEW IF EXISTS `view_teaching_class_student`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `view_teaching_class_student` AS select `jy_course_he`.`t_teaching_class_student`.`id` AS `id`,`jy_course_he`.`t_teaching_class_student`.`insert_time` AS `insert_time`,`jy_course_he`.`t_teaching_class_student`.`update_time` AS `update_time`,`jy_course_he`.`t_teaching_class_student`.`recycle_sign` AS `recycle_sign`,`jy_course_he`.`t_teaching_class_student`.`tecl_id` AS `tecl_id`,`jy_course_he`.`t_teaching_class_student`.`stud_id` AS `stud_id`,`jy_course_he`.`t_teaching_class_student`.`tcst_data_source` AS `tcst_data_source` from `jy_course_he`.`t_teaching_class_student`;

-- ----------------------------
-- View structure for view_teaching_class_teacher
-- ----------------------------
DROP VIEW IF EXISTS `view_teaching_class_teacher`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `view_teaching_class_teacher` AS select `jy_course_he`.`t_teaching_class_teacher`.`id` AS `id`,`jy_course_he`.`t_teaching_class_teacher`.`insert_time` AS `insert_time`,`jy_course_he`.`t_teaching_class_teacher`.`update_time` AS `update_time`,`jy_course_he`.`t_teaching_class_teacher`.`recycle_sign` AS `recycle_sign`,`jy_course_he`.`t_teaching_class_teacher`.`teac_id` AS `teac_id`,`jy_course_he`.`t_teaching_class_teacher`.`tecl_id` AS `tecl_id` from `jy_course_he`.`t_teaching_class_teacher`;

-- ----------------------------
-- View structure for view_tecl_student
-- ----------------------------
DROP VIEW IF EXISTS `view_tecl_student`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `view_tecl_student` AS select `c`.`id` AS `tecl_id`,`c`.`start_week` AS `start_week`,`c`.`end_week` AS `end_week`,`c`.`acte_id` AS `acte_id`,`u`.`id` AS `student_user_id`,`u`.`user_code` AS `student_user_code`,`u`.`user_name` AS `student_user_name`,`ac`.`id` AS `adcl_id`,`ac`.`adcl_code` AS `adcl_code`,`ac`.`adcl_name` AS `adcl_name`,`ac`.`adcl_grade` AS `adcl_grade`,`ac`.`majo_id` AS `majo_id`,`d`.`majo_code` AS `majo_code`,`d`.`majo_name` AS `majo_name`,`c`.`tenant_org_code` AS `tenant_id` from (((((`jy_course_he`.`t_teaching_class` `c` join `jy_course_he`.`t_teaching_class_student` `cs` on(((`cs`.`tecl_id` = `c`.`id`) and (`cs`.`recycle_sign` = 0)))) join `jy_course_he`.`t_student` `s` on(((`s`.`id` = `cs`.`stud_id`) and (`s`.`recycle_sign` = 0)))) join `jy_course_he`.`t_user` `u` on(((`u`.`id` = `s`.`user_id`) and (`u`.`recycle_sign` = 0)))) left join `jy_course_he`.`t_administrative_class` `ac` on(((`ac`.`id` = `s`.`adcl_id`) and (`ac`.`recycle_sign` = 0)))) left join `jy_course_he`.`t_major` `d` on(((`d`.`id` = `ac`.`majo_id`) and (`d`.`recycle_sign` = 0)))) where (`c`.`recycle_sign` = 0);

-- ----------------------------
-- View structure for view_tecl_subj_org
-- ----------------------------
DROP VIEW IF EXISTS `view_tecl_subj_org`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `view_tecl_subj_org` AS select `tc`.`id` AS `tecl_id`,`tc`.`tecl_code` AS `tecl_code`,`tc`.`tecl_name` AS `tecl_name`,`tc`.`start_week` AS `start_week`,`tc`.`end_week` AS `end_week`,`s`.`id` AS `subj_id`,`s`.`subj_code` AS `subj_code`,`s`.`subj_name` AS `subj_name`,`s`.`subj_source` AS `educational_level`,`s`.`subject_type_id` AS `subj_type_id`,`st`.`type_value` AS `subj_type_name`,`s`.`subject_nature_id` AS `subj_nature_id`,`sn`.`nature_value` AS `subj_nature_name`,`s`.`subject_category_id` AS `subj_category_id`,`sc`.`category_value` AS `subj_category_name`,`s`.`total_hours` AS `subj_total_hours`,`te`.`id` AS `acte_id`,`te`.`acte_term` AS `acte_term`,`ye`.`acye_code` AS `acye_code`,`o`.`id` AS `org_id`,`o`.`orga_code` AS `org_code`,`o`.`orga_name` AS `org_name`,`tc`.`tenant_org_code` AS `tenant_id` from ((((((((`jy_course_he`.`t_teaching_class` `tc` left join `jy_course_he`.`t_subject` `s` on(((`s`.`id` = `tc`.`subj_id`) and (`s`.`recycle_sign` = 0)))) left join `jy_course_he`.`t_subject_type` `st` on(((`st`.`id` = `s`.`subject_type_id`) and (`st`.`recycle_sign` = 0)))) left join `jy_course_he`.`t_subject_nature` `sn` on(((`sn`.`id` = `s`.`subject_nature_id`) and (`sn`.`recycle_sign` = 0)))) left join `jy_course_he`.`t_subject_category` `sc` on(((`sc`.`id` = `s`.`subject_category_id`) and (`sc`.`recycle_sign` = 0)))) left join `jy_course_he`.`t_academic_term` `te` on(((`te`.`id` = `tc`.`acte_id`) and (`te`.`recycle_sign` = 0)))) left join `jy_course_he`.`t_academic_year` `ye` on(((`ye`.`id` = `te`.`acye_id`) and (`ye`.`recycle_sign` = 0)))) left join `jy_course_he`.`t_teaching_class_organization_relation` `r` on(((`r`.`tecl_code` = `tc`.`tecl_code`) and (`r`.`recycle_sign` = 0)))) left join `jy_course_he`.`t_organization` `o` on(((`o`.`orga_code` = `r`.`orga_code`) and (`o`.`recycle_sign` = 0)))) where (`tc`.`recycle_sign` = 0);

-- ----------------------------
-- View structure for view_tecl_teacher
-- ----------------------------
DROP VIEW IF EXISTS `view_tecl_teacher`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `view_tecl_teacher` AS select `c`.`id` AS `tecl_id`,`u`.`id` AS `teacher_user_id`,`u`.`user_code` AS `teacher_user_code`,`u`.`user_name` AS `teacher_user_name`,`t`.`teac_in_service_status` AS `teac_in_service_status`,`t`.`teacher_title_id` AS `teacher_title_id`,`tt`.`title_code` AS `teacher_title_code`,`tt`.`title_value` AS `teacher_title_name`,`t`.`employment_start_date` AS `employment_start_date`,`c`.`tenant_org_code` AS `tenant_id` from ((((`jy_course_he`.`t_teaching_class` `c` join `jy_course_he`.`t_teaching_class_teacher` `ct` on(((`ct`.`tecl_id` = `c`.`id`) and (`ct`.`recycle_sign` = 0)))) join `jy_course_he`.`t_teacher` `t` on(((`t`.`id` = `ct`.`teac_id`) and (`t`.`recycle_sign` = 0)))) join `jy_course_he`.`t_user` `u` on(((`u`.`id` = `t`.`user_id`) and (`u`.`recycle_sign` = 0)))) left join `jy_course_he`.`t_teacher_title` `tt` on(((`tt`.`id` = `t`.`teacher_title_id`) and (`tt`.`recycle_sign` = 0)))) where (`c`.`recycle_sign` = 0);

-- ----------------------------
-- View structure for view_tecl_teacher_org
-- ----------------------------
DROP VIEW IF EXISTS `view_tecl_teacher_org`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `view_tecl_teacher_org` AS select distinct `u`.`id` AS `teacher_user_id`,`o`.`id` AS `org_id`,`o`.`orga_code` AS `org_code`,`o`.`orga_name` AS `org_name`,`c`.`tenant_org_code` AS `tenant_id` from (((((`jy_course_he`.`t_teaching_class` `c` join `jy_course_he`.`t_teaching_class_teacher` `ct` on(((`ct`.`tecl_id` = `c`.`id`) and (`ct`.`recycle_sign` = 0)))) join `jy_course_he`.`t_teacher` `t` on(((`t`.`id` = `ct`.`teac_id`) and (`t`.`recycle_sign` = 0)))) join `jy_course_he`.`t_user` `u` on(((`u`.`id` = `t`.`user_id`) and (`u`.`recycle_sign` = 0)))) join `jy_course_he`.`t_organization_user` `ou` on(((`ou`.`user_id` = `u`.`id`) and (`ou`.`recycle_sign` = 0)))) join `jy_course_he`.`t_organization` `o` on(((`o`.`id` = `ou`.`orga_id`) and (`o`.`recycle_sign` = 0)))) where (`c`.`recycle_sign` = 0);

-- ----------------------------
-- View structure for view_user
-- ----------------------------
DROP VIEW IF EXISTS `view_user`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `view_user` AS select `jy_course_he`.`t_user`.`id` AS `id`,`jy_course_he`.`t_user`.`insert_time` AS `insert_time`,`jy_course_he`.`t_user`.`update_time` AS `update_time`,`jy_course_he`.`t_user`.`recycle_sign` AS `recycle_sign`,`jy_course_he`.`t_user`.`tenant_org_code` AS `tenant_org_code`,`jy_course_he`.`t_user`.`user_id` AS `user_id`,`jy_course_he`.`t_user`.`user_code` AS `user_code`,`jy_course_he`.`t_user`.`user_email` AS `user_email`,`jy_course_he`.`t_user`.`user_phone_num` AS `user_phone_num`,`jy_course_he`.`t_user`.`user_identifier_num` AS `user_identifier_num`,`jy_course_he`.`t_user`.`user_status` AS `user_status`,`jy_course_he`.`t_user`.`user_name` AS `user_name`,`jy_course_he`.`t_user`.`user_gender` AS `user_gender`,`jy_course_he`.`t_user`.`user_birthday` AS `user_birthday`,`jy_course_he`.`t_user`.`is_tenant_admin` AS `is_tenant_admin`,`jy_course_he`.`t_user`.`begin_date` AS `begin_date`,`jy_course_he`.`t_user`.`end_date` AS `end_date`,`jy_course_he`.`t_user`.`wechat_user_id` AS `wechat_user_id`,`jy_course_he`.`t_user`.`password` AS `password`,`jy_course_he`.`t_user`.`alternate_name` AS `alternate_name` from `jy_course_he`.`t_user`;

-- ----------------------------
-- View structure for view_user_level
-- ----------------------------
DROP VIEW IF EXISTS `view_user_level`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `view_user_level` AS select `jy_course_he`.`t_user_level`.`id` AS `id`,`jy_course_he`.`t_user_level`.`user_id` AS `user_id`,`jy_course_he`.`t_user_level`.`user_code` AS `user_code`,`jy_course_he`.`t_user_level`.`role_code` AS `role_code`,`jy_course_he`.`t_user_level`.`user_level` AS `user_level`,`jy_course_he`.`t_user_level`.`recycle_sign` AS `recycle_sign`,`jy_course_he`.`t_user_level`.`tenant_org_code` AS `tenant_org_code`,`jy_course_he`.`t_user_level`.`insert_time` AS `insert_time`,`jy_course_he`.`t_user_level`.`update_time` AS `update_time`,`jy_course_he`.`t_user_level`.`app_code` AS `app_code` from `jy_course_he`.`t_user_level`;

-- ----------------------------
-- View structure for view_user_role
-- ----------------------------
DROP VIEW IF EXISTS `view_user_role`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `view_user_role` AS select `jy_course_he`.`t_user_role`.`id` AS `id`,`jy_course_he`.`t_user_role`.`insert_time` AS `insert_time`,`jy_course_he`.`t_user_role`.`update_time` AS `update_time`,`jy_course_he`.`t_user_role`.`recycle_sign` AS `recycle_sign`,`jy_course_he`.`t_user_role`.`tenant_org_code` AS `tenant_org_code`,`jy_course_he`.`t_user_role`.`user_id` AS `user_id`,`jy_course_he`.`t_user_role`.`user_code` AS `user_code`,`jy_course_he`.`t_user_role`.`role_id` AS `role_id`,`jy_course_he`.`t_user_role`.`begin_date` AS `begin_date`,`jy_course_he`.`t_user_role`.`end_date` AS `end_date`,`jy_course_he`.`t_user_role`.`app_code` AS `app_code` from `jy_course_he`.`t_user_role`;

SET FOREIGN_KEY_CHECKS = 1;
