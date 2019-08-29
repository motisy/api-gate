/*
Navicat MySQL Data Transfer

Source Server         : 测试服务器
Source Server Version : 50642
Source Host           : 192.168.8.254:3306
Source Database       : api

Target Server Type    : MYSQL
Target Server Version : 50642
File Encoding         : 65001

Date: 2019-08-29 16:16:25
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for account_api_limit
-- ----------------------------
DROP TABLE IF EXISTS `account_api_limit`;
CREATE TABLE `account_api_limit` (
  `account_id` bigint(20) NOT NULL COMMENT '账号',
  `api_id` bigint(20) NOT NULL COMMENT 'api',
  `has_limit` tinyint(1) NOT NULL DEFAULT '0' COMMENT '默认没有限制',
  `limit_type` varchar(20) NOT NULL DEFAULT 'time_limit' COMMENT '限制类型，time_limit是时间范围内次数限制，total_limit是总次数限制',
  `limit_number` int(11) NOT NULL DEFAULT '1000' COMMENT '限制访问次数',
  `limit_time_number` int(11) DEFAULT '1' COMMENT '时间范围大小，配合单位实用',
  `limit_time_unit` varchar(10) DEFAULT 'day' COMMENT '时间范围的单位，minute/hour/day',
  `limit_rest_number` int(11) DEFAULT NULL,
  `create_by` varchar(64) DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`account_id`,`api_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='账号访问api的权限';

-- ----------------------------
-- Records of account_api_limit
-- ----------------------------
INSERT INTO `account_api_limit` VALUES ('4', '1', '1', 'time_limit', '100', '1', 'minute', '3', null, null, '若依', '2019-08-23 17:17:48', '');
INSERT INTO `account_api_limit` VALUES ('4', '3', '0', 'time_limit', '1000', '1', 'day', null, '若依', '2019-08-21 13:52:29', '', null, '');
INSERT INTO `account_api_limit` VALUES ('4', '4', '0', 'time_limit', '1000', '1', 'day', null, '若依', '2019-08-21 16:05:59', '', null, '');
INSERT INTO `account_api_limit` VALUES ('4', '5', '0', 'time_limit', '1000', '1', 'day', null, '若依', '2019-08-26 17:16:27', '', null, '');

-- ----------------------------
-- Table structure for api_account
-- ----------------------------
DROP TABLE IF EXISTS `api_account`;
CREATE TABLE `api_account` (
  `account_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `account_name` varchar(255) DEFAULT NULL COMMENT '账号名称',
  `app_key` varchar(255) DEFAULT NULL COMMENT 'api访问秘钥',
  `app_screct` varchar(255) DEFAULT NULL COMMENT 'api访问秘钥',
  `create_by` varchar(64) DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`account_id`),
  UNIQUE KEY `name` (`account_name`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 COMMENT='api访问账号';

-- ----------------------------
-- Records of api_account
-- ----------------------------
INSERT INTO `api_account` VALUES ('4', '测试账号', '1hGBBbzU0F', 'e9d2b3c9c04109e5ae5ffe8a8697c8c2', '若依', '2019-08-13 14:21:10', '', null, '');
INSERT INTO `api_account` VALUES ('5', '测试账号	2', 'W5wMNwQ3R7', '713a79f78c265129cc2aeca41bedd2ee', '若依', '2019-08-13 14:21:22', '', null, '');

-- ----------------------------
-- Table structure for api_group
-- ----------------------------
DROP TABLE IF EXISTS `api_group`;
CREATE TABLE `api_group` (
  `api_group_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `api_group_name` varchar(255) NOT NULL COMMENT '服务名称',
  `create_by` varchar(64) DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`api_group_id`),
  UNIQUE KEY `name` (`api_group_name`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COMMENT='api分组';

-- ----------------------------
-- Records of api_group
-- ----------------------------
INSERT INTO `api_group` VALUES ('3', '管廊', '若依', '2019-08-06 15:36:17', '若依', '2019-08-06 15:59:28', '两学一做22');

-- ----------------------------
-- Table structure for api_request_record
-- ----------------------------
DROP TABLE IF EXISTS `api_request_record`;
CREATE TABLE `api_request_record` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `app_key` varchar(255) DEFAULT NULL COMMENT '接口调用者',
  `api_id` bigint(20) DEFAULT NULL COMMENT 'api',
  `api_name` varchar(255) DEFAULT NULL,
  `api_url` varchar(255) DEFAULT NULL,
  `server_id` bigint(20) DEFAULT NULL COMMENT '服务端',
  `server_name` varchar(255) DEFAULT NULL,
  `request_ip` varchar(255) DEFAULT NULL,
  `request_location` varchar(255) DEFAULT NULL,
  `request_method` varchar(255) DEFAULT NULL,
  `request_url` varchar(255) DEFAULT NULL COMMENT '请求地址',
  `forward_url` varchar(255) DEFAULT NULL COMMENT '转发地址',
  `request_params` text,
  `use_time` int(11) DEFAULT NULL COMMENT '总共用时 ms',
  `response_content_type` varchar(255) DEFAULT NULL COMMENT '响应数据结构',
  `forward_success` tinyint(1) DEFAULT '0' COMMENT '转发是否成功，与接口结果无关',
  `failed_reasons` varchar(255) DEFAULT NULL COMMENT '失败原因',
  `create_by` varchar(64) DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8 COMMENT='请求转发记录';

-- ----------------------------
-- Records of api_request_record
-- ----------------------------
INSERT INTO `api_request_record` VALUES ('1', '1hGBBbzU0F', '4', '转发2', '/*', '8', '管廊', '127.0.0.1', '内网IP', 'GET', 'http://localhost/openapi/img/logo.png', 'http://192.168.8.132:8080/img/logo.png', '{}', '51', 'image/png', '1', null, 'System', '2019-08-29 14:11:12', null, null, null);
INSERT INTO `api_request_record` VALUES ('2', '1hGBBbzU0F', '3', '转发', '/app/*', '5', '管廊app1', '127.0.0.1', '内网IP', 'GET', 'http://localhost/openapi/app/user/getUserById', 'http://192.168.8.132:8080/app/app/user/getUserById', '{}', '44', null, '1', null, 'System', '2019-08-29 14:17:44', null, null, null);
INSERT INTO `api_request_record` VALUES ('3', '1hGBBbzU0F', '3', '转发', '/app/*', '5', '管廊app1', '127.0.0.1', '内网IP', 'GET', 'http://localhost/openapi/app/user/getUserById', 'http://192.168.8.132:8080/app/app/user/getUserById', '{}', '21', null, '1', null, 'System', '2019-08-29 14:17:56', null, null, null);
INSERT INTO `api_request_record` VALUES ('4', '1hGBBbzU0F', '3', '转发', '/app/*', '5', '管廊app1', '127.0.0.1', '内网IP', 'GET', 'http://localhost/openapi/app/user/getUserById', 'http://192.168.8.132:8080/app/app/user/getUserById', '{}', '22', null, '1', null, 'System', '2019-08-29 14:18:10', null, null, null);
INSERT INTO `api_request_record` VALUES ('5', '1hGBBbzU0F', '3', '转发', '/app/*', '5', '管廊app1', '127.0.0.1', '内网IP', 'GET', 'http://localhost/openapi/app/user/getUserById', 'http://192.168.8.132:8080/app/app/user/getUserById', '{\"id\":\"1\"}', '23', null, '1', null, 'System', '2019-08-29 14:18:42', null, null, null);
INSERT INTO `api_request_record` VALUES ('6', '1hGBBbzU0F', '3', '转发', '/app/*', '5', '管廊app1', '127.0.0.1', '内网IP', 'GET', 'http://localhost/openapi/app/user/getUserById', 'http://192.168.8.132:8080/app/app/user/getUserById', '{\"id\":\"1\"}', '66339', null, '1', null, 'System', '2019-08-29 14:21:32', null, null, null);
INSERT INTO `api_request_record` VALUES ('7', '1hGBBbzU0F', '3', '转发', '/app/*', '5', '管廊app1', '127.0.0.1', '内网IP', 'GET', 'http://localhost/openapi/app/user/getUserById', 'http://192.168.8.132:8080/app/app/user/getUserById', '{\"id\":\"1\"}', '33128', null, '1', null, 'System', '2019-08-29 14:22:15', null, null, null);
INSERT INTO `api_request_record` VALUES ('8', '1hGBBbzU0F', '3', '转发', '/app/*', '5', '管廊app1', '127.0.0.1', '内网IP', 'GET', 'http://localhost/openapi/app/user/getUserById', 'http://192.168.8.132:8080/app/app/user/getUserById', '{\"id\":\"1\"}', '30974', null, '1', null, 'System', '2019-08-29 14:23:34', null, null, null);
INSERT INTO `api_request_record` VALUES ('9', '1hGBBbzU0F', '3', '转发', '/app/*', '5', '管廊app1', '127.0.0.1', '内网IP', 'GET', 'http://localhost/openapi/app/user/getUserById', 'http://192.168.8.132:8080/app/app/user/getUserById', '{\"id\":\"1\"}', '64094', null, '1', null, 'System', '2019-08-29 14:25:31', null, null, null);
INSERT INTO `api_request_record` VALUES ('10', '1hGBBbzU0F', '3', '转发', '/app/*', '5', '管廊app1', '127.0.0.1', '内网IP', 'GET', 'http://localhost/openapi/app/user/getUserById', 'http://192.168.8.132:8080/app/app/user/getUserById', '{\"id\":\"1\"}', '18401', null, '1', '未找到服务器', 'System', '2019-08-29 14:27:55', null, null, null);
INSERT INTO `api_request_record` VALUES ('11', '1hGBBbzU0F', '3', '转发', '/app/*', '5', '管廊app1', '127.0.0.1', '内网IP', 'GET', 'http://localhost/openapi/app/user/getUserById', 'http://192.168.8.132:8080/app/app/user/getUserById', '{\"id\":\"1\"}', '15397', null, '1', '{\"timestamp\":\"2019-08-29 14:31:29\",\"status\":404,\"error\":\"Not Found\",\"message\":\"No message available\",\"path\":\"/app/app/user/getUserById\"}', 'System', '2019-08-29 14:31:45', null, null, null);
INSERT INTO `api_request_record` VALUES ('12', '1hGBBbzU0F', '3', '转发', '/app/*', '5', '管廊app1', '127.0.0.1', '内网IP', 'GET', 'http://localhost/openapi/app/user/getUserById', 'http://192.168.8.132:8080/app/app/user/getUserById', '{\"id\":\"1\"}', '33', null, '1', '{\"timestamp\":\"2019-08-29 14:32:29\",\"status\":404,\"error\":\"Not Found\",\"message\":\"No message available\",\"path\":\"/app/app/user/getUserById\"}', 'System', '2019-08-29 14:32:29', null, null, null);
INSERT INTO `api_request_record` VALUES ('13', '1hGBBbzU0F', '3', '转发', '/app/*', '5', '管廊app1', '127.0.0.1', '内网IP', 'GET', 'http://localhost/openapi/app/user/getUserById', 'http://192.168.8.132:8080/app/app/user/getUserById', '{\"id\":\"1\"}', '22', null, '1', '{\"timestamp\":\"2019-08-29 14:33:27\",\"status\":404,\"error\":\"Not Found\",\"message\":\"No message available\",\"path\":\"/app/app/user/getUserById\"}', 'System', '2019-08-29 14:33:27', null, null, null);
INSERT INTO `api_request_record` VALUES ('14', '1hGBBbzU0F', '3', '转发', '/app/*', '5', '管廊app1', '127.0.0.1', '内网IP', 'GET', 'http://localhost/openapi/app/user/getUserById', 'http://192.168.8.132:8080/app/app/user/getUserById', '{\"id\":\"1\"}', '16194', null, '1', '{\"timestamp\":\"2019-08-29 14:33:55\",\"status\":404,\"error\":\"Not Found\",\"message\":\"No message available\",\"path\":\"/app/app/user/getUserById\"}', 'System', '2019-08-29 14:34:11', null, null, null);
INSERT INTO `api_request_record` VALUES ('15', '1hGBBbzU0F', '3', '转发', '/app/*', '5', '管廊app1', '127.0.0.1', '内网IP', 'GET', 'http://localhost/openapi/app/user/getUserById', 'http://192.168.8.132:8080/app/app/user/getUserById', '{\"id\":\"1\"}', '147', null, '1', '{\"timestamp\":\"2019-08-29 14:37:48\",\"status\":404,\"error\":\"Not Found\",\"message\":\"No message available\",\"path\":\"/app/app/user/getUserById\"}', 'System', '2019-08-29 14:37:48', null, null, null);
INSERT INTO `api_request_record` VALUES ('16', '1hGBBbzU0F', '1', '获取用户信息', '/user/getUserById', '5', '管廊app1', '127.0.0.1', '内网IP', 'GET', 'http://localhost/openapi/user/getUserById', 'http://192.168.8.132:8080/app/user/getUserById', '{\"id\":\"1\"}', '45', 'application/json;charset=UTF-8', '1', null, 'System', '2019-08-29 14:38:09', null, null, null);
INSERT INTO `api_request_record` VALUES ('17', '1hGBBbzU0F', '3', '转发', '/app/*', '5', '管廊app1', '127.0.0.1', '内网IP', 'GET', 'http://localhost/openapi/app/user/getUserById', 'http://192.168.8.132:8080/app/app/user/getUserById', '{\"id\":\"1\"}', '21', null, '1', '{\"timestamp\":\"2019-08-29 14:38:29\",\"status\":404,\"error\":\"Not Found\",\"message\":\"No message available\",\"path\":\"/app/app/user/getUserById\"}', 'System', '2019-08-29 14:38:29', null, null, null);
INSERT INTO `api_request_record` VALUES ('18', '1hGBBbzU0F', '1', '获取用户信息', '/user/getUserById', '9', '管廊app2', '127.0.0.1', '内网IP', 'GET', 'http://localhost/openapi/user/getUserById', 'http://192.168.8.132:8080/app/user/getUserById', '{\"id\":\"1\"}', '27', 'application/json;charset=UTF-8', '1', null, 'System', '2019-08-29 14:38:57', null, null, null);
INSERT INTO `api_request_record` VALUES ('19', '1hGBBbzU0F', '1', '获取用户信息', '/user/getUserById', '5', '管廊app1', '127.0.0.1', '内网IP', 'GET', 'http://localhost/openapi/user/getUserById', 'http://192.168.8.132:8080/app/user/getUserById', '{\"id\":\"1\"}', '56', 'application/json;charset=UTF-8', '1', null, 'System', '2019-08-29 14:55:48', null, null, null);
INSERT INTO `api_request_record` VALUES ('20', '1hGBBbzU0F', '1', '获取用户信息', '/user/getUserById', '9', '管廊app2', '127.0.0.1', '内网IP', 'GET', 'http://localhost/openapi/user/getUserById', 'http://192.168.8.132:8080/app/user/getUserById', '{\"id\":\"1\"}', '32', 'application/json;charset=UTF-8', '1', null, 'System', '2019-08-29 14:59:06', null, null, null);
INSERT INTO `api_request_record` VALUES ('21', '1hGBBbzU0F', '1', '获取用户信息', '/user/getUserById', '5', '管廊app1', '127.0.0.1', '内网IP', 'GET', 'http://localhost/openapi/user/getUserById', 'http://192.168.8.132:8080/app/user/getUserById', '{\"id\":\"1\"}', '29', 'application/json;charset=UTF-8', '1', null, 'System', '2019-08-29 15:39:53', null, null, null);
INSERT INTO `api_request_record` VALUES ('22', '1hGBBbzU0F', '1', '获取用户信息', '/user/getUserById', '10', '管廊app3', '127.0.0.1', '内网IP', 'GET', 'http://localhost/openapi/user/getUserById', 'http://192.168.8.132:8080/app/user/getUserById', '{\"id\":\"1\"}', '25', 'application/json;charset=UTF-8', '1', null, 'System', '2019-08-29 15:41:54', null, null, null);

-- ----------------------------
-- Table structure for api_server
-- ----------------------------
DROP TABLE IF EXISTS `api_server`;
CREATE TABLE `api_server` (
  `server_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `server_name` varchar(255) NOT NULL COMMENT '服务名称',
  `server_code` varchar(255) NOT NULL COMMENT '服务编号',
  `server_domain` varchar(255) DEFAULT NULL COMMENT '服务域名/ip',
  `server_port` int(10) DEFAULT NULL COMMENT '服务地址头',
  `server_suffix` varchar(255) DEFAULT '' COMMENT '服务地址访问后缀',
  `server_url` varchar(255) DEFAULT NULL COMMENT '服务访问地址',
  `server_auto_check` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否自动检测可用性',
  `server_check_url` varchar(255) DEFAULT NULL COMMENT '服务检查地址',
  `server_live` tinyint(1) NOT NULL DEFAULT '1' COMMENT '服务是否可用',
  `server_group` bigint(20) DEFAULT NULL COMMENT '服务器组',
  `create_by` varchar(64) DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 DEFAULT NULL COMMENT '备注',
  `check_result_type` varchar(255) DEFAULT NULL COMMENT '检查结果类型，string或json',
  `check_type` varchar(255) DEFAULT NULL COMMENT '检查方式，string是包含和不包含，json是等于和不等于',
  `check_json_key` varchar(255) DEFAULT NULL COMMENT '检查结果是json时的key值',
  `check_value` varchar(255) DEFAULT NULL,
  `check_cycle_minute` int(11) DEFAULT NULL,
  `server_weight` int(11) NOT NULL DEFAULT '1' COMMENT '服务器权重，在多服务器的情况下，权重越高表示请求将优先或多发至权重高的服务器',
  PRIMARY KEY (`server_id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8 COMMENT='api服务';

-- ----------------------------
-- Records of api_server
-- ----------------------------
INSERT INTO `api_server` VALUES ('5', '管廊app1', 'guanlang_app1', 'http://192.168.8.132', '8080', '/app', 'http://192.168.8.132:8080/app', '0', null, '1', '3', '若依', '2019-08-08 16:49:38', '若依', '2019-08-28 13:41:15', '', null, null, null, null, null, '6');
INSERT INTO `api_server` VALUES ('6', '管廊web', 'guanlang_web', 'http://192.168.8.132', '8080', '/web', 'http://192.168.8.132:8080/web', '0', null, '1', '3', '若依', '2019-08-19 09:23:58', '', null, '', null, null, null, null, null, '1');
INSERT INTO `api_server` VALUES ('8', '管廊', 'guanlang', 'http://192.168.8.132', '8080', '', 'http://192.168.8.132:8080', '1', 'http://192.168.8.132:8080/app/user/getUserById?id=1', '1', '3', '若依', '2019-08-21 16:22:50', '若依', '2019-08-28 14:03:47', '', 'json', 'notContain', 'JSON.code', '200', '1', '1');
INSERT INTO `api_server` VALUES ('9', '管廊app2', 'guanlang_app2', 'http://192.168.8.132', '8080', '/app', 'http://192.168.8.132:8080/app', '0', null, '1', '3', '若依', '2019-08-08 16:49:38', '若依', '2019-08-28 13:38:38', '', null, null, null, null, null, '2');
INSERT INTO `api_server` VALUES ('10', '管廊app3', 'guanlang_app3', 'http://192.168.8.132', '8080', '/app', 'http://192.168.8.132:8080/app', '0', null, '1', '3', '若依', '2019-08-08 16:49:38', '若依', '2019-08-26 09:53:36', '', null, null, null, null, null, '2');
INSERT INTO `api_server` VALUES ('11', '本地', 'test', 'http://localhost', '80', '', 'http://localhost:80', '0', null, '1', null, '若依', '2019-08-26 17:09:21', '', null, '', null, null, null, null, null, '1');

-- ----------------------------
-- Table structure for api_server_group
-- ----------------------------
DROP TABLE IF EXISTS `api_server_group`;
CREATE TABLE `api_server_group` (
  `server_group_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `server_group_name` varchar(255) NOT NULL COMMENT '服务名称',
  `server_group_code` varchar(255) DEFAULT NULL COMMENT '服务编号',
  `create_by` varchar(64) DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`server_group_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COMMENT='api服务分组';

-- ----------------------------
-- Records of api_server_group
-- ----------------------------
INSERT INTO `api_server_group` VALUES ('3', '管廊', null, '若依', '2019-08-06 15:36:17', '若依', '2019-08-06 15:59:28', '两学一做22');

-- ----------------------------
-- Table structure for api_url
-- ----------------------------
DROP TABLE IF EXISTS `api_url`;
CREATE TABLE `api_url` (
  `api_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `api_name` varchar(255) DEFAULT NULL,
  `api_group_id` bigint(20) DEFAULT NULL,
  `api_request_method` varchar(255) DEFAULT NULL,
  `api_server_ids` varchar(20) NOT NULL COMMENT '后端服务，多个用英文,分隔',
  `api_url_suffix` varchar(255) NOT NULL COMMENT '访问地址',
  `api_server_url_suffix` varchar(255) DEFAULT NULL COMMENT '转发地址',
  `api_server_request_way` varchar(255) NOT NULL DEFAULT 'weight_round_robin' COMMENT '多服务器时，使用的负载均衡算法，默认是加权轮询(nginx采用)，round_robin/weight_round_robin/small_reponse_time',
  `create_by` varchar(64) DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`api_id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COMMENT='api开放接口';

-- ----------------------------
-- Records of api_url
-- ----------------------------
INSERT INTO `api_url` VALUES ('1', '获取用户信息', null, 'GET/POST', '5,9,10', '/user/getUserById', '/user/getUserById', 'weight_round_robin', null, null, '若依', '2019-08-26 09:49:58', '');
INSERT INTO `api_url` VALUES ('2', '获取消息列表', '3', 'POST', '6', '/message', '/message/list', 'weight_round_robin', '若依', '2019-08-19 09:24:43', '', null, '');
INSERT INTO `api_url` VALUES ('3', '转发', null, 'GET/POST', '5', '/app/*', '/*', 'weight_round_robin', null, null, '若依', '2019-08-21 15:09:47', '');
INSERT INTO `api_url` VALUES ('4', '转发2', null, 'GET/POST', '8', '/*', '/*', 'weight_round_robin', null, null, '若依', '2019-08-21 16:23:06', '');
INSERT INTO `api_url` VALUES ('5', '文件上传测试', null, 'GET/POST', '11', '/api/test/fileUpload', '/api/test/fileUpload', 'weight_round_robin', null, null, '若依', '2019-08-26 17:11:32', '');

-- ----------------------------
-- Table structure for api_url_param
-- ----------------------------
DROP TABLE IF EXISTS `api_url_param`;
CREATE TABLE `api_url_param` (
  `param_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `api_id` bigint(20) NOT NULL COMMENT 'api',
  `param_name` varchar(255) NOT NULL COMMENT '参数名称',
  `param_required` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否必填',
  `param_not_empty` tinyint(1) DEFAULT '0' COMMENT '不为空',
  `param_type` varchar(20) DEFAULT NULL COMMENT '参数类型，string,number,date,boolean,json,file,other',
  `param_check_regex` varchar(255) DEFAULT NULL COMMENT '正则表达式',
  `create_by` varchar(64) DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`param_id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8 COMMENT='api开放接口';

-- ----------------------------
-- Records of api_url_param
-- ----------------------------
INSERT INTO `api_url_param` VALUES ('3', '1', 'id', '1', null, 'number', '', null, null, '若依', '2019-08-21 10:20:29', '用户id');
INSERT INTO `api_url_param` VALUES ('4', '2', 'userId', '1', '0', 'number', '', '若依', '2019-08-19 09:24:59', '', null, '');
INSERT INTO `api_url_param` VALUES ('5', '2', 'beginTime', '0', '0', 'date', '', '若依', '2019-08-19 09:25:09', '', null, '');
INSERT INTO `api_url_param` VALUES ('6', '2', 'endTime', '0', '0', 'date', '', '若依', '2019-08-19 09:25:17', '', null, '');
INSERT INTO `api_url_param` VALUES ('7', '2', 'readStatus', '0', '0', 'number', '', '若依', '2019-08-19 09:25:32', '', null, '0未读，1已读');
INSERT INTO `api_url_param` VALUES ('8', '2', 'pageNum', '0', '0', 'number', '', '若依', '2019-08-19 09:25:48', '', null, '页码\r\n');
INSERT INTO `api_url_param` VALUES ('9', '2', 'pageSize', '0', '0', 'number', '', '若依', '2019-08-19 09:26:02', '', null, '页面大小\r\n');
INSERT INTO `api_url_param` VALUES ('10', '2', 'messageLevel', '0', '0', 'number', '', '若依', '2019-08-19 09:26:16', '', null, '1/2，2级报警(红色)>1级报警(黄色)');
INSERT INTO `api_url_param` VALUES ('11', '5', 'file', '1', '0', 'file', '', '若依', '2019-08-26 17:31:48', '', null, '');

-- ----------------------------
-- Table structure for qrtz_blob_triggers
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_blob_triggers`;
CREATE TABLE `qrtz_blob_triggers` (
  `sched_name` varchar(120) NOT NULL,
  `trigger_name` varchar(200) NOT NULL,
  `trigger_group` varchar(200) NOT NULL,
  `blob_data` blob,
  PRIMARY KEY (`sched_name`,`trigger_name`,`trigger_group`),
  CONSTRAINT `qrtz_blob_triggers_ibfk_1` FOREIGN KEY (`sched_name`, `trigger_name`, `trigger_group`) REFERENCES `qrtz_triggers` (`sched_name`, `trigger_name`, `trigger_group`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of qrtz_blob_triggers
-- ----------------------------

-- ----------------------------
-- Table structure for qrtz_calendars
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_calendars`;
CREATE TABLE `qrtz_calendars` (
  `sched_name` varchar(120) NOT NULL,
  `calendar_name` varchar(200) NOT NULL,
  `calendar` blob NOT NULL,
  PRIMARY KEY (`sched_name`,`calendar_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of qrtz_calendars
-- ----------------------------

-- ----------------------------
-- Table structure for qrtz_cron_triggers
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_cron_triggers`;
CREATE TABLE `qrtz_cron_triggers` (
  `sched_name` varchar(120) NOT NULL,
  `trigger_name` varchar(200) NOT NULL,
  `trigger_group` varchar(200) NOT NULL,
  `cron_expression` varchar(200) NOT NULL,
  `time_zone_id` varchar(80) DEFAULT NULL,
  PRIMARY KEY (`sched_name`,`trigger_name`,`trigger_group`),
  CONSTRAINT `qrtz_cron_triggers_ibfk_1` FOREIGN KEY (`sched_name`, `trigger_name`, `trigger_group`) REFERENCES `qrtz_triggers` (`sched_name`, `trigger_name`, `trigger_group`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of qrtz_cron_triggers
-- ----------------------------
INSERT INTO `qrtz_cron_triggers` VALUES ('RuoyiScheduler', 'TASK_CLASS_NAME1', 'DEFAULT', '0/10 * * * * ?', 'Asia/Shanghai');
INSERT INTO `qrtz_cron_triggers` VALUES ('RuoyiScheduler', 'TASK_CLASS_NAME2', 'DEFAULT', '0/15 * * * * ?', 'Asia/Shanghai');
INSERT INTO `qrtz_cron_triggers` VALUES ('RuoyiScheduler', 'TASK_CLASS_NAME27', 'API_SERVER_CHECK', '0 0/1 * * * ?', 'Asia/Shanghai');
INSERT INTO `qrtz_cron_triggers` VALUES ('RuoyiScheduler', 'TASK_CLASS_NAME3', 'DEFAULT', '0/20 * * * * ?', 'Asia/Shanghai');

-- ----------------------------
-- Table structure for qrtz_fired_triggers
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_fired_triggers`;
CREATE TABLE `qrtz_fired_triggers` (
  `sched_name` varchar(120) NOT NULL,
  `entry_id` varchar(95) NOT NULL,
  `trigger_name` varchar(200) NOT NULL,
  `trigger_group` varchar(200) NOT NULL,
  `instance_name` varchar(200) NOT NULL,
  `fired_time` bigint(13) NOT NULL,
  `sched_time` bigint(13) NOT NULL,
  `priority` int(11) NOT NULL,
  `state` varchar(16) NOT NULL,
  `job_name` varchar(200) DEFAULT NULL,
  `job_group` varchar(200) DEFAULT NULL,
  `is_nonconcurrent` varchar(1) DEFAULT NULL,
  `requests_recovery` varchar(1) DEFAULT NULL,
  PRIMARY KEY (`sched_name`,`entry_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of qrtz_fired_triggers
-- ----------------------------

-- ----------------------------
-- Table structure for qrtz_job_details
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_job_details`;
CREATE TABLE `qrtz_job_details` (
  `sched_name` varchar(120) NOT NULL,
  `job_name` varchar(200) NOT NULL,
  `job_group` varchar(200) NOT NULL,
  `description` varchar(250) DEFAULT NULL,
  `job_class_name` varchar(250) NOT NULL,
  `is_durable` varchar(1) NOT NULL,
  `is_nonconcurrent` varchar(1) NOT NULL,
  `is_update_data` varchar(1) NOT NULL,
  `requests_recovery` varchar(1) NOT NULL,
  `job_data` blob,
  PRIMARY KEY (`sched_name`,`job_name`,`job_group`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of qrtz_job_details
-- ----------------------------
INSERT INTO `qrtz_job_details` VALUES ('RuoyiScheduler', 'TASK_CLASS_NAME1', 'DEFAULT', null, 'com.ruoyi.project.monitor.job.util.QuartzDisallowConcurrentExecution', '0', '1', '0', '0', 0xACED0005737200156F72672E71756172747A2E4A6F62446174614D61709FB083E8BFA9B0CB020000787200266F72672E71756172747A2E7574696C732E537472696E674B65794469727479466C61674D61708208E8C3FBC55D280200015A0013616C6C6F77735472616E7369656E74446174617872001D6F72672E71756172747A2E7574696C732E4469727479466C61674D617013E62EAD28760ACE0200025A000564697274794C00036D617074000F4C6A6176612F7574696C2F4D61703B787001737200116A6176612E7574696C2E486173684D61700507DAC1C31660D103000246000A6C6F6164466163746F724900097468726573686F6C6478703F4000000000000C7708000000100000000174000F5441534B5F50524F5045525449455373720028636F6D2E72756F79692E70726F6A6563742E6D6F6E69746F722E6A6F622E646F6D61696E2E4A6F6200000000000000010200084C000A636F6E63757272656E747400124C6A6176612F6C616E672F537472696E673B4C000E63726F6E45787072657373696F6E71007E00094C000C696E766F6B6554617267657471007E00094C00086A6F6247726F757071007E00094C00056A6F6249647400104C6A6176612F6C616E672F4C6F6E673B4C00076A6F624E616D6571007E00094C000D6D697366697265506F6C69637971007E00094C000673746174757371007E000978720029636F6D2E72756F79692E6672616D65776F726B2E7765622E646F6D61696E2E42617365456E7469747900000000000000010200074C0008637265617465427971007E00094C000A63726561746554696D657400104C6A6176612F7574696C2F446174653B4C0006706172616D7371007E00034C000672656D61726B71007E00094C000B73656172636856616C756571007E00094C0008757064617465427971007E00094C000A75706461746554696D6571007E000C787074000561646D696E7372000E6A6176612E7574696C2E44617465686A81014B59741903000078707708000001622CDE29E078707400007070707400013174000E302F3130202A202A202A202A203F74001172795461736B2E72794E6F506172616D7374000744454641554C547372000E6A6176612E6C616E672E4C6F6E673B8BE490CC8F23DF0200014A000576616C7565787200106A6176612E6C616E672E4E756D62657286AC951D0B94E08B02000078700000000000000001740018E7B3BBE7BB9FE9BB98E8AEA4EFBC88E697A0E58F82EFBC8974000133740001317800);
INSERT INTO `qrtz_job_details` VALUES ('RuoyiScheduler', 'TASK_CLASS_NAME2', 'DEFAULT', null, 'com.ruoyi.project.monitor.job.util.QuartzDisallowConcurrentExecution', '0', '1', '0', '0', 0xACED0005737200156F72672E71756172747A2E4A6F62446174614D61709FB083E8BFA9B0CB020000787200266F72672E71756172747A2E7574696C732E537472696E674B65794469727479466C61674D61708208E8C3FBC55D280200015A0013616C6C6F77735472616E7369656E74446174617872001D6F72672E71756172747A2E7574696C732E4469727479466C61674D617013E62EAD28760ACE0200025A000564697274794C00036D617074000F4C6A6176612F7574696C2F4D61703B787001737200116A6176612E7574696C2E486173684D61700507DAC1C31660D103000246000A6C6F6164466163746F724900097468726573686F6C6478703F4000000000000C7708000000100000000174000F5441534B5F50524F5045525449455373720028636F6D2E72756F79692E70726F6A6563742E6D6F6E69746F722E6A6F622E646F6D61696E2E4A6F6200000000000000010200084C000A636F6E63757272656E747400124C6A6176612F6C616E672F537472696E673B4C000E63726F6E45787072657373696F6E71007E00094C000C696E766F6B6554617267657471007E00094C00086A6F6247726F757071007E00094C00056A6F6249647400104C6A6176612F6C616E672F4C6F6E673B4C00076A6F624E616D6571007E00094C000D6D697366697265506F6C69637971007E00094C000673746174757371007E000978720029636F6D2E72756F79692E6672616D65776F726B2E7765622E646F6D61696E2E42617365456E7469747900000000000000010200074C0008637265617465427971007E00094C000A63726561746554696D657400104C6A6176612F7574696C2F446174653B4C0006706172616D7371007E00034C000672656D61726B71007E00094C000B73656172636856616C756571007E00094C0008757064617465427971007E00094C000A75706461746554696D6571007E000C787074000561646D696E7372000E6A6176612E7574696C2E44617465686A81014B59741903000078707708000001622CDE29E078707400007070707400013174000E302F3135202A202A202A202A203F74001572795461736B2E7279506172616D7328277279272974000744454641554C547372000E6A6176612E6C616E672E4C6F6E673B8BE490CC8F23DF0200014A000576616C7565787200106A6176612E6C616E672E4E756D62657286AC951D0B94E08B02000078700000000000000002740018E7B3BBE7BB9FE9BB98E8AEA4EFBC88E69C89E58F82EFBC8974000133740001317800);
INSERT INTO `qrtz_job_details` VALUES ('RuoyiScheduler', 'TASK_CLASS_NAME27', 'API_SERVER_CHECK', null, 'com.ruoyi.project.monitor.job.util.QuartzDisallowConcurrentExecution', '0', '1', '0', '0', 0xACED0005737200156F72672E71756172747A2E4A6F62446174614D61709FB083E8BFA9B0CB020000787200266F72672E71756172747A2E7574696C732E537472696E674B65794469727479466C61674D61708208E8C3FBC55D280200015A0013616C6C6F77735472616E7369656E74446174617872001D6F72672E71756172747A2E7574696C732E4469727479466C61674D617013E62EAD28760ACE0200025A000564697274794C00036D617074000F4C6A6176612F7574696C2F4D61703B787001737200116A6176612E7574696C2E486173684D61700507DAC1C31660D103000246000A6C6F6164466163746F724900097468726573686F6C6478703F4000000000000C7708000000100000000174000F5441534B5F50524F5045525449455373720028636F6D2E72756F79692E70726F6A6563742E6D6F6E69746F722E6A6F622E646F6D61696E2E4A6F6200000000000000010200084C000A636F6E63757272656E747400124C6A6176612F6C616E672F537472696E673B4C000E63726F6E45787072657373696F6E71007E00094C000C696E766F6B6554617267657471007E00094C00086A6F6247726F757071007E00094C00056A6F6249647400104C6A6176612F6C616E672F4C6F6E673B4C00076A6F624E616D6571007E00094C000D6D697366697265506F6C69637971007E00094C000673746174757371007E000978720029636F6D2E72756F79692E6672616D65776F726B2E7765622E646F6D61696E2E42617365456E7469747900000000000000010200074C0008637265617465427971007E00094C000A63726561746554696D657400104C6A6176612F7574696C2F446174653B4C0006706172616D7371007E00034C000672656D61726B71007E00094C000B73656172636856616C756571007E00094C0008757064617465427971007E00094C000A75706461746554696D6571007E000C7870707070707070707400013174000D3020302F31202A202A202A203F740018617069536572766572436865636B2E636865636B28384C297400104150495F5345525645525F434845434B7372000E6A6176612E6C616E672E4C6F6E673B8BE490CC8F23DF0200014A000576616C7565787200106A6176612E6C616E672E4E756D62657286AC951D0B94E08B0200007870000000000000001B7400124150495F5345525645525F434845434B5F3871007E000E71007E000E7800);
INSERT INTO `qrtz_job_details` VALUES ('RuoyiScheduler', 'TASK_CLASS_NAME3', 'DEFAULT', null, 'com.ruoyi.project.monitor.job.util.QuartzDisallowConcurrentExecution', '0', '1', '0', '0', 0xACED0005737200156F72672E71756172747A2E4A6F62446174614D61709FB083E8BFA9B0CB020000787200266F72672E71756172747A2E7574696C732E537472696E674B65794469727479466C61674D61708208E8C3FBC55D280200015A0013616C6C6F77735472616E7369656E74446174617872001D6F72672E71756172747A2E7574696C732E4469727479466C61674D617013E62EAD28760ACE0200025A000564697274794C00036D617074000F4C6A6176612F7574696C2F4D61703B787001737200116A6176612E7574696C2E486173684D61700507DAC1C31660D103000246000A6C6F6164466163746F724900097468726573686F6C6478703F4000000000000C7708000000100000000174000F5441534B5F50524F5045525449455373720028636F6D2E72756F79692E70726F6A6563742E6D6F6E69746F722E6A6F622E646F6D61696E2E4A6F6200000000000000010200084C000A636F6E63757272656E747400124C6A6176612F6C616E672F537472696E673B4C000E63726F6E45787072657373696F6E71007E00094C000C696E766F6B6554617267657471007E00094C00086A6F6247726F757071007E00094C00056A6F6249647400104C6A6176612F6C616E672F4C6F6E673B4C00076A6F624E616D6571007E00094C000D6D697366697265506F6C69637971007E00094C000673746174757371007E000978720029636F6D2E72756F79692E6672616D65776F726B2E7765622E646F6D61696E2E42617365456E7469747900000000000000010200074C0008637265617465427971007E00094C000A63726561746554696D657400104C6A6176612F7574696C2F446174653B4C0006706172616D7371007E00034C000672656D61726B71007E00094C000B73656172636856616C756571007E00094C0008757064617465427971007E00094C000A75706461746554696D6571007E000C787074000561646D696E7372000E6A6176612E7574696C2E44617465686A81014B59741903000078707708000001622CDE29E078707400007070707400013174000E302F3230202A202A202A202A203F74003872795461736B2E72794D756C7469706C65506172616D7328277279272C20747275652C20323030304C2C203331362E3530442C203130302974000744454641554C547372000E6A6176612E6C616E672E4C6F6E673B8BE490CC8F23DF0200014A000576616C7565787200106A6176612E6C616E672E4E756D62657286AC951D0B94E08B02000078700000000000000003740018E7B3BBE7BB9FE9BB98E8AEA4EFBC88E5A49AE58F82EFBC8974000133740001317800);

-- ----------------------------
-- Table structure for qrtz_locks
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_locks`;
CREATE TABLE `qrtz_locks` (
  `sched_name` varchar(120) NOT NULL,
  `lock_name` varchar(40) NOT NULL,
  PRIMARY KEY (`sched_name`,`lock_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of qrtz_locks
-- ----------------------------
INSERT INTO `qrtz_locks` VALUES ('RuoyiScheduler', 'STATE_ACCESS');
INSERT INTO `qrtz_locks` VALUES ('RuoyiScheduler', 'TRIGGER_ACCESS');

-- ----------------------------
-- Table structure for qrtz_paused_trigger_grps
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_paused_trigger_grps`;
CREATE TABLE `qrtz_paused_trigger_grps` (
  `sched_name` varchar(120) NOT NULL,
  `trigger_group` varchar(200) NOT NULL,
  PRIMARY KEY (`sched_name`,`trigger_group`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of qrtz_paused_trigger_grps
-- ----------------------------

-- ----------------------------
-- Table structure for qrtz_scheduler_state
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_scheduler_state`;
CREATE TABLE `qrtz_scheduler_state` (
  `sched_name` varchar(120) NOT NULL,
  `instance_name` varchar(200) NOT NULL,
  `last_checkin_time` bigint(13) NOT NULL,
  `checkin_interval` bigint(13) NOT NULL,
  PRIMARY KEY (`sched_name`,`instance_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of qrtz_scheduler_state
-- ----------------------------
INSERT INTO `qrtz_scheduler_state` VALUES ('RuoyiScheduler', 'USER-20180709RE1567061100643', '1567066581559', '15000');

-- ----------------------------
-- Table structure for qrtz_simple_triggers
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_simple_triggers`;
CREATE TABLE `qrtz_simple_triggers` (
  `sched_name` varchar(120) NOT NULL,
  `trigger_name` varchar(200) NOT NULL,
  `trigger_group` varchar(200) NOT NULL,
  `repeat_count` bigint(7) NOT NULL,
  `repeat_interval` bigint(12) NOT NULL,
  `times_triggered` bigint(10) NOT NULL,
  PRIMARY KEY (`sched_name`,`trigger_name`,`trigger_group`),
  CONSTRAINT `qrtz_simple_triggers_ibfk_1` FOREIGN KEY (`sched_name`, `trigger_name`, `trigger_group`) REFERENCES `qrtz_triggers` (`sched_name`, `trigger_name`, `trigger_group`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of qrtz_simple_triggers
-- ----------------------------

-- ----------------------------
-- Table structure for qrtz_simprop_triggers
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_simprop_triggers`;
CREATE TABLE `qrtz_simprop_triggers` (
  `sched_name` varchar(120) NOT NULL,
  `trigger_name` varchar(200) NOT NULL,
  `trigger_group` varchar(200) NOT NULL,
  `str_prop_1` varchar(512) DEFAULT NULL,
  `str_prop_2` varchar(512) DEFAULT NULL,
  `str_prop_3` varchar(512) DEFAULT NULL,
  `int_prop_1` int(11) DEFAULT NULL,
  `int_prop_2` int(11) DEFAULT NULL,
  `long_prop_1` bigint(20) DEFAULT NULL,
  `long_prop_2` bigint(20) DEFAULT NULL,
  `dec_prop_1` decimal(13,4) DEFAULT NULL,
  `dec_prop_2` decimal(13,4) DEFAULT NULL,
  `bool_prop_1` varchar(1) DEFAULT NULL,
  `bool_prop_2` varchar(1) DEFAULT NULL,
  PRIMARY KEY (`sched_name`,`trigger_name`,`trigger_group`),
  CONSTRAINT `qrtz_simprop_triggers_ibfk_1` FOREIGN KEY (`sched_name`, `trigger_name`, `trigger_group`) REFERENCES `qrtz_triggers` (`sched_name`, `trigger_name`, `trigger_group`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of qrtz_simprop_triggers
-- ----------------------------

-- ----------------------------
-- Table structure for qrtz_triggers
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_triggers`;
CREATE TABLE `qrtz_triggers` (
  `sched_name` varchar(120) NOT NULL,
  `trigger_name` varchar(200) NOT NULL,
  `trigger_group` varchar(200) NOT NULL,
  `job_name` varchar(200) NOT NULL,
  `job_group` varchar(200) NOT NULL,
  `description` varchar(250) DEFAULT NULL,
  `next_fire_time` bigint(13) DEFAULT NULL,
  `prev_fire_time` bigint(13) DEFAULT NULL,
  `priority` int(11) DEFAULT NULL,
  `trigger_state` varchar(16) NOT NULL,
  `trigger_type` varchar(8) NOT NULL,
  `start_time` bigint(13) NOT NULL,
  `end_time` bigint(13) DEFAULT NULL,
  `calendar_name` varchar(200) DEFAULT NULL,
  `misfire_instr` smallint(2) DEFAULT NULL,
  `job_data` blob,
  PRIMARY KEY (`sched_name`,`trigger_name`,`trigger_group`),
  KEY `sched_name` (`sched_name`,`job_name`,`job_group`),
  CONSTRAINT `qrtz_triggers_ibfk_1` FOREIGN KEY (`sched_name`, `job_name`, `job_group`) REFERENCES `qrtz_job_details` (`sched_name`, `job_name`, `job_group`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of qrtz_triggers
-- ----------------------------
INSERT INTO `qrtz_triggers` VALUES ('RuoyiScheduler', 'TASK_CLASS_NAME1', 'DEFAULT', 'TASK_CLASS_NAME1', 'DEFAULT', null, '1567061100000', '-1', '5', 'PAUSED', 'CRON', '1567061100000', '0', null, '2', '');
INSERT INTO `qrtz_triggers` VALUES ('RuoyiScheduler', 'TASK_CLASS_NAME2', 'DEFAULT', 'TASK_CLASS_NAME2', 'DEFAULT', null, '1567061115000', '-1', '5', 'PAUSED', 'CRON', '1567061101000', '0', null, '2', '');
INSERT INTO `qrtz_triggers` VALUES ('RuoyiScheduler', 'TASK_CLASS_NAME27', 'API_SERVER_CHECK', 'TASK_CLASS_NAME27', 'API_SERVER_CHECK', null, '1567066620000', '1567066560000', '5', 'WAITING', 'CRON', '1567061105000', '0', null, '-1', '');
INSERT INTO `qrtz_triggers` VALUES ('RuoyiScheduler', 'TASK_CLASS_NAME3', 'DEFAULT', 'TASK_CLASS_NAME3', 'DEFAULT', null, '1567061120000', '-1', '5', 'PAUSED', 'CRON', '1567061101000', '0', null, '2', '');

-- ----------------------------
-- Table structure for sys_config
-- ----------------------------
DROP TABLE IF EXISTS `sys_config`;
CREATE TABLE `sys_config` (
  `config_id` int(5) NOT NULL AUTO_INCREMENT COMMENT '参数主键',
  `config_name` varchar(100) DEFAULT '' COMMENT '参数名称',
  `config_key` varchar(100) DEFAULT '' COMMENT '参数键名',
  `config_value` varchar(500) DEFAULT '' COMMENT '参数键值',
  `config_type` char(1) DEFAULT 'N' COMMENT '系统内置（Y是 N否）',
  `create_by` varchar(64) DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`config_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COMMENT='参数配置表';

-- ----------------------------
-- Records of sys_config
-- ----------------------------
INSERT INTO `sys_config` VALUES ('1', '主框架页-默认皮肤样式名称', 'sys.index.skinName', 'skin-blue', 'Y', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00', '蓝色 skin-blue、绿色 skin-green、紫色 skin-purple、红色 skin-red、黄色 skin-yellow');
INSERT INTO `sys_config` VALUES ('2', '用户管理-账号初始密码', 'sys.user.initPassword', '123456', 'Y', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00', '初始化密码 123456');
INSERT INTO `sys_config` VALUES ('3', '主框架页-侧边栏主题', 'sys.index.sideTheme', 'theme-dark', 'Y', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00', '深色主题theme-dark，浅色主题theme-light');

-- ----------------------------
-- Table structure for sys_dept
-- ----------------------------
DROP TABLE IF EXISTS `sys_dept`;
CREATE TABLE `sys_dept` (
  `dept_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '部门id',
  `parent_id` bigint(20) DEFAULT '0' COMMENT '父部门id',
  `ancestors` varchar(50) DEFAULT '' COMMENT '祖级列表',
  `dept_name` varchar(30) DEFAULT '' COMMENT '部门名称',
  `order_num` int(4) DEFAULT '0' COMMENT '显示顺序',
  `leader` varchar(20) DEFAULT NULL COMMENT '负责人',
  `phone` varchar(11) DEFAULT NULL COMMENT '联系电话',
  `email` varchar(50) DEFAULT NULL COMMENT '邮箱',
  `status` char(1) DEFAULT '0' COMMENT '部门状态（0正常 1停用）',
  `del_flag` char(1) DEFAULT '0' COMMENT '删除标志（0代表存在 2代表删除）',
  `create_by` varchar(64) DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`dept_id`)
) ENGINE=InnoDB AUTO_INCREMENT=110 DEFAULT CHARSET=utf8 COMMENT='部门表';

-- ----------------------------
-- Records of sys_dept
-- ----------------------------
INSERT INTO `sys_dept` VALUES ('100', '0', '0', '若依科技', '0', '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00');
INSERT INTO `sys_dept` VALUES ('101', '100', '0,100', '深圳总公司', '1', '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00');
INSERT INTO `sys_dept` VALUES ('102', '100', '0,100', '长沙分公司', '2', '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00');
INSERT INTO `sys_dept` VALUES ('103', '101', '0,100,101', '研发部门', '1', '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00');
INSERT INTO `sys_dept` VALUES ('104', '101', '0,100,101', '市场部门', '2', '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00');
INSERT INTO `sys_dept` VALUES ('105', '101', '0,100,101', '测试部门', '3', '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00');
INSERT INTO `sys_dept` VALUES ('106', '101', '0,100,101', '财务部门', '4', '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00');
INSERT INTO `sys_dept` VALUES ('107', '101', '0,100,101', '运维部门', '5', '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00');
INSERT INTO `sys_dept` VALUES ('108', '102', '0,100,102', '市场部门', '1', '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00');
INSERT INTO `sys_dept` VALUES ('109', '102', '0,100,102', '财务部门', '2', '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00');

-- ----------------------------
-- Table structure for sys_dict_data
-- ----------------------------
DROP TABLE IF EXISTS `sys_dict_data`;
CREATE TABLE `sys_dict_data` (
  `dict_code` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '字典编码',
  `dict_sort` int(4) DEFAULT '0' COMMENT '字典排序',
  `dict_label` varchar(100) DEFAULT '' COMMENT '字典标签',
  `dict_value` varchar(100) DEFAULT '' COMMENT '字典键值',
  `dict_type` varchar(100) DEFAULT '' COMMENT '字典类型',
  `css_class` varchar(100) DEFAULT NULL COMMENT '样式属性（其他样式扩展）',
  `list_class` varchar(100) DEFAULT NULL COMMENT '表格回显样式',
  `is_default` char(1) DEFAULT 'N' COMMENT '是否默认（Y是 N否）',
  `status` char(1) DEFAULT '0' COMMENT '状态（0正常 1停用）',
  `create_by` varchar(64) DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`dict_code`)
) ENGINE=InnoDB AUTO_INCREMENT=30 DEFAULT CHARSET=utf8 COMMENT='字典数据表';

-- ----------------------------
-- Records of sys_dict_data
-- ----------------------------
INSERT INTO `sys_dict_data` VALUES ('1', '1', '男', '0', 'sys_user_sex', '', '', 'Y', '0', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00', '性别男');
INSERT INTO `sys_dict_data` VALUES ('2', '2', '女', '1', 'sys_user_sex', '', '', 'N', '0', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00', '性别女');
INSERT INTO `sys_dict_data` VALUES ('3', '3', '未知', '2', 'sys_user_sex', '', '', 'N', '0', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00', '性别未知');
INSERT INTO `sys_dict_data` VALUES ('4', '1', '显示', '0', 'sys_show_hide', '', 'primary', 'Y', '0', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00', '显示菜单');
INSERT INTO `sys_dict_data` VALUES ('5', '2', '隐藏', '1', 'sys_show_hide', '', 'danger', 'N', '0', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00', '隐藏菜单');
INSERT INTO `sys_dict_data` VALUES ('6', '1', '正常', '0', 'sys_normal_disable', '', 'primary', 'Y', '0', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00', '正常状态');
INSERT INTO `sys_dict_data` VALUES ('7', '2', '停用', '1', 'sys_normal_disable', '', 'danger', 'N', '0', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00', '停用状态');
INSERT INTO `sys_dict_data` VALUES ('8', '1', '正常', '0', 'sys_job_status', '', 'primary', 'Y', '0', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00', '正常状态');
INSERT INTO `sys_dict_data` VALUES ('9', '2', '暂停', '1', 'sys_job_status', '', 'danger', 'N', '0', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00', '停用状态');
INSERT INTO `sys_dict_data` VALUES ('10', '1', '默认', 'DEFAULT', 'sys_job_group', '', '', 'Y', '0', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00', '默认分组');
INSERT INTO `sys_dict_data` VALUES ('11', '2', '系统', 'SYSTEM', 'sys_job_group', '', '', 'N', '0', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00', '系统分组');
INSERT INTO `sys_dict_data` VALUES ('12', '1', '是', 'Y', 'sys_yes_no', '', 'primary', 'Y', '0', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00', '系统默认是');
INSERT INTO `sys_dict_data` VALUES ('13', '2', '否', 'N', 'sys_yes_no', '', 'danger', 'N', '0', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00', '系统默认否');
INSERT INTO `sys_dict_data` VALUES ('14', '1', '通知', '1', 'sys_notice_type', '', 'warning', 'Y', '0', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00', '通知');
INSERT INTO `sys_dict_data` VALUES ('15', '2', '公告', '2', 'sys_notice_type', '', 'success', 'N', '0', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00', '公告');
INSERT INTO `sys_dict_data` VALUES ('16', '1', '正常', '0', 'sys_notice_status', '', 'primary', 'Y', '0', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00', '正常状态');
INSERT INTO `sys_dict_data` VALUES ('17', '2', '关闭', '1', 'sys_notice_status', '', 'danger', 'N', '0', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00', '关闭状态');
INSERT INTO `sys_dict_data` VALUES ('18', '1', '新增', '1', 'sys_oper_type', '', 'info', 'N', '0', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00', '新增操作');
INSERT INTO `sys_dict_data` VALUES ('19', '2', '修改', '2', 'sys_oper_type', '', 'info', 'N', '0', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00', '修改操作');
INSERT INTO `sys_dict_data` VALUES ('20', '3', '删除', '3', 'sys_oper_type', '', 'danger', 'N', '0', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00', '删除操作');
INSERT INTO `sys_dict_data` VALUES ('21', '4', '授权', '4', 'sys_oper_type', '', 'primary', 'N', '0', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00', '授权操作');
INSERT INTO `sys_dict_data` VALUES ('22', '5', '导出', '5', 'sys_oper_type', '', 'warning', 'N', '0', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00', '导出操作');
INSERT INTO `sys_dict_data` VALUES ('23', '6', '导入', '6', 'sys_oper_type', '', 'warning', 'N', '0', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00', '导入操作');
INSERT INTO `sys_dict_data` VALUES ('24', '7', '强退', '7', 'sys_oper_type', '', 'danger', 'N', '0', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00', '强退操作');
INSERT INTO `sys_dict_data` VALUES ('25', '8', '生成代码', '8', 'sys_oper_type', '', 'warning', 'N', '0', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00', '生成操作');
INSERT INTO `sys_dict_data` VALUES ('26', '9', '清空数据', '9', 'sys_oper_type', '', 'danger', 'N', '0', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00', '清空操作');
INSERT INTO `sys_dict_data` VALUES ('27', '1', '成功', '0', 'sys_common_status', '', 'primary', 'N', '0', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00', '正常状态');
INSERT INTO `sys_dict_data` VALUES ('28', '2', '失败', '1', 'sys_common_status', '', 'danger', 'N', '0', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00', '停用状态');
INSERT INTO `sys_dict_data` VALUES ('29', '3', 'API服务器检查', 'API_SERVER_CHECK', 'sys_job_group', null, null, 'Y', '0', 'admin', '2019-08-27 16:00:03', '', null, null);

-- ----------------------------
-- Table structure for sys_dict_type
-- ----------------------------
DROP TABLE IF EXISTS `sys_dict_type`;
CREATE TABLE `sys_dict_type` (
  `dict_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '字典主键',
  `dict_name` varchar(100) DEFAULT '' COMMENT '字典名称',
  `dict_type` varchar(100) DEFAULT '' COMMENT '字典类型',
  `status` char(1) DEFAULT '0' COMMENT '状态（0正常 1停用）',
  `create_by` varchar(64) DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`dict_id`),
  UNIQUE KEY `dict_type` (`dict_type`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8 COMMENT='字典类型表';

-- ----------------------------
-- Records of sys_dict_type
-- ----------------------------
INSERT INTO `sys_dict_type` VALUES ('1', '用户性别', 'sys_user_sex', '0', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00', '用户性别列表');
INSERT INTO `sys_dict_type` VALUES ('2', '菜单状态', 'sys_show_hide', '0', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00', '菜单状态列表');
INSERT INTO `sys_dict_type` VALUES ('3', '系统开关', 'sys_normal_disable', '0', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00', '系统开关列表');
INSERT INTO `sys_dict_type` VALUES ('4', '任务状态', 'sys_job_status', '0', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00', '任务状态列表');
INSERT INTO `sys_dict_type` VALUES ('5', '任务分组', 'sys_job_group', '0', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00', '任务分组列表');
INSERT INTO `sys_dict_type` VALUES ('6', '系统是否', 'sys_yes_no', '0', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00', '系统是否列表');
INSERT INTO `sys_dict_type` VALUES ('7', '通知类型', 'sys_notice_type', '0', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00', '通知类型列表');
INSERT INTO `sys_dict_type` VALUES ('8', '通知状态', 'sys_notice_status', '0', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00', '通知状态列表');
INSERT INTO `sys_dict_type` VALUES ('9', '操作类型', 'sys_oper_type', '0', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00', '操作类型列表');
INSERT INTO `sys_dict_type` VALUES ('10', '系统状态', 'sys_common_status', '0', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00', '登录状态列表');

-- ----------------------------
-- Table structure for sys_job
-- ----------------------------
DROP TABLE IF EXISTS `sys_job`;
CREATE TABLE `sys_job` (
  `job_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '任务ID',
  `job_name` varchar(64) NOT NULL DEFAULT '' COMMENT '任务名称',
  `job_group` varchar(64) NOT NULL DEFAULT 'DEFAULT' COMMENT '任务组名',
  `invoke_target` varchar(500) NOT NULL COMMENT '调用目标字符串',
  `cron_expression` varchar(255) DEFAULT '' COMMENT 'cron执行表达式',
  `misfire_policy` varchar(20) DEFAULT '3' COMMENT '计划执行错误策略（1立即执行 2执行一次 3放弃执行）',
  `concurrent` char(1) DEFAULT '1' COMMENT '是否并发执行（0允许 1禁止）',
  `status` char(1) DEFAULT '0' COMMENT '状态（0正常 1暂停）',
  `create_by` varchar(64) DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) DEFAULT '' COMMENT '备注信息',
  PRIMARY KEY (`job_id`,`job_name`,`job_group`)
) ENGINE=InnoDB AUTO_INCREMENT=28 DEFAULT CHARSET=utf8 COMMENT='定时任务调度表';

-- ----------------------------
-- Records of sys_job
-- ----------------------------
INSERT INTO `sys_job` VALUES ('1', '系统默认（无参）', 'DEFAULT', 'ryTask.ryNoParams', '0/10 * * * * ?', '3', '1', '1', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00', '');
INSERT INTO `sys_job` VALUES ('2', '系统默认（有参）', 'DEFAULT', 'ryTask.ryParams(\'ry\')', '0/15 * * * * ?', '3', '1', '1', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00', '');
INSERT INTO `sys_job` VALUES ('3', '系统默认（多参）', 'DEFAULT', 'ryTask.ryMultipleParams(\'ry\', true, 2000L, 316.50D, 100)', '0/20 * * * * ?', '3', '1', '1', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00', '');
INSERT INTO `sys_job` VALUES ('27', 'API_SERVER_CHECK_8', 'API_SERVER_CHECK', 'apiServerCheck.check(8L)', '0 0/1 * * * ?', '1', '1', '0', '', '2019-08-29 14:40:45', '', '2019-08-29 14:40:45', '');

-- ----------------------------
-- Table structure for sys_job_log
-- ----------------------------
DROP TABLE IF EXISTS `sys_job_log`;
CREATE TABLE `sys_job_log` (
  `job_log_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '任务日志ID',
  `job_name` varchar(64) NOT NULL COMMENT '任务名称',
  `job_group` varchar(64) NOT NULL COMMENT '任务组名',
  `invoke_target` varchar(500) NOT NULL COMMENT '调用目标字符串',
  `job_message` varchar(500) DEFAULT NULL COMMENT '日志信息',
  `status` char(1) DEFAULT '0' COMMENT '执行状态（0正常 1失败）',
  `exception_info` varchar(2000) DEFAULT '' COMMENT '异常信息',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`job_log_id`)
) ENGINE=InnoDB AUTO_INCREMENT=480 DEFAULT CHARSET=utf8 COMMENT='定时任务调度日志表';

-- ----------------------------
-- Records of sys_job_log
-- ----------------------------
INSERT INTO `sys_job_log` VALUES ('1', 'API_SERVER_CHECK_8', 'API_SERVER_CHECK', 'apiServerCheck.check(8L)', 'API_SERVER_CHECK_8 总共耗时：19620毫秒', '0', '', '2019-08-28 13:54:51');
INSERT INTO `sys_job_log` VALUES ('2', 'API_SERVER_CHECK_8', 'API_SERVER_CHECK', 'apiServerCheck.check(8L)', 'API_SERVER_CHECK_8 总共耗时：17244毫秒', '0', '', '2019-08-28 13:55:21');
INSERT INTO `sys_job_log` VALUES ('3', 'API_SERVER_CHECK_8', 'API_SERVER_CHECK', 'apiServerCheck.check(8L)', 'API_SERVER_CHECK_8 总共耗时：19887毫秒', '0', '', '2019-08-28 13:57:01');
INSERT INTO `sys_job_log` VALUES ('4', 'API_SERVER_CHECK_8', 'API_SERVER_CHECK', 'apiServerCheck.check(8L)', 'API_SERVER_CHECK_8 总共耗时：12296毫秒', '0', '', '2019-08-28 13:57:20');
INSERT INTO `sys_job_log` VALUES ('5', 'API_SERVER_CHECK_8', 'API_SERVER_CHECK', 'apiServerCheck.check(8L)', 'API_SERVER_CHECK_8 总共耗时：12782毫秒', '1', 'java.lang.reflect.InvocationTargetException\r\n	at sun.reflect.NativeMethodAccessorImpl.invoke0(Native Method)\r\n	at sun.reflect.NativeMethodAccessorImpl.invoke(NativeMethodAccessorImpl.java:62)\r\n	at sun.reflect.DelegatingMethodAccessorImpl.invoke(DelegatingMethodAccessorImpl.java:43)\r\n	at java.lang.reflect.Method.invoke(Method.java:498)\r\n	at com.ruoyi.project.monitor.job.util.JobInvokeUtil.invokeMethod(JobInvokeUtil.java:56)\r\n	at com.ruoyi.project.monitor.job.util.JobInvokeUtil.invokeMethod(JobInvokeUtil.java:33)\r\n	at com.ruoyi.project.monitor.job.util.QuartzDisallowConcurrentExecution.doExecute(QuartzDisallowConcurrentExecution.java:19)\r\n	at com.ruoyi.project.monitor.job.util.AbstractQuartzJob.execute(AbstractQuartzJob.java:42)\r\n	at org.quartz.core.JobRunShell.run(JobRunShell.java:202)\r\n	at org.quartz.simpl.SimpleThreadPool$WorkerThread.run(SimpleThreadPool.java:573)\r\nCaused by: org.apache.shiro.UnavailableSecurityManagerException: No SecurityManager accessible to the calling code, either bound to the org.apache.shiro.util.ThreadContext or as a vm static singleton.  This is an invalid application configuration.\r\n	at org.apache.shiro.SecurityUtils.getSecurityManager(SecurityUtils.java:123)\r\n	at org.apache.shiro.subject.Subject$Builder.<init>(Subject.java:626)\r\n	at org.apache.shiro.SecurityUtils.getSubject(SecurityUtils.java:56)\r\n	at com.ruoyi.common.utils.security.ShiroUtils.getSubject(ShiroUtils.java:23)\r\n	at com.ruoyi.common.utils.security.ShiroUtils.getSysUser(ShiroUtils.java:39)\r\n	at com.ruoyi.common.base.service.impl.XmlBaseServiceImpl.updateByPrimaryKeySelective(XmlBaseServiceImpl.java:79)\r\n	at com.ruoyi.project.api.task.ApiServerCheck.serverDown(ApiServerCheck.java:101)\r\n	at com.ruoyi.project.api.task.ApiServerCheck.check(ApiServerCheck.java:47)\r\n	... 10 more\r\n', '2019-08-28 13:58:12');
INSERT INTO `sys_job_log` VALUES ('6', 'API_SERVER_CHECK_8', 'API_SERVER_CHECK', 'apiServerCheck.check(8L)', 'API_SERVER_CHECK_8 总共耗时：5143毫秒', '0', '', '2019-08-28 13:58:22');
INSERT INTO `sys_job_log` VALUES ('7', 'API_SERVER_CHECK_8', 'API_SERVER_CHECK', 'apiServerCheck.check(8L)', 'API_SERVER_CHECK_8 总共耗时：7577毫秒', '0', '', '2019-08-28 13:59:45');
INSERT INTO `sys_job_log` VALUES ('8', 'API_SERVER_CHECK_8', 'API_SERVER_CHECK', 'apiServerCheck.check(8L)', 'API_SERVER_CHECK_8 总共耗时：115毫秒', '0', '', '2019-08-28 15:19:41');
INSERT INTO `sys_job_log` VALUES ('9', 'API_SERVER_CHECK_8', 'API_SERVER_CHECK', 'apiServerCheck.check(8L)', 'API_SERVER_CHECK_8 总共耗时：25毫秒', '0', '', '2019-08-28 15:20:41');
INSERT INTO `sys_job_log` VALUES ('10', 'API_SERVER_CHECK_8', 'API_SERVER_CHECK', 'apiServerCheck.check(8L)', 'API_SERVER_CHECK_8 总共耗时：13毫秒', '0', '', '2019-08-28 15:21:41');
INSERT INTO `sys_job_log` VALUES ('11', 'API_SERVER_CHECK_8', 'API_SERVER_CHECK', 'apiServerCheck.check(8L)', 'API_SERVER_CHECK_8 总共耗时：14毫秒', '0', '', '2019-08-28 15:22:41');
INSERT INTO `sys_job_log` VALUES ('12', 'API_SERVER_CHECK_8', 'API_SERVER_CHECK', 'apiServerCheck.check(8L)', 'API_SERVER_CHECK_8 总共耗时：102毫秒', '0', '', '2019-08-28 15:25:41');
INSERT INTO `sys_job_log` VALUES ('13', 'API_SERVER_CHECK_8', 'API_SERVER_CHECK', 'apiServerCheck.check(8L)', 'API_SERVER_CHECK_8 总共耗时：18毫秒', '0', '', '2019-08-28 15:26:41');
INSERT INTO `sys_job_log` VALUES ('14', 'API_SERVER_CHECK_8', 'API_SERVER_CHECK', 'apiServerCheck.check(8L)', 'API_SERVER_CHECK_8 总共耗时：12毫秒', '0', '', '2019-08-28 15:27:41');
INSERT INTO `sys_job_log` VALUES ('15', 'API_SERVER_CHECK_8', 'API_SERVER_CHECK', 'apiServerCheck.check(8L)', 'API_SERVER_CHECK_8 总共耗时：15毫秒', '0', '', '2019-08-28 15:28:41');
INSERT INTO `sys_job_log` VALUES ('16', 'API_SERVER_CHECK_8', 'API_SERVER_CHECK', 'apiServerCheck.check(8L)', 'API_SERVER_CHECK_8 总共耗时：13毫秒', '0', '', '2019-08-28 15:29:41');
INSERT INTO `sys_job_log` VALUES ('17', 'API_SERVER_CHECK_8', 'API_SERVER_CHECK', 'apiServerCheck.check(8L)', 'API_SERVER_CHECK_8 总共耗时：12毫秒', '0', '', '2019-08-28 15:30:41');
INSERT INTO `sys_job_log` VALUES ('18', 'API_SERVER_CHECK_8', 'API_SERVER_CHECK', 'apiServerCheck.check(8L)', 'API_SERVER_CHECK_8 总共耗时：16毫秒', '0', '', '2019-08-28 15:31:41');
INSERT INTO `sys_job_log` VALUES ('19', 'API_SERVER_CHECK_8', 'API_SERVER_CHECK', 'apiServerCheck.check(8L)', 'API_SERVER_CHECK_8 总共耗时：12毫秒', '0', '', '2019-08-28 15:32:41');
INSERT INTO `sys_job_log` VALUES ('20', 'API_SERVER_CHECK_8', 'API_SERVER_CHECK', 'apiServerCheck.check(8L)', 'API_SERVER_CHECK_8 总共耗时：13毫秒', '0', '', '2019-08-28 15:33:41');
INSERT INTO `sys_job_log` VALUES ('21', 'API_SERVER_CHECK_8', 'API_SERVER_CHECK', 'apiServerCheck.check(8L)', 'API_SERVER_CHECK_8 总共耗时：16毫秒', '0', '', '2019-08-28 15:34:41');
INSERT INTO `sys_job_log` VALUES ('22', 'API_SERVER_CHECK_8', 'API_SERVER_CHECK', 'apiServerCheck.check(8L)', 'API_SERVER_CHECK_8 总共耗时：12毫秒', '0', '', '2019-08-28 15:35:41');
INSERT INTO `sys_job_log` VALUES ('23', 'API_SERVER_CHECK_8', 'API_SERVER_CHECK', 'apiServerCheck.check(8L)', 'API_SERVER_CHECK_8 总共耗时：11毫秒', '0', '', '2019-08-28 15:36:41');
INSERT INTO `sys_job_log` VALUES ('24', 'API_SERVER_CHECK_8', 'API_SERVER_CHECK', 'apiServerCheck.check(8L)', 'API_SERVER_CHECK_8 总共耗时：14毫秒', '0', '', '2019-08-28 15:37:41');
INSERT INTO `sys_job_log` VALUES ('25', 'API_SERVER_CHECK_8', 'API_SERVER_CHECK', 'apiServerCheck.check(8L)', 'API_SERVER_CHECK_8 总共耗时：14毫秒', '0', '', '2019-08-28 15:38:41');
INSERT INTO `sys_job_log` VALUES ('26', 'API_SERVER_CHECK_8', 'API_SERVER_CHECK', 'apiServerCheck.check(8L)', 'API_SERVER_CHECK_8 总共耗时：14毫秒', '0', '', '2019-08-28 15:39:41');
INSERT INTO `sys_job_log` VALUES ('27', 'API_SERVER_CHECK_8', 'API_SERVER_CHECK', 'apiServerCheck.check(8L)', 'API_SERVER_CHECK_8 总共耗时：12毫秒', '0', '', '2019-08-28 15:40:41');
INSERT INTO `sys_job_log` VALUES ('28', 'API_SERVER_CHECK_8', 'API_SERVER_CHECK', 'apiServerCheck.check(8L)', 'API_SERVER_CHECK_8 总共耗时：15毫秒', '0', '', '2019-08-28 15:41:41');
INSERT INTO `sys_job_log` VALUES ('29', 'API_SERVER_CHECK_8', 'API_SERVER_CHECK', 'apiServerCheck.check(8L)', 'API_SERVER_CHECK_8 总共耗时：13毫秒', '0', '', '2019-08-28 15:42:41');
INSERT INTO `sys_job_log` VALUES ('30', 'API_SERVER_CHECK_8', 'API_SERVER_CHECK', 'apiServerCheck.check(8L)', 'API_SERVER_CHECK_8 总共耗时：12毫秒', '0', '', '2019-08-28 15:43:41');
INSERT INTO `sys_job_log` VALUES ('31', 'API_SERVER_CHECK_8', 'API_SERVER_CHECK', 'apiServerCheck.check(8L)', 'API_SERVER_CHECK_8 总共耗时：12毫秒', '0', '', '2019-08-28 15:44:41');
INSERT INTO `sys_job_log` VALUES ('32', 'API_SERVER_CHECK_8', 'API_SERVER_CHECK', 'apiServerCheck.check(8L)', 'API_SERVER_CHECK_8 总共耗时：12毫秒', '0', '', '2019-08-28 15:45:41');
INSERT INTO `sys_job_log` VALUES ('33', 'API_SERVER_CHECK_8', 'API_SERVER_CHECK', 'apiServerCheck.check(8L)', 'API_SERVER_CHECK_8 总共耗时：11毫秒', '0', '', '2019-08-28 15:46:41');
INSERT INTO `sys_job_log` VALUES ('34', 'API_SERVER_CHECK_8', 'API_SERVER_CHECK', 'apiServerCheck.check(8L)', 'API_SERVER_CHECK_8 总共耗时：12毫秒', '0', '', '2019-08-28 15:47:41');
INSERT INTO `sys_job_log` VALUES ('35', 'API_SERVER_CHECK_8', 'API_SERVER_CHECK', 'apiServerCheck.check(8L)', 'API_SERVER_CHECK_8 总共耗时：14毫秒', '0', '', '2019-08-28 15:48:41');
INSERT INTO `sys_job_log` VALUES ('36', 'API_SERVER_CHECK_8', 'API_SERVER_CHECK', 'apiServerCheck.check(8L)', 'API_SERVER_CHECK_8 总共耗时：12毫秒', '0', '', '2019-08-28 15:49:41');
INSERT INTO `sys_job_log` VALUES ('37', 'API_SERVER_CHECK_8', 'API_SERVER_CHECK', 'apiServerCheck.check(8L)', 'API_SERVER_CHECK_8 总共耗时：12毫秒', '0', '', '2019-08-28 15:50:41');
INSERT INTO `sys_job_log` VALUES ('38', 'API_SERVER_CHECK_8', 'API_SERVER_CHECK', 'apiServerCheck.check(8L)', 'API_SERVER_CHECK_8 总共耗时：11毫秒', '0', '', '2019-08-28 15:51:41');
INSERT INTO `sys_job_log` VALUES ('39', 'API_SERVER_CHECK_8', 'API_SERVER_CHECK', 'apiServerCheck.check(8L)', 'API_SERVER_CHECK_8 总共耗时：15毫秒', '0', '', '2019-08-28 15:52:41');
INSERT INTO `sys_job_log` VALUES ('40', 'API_SERVER_CHECK_8', 'API_SERVER_CHECK', 'apiServerCheck.check(8L)', 'API_SERVER_CHECK_8 总共耗时：12毫秒', '0', '', '2019-08-28 15:53:41');
INSERT INTO `sys_job_log` VALUES ('41', 'API_SERVER_CHECK_8', 'API_SERVER_CHECK', 'apiServerCheck.check(8L)', 'API_SERVER_CHECK_8 总共耗时：13毫秒', '0', '', '2019-08-28 15:54:41');
INSERT INTO `sys_job_log` VALUES ('42', 'API_SERVER_CHECK_8', 'API_SERVER_CHECK', 'apiServerCheck.check(8L)', 'API_SERVER_CHECK_8 总共耗时：12毫秒', '0', '', '2019-08-28 15:55:41');
INSERT INTO `sys_job_log` VALUES ('43', 'API_SERVER_CHECK_8', 'API_SERVER_CHECK', 'apiServerCheck.check(8L)', 'API_SERVER_CHECK_8 总共耗时：13毫秒', '0', '', '2019-08-28 15:56:41');
INSERT INTO `sys_job_log` VALUES ('44', 'API_SERVER_CHECK_8', 'API_SERVER_CHECK', 'apiServerCheck.check(8L)', 'API_SERVER_CHECK_8 总共耗时：15毫秒', '0', '', '2019-08-28 15:57:41');
INSERT INTO `sys_job_log` VALUES ('45', 'API_SERVER_CHECK_8', 'API_SERVER_CHECK', 'apiServerCheck.check(8L)', 'API_SERVER_CHECK_8 总共耗时：11毫秒', '0', '', '2019-08-28 15:58:41');
INSERT INTO `sys_job_log` VALUES ('46', 'API_SERVER_CHECK_8', 'API_SERVER_CHECK', 'apiServerCheck.check(8L)', 'API_SERVER_CHECK_8 总共耗时：15毫秒', '0', '', '2019-08-28 15:59:41');
INSERT INTO `sys_job_log` VALUES ('47', 'API_SERVER_CHECK_8', 'API_SERVER_CHECK', 'apiServerCheck.check(8L)', 'API_SERVER_CHECK_8 总共耗时：12毫秒', '0', '', '2019-08-28 16:00:41');
INSERT INTO `sys_job_log` VALUES ('48', 'API_SERVER_CHECK_8', 'API_SERVER_CHECK', 'apiServerCheck.check(8L)', 'API_SERVER_CHECK_8 总共耗时：13毫秒', '0', '', '2019-08-28 16:01:41');
INSERT INTO `sys_job_log` VALUES ('49', 'API_SERVER_CHECK_8', 'API_SERVER_CHECK', 'apiServerCheck.check(8L)', 'API_SERVER_CHECK_8 总共耗时：12毫秒', '0', '', '2019-08-28 16:02:41');
INSERT INTO `sys_job_log` VALUES ('50', 'API_SERVER_CHECK_8', 'API_SERVER_CHECK', 'apiServerCheck.check(8L)', 'API_SERVER_CHECK_8 总共耗时：12毫秒', '0', '', '2019-08-28 16:03:41');
INSERT INTO `sys_job_log` VALUES ('51', 'API_SERVER_CHECK_8', 'API_SERVER_CHECK', 'apiServerCheck.check(8L)', 'API_SERVER_CHECK_8 总共耗时：11毫秒', '0', '', '2019-08-28 16:04:41');
INSERT INTO `sys_job_log` VALUES ('52', 'API_SERVER_CHECK_8', 'API_SERVER_CHECK', 'apiServerCheck.check(8L)', 'API_SERVER_CHECK_8 总共耗时：109毫秒', '0', '', '2019-08-28 16:07:41');
INSERT INTO `sys_job_log` VALUES ('53', 'API_SERVER_CHECK_8', 'API_SERVER_CHECK', 'apiServerCheck.check(8L)', 'API_SERVER_CHECK_8 总共耗时：23毫秒', '0', '', '2019-08-28 16:08:41');
INSERT INTO `sys_job_log` VALUES ('54', 'API_SERVER_CHECK_8', 'API_SERVER_CHECK', 'apiServerCheck.check(8L)', 'API_SERVER_CHECK_8 总共耗时：12毫秒', '0', '', '2019-08-28 16:09:41');
INSERT INTO `sys_job_log` VALUES ('55', 'API_SERVER_CHECK_8', 'API_SERVER_CHECK', 'apiServerCheck.check(8L)', 'API_SERVER_CHECK_8 总共耗时：14毫秒', '0', '', '2019-08-28 16:10:41');
INSERT INTO `sys_job_log` VALUES ('56', 'API_SERVER_CHECK_8', 'API_SERVER_CHECK', 'apiServerCheck.check(8L)', 'API_SERVER_CHECK_8 总共耗时：14毫秒', '0', '', '2019-08-28 16:11:41');
INSERT INTO `sys_job_log` VALUES ('57', 'API_SERVER_CHECK_8', 'API_SERVER_CHECK', 'apiServerCheck.check(8L)', 'API_SERVER_CHECK_8 总共耗时：15毫秒', '0', '', '2019-08-28 16:12:41');
INSERT INTO `sys_job_log` VALUES ('58', 'API_SERVER_CHECK_8', 'API_SERVER_CHECK', 'apiServerCheck.check(8L)', 'API_SERVER_CHECK_8 总共耗时：15毫秒', '0', '', '2019-08-28 16:13:41');
INSERT INTO `sys_job_log` VALUES ('59', 'API_SERVER_CHECK_8', 'API_SERVER_CHECK', 'apiServerCheck.check(8L)', 'API_SERVER_CHECK_8 总共耗时：13毫秒', '0', '', '2019-08-28 16:14:41');
INSERT INTO `sys_job_log` VALUES ('60', 'API_SERVER_CHECK_8', 'API_SERVER_CHECK', 'apiServerCheck.check(8L)', 'API_SERVER_CHECK_8 总共耗时：14毫秒', '0', '', '2019-08-28 16:15:41');
INSERT INTO `sys_job_log` VALUES ('61', 'API_SERVER_CHECK_8', 'API_SERVER_CHECK', 'apiServerCheck.check(8L)', 'API_SERVER_CHECK_8 总共耗时：15毫秒', '0', '', '2019-08-28 16:16:41');
INSERT INTO `sys_job_log` VALUES ('62', 'API_SERVER_CHECK_8', 'API_SERVER_CHECK', 'apiServerCheck.check(8L)', 'API_SERVER_CHECK_8 总共耗时：12毫秒', '0', '', '2019-08-28 16:17:41');
INSERT INTO `sys_job_log` VALUES ('63', 'API_SERVER_CHECK_8', 'API_SERVER_CHECK', 'apiServerCheck.check(8L)', 'API_SERVER_CHECK_8 总共耗时：13毫秒', '0', '', '2019-08-28 16:18:41');
INSERT INTO `sys_job_log` VALUES ('64', 'API_SERVER_CHECK_8', 'API_SERVER_CHECK', 'apiServerCheck.check(8L)', 'API_SERVER_CHECK_8 总共耗时：14毫秒', '0', '', '2019-08-28 16:19:41');
INSERT INTO `sys_job_log` VALUES ('65', 'API_SERVER_CHECK_8', 'API_SERVER_CHECK', 'apiServerCheck.check(8L)', 'API_SERVER_CHECK_8 总共耗时：13毫秒', '0', '', '2019-08-28 16:20:41');
INSERT INTO `sys_job_log` VALUES ('66', 'API_SERVER_CHECK_8', 'API_SERVER_CHECK', 'apiServerCheck.check(8L)', 'API_SERVER_CHECK_8 总共耗时：15毫秒', '0', '', '2019-08-28 16:21:41');
INSERT INTO `sys_job_log` VALUES ('67', 'API_SERVER_CHECK_8', 'API_SERVER_CHECK', 'apiServerCheck.check(8L)', 'API_SERVER_CHECK_8 总共耗时：14毫秒', '0', '', '2019-08-28 16:22:41');
INSERT INTO `sys_job_log` VALUES ('68', 'API_SERVER_CHECK_8', 'API_SERVER_CHECK', 'apiServerCheck.check(8L)', 'API_SERVER_CHECK_8 总共耗时：14毫秒', '0', '', '2019-08-28 16:23:41');
INSERT INTO `sys_job_log` VALUES ('69', 'API_SERVER_CHECK_8', 'API_SERVER_CHECK', 'apiServerCheck.check(8L)', 'API_SERVER_CHECK_8 总共耗时：13毫秒', '0', '', '2019-08-28 16:24:41');
INSERT INTO `sys_job_log` VALUES ('70', 'API_SERVER_CHECK_8', 'API_SERVER_CHECK', 'apiServerCheck.check(8L)', 'API_SERVER_CHECK_8 总共耗时：13毫秒', '0', '', '2019-08-28 16:25:41');
INSERT INTO `sys_job_log` VALUES ('71', 'API_SERVER_CHECK_8', 'API_SERVER_CHECK', 'apiServerCheck.check(8L)', 'API_SERVER_CHECK_8 总共耗时：13毫秒', '0', '', '2019-08-28 16:26:41');
INSERT INTO `sys_job_log` VALUES ('72', 'API_SERVER_CHECK_8', 'API_SERVER_CHECK', 'apiServerCheck.check(8L)', 'API_SERVER_CHECK_8 总共耗时：12毫秒', '0', '', '2019-08-28 16:27:41');
INSERT INTO `sys_job_log` VALUES ('73', 'API_SERVER_CHECK_8', 'API_SERVER_CHECK', 'apiServerCheck.check(8L)', 'API_SERVER_CHECK_8 总共耗时：12毫秒', '0', '', '2019-08-28 16:28:41');
INSERT INTO `sys_job_log` VALUES ('74', 'API_SERVER_CHECK_8', 'API_SERVER_CHECK', 'apiServerCheck.check(8L)', 'API_SERVER_CHECK_8 总共耗时：12毫秒', '0', '', '2019-08-28 16:29:41');
INSERT INTO `sys_job_log` VALUES ('75', 'API_SERVER_CHECK_8', 'API_SERVER_CHECK', 'apiServerCheck.check(8L)', 'API_SERVER_CHECK_8 总共耗时：15毫秒', '0', '', '2019-08-28 16:30:41');
INSERT INTO `sys_job_log` VALUES ('76', 'API_SERVER_CHECK_8', 'API_SERVER_CHECK', 'apiServerCheck.check(8L)', 'API_SERVER_CHECK_8 总共耗时：13毫秒', '0', '', '2019-08-28 16:31:41');
INSERT INTO `sys_job_log` VALUES ('77', 'API_SERVER_CHECK_8', 'API_SERVER_CHECK', 'apiServerCheck.check(8L)', 'API_SERVER_CHECK_8 总共耗时：12毫秒', '0', '', '2019-08-28 16:32:41');
INSERT INTO `sys_job_log` VALUES ('78', 'API_SERVER_CHECK_8', 'API_SERVER_CHECK', 'apiServerCheck.check(8L)', 'API_SERVER_CHECK_8 总共耗时：12毫秒', '0', '', '2019-08-28 16:33:41');
INSERT INTO `sys_job_log` VALUES ('79', 'API_SERVER_CHECK_8', 'API_SERVER_CHECK', 'apiServerCheck.check(8L)', 'API_SERVER_CHECK_8 总共耗时：11毫秒', '0', '', '2019-08-28 16:34:41');
INSERT INTO `sys_job_log` VALUES ('80', 'API_SERVER_CHECK_8', 'API_SERVER_CHECK', 'apiServerCheck.check(8L)', 'API_SERVER_CHECK_8 总共耗时：13毫秒', '0', '', '2019-08-28 16:35:41');
INSERT INTO `sys_job_log` VALUES ('81', 'API_SERVER_CHECK_8', 'API_SERVER_CHECK', 'apiServerCheck.check(8L)', 'API_SERVER_CHECK_8 总共耗时：15毫秒', '0', '', '2019-08-28 16:36:41');
INSERT INTO `sys_job_log` VALUES ('82', 'API_SERVER_CHECK_8', 'API_SERVER_CHECK', 'apiServerCheck.check(8L)', 'API_SERVER_CHECK_8 总共耗时：14毫秒', '0', '', '2019-08-28 16:37:41');
INSERT INTO `sys_job_log` VALUES ('83', 'API_SERVER_CHECK_8', 'API_SERVER_CHECK', 'apiServerCheck.check(8L)', 'API_SERVER_CHECK_8 总共耗时：13毫秒', '0', '', '2019-08-28 16:38:41');
INSERT INTO `sys_job_log` VALUES ('84', 'API_SERVER_CHECK_8', 'API_SERVER_CHECK', 'apiServerCheck.check(8L)', 'API_SERVER_CHECK_8 总共耗时：14毫秒', '0', '', '2019-08-28 16:39:41');
INSERT INTO `sys_job_log` VALUES ('85', 'API_SERVER_CHECK_8', 'API_SERVER_CHECK', 'apiServerCheck.check(8L)', 'API_SERVER_CHECK_8 总共耗时：10毫秒', '0', '', '2019-08-28 16:40:41');
INSERT INTO `sys_job_log` VALUES ('86', 'API_SERVER_CHECK_8', 'API_SERVER_CHECK', 'apiServerCheck.check(8L)', 'API_SERVER_CHECK_8 总共耗时：17毫秒', '0', '', '2019-08-28 16:41:41');
INSERT INTO `sys_job_log` VALUES ('87', 'API_SERVER_CHECK_8', 'API_SERVER_CHECK', 'apiServerCheck.check(8L)', 'API_SERVER_CHECK_8 总共耗时：11毫秒', '0', '', '2019-08-28 16:42:41');
INSERT INTO `sys_job_log` VALUES ('88', 'API_SERVER_CHECK_8', 'API_SERVER_CHECK', 'apiServerCheck.check(8L)', 'API_SERVER_CHECK_8 总共耗时：100毫秒', '0', '', '2019-08-28 17:01:41');
INSERT INTO `sys_job_log` VALUES ('89', 'API_SERVER_CHECK_8', 'API_SERVER_CHECK', 'apiServerCheck.check(8L)', 'API_SERVER_CHECK_8 总共耗时：19毫秒', '0', '', '2019-08-28 17:02:41');
INSERT INTO `sys_job_log` VALUES ('90', 'API_SERVER_CHECK_8', 'API_SERVER_CHECK', 'apiServerCheck.check(8L)', 'API_SERVER_CHECK_8 总共耗时：16毫秒', '0', '', '2019-08-28 17:03:41');
INSERT INTO `sys_job_log` VALUES ('91', 'API_SERVER_CHECK_8', 'API_SERVER_CHECK', 'apiServerCheck.check(8L)', 'API_SERVER_CHECK_8 总共耗时：12毫秒', '0', '', '2019-08-28 17:04:41');
INSERT INTO `sys_job_log` VALUES ('92', 'API_SERVER_CHECK_8', 'API_SERVER_CHECK', 'apiServerCheck.check(8L)', 'API_SERVER_CHECK_8 总共耗时：12毫秒', '0', '', '2019-08-28 17:05:41');
INSERT INTO `sys_job_log` VALUES ('93', 'API_SERVER_CHECK_8', 'API_SERVER_CHECK', 'apiServerCheck.check(8L)', 'API_SERVER_CHECK_8 总共耗时：12毫秒', '0', '', '2019-08-28 17:06:41');
INSERT INTO `sys_job_log` VALUES ('94', 'API_SERVER_CHECK_8', 'API_SERVER_CHECK', 'apiServerCheck.check(8L)', 'API_SERVER_CHECK_8 总共耗时：12毫秒', '0', '', '2019-08-28 17:07:41');
INSERT INTO `sys_job_log` VALUES ('95', 'API_SERVER_CHECK_8', 'API_SERVER_CHECK', 'apiServerCheck.check(8L)', 'API_SERVER_CHECK_8 总共耗时：13毫秒', '0', '', '2019-08-28 17:08:41');
INSERT INTO `sys_job_log` VALUES ('96', 'API_SERVER_CHECK_8', 'API_SERVER_CHECK', 'apiServerCheck.check(8L)', 'API_SERVER_CHECK_8 总共耗时：12毫秒', '0', '', '2019-08-28 17:09:41');
INSERT INTO `sys_job_log` VALUES ('97', 'API_SERVER_CHECK_8', 'API_SERVER_CHECK', 'apiServerCheck.check(8L)', 'API_SERVER_CHECK_8 总共耗时：13毫秒', '0', '', '2019-08-28 17:10:41');
INSERT INTO `sys_job_log` VALUES ('98', 'API_SERVER_CHECK_8', 'API_SERVER_CHECK', 'apiServerCheck.check(8L)', 'API_SERVER_CHECK_8 总共耗时：17毫秒', '0', '', '2019-08-28 17:11:41');
INSERT INTO `sys_job_log` VALUES ('99', 'API_SERVER_CHECK_8', 'API_SERVER_CHECK', 'apiServerCheck.check(8L)', 'API_SERVER_CHECK_8 总共耗时：12毫秒', '0', '', '2019-08-28 17:12:41');
INSERT INTO `sys_job_log` VALUES ('100', 'API_SERVER_CHECK_8', 'API_SERVER_CHECK', 'apiServerCheck.check(8L)', 'API_SERVER_CHECK_8 总共耗时：15毫秒', '0', '', '2019-08-28 17:13:41');
INSERT INTO `sys_job_log` VALUES ('101', 'API_SERVER_CHECK_8', 'API_SERVER_CHECK', 'apiServerCheck.check(8L)', 'API_SERVER_CHECK_8 总共耗时：15毫秒', '0', '', '2019-08-28 17:14:41');
INSERT INTO `sys_job_log` VALUES ('102', 'API_SERVER_CHECK_8', 'API_SERVER_CHECK', 'apiServerCheck.check(8L)', 'API_SERVER_CHECK_8 总共耗时：14毫秒', '0', '', '2019-08-28 17:15:41');
INSERT INTO `sys_job_log` VALUES ('103', 'API_SERVER_CHECK_8', 'API_SERVER_CHECK', 'apiServerCheck.check(8L)', 'API_SERVER_CHECK_8 总共耗时：12毫秒', '0', '', '2019-08-28 17:16:41');
INSERT INTO `sys_job_log` VALUES ('104', 'API_SERVER_CHECK_8', 'API_SERVER_CHECK', 'apiServerCheck.check(8L)', 'API_SERVER_CHECK_8 总共耗时：13毫秒', '0', '', '2019-08-28 17:17:41');
INSERT INTO `sys_job_log` VALUES ('105', 'API_SERVER_CHECK_8', 'API_SERVER_CHECK', 'apiServerCheck.check(8L)', 'API_SERVER_CHECK_8 总共耗时：13毫秒', '0', '', '2019-08-28 17:18:41');
INSERT INTO `sys_job_log` VALUES ('106', 'API_SERVER_CHECK_8', 'API_SERVER_CHECK', 'apiServerCheck.check(8L)', 'API_SERVER_CHECK_8 总共耗时：11毫秒', '0', '', '2019-08-28 17:19:41');
INSERT INTO `sys_job_log` VALUES ('107', 'API_SERVER_CHECK_8', 'API_SERVER_CHECK', 'apiServerCheck.check(8L)', 'API_SERVER_CHECK_8 总共耗时：11毫秒', '0', '', '2019-08-28 17:20:41');
INSERT INTO `sys_job_log` VALUES ('108', 'API_SERVER_CHECK_8', 'API_SERVER_CHECK', 'apiServerCheck.check(8L)', 'API_SERVER_CHECK_8 总共耗时：12毫秒', '0', '', '2019-08-28 17:21:41');
INSERT INTO `sys_job_log` VALUES ('109', 'API_SERVER_CHECK_8', 'API_SERVER_CHECK', 'apiServerCheck.check(8L)', 'API_SERVER_CHECK_8 总共耗时：12毫秒', '0', '', '2019-08-28 17:22:41');
INSERT INTO `sys_job_log` VALUES ('110', 'API_SERVER_CHECK_8', 'API_SERVER_CHECK', 'apiServerCheck.check(8L)', 'API_SERVER_CHECK_8 总共耗时：12毫秒', '0', '', '2019-08-28 17:23:41');
INSERT INTO `sys_job_log` VALUES ('111', 'API_SERVER_CHECK_8', 'API_SERVER_CHECK', 'apiServerCheck.check(8L)', 'API_SERVER_CHECK_8 总共耗时：12毫秒', '0', '', '2019-08-28 17:24:41');
INSERT INTO `sys_job_log` VALUES ('112', 'API_SERVER_CHECK_8', 'API_SERVER_CHECK', 'apiServerCheck.check(8L)', 'API_SERVER_CHECK_8 总共耗时：14毫秒', '0', '', '2019-08-28 17:25:41');
INSERT INTO `sys_job_log` VALUES ('113', 'API_SERVER_CHECK_8', 'API_SERVER_CHECK', 'apiServerCheck.check(8L)', 'API_SERVER_CHECK_8 总共耗时：13毫秒', '0', '', '2019-08-28 17:26:41');
INSERT INTO `sys_job_log` VALUES ('114', 'API_SERVER_CHECK_8', 'API_SERVER_CHECK', 'apiServerCheck.check(8L)', 'API_SERVER_CHECK_8 总共耗时：108毫秒', '0', '', '2019-08-29 09:44:40');
INSERT INTO `sys_job_log` VALUES ('115', 'API_SERVER_CHECK_8', 'API_SERVER_CHECK', 'apiServerCheck.check(8L)', 'API_SERVER_CHECK_8 总共耗时：21毫秒', '0', '', '2019-08-29 09:45:40');
INSERT INTO `sys_job_log` VALUES ('116', 'API_SERVER_CHECK_8', 'API_SERVER_CHECK', 'apiServerCheck.check(8L)', 'API_SERVER_CHECK_8 总共耗时：16毫秒', '0', '', '2019-08-29 09:46:40');
INSERT INTO `sys_job_log` VALUES ('117', 'API_SERVER_CHECK_8', 'API_SERVER_CHECK', 'apiServerCheck.check(8L)', 'API_SERVER_CHECK_8 总共耗时：14毫秒', '0', '', '2019-08-29 09:47:40');
INSERT INTO `sys_job_log` VALUES ('118', 'API_SERVER_CHECK_8', 'API_SERVER_CHECK', 'apiServerCheck.check(8L)', 'API_SERVER_CHECK_8 总共耗时：19毫秒', '0', '', '2019-08-29 09:48:40');
INSERT INTO `sys_job_log` VALUES ('119', 'API_SERVER_CHECK_8', 'API_SERVER_CHECK', 'apiServerCheck.check(8L)', 'API_SERVER_CHECK_8 总共耗时：23毫秒', '0', '', '2019-08-29 09:49:40');
INSERT INTO `sys_job_log` VALUES ('120', 'API_SERVER_CHECK_8', 'API_SERVER_CHECK', 'apiServerCheck.check(8L)', 'API_SERVER_CHECK_8 总共耗时：14毫秒', '0', '', '2019-08-29 09:50:40');
INSERT INTO `sys_job_log` VALUES ('121', 'API_SERVER_CHECK_8', 'API_SERVER_CHECK', 'apiServerCheck.check(8L)', 'API_SERVER_CHECK_8 总共耗时：12毫秒', '0', '', '2019-08-29 09:51:40');
INSERT INTO `sys_job_log` VALUES ('122', 'API_SERVER_CHECK_8', 'API_SERVER_CHECK', 'apiServerCheck.check(8L)', 'API_SERVER_CHECK_8 总共耗时：13毫秒', '0', '', '2019-08-29 09:52:40');
INSERT INTO `sys_job_log` VALUES ('123', 'API_SERVER_CHECK_8', 'API_SERVER_CHECK', 'apiServerCheck.check(8L)', 'API_SERVER_CHECK_8 总共耗时：14毫秒', '0', '', '2019-08-29 09:53:40');
INSERT INTO `sys_job_log` VALUES ('124', 'API_SERVER_CHECK_8', 'API_SERVER_CHECK', 'apiServerCheck.check(8L)', 'API_SERVER_CHECK_8 总共耗时：15毫秒', '0', '', '2019-08-29 09:54:40');
INSERT INTO `sys_job_log` VALUES ('125', 'API_SERVER_CHECK_8', 'API_SERVER_CHECK', 'apiServerCheck.check(8L)', 'API_SERVER_CHECK_8 总共耗时：14毫秒', '0', '', '2019-08-29 09:55:40');
INSERT INTO `sys_job_log` VALUES ('126', 'API_SERVER_CHECK_8', 'API_SERVER_CHECK', 'apiServerCheck.check(8L)', 'API_SERVER_CHECK_8 总共耗时：13毫秒', '0', '', '2019-08-29 09:56:40');
INSERT INTO `sys_job_log` VALUES ('127', 'API_SERVER_CHECK_8', 'API_SERVER_CHECK', 'apiServerCheck.check(8L)', 'API_SERVER_CHECK_8 总共耗时：13毫秒', '0', '', '2019-08-29 09:57:40');
INSERT INTO `sys_job_log` VALUES ('128', 'API_SERVER_CHECK_8', 'API_SERVER_CHECK', 'apiServerCheck.check(8L)', 'API_SERVER_CHECK_8 总共耗时：14毫秒', '0', '', '2019-08-29 09:58:40');
INSERT INTO `sys_job_log` VALUES ('129', 'API_SERVER_CHECK_8', 'API_SERVER_CHECK', 'apiServerCheck.check(8L)', 'API_SERVER_CHECK_8 总共耗时：17毫秒', '0', '', '2019-08-29 09:59:40');
INSERT INTO `sys_job_log` VALUES ('130', 'API_SERVER_CHECK_8', 'API_SERVER_CHECK', 'apiServerCheck.check(8L)', 'API_SERVER_CHECK_8 总共耗时：14毫秒', '0', '', '2019-08-29 10:00:40');
INSERT INTO `sys_job_log` VALUES ('131', 'API_SERVER_CHECK_8', 'API_SERVER_CHECK', 'apiServerCheck.check(8L)', 'API_SERVER_CHECK_8 总共耗时：103毫秒', '0', '', '2019-08-29 10:01:40');
INSERT INTO `sys_job_log` VALUES ('132', 'API_SERVER_CHECK_8', 'API_SERVER_CHECK', 'apiServerCheck.check(8L)', 'API_SERVER_CHECK_8 总共耗时：23毫秒', '0', '', '2019-08-29 10:02:40');
INSERT INTO `sys_job_log` VALUES ('133', 'API_SERVER_CHECK_8', 'API_SERVER_CHECK', 'apiServerCheck.check(8L)', 'API_SERVER_CHECK_8 总共耗时：14毫秒', '0', '', '2019-08-29 10:03:40');
INSERT INTO `sys_job_log` VALUES ('134', 'API_SERVER_CHECK_8', 'API_SERVER_CHECK', 'apiServerCheck.check(8L)', 'API_SERVER_CHECK_8 总共耗时：13毫秒', '0', '', '2019-08-29 10:04:40');
INSERT INTO `sys_job_log` VALUES ('135', 'API_SERVER_CHECK_8', 'API_SERVER_CHECK', 'apiServerCheck.check(8L)', 'API_SERVER_CHECK_8 总共耗时：19毫秒', '0', '', '2019-08-29 10:05:40');
INSERT INTO `sys_job_log` VALUES ('136', 'API_SERVER_CHECK_8', 'API_SERVER_CHECK', 'apiServerCheck.check(8L)', 'API_SERVER_CHECK_8 总共耗时：13毫秒', '0', '', '2019-08-29 10:06:40');
INSERT INTO `sys_job_log` VALUES ('137', 'API_SERVER_CHECK_8', 'API_SERVER_CHECK', 'apiServerCheck.check(8L)', 'API_SERVER_CHECK_8 总共耗时：13毫秒', '0', '', '2019-08-29 10:07:40');
INSERT INTO `sys_job_log` VALUES ('138', 'API_SERVER_CHECK_8', 'API_SERVER_CHECK', 'apiServerCheck.check(8L)', 'API_SERVER_CHECK_8 总共耗时：16毫秒', '0', '', '2019-08-29 10:08:40');
INSERT INTO `sys_job_log` VALUES ('139', 'API_SERVER_CHECK_8', 'API_SERVER_CHECK', 'apiServerCheck.check(8L)', 'API_SERVER_CHECK_8 总共耗时：15毫秒', '0', '', '2019-08-29 10:09:40');
INSERT INTO `sys_job_log` VALUES ('140', 'API_SERVER_CHECK_8', 'API_SERVER_CHECK', 'apiServerCheck.check(8L)', 'API_SERVER_CHECK_8 总共耗时：13毫秒', '0', '', '2019-08-29 10:10:40');
INSERT INTO `sys_job_log` VALUES ('141', 'API_SERVER_CHECK_8', 'API_SERVER_CHECK', 'apiServerCheck.check(8L)', 'API_SERVER_CHECK_8 总共耗时：16毫秒', '0', '', '2019-08-29 10:11:40');
INSERT INTO `sys_job_log` VALUES ('142', 'API_SERVER_CHECK_8', 'API_SERVER_CHECK', 'apiServerCheck.check(8L)', 'API_SERVER_CHECK_8 总共耗时：13毫秒', '0', '', '2019-08-29 10:12:40');
INSERT INTO `sys_job_log` VALUES ('143', 'API_SERVER_CHECK_8', 'API_SERVER_CHECK', 'apiServerCheck.check(8L)', 'API_SERVER_CHECK_8 总共耗时：12毫秒', '0', '', '2019-08-29 10:13:40');
INSERT INTO `sys_job_log` VALUES ('144', 'API_SERVER_CHECK_8', 'API_SERVER_CHECK', 'apiServerCheck.check(8L)', 'API_SERVER_CHECK_8 总共耗时：14毫秒', '0', '', '2019-08-29 10:14:40');
INSERT INTO `sys_job_log` VALUES ('145', 'API_SERVER_CHECK_8', 'API_SERVER_CHECK', 'apiServerCheck.check(8L)', 'API_SERVER_CHECK_8 总共耗时：15毫秒', '0', '', '2019-08-29 10:15:40');
INSERT INTO `sys_job_log` VALUES ('146', 'API_SERVER_CHECK_8', 'API_SERVER_CHECK', 'apiServerCheck.check(8L)', 'API_SERVER_CHECK_8 总共耗时：17毫秒', '0', '', '2019-08-29 10:16:40');
INSERT INTO `sys_job_log` VALUES ('147', 'API_SERVER_CHECK_8', 'API_SERVER_CHECK', 'apiServerCheck.check(8L)', 'API_SERVER_CHECK_8 总共耗时：12毫秒', '0', '', '2019-08-29 10:17:40');
INSERT INTO `sys_job_log` VALUES ('148', 'API_SERVER_CHECK_8', 'API_SERVER_CHECK', 'apiServerCheck.check(8L)', 'API_SERVER_CHECK_8 总共耗时：14毫秒', '0', '', '2019-08-29 10:18:40');
INSERT INTO `sys_job_log` VALUES ('149', 'API_SERVER_CHECK_8', 'API_SERVER_CHECK', 'apiServerCheck.check(8L)', 'API_SERVER_CHECK_8 总共耗时：12毫秒', '0', '', '2019-08-29 10:19:40');
INSERT INTO `sys_job_log` VALUES ('150', 'API_SERVER_CHECK_8', 'API_SERVER_CHECK', 'apiServerCheck.check(8L)', 'API_SERVER_CHECK_8 总共耗时：12毫秒', '0', '', '2019-08-29 10:20:40');
INSERT INTO `sys_job_log` VALUES ('151', 'API_SERVER_CHECK_8', 'API_SERVER_CHECK', 'apiServerCheck.check(8L)', 'API_SERVER_CHECK_8 总共耗时：13毫秒', '0', '', '2019-08-29 10:21:40');
INSERT INTO `sys_job_log` VALUES ('152', 'API_SERVER_CHECK_8', 'API_SERVER_CHECK', 'apiServerCheck.check(8L)', 'API_SERVER_CHECK_8 总共耗时：13毫秒', '0', '', '2019-08-29 10:22:40');
INSERT INTO `sys_job_log` VALUES ('153', 'API_SERVER_CHECK_8', 'API_SERVER_CHECK', 'apiServerCheck.check(8L)', 'API_SERVER_CHECK_8 总共耗时：13毫秒', '0', '', '2019-08-29 10:23:40');
INSERT INTO `sys_job_log` VALUES ('154', 'API_SERVER_CHECK_8', 'API_SERVER_CHECK', 'apiServerCheck.check(8L)', 'API_SERVER_CHECK_8 总共耗时：13毫秒', '0', '', '2019-08-29 10:24:40');
INSERT INTO `sys_job_log` VALUES ('155', 'API_SERVER_CHECK_8', 'API_SERVER_CHECK', 'apiServerCheck.check(8L)', 'API_SERVER_CHECK_8 总共耗时：11毫秒', '0', '', '2019-08-29 10:25:40');
INSERT INTO `sys_job_log` VALUES ('156', 'API_SERVER_CHECK_8', 'API_SERVER_CHECK', 'apiServerCheck.check(8L)', 'API_SERVER_CHECK_8 总共耗时：16毫秒', '0', '', '2019-08-29 10:26:40');
INSERT INTO `sys_job_log` VALUES ('157', 'API_SERVER_CHECK_8', 'API_SERVER_CHECK', 'apiServerCheck.check(8L)', 'API_SERVER_CHECK_8 总共耗时：22毫秒', '0', '', '2019-08-29 10:27:40');
INSERT INTO `sys_job_log` VALUES ('158', 'API_SERVER_CHECK_8', 'API_SERVER_CHECK', 'apiServerCheck.check(8L)', 'API_SERVER_CHECK_8 总共耗时：15毫秒', '0', '', '2019-08-29 10:28:40');
INSERT INTO `sys_job_log` VALUES ('159', 'API_SERVER_CHECK_8', 'API_SERVER_CHECK', 'apiServerCheck.check(8L)', 'API_SERVER_CHECK_8 总共耗时：15毫秒', '0', '', '2019-08-29 10:29:40');
INSERT INTO `sys_job_log` VALUES ('160', 'API_SERVER_CHECK_8', 'API_SERVER_CHECK', 'apiServerCheck.check(8L)', 'API_SERVER_CHECK_8 总共耗时：12毫秒', '0', '', '2019-08-29 10:30:40');
INSERT INTO `sys_job_log` VALUES ('161', 'API_SERVER_CHECK_8', 'API_SERVER_CHECK', 'apiServerCheck.check(8L)', 'API_SERVER_CHECK_8 总共耗时：15毫秒', '0', '', '2019-08-29 10:31:40');
INSERT INTO `sys_job_log` VALUES ('162', 'API_SERVER_CHECK_8', 'API_SERVER_CHECK', 'apiServerCheck.check(8L)', 'API_SERVER_CHECK_8 总共耗时：14毫秒', '0', '', '2019-08-29 10:32:40');
INSERT INTO `sys_job_log` VALUES ('163', 'API_SERVER_CHECK_8', 'API_SERVER_CHECK', 'apiServerCheck.check(8L)', 'API_SERVER_CHECK_8 总共耗时：121毫秒', '0', '', '2019-08-29 10:47:40');
INSERT INTO `sys_job_log` VALUES ('164', 'API_SERVER_CHECK_8', 'API_SERVER_CHECK', 'apiServerCheck.check(8L)', 'API_SERVER_CHECK_8 总共耗时：22毫秒', '0', '', '2019-08-29 10:48:40');
INSERT INTO `sys_job_log` VALUES ('165', 'API_SERVER_CHECK_8', 'API_SERVER_CHECK', 'apiServerCheck.check(8L)', 'API_SERVER_CHECK_8 总共耗时：14毫秒', '0', '', '2019-08-29 10:49:40');
INSERT INTO `sys_job_log` VALUES ('166', 'API_SERVER_CHECK_8', 'API_SERVER_CHECK', 'apiServerCheck.check(8L)', 'API_SERVER_CHECK_8 总共耗时：13毫秒', '0', '', '2019-08-29 10:50:40');
INSERT INTO `sys_job_log` VALUES ('167', 'API_SERVER_CHECK_8', 'API_SERVER_CHECK', 'apiServerCheck.check(8L)', 'API_SERVER_CHECK_8 总共耗时：12毫秒', '0', '', '2019-08-29 10:51:40');
INSERT INTO `sys_job_log` VALUES ('168', 'API_SERVER_CHECK_8', 'API_SERVER_CHECK', 'apiServerCheck.check(8L)', 'API_SERVER_CHECK_8 总共耗时：100毫秒', '0', '', '2019-08-29 10:55:40');
INSERT INTO `sys_job_log` VALUES ('169', 'API_SERVER_CHECK_8', 'API_SERVER_CHECK', 'apiServerCheck.check(8L)', 'API_SERVER_CHECK_8 总共耗时：22毫秒', '0', '', '2019-08-29 10:56:40');
INSERT INTO `sys_job_log` VALUES ('170', 'API_SERVER_CHECK_8', 'API_SERVER_CHECK', 'apiServerCheck.check(8L)', 'API_SERVER_CHECK_8 总共耗时：14毫秒', '0', '', '2019-08-29 10:57:40');
INSERT INTO `sys_job_log` VALUES ('171', 'API_SERVER_CHECK_8', 'API_SERVER_CHECK', 'apiServerCheck.check(8L)', 'API_SERVER_CHECK_8 总共耗时：15毫秒', '0', '', '2019-08-29 10:58:40');
INSERT INTO `sys_job_log` VALUES ('172', 'API_SERVER_CHECK_8', 'API_SERVER_CHECK', 'apiServerCheck.check(8L)', 'API_SERVER_CHECK_8 总共耗时：13毫秒', '0', '', '2019-08-29 10:59:40');
INSERT INTO `sys_job_log` VALUES ('173', 'API_SERVER_CHECK_8', 'API_SERVER_CHECK', 'apiServerCheck.check(8L)', 'API_SERVER_CHECK_8 总共耗时：13毫秒', '0', '', '2019-08-29 11:00:40');
INSERT INTO `sys_job_log` VALUES ('174', 'API_SERVER_CHECK_8', 'API_SERVER_CHECK', 'apiServerCheck.check(8L)', 'API_SERVER_CHECK_8 总共耗时：13毫秒', '0', '', '2019-08-29 11:01:40');
INSERT INTO `sys_job_log` VALUES ('175', 'API_SERVER_CHECK_8', 'API_SERVER_CHECK', 'apiServerCheck.check(8L)', 'API_SERVER_CHECK_8 总共耗时：13毫秒', '0', '', '2019-08-29 11:02:40');
INSERT INTO `sys_job_log` VALUES ('176', 'API_SERVER_CHECK_8', 'API_SERVER_CHECK', 'apiServerCheck.check(8L)', 'API_SERVER_CHECK_8 总共耗时：15毫秒', '0', '', '2019-08-29 11:03:40');
INSERT INTO `sys_job_log` VALUES ('177', 'API_SERVER_CHECK_8', 'API_SERVER_CHECK', 'apiServerCheck.check(8L)', 'API_SERVER_CHECK_8 总共耗时：17毫秒', '0', '', '2019-08-29 11:04:40');
INSERT INTO `sys_job_log` VALUES ('178', 'API_SERVER_CHECK_8', 'API_SERVER_CHECK', 'apiServerCheck.check(8L)', 'API_SERVER_CHECK_8 总共耗时：21毫秒', '0', '', '2019-08-29 11:05:40');
INSERT INTO `sys_job_log` VALUES ('179', 'API_SERVER_CHECK_8', 'API_SERVER_CHECK', 'apiServerCheck.check(8L)', 'API_SERVER_CHECK_8 总共耗时：15毫秒', '0', '', '2019-08-29 11:06:40');
INSERT INTO `sys_job_log` VALUES ('180', 'API_SERVER_CHECK_8', 'API_SERVER_CHECK', 'apiServerCheck.check(8L)', 'API_SERVER_CHECK_8 总共耗时：12毫秒', '0', '', '2019-08-29 11:07:40');
INSERT INTO `sys_job_log` VALUES ('181', 'API_SERVER_CHECK_8', 'API_SERVER_CHECK', 'apiServerCheck.check(8L)', 'API_SERVER_CHECK_8 总共耗时：14毫秒', '0', '', '2019-08-29 11:08:40');
INSERT INTO `sys_job_log` VALUES ('182', 'API_SERVER_CHECK_8', 'API_SERVER_CHECK', 'apiServerCheck.check(8L)', 'API_SERVER_CHECK_8 总共耗时：13毫秒', '0', '', '2019-08-29 11:09:40');
INSERT INTO `sys_job_log` VALUES ('183', 'API_SERVER_CHECK_8', 'API_SERVER_CHECK', 'apiServerCheck.check(8L)', 'API_SERVER_CHECK_8 总共耗时：14毫秒', '0', '', '2019-08-29 11:10:40');
INSERT INTO `sys_job_log` VALUES ('184', 'API_SERVER_CHECK_8', 'API_SERVER_CHECK', 'apiServerCheck.check(8L)', 'API_SERVER_CHECK_8 总共耗时：14毫秒', '0', '', '2019-08-29 11:11:40');
INSERT INTO `sys_job_log` VALUES ('185', 'API_SERVER_CHECK_8', 'API_SERVER_CHECK', 'apiServerCheck.check(8L)', 'API_SERVER_CHECK_8 总共耗时：15毫秒', '0', '', '2019-08-29 11:12:40');
INSERT INTO `sys_job_log` VALUES ('186', 'API_SERVER_CHECK_8', 'API_SERVER_CHECK', 'apiServerCheck.check(8L)', 'API_SERVER_CHECK_8 总共耗时：16毫秒', '0', '', '2019-08-29 11:13:40');
INSERT INTO `sys_job_log` VALUES ('187', 'API_SERVER_CHECK_8', 'API_SERVER_CHECK', 'apiServerCheck.check(8L)', 'API_SERVER_CHECK_8 总共耗时：15毫秒', '0', '', '2019-08-29 11:14:40');
INSERT INTO `sys_job_log` VALUES ('188', 'API_SERVER_CHECK_8', 'API_SERVER_CHECK', 'apiServerCheck.check(8L)', 'API_SERVER_CHECK_8 总共耗时：15毫秒', '0', '', '2019-08-29 11:15:40');
INSERT INTO `sys_job_log` VALUES ('189', 'API_SERVER_CHECK_8', 'API_SERVER_CHECK', 'apiServerCheck.check(8L)', 'API_SERVER_CHECK_8 总共耗时：16毫秒', '0', '', '2019-08-29 11:16:40');
INSERT INTO `sys_job_log` VALUES ('190', 'API_SERVER_CHECK_8', 'API_SERVER_CHECK', 'apiServerCheck.check(8L)', 'API_SERVER_CHECK_8 总共耗时：12毫秒', '0', '', '2019-08-29 11:17:40');
INSERT INTO `sys_job_log` VALUES ('191', 'API_SERVER_CHECK_8', 'API_SERVER_CHECK', 'apiServerCheck.check(8L)', 'API_SERVER_CHECK_8 总共耗时：12毫秒', '0', '', '2019-08-29 11:18:40');
INSERT INTO `sys_job_log` VALUES ('192', 'API_SERVER_CHECK_8', 'API_SERVER_CHECK', 'apiServerCheck.check(8L)', 'API_SERVER_CHECK_8 总共耗时：14毫秒', '0', '', '2019-08-29 11:19:40');
INSERT INTO `sys_job_log` VALUES ('193', 'API_SERVER_CHECK_8', 'API_SERVER_CHECK', 'apiServerCheck.check(8L)', 'API_SERVER_CHECK_8 总共耗时：14毫秒', '0', '', '2019-08-29 11:20:40');
INSERT INTO `sys_job_log` VALUES ('194', 'API_SERVER_CHECK_8', 'API_SERVER_CHECK', 'apiServerCheck.check(8L)', 'API_SERVER_CHECK_8 总共耗时：12毫秒', '0', '', '2019-08-29 11:21:40');
INSERT INTO `sys_job_log` VALUES ('195', 'API_SERVER_CHECK_8', 'API_SERVER_CHECK', 'apiServerCheck.check(8L)', 'API_SERVER_CHECK_8 总共耗时：12毫秒', '0', '', '2019-08-29 11:22:40');
INSERT INTO `sys_job_log` VALUES ('196', 'API_SERVER_CHECK_8', 'API_SERVER_CHECK', 'apiServerCheck.check(8L)', 'API_SERVER_CHECK_8 总共耗时：13毫秒', '0', '', '2019-08-29 11:23:40');
INSERT INTO `sys_job_log` VALUES ('197', 'API_SERVER_CHECK_8', 'API_SERVER_CHECK', 'apiServerCheck.check(8L)', 'API_SERVER_CHECK_8 总共耗时：11毫秒', '0', '', '2019-08-29 11:24:40');
INSERT INTO `sys_job_log` VALUES ('198', 'API_SERVER_CHECK_8', 'API_SERVER_CHECK', 'apiServerCheck.check(8L)', 'API_SERVER_CHECK_8 总共耗时：12毫秒', '0', '', '2019-08-29 11:25:40');
INSERT INTO `sys_job_log` VALUES ('199', 'API_SERVER_CHECK_8', 'API_SERVER_CHECK', 'apiServerCheck.check(8L)', 'API_SERVER_CHECK_8 总共耗时：14毫秒', '0', '', '2019-08-29 11:26:40');
INSERT INTO `sys_job_log` VALUES ('200', 'API_SERVER_CHECK_8', 'API_SERVER_CHECK', 'apiServerCheck.check(8L)', 'API_SERVER_CHECK_8 总共耗时：12毫秒', '0', '', '2019-08-29 11:27:40');
INSERT INTO `sys_job_log` VALUES ('201', 'API_SERVER_CHECK_8', 'API_SERVER_CHECK', 'apiServerCheck.check(8L)', 'API_SERVER_CHECK_8 总共耗时：13毫秒', '0', '', '2019-08-29 11:28:40');
INSERT INTO `sys_job_log` VALUES ('202', 'API_SERVER_CHECK_8', 'API_SERVER_CHECK', 'apiServerCheck.check(8L)', 'API_SERVER_CHECK_8 总共耗时：12毫秒', '0', '', '2019-08-29 11:29:40');
INSERT INTO `sys_job_log` VALUES ('203', 'API_SERVER_CHECK_8', 'API_SERVER_CHECK', 'apiServerCheck.check(8L)', 'API_SERVER_CHECK_8 总共耗时：28毫秒', '0', '', '2019-08-29 11:30:40');
INSERT INTO `sys_job_log` VALUES ('204', 'API_SERVER_CHECK_8', 'API_SERVER_CHECK', 'apiServerCheck.check(8L)', 'API_SERVER_CHECK_8 总共耗时：13毫秒', '0', '', '2019-08-29 11:31:40');
INSERT INTO `sys_job_log` VALUES ('205', 'API_SERVER_CHECK_8', 'API_SERVER_CHECK', 'apiServerCheck.check(8L)', 'API_SERVER_CHECK_8 总共耗时：13毫秒', '0', '', '2019-08-29 11:32:40');
INSERT INTO `sys_job_log` VALUES ('206', 'API_SERVER_CHECK_8', 'API_SERVER_CHECK', 'apiServerCheck.check(8L)', 'API_SERVER_CHECK_8 总共耗时：13毫秒', '0', '', '2019-08-29 11:33:40');
INSERT INTO `sys_job_log` VALUES ('207', 'API_SERVER_CHECK_8', 'API_SERVER_CHECK', 'apiServerCheck.check(8L)', 'API_SERVER_CHECK_8 总共耗时：12毫秒', '0', '', '2019-08-29 11:34:40');
INSERT INTO `sys_job_log` VALUES ('208', 'API_SERVER_CHECK_8', 'API_SERVER_CHECK', 'apiServerCheck.check(8L)', 'API_SERVER_CHECK_8 总共耗时：12毫秒', '0', '', '2019-08-29 11:35:40');
INSERT INTO `sys_job_log` VALUES ('209', 'API_SERVER_CHECK_8', 'API_SERVER_CHECK', 'apiServerCheck.check(8L)', 'API_SERVER_CHECK_8 总共耗时：15毫秒', '0', '', '2019-08-29 11:36:40');
INSERT INTO `sys_job_log` VALUES ('210', 'API_SERVER_CHECK_8', 'API_SERVER_CHECK', 'apiServerCheck.check(8L)', 'API_SERVER_CHECK_8 总共耗时：20毫秒', '0', '', '2019-08-29 11:37:40');
INSERT INTO `sys_job_log` VALUES ('211', 'API_SERVER_CHECK_8', 'API_SERVER_CHECK', 'apiServerCheck.check(8L)', 'API_SERVER_CHECK_8 总共耗时：11毫秒', '0', '', '2019-08-29 11:38:40');
INSERT INTO `sys_job_log` VALUES ('212', 'API_SERVER_CHECK_8', 'API_SERVER_CHECK', 'apiServerCheck.check(8L)', 'API_SERVER_CHECK_8 总共耗时：12毫秒', '0', '', '2019-08-29 11:39:40');
INSERT INTO `sys_job_log` VALUES ('213', 'API_SERVER_CHECK_8', 'API_SERVER_CHECK', 'apiServerCheck.check(8L)', 'API_SERVER_CHECK_8 总共耗时：11毫秒', '0', '', '2019-08-29 11:40:40');
INSERT INTO `sys_job_log` VALUES ('214', 'API_SERVER_CHECK_8', 'API_SERVER_CHECK', 'apiServerCheck.check(8L)', 'API_SERVER_CHECK_8 总共耗时：11毫秒', '0', '', '2019-08-29 11:41:40');
INSERT INTO `sys_job_log` VALUES ('215', 'API_SERVER_CHECK_8', 'API_SERVER_CHECK', 'apiServerCheck.check(8L)', 'API_SERVER_CHECK_8 总共耗时：14毫秒', '0', '', '2019-08-29 11:42:40');
INSERT INTO `sys_job_log` VALUES ('216', 'API_SERVER_CHECK_8', 'API_SERVER_CHECK', 'apiServerCheck.check(8L)', 'API_SERVER_CHECK_8 总共耗时：12毫秒', '0', '', '2019-08-29 11:43:40');
INSERT INTO `sys_job_log` VALUES ('217', 'API_SERVER_CHECK_8', 'API_SERVER_CHECK', 'apiServerCheck.check(8L)', 'API_SERVER_CHECK_8 总共耗时：11毫秒', '0', '', '2019-08-29 11:44:40');
INSERT INTO `sys_job_log` VALUES ('218', 'API_SERVER_CHECK_8', 'API_SERVER_CHECK', 'apiServerCheck.check(8L)', 'API_SERVER_CHECK_8 总共耗时：11毫秒', '0', '', '2019-08-29 11:45:40');
INSERT INTO `sys_job_log` VALUES ('219', 'API_SERVER_CHECK_8', 'API_SERVER_CHECK', 'apiServerCheck.check(8L)', 'API_SERVER_CHECK_8 总共耗时：12毫秒', '0', '', '2019-08-29 11:46:40');
INSERT INTO `sys_job_log` VALUES ('220', 'API_SERVER_CHECK_8', 'API_SERVER_CHECK', 'apiServerCheck.check(8L)', 'API_SERVER_CHECK_8 总共耗时：11毫秒', '0', '', '2019-08-29 11:47:40');
INSERT INTO `sys_job_log` VALUES ('221', 'API_SERVER_CHECK_8', 'API_SERVER_CHECK', 'apiServerCheck.check(8L)', 'API_SERVER_CHECK_8 总共耗时：11毫秒', '0', '', '2019-08-29 11:48:40');
INSERT INTO `sys_job_log` VALUES ('222', 'API_SERVER_CHECK_8', 'API_SERVER_CHECK', 'apiServerCheck.check(8L)', 'API_SERVER_CHECK_8 总共耗时：13毫秒', '0', '', '2019-08-29 11:49:40');
INSERT INTO `sys_job_log` VALUES ('223', 'API_SERVER_CHECK_8', 'API_SERVER_CHECK', 'apiServerCheck.check(8L)', 'API_SERVER_CHECK_8 总共耗时：12毫秒', '0', '', '2019-08-29 11:50:40');
INSERT INTO `sys_job_log` VALUES ('224', 'API_SERVER_CHECK_8', 'API_SERVER_CHECK', 'apiServerCheck.check(8L)', 'API_SERVER_CHECK_8 总共耗时：11毫秒', '0', '', '2019-08-29 11:51:40');
INSERT INTO `sys_job_log` VALUES ('225', 'API_SERVER_CHECK_8', 'API_SERVER_CHECK', 'apiServerCheck.check(8L)', 'API_SERVER_CHECK_8 总共耗时：13毫秒', '0', '', '2019-08-29 11:52:40');
INSERT INTO `sys_job_log` VALUES ('226', 'API_SERVER_CHECK_8', 'API_SERVER_CHECK', 'apiServerCheck.check(8L)', 'API_SERVER_CHECK_8 总共耗时：11毫秒', '0', '', '2019-08-29 11:53:40');
INSERT INTO `sys_job_log` VALUES ('227', 'API_SERVER_CHECK_8', 'API_SERVER_CHECK', 'apiServerCheck.check(8L)', 'API_SERVER_CHECK_8 总共耗时：16毫秒', '0', '', '2019-08-29 11:54:40');
INSERT INTO `sys_job_log` VALUES ('228', 'API_SERVER_CHECK_8', 'API_SERVER_CHECK', 'apiServerCheck.check(8L)', 'API_SERVER_CHECK_8 总共耗时：10毫秒', '0', '', '2019-08-29 11:55:40');
INSERT INTO `sys_job_log` VALUES ('229', 'API_SERVER_CHECK_8', 'API_SERVER_CHECK', 'apiServerCheck.check(8L)', 'API_SERVER_CHECK_8 总共耗时：13毫秒', '0', '', '2019-08-29 11:56:40');
INSERT INTO `sys_job_log` VALUES ('230', 'API_SERVER_CHECK_8', 'API_SERVER_CHECK', 'apiServerCheck.check(8L)', 'API_SERVER_CHECK_8 总共耗时：11毫秒', '0', '', '2019-08-29 11:57:40');
INSERT INTO `sys_job_log` VALUES ('231', 'API_SERVER_CHECK_8', 'API_SERVER_CHECK', 'apiServerCheck.check(8L)', 'API_SERVER_CHECK_8 总共耗时：12毫秒', '0', '', '2019-08-29 11:58:40');
INSERT INTO `sys_job_log` VALUES ('232', 'API_SERVER_CHECK_8', 'API_SERVER_CHECK', 'apiServerCheck.check(8L)', 'API_SERVER_CHECK_8 总共耗时：11毫秒', '0', '', '2019-08-29 11:59:40');
INSERT INTO `sys_job_log` VALUES ('233', 'API_SERVER_CHECK_8', 'API_SERVER_CHECK', 'apiServerCheck.check(8L)', 'API_SERVER_CHECK_8 总共耗时：13毫秒', '0', '', '2019-08-29 12:00:40');
INSERT INTO `sys_job_log` VALUES ('234', 'API_SERVER_CHECK_8', 'API_SERVER_CHECK', 'apiServerCheck.check(8L)', 'API_SERVER_CHECK_8 总共耗时：11毫秒', '0', '', '2019-08-29 12:01:40');
INSERT INTO `sys_job_log` VALUES ('235', 'API_SERVER_CHECK_8', 'API_SERVER_CHECK', 'apiServerCheck.check(8L)', 'API_SERVER_CHECK_8 总共耗时：12毫秒', '0', '', '2019-08-29 12:02:40');
INSERT INTO `sys_job_log` VALUES ('236', 'API_SERVER_CHECK_8', 'API_SERVER_CHECK', 'apiServerCheck.check(8L)', 'API_SERVER_CHECK_8 总共耗时：10毫秒', '0', '', '2019-08-29 12:03:40');
INSERT INTO `sys_job_log` VALUES ('237', 'API_SERVER_CHECK_8', 'API_SERVER_CHECK', 'apiServerCheck.check(8L)', 'API_SERVER_CHECK_8 总共耗时：13毫秒', '0', '', '2019-08-29 12:04:40');
INSERT INTO `sys_job_log` VALUES ('238', 'API_SERVER_CHECK_8', 'API_SERVER_CHECK', 'apiServerCheck.check(8L)', 'API_SERVER_CHECK_8 总共耗时：12毫秒', '0', '', '2019-08-29 12:05:40');
INSERT INTO `sys_job_log` VALUES ('239', 'API_SERVER_CHECK_8', 'API_SERVER_CHECK', 'apiServerCheck.check(8L)', 'API_SERVER_CHECK_8 总共耗时：13毫秒', '0', '', '2019-08-29 12:06:40');
INSERT INTO `sys_job_log` VALUES ('240', 'API_SERVER_CHECK_8', 'API_SERVER_CHECK', 'apiServerCheck.check(8L)', 'API_SERVER_CHECK_8 总共耗时：12毫秒', '0', '', '2019-08-29 12:07:40');
INSERT INTO `sys_job_log` VALUES ('241', 'API_SERVER_CHECK_8', 'API_SERVER_CHECK', 'apiServerCheck.check(8L)', 'API_SERVER_CHECK_8 总共耗时：12毫秒', '0', '', '2019-08-29 12:08:40');
INSERT INTO `sys_job_log` VALUES ('242', 'API_SERVER_CHECK_8', 'API_SERVER_CHECK', 'apiServerCheck.check(8L)', 'API_SERVER_CHECK_8 总共耗时：11毫秒', '0', '', '2019-08-29 12:09:40');
INSERT INTO `sys_job_log` VALUES ('243', 'API_SERVER_CHECK_8', 'API_SERVER_CHECK', 'apiServerCheck.check(8L)', 'API_SERVER_CHECK_8 总共耗时：11毫秒', '0', '', '2019-08-29 12:10:40');
INSERT INTO `sys_job_log` VALUES ('244', 'API_SERVER_CHECK_8', 'API_SERVER_CHECK', 'apiServerCheck.check(8L)', 'API_SERVER_CHECK_8 总共耗时：10毫秒', '0', '', '2019-08-29 12:11:40');
INSERT INTO `sys_job_log` VALUES ('245', 'API_SERVER_CHECK_8', 'API_SERVER_CHECK', 'apiServerCheck.check(8L)', 'API_SERVER_CHECK_8 总共耗时：11毫秒', '0', '', '2019-08-29 12:12:40');
INSERT INTO `sys_job_log` VALUES ('246', 'API_SERVER_CHECK_8', 'API_SERVER_CHECK', 'apiServerCheck.check(8L)', 'API_SERVER_CHECK_8 总共耗时：10毫秒', '0', '', '2019-08-29 12:13:40');
INSERT INTO `sys_job_log` VALUES ('247', 'API_SERVER_CHECK_8', 'API_SERVER_CHECK', 'apiServerCheck.check(8L)', 'API_SERVER_CHECK_8 总共耗时：12毫秒', '0', '', '2019-08-29 12:14:40');
INSERT INTO `sys_job_log` VALUES ('248', 'API_SERVER_CHECK_8', 'API_SERVER_CHECK', 'apiServerCheck.check(8L)', 'API_SERVER_CHECK_8 总共耗时：12毫秒', '0', '', '2019-08-29 12:15:40');
INSERT INTO `sys_job_log` VALUES ('249', 'API_SERVER_CHECK_8', 'API_SERVER_CHECK', 'apiServerCheck.check(8L)', 'API_SERVER_CHECK_8 总共耗时：12毫秒', '0', '', '2019-08-29 12:16:40');
INSERT INTO `sys_job_log` VALUES ('250', 'API_SERVER_CHECK_8', 'API_SERVER_CHECK', 'apiServerCheck.check(8L)', 'API_SERVER_CHECK_8 总共耗时：12毫秒', '0', '', '2019-08-29 12:17:40');
INSERT INTO `sys_job_log` VALUES ('251', 'API_SERVER_CHECK_8', 'API_SERVER_CHECK', 'apiServerCheck.check(8L)', 'API_SERVER_CHECK_8 总共耗时：12毫秒', '0', '', '2019-08-29 12:18:40');
INSERT INTO `sys_job_log` VALUES ('252', 'API_SERVER_CHECK_8', 'API_SERVER_CHECK', 'apiServerCheck.check(8L)', 'API_SERVER_CHECK_8 总共耗时：12毫秒', '0', '', '2019-08-29 12:19:40');
INSERT INTO `sys_job_log` VALUES ('253', 'API_SERVER_CHECK_8', 'API_SERVER_CHECK', 'apiServerCheck.check(8L)', 'API_SERVER_CHECK_8 总共耗时：11毫秒', '0', '', '2019-08-29 12:20:40');
INSERT INTO `sys_job_log` VALUES ('254', 'API_SERVER_CHECK_8', 'API_SERVER_CHECK', 'apiServerCheck.check(8L)', 'API_SERVER_CHECK_8 总共耗时：11毫秒', '0', '', '2019-08-29 12:21:40');
INSERT INTO `sys_job_log` VALUES ('255', 'API_SERVER_CHECK_8', 'API_SERVER_CHECK', 'apiServerCheck.check(8L)', 'API_SERVER_CHECK_8 总共耗时：12毫秒', '0', '', '2019-08-29 12:22:40');
INSERT INTO `sys_job_log` VALUES ('256', 'API_SERVER_CHECK_8', 'API_SERVER_CHECK', 'apiServerCheck.check(8L)', 'API_SERVER_CHECK_8 总共耗时：11毫秒', '0', '', '2019-08-29 12:23:40');
INSERT INTO `sys_job_log` VALUES ('257', 'API_SERVER_CHECK_8', 'API_SERVER_CHECK', 'apiServerCheck.check(8L)', 'API_SERVER_CHECK_8 总共耗时：10毫秒', '0', '', '2019-08-29 12:24:40');
INSERT INTO `sys_job_log` VALUES ('258', 'API_SERVER_CHECK_8', 'API_SERVER_CHECK', 'apiServerCheck.check(8L)', 'API_SERVER_CHECK_8 总共耗时：13毫秒', '0', '', '2019-08-29 12:25:40');
INSERT INTO `sys_job_log` VALUES ('259', 'API_SERVER_CHECK_8', 'API_SERVER_CHECK', 'apiServerCheck.check(8L)', 'API_SERVER_CHECK_8 总共耗时：11毫秒', '0', '', '2019-08-29 12:26:40');
INSERT INTO `sys_job_log` VALUES ('260', 'API_SERVER_CHECK_8', 'API_SERVER_CHECK', 'apiServerCheck.check(8L)', 'API_SERVER_CHECK_8 总共耗时：11毫秒', '0', '', '2019-08-29 12:27:40');
INSERT INTO `sys_job_log` VALUES ('261', 'API_SERVER_CHECK_8', 'API_SERVER_CHECK', 'apiServerCheck.check(8L)', 'API_SERVER_CHECK_8 总共耗时：12毫秒', '0', '', '2019-08-29 12:28:40');
INSERT INTO `sys_job_log` VALUES ('262', 'API_SERVER_CHECK_8', 'API_SERVER_CHECK', 'apiServerCheck.check(8L)', 'API_SERVER_CHECK_8 总共耗时：13毫秒', '0', '', '2019-08-29 12:29:40');
INSERT INTO `sys_job_log` VALUES ('263', 'API_SERVER_CHECK_8', 'API_SERVER_CHECK', 'apiServerCheck.check(8L)', 'API_SERVER_CHECK_8 总共耗时：12毫秒', '0', '', '2019-08-29 12:30:40');
INSERT INTO `sys_job_log` VALUES ('264', 'API_SERVER_CHECK_8', 'API_SERVER_CHECK', 'apiServerCheck.check(8L)', 'API_SERVER_CHECK_8 总共耗时：12毫秒', '0', '', '2019-08-29 12:31:40');
INSERT INTO `sys_job_log` VALUES ('265', 'API_SERVER_CHECK_8', 'API_SERVER_CHECK', 'apiServerCheck.check(8L)', 'API_SERVER_CHECK_8 总共耗时：13毫秒', '0', '', '2019-08-29 12:32:40');
INSERT INTO `sys_job_log` VALUES ('266', 'API_SERVER_CHECK_8', 'API_SERVER_CHECK', 'apiServerCheck.check(8L)', 'API_SERVER_CHECK_8 总共耗时：10毫秒', '0', '', '2019-08-29 12:33:40');
INSERT INTO `sys_job_log` VALUES ('267', 'API_SERVER_CHECK_8', 'API_SERVER_CHECK', 'apiServerCheck.check(8L)', 'API_SERVER_CHECK_8 总共耗时：12毫秒', '0', '', '2019-08-29 12:34:40');
INSERT INTO `sys_job_log` VALUES ('268', 'API_SERVER_CHECK_8', 'API_SERVER_CHECK', 'apiServerCheck.check(8L)', 'API_SERVER_CHECK_8 总共耗时：13毫秒', '0', '', '2019-08-29 12:35:40');
INSERT INTO `sys_job_log` VALUES ('269', 'API_SERVER_CHECK_8', 'API_SERVER_CHECK', 'apiServerCheck.check(8L)', 'API_SERVER_CHECK_8 总共耗时：11毫秒', '0', '', '2019-08-29 12:36:40');
INSERT INTO `sys_job_log` VALUES ('270', 'API_SERVER_CHECK_8', 'API_SERVER_CHECK', 'apiServerCheck.check(8L)', 'API_SERVER_CHECK_8 总共耗时：11毫秒', '0', '', '2019-08-29 12:37:40');
INSERT INTO `sys_job_log` VALUES ('271', 'API_SERVER_CHECK_8', 'API_SERVER_CHECK', 'apiServerCheck.check(8L)', 'API_SERVER_CHECK_8 总共耗时：11毫秒', '0', '', '2019-08-29 12:38:40');
INSERT INTO `sys_job_log` VALUES ('272', 'API_SERVER_CHECK_8', 'API_SERVER_CHECK', 'apiServerCheck.check(8L)', 'API_SERVER_CHECK_8 总共耗时：10毫秒', '0', '', '2019-08-29 12:39:40');
INSERT INTO `sys_job_log` VALUES ('273', 'API_SERVER_CHECK_8', 'API_SERVER_CHECK', 'apiServerCheck.check(8L)', 'API_SERVER_CHECK_8 总共耗时：13毫秒', '0', '', '2019-08-29 12:40:40');
INSERT INTO `sys_job_log` VALUES ('274', 'API_SERVER_CHECK_8', 'API_SERVER_CHECK', 'apiServerCheck.check(8L)', 'API_SERVER_CHECK_8 总共耗时：10毫秒', '0', '', '2019-08-29 12:41:40');
INSERT INTO `sys_job_log` VALUES ('275', 'API_SERVER_CHECK_8', 'API_SERVER_CHECK', 'apiServerCheck.check(8L)', 'API_SERVER_CHECK_8 总共耗时：12毫秒', '0', '', '2019-08-29 12:42:40');
INSERT INTO `sys_job_log` VALUES ('276', 'API_SERVER_CHECK_8', 'API_SERVER_CHECK', 'apiServerCheck.check(8L)', 'API_SERVER_CHECK_8 总共耗时：11毫秒', '0', '', '2019-08-29 12:43:40');
INSERT INTO `sys_job_log` VALUES ('277', 'API_SERVER_CHECK_8', 'API_SERVER_CHECK', 'apiServerCheck.check(8L)', 'API_SERVER_CHECK_8 总共耗时：12毫秒', '0', '', '2019-08-29 12:44:40');
INSERT INTO `sys_job_log` VALUES ('278', 'API_SERVER_CHECK_8', 'API_SERVER_CHECK', 'apiServerCheck.check(8L)', 'API_SERVER_CHECK_8 总共耗时：12毫秒', '0', '', '2019-08-29 12:45:40');
INSERT INTO `sys_job_log` VALUES ('279', 'API_SERVER_CHECK_8', 'API_SERVER_CHECK', 'apiServerCheck.check(8L)', 'API_SERVER_CHECK_8 总共耗时：10毫秒', '0', '', '2019-08-29 12:46:40');
INSERT INTO `sys_job_log` VALUES ('280', 'API_SERVER_CHECK_8', 'API_SERVER_CHECK', 'apiServerCheck.check(8L)', 'API_SERVER_CHECK_8 总共耗时：14毫秒', '0', '', '2019-08-29 12:47:40');
INSERT INTO `sys_job_log` VALUES ('281', 'API_SERVER_CHECK_8', 'API_SERVER_CHECK', 'apiServerCheck.check(8L)', 'API_SERVER_CHECK_8 总共耗时：11毫秒', '0', '', '2019-08-29 12:48:40');
INSERT INTO `sys_job_log` VALUES ('282', 'API_SERVER_CHECK_8', 'API_SERVER_CHECK', 'apiServerCheck.check(8L)', 'API_SERVER_CHECK_8 总共耗时：11毫秒', '0', '', '2019-08-29 12:49:40');
INSERT INTO `sys_job_log` VALUES ('283', 'API_SERVER_CHECK_8', 'API_SERVER_CHECK', 'apiServerCheck.check(8L)', 'API_SERVER_CHECK_8 总共耗时：11毫秒', '0', '', '2019-08-29 12:50:40');
INSERT INTO `sys_job_log` VALUES ('284', 'API_SERVER_CHECK_8', 'API_SERVER_CHECK', 'apiServerCheck.check(8L)', 'API_SERVER_CHECK_8 总共耗时：11毫秒', '0', '', '2019-08-29 12:51:40');
INSERT INTO `sys_job_log` VALUES ('285', 'API_SERVER_CHECK_8', 'API_SERVER_CHECK', 'apiServerCheck.check(8L)', 'API_SERVER_CHECK_8 总共耗时：10毫秒', '0', '', '2019-08-29 12:52:40');
INSERT INTO `sys_job_log` VALUES ('286', 'API_SERVER_CHECK_8', 'API_SERVER_CHECK', 'apiServerCheck.check(8L)', 'API_SERVER_CHECK_8 总共耗时：11毫秒', '0', '', '2019-08-29 12:53:40');
INSERT INTO `sys_job_log` VALUES ('287', 'API_SERVER_CHECK_8', 'API_SERVER_CHECK', 'apiServerCheck.check(8L)', 'API_SERVER_CHECK_8 总共耗时：11毫秒', '0', '', '2019-08-29 12:54:40');
INSERT INTO `sys_job_log` VALUES ('288', 'API_SERVER_CHECK_8', 'API_SERVER_CHECK', 'apiServerCheck.check(8L)', 'API_SERVER_CHECK_8 总共耗时：13毫秒', '0', '', '2019-08-29 12:55:40');
INSERT INTO `sys_job_log` VALUES ('289', 'API_SERVER_CHECK_8', 'API_SERVER_CHECK', 'apiServerCheck.check(8L)', 'API_SERVER_CHECK_8 总共耗时：10毫秒', '0', '', '2019-08-29 12:56:40');
INSERT INTO `sys_job_log` VALUES ('290', 'API_SERVER_CHECK_8', 'API_SERVER_CHECK', 'apiServerCheck.check(8L)', 'API_SERVER_CHECK_8 总共耗时：12毫秒', '0', '', '2019-08-29 12:57:40');
INSERT INTO `sys_job_log` VALUES ('291', 'API_SERVER_CHECK_8', 'API_SERVER_CHECK', 'apiServerCheck.check(8L)', 'API_SERVER_CHECK_8 总共耗时：11毫秒', '0', '', '2019-08-29 12:58:40');
INSERT INTO `sys_job_log` VALUES ('292', 'API_SERVER_CHECK_8', 'API_SERVER_CHECK', 'apiServerCheck.check(8L)', 'API_SERVER_CHECK_8 总共耗时：10毫秒', '0', '', '2019-08-29 12:59:40');
INSERT INTO `sys_job_log` VALUES ('293', 'API_SERVER_CHECK_8', 'API_SERVER_CHECK', 'apiServerCheck.check(8L)', 'API_SERVER_CHECK_8 总共耗时：11毫秒', '0', '', '2019-08-29 13:00:40');
INSERT INTO `sys_job_log` VALUES ('294', 'API_SERVER_CHECK_8', 'API_SERVER_CHECK', 'apiServerCheck.check(8L)', 'API_SERVER_CHECK_8 总共耗时：11毫秒', '0', '', '2019-08-29 13:01:40');
INSERT INTO `sys_job_log` VALUES ('295', 'API_SERVER_CHECK_8', 'API_SERVER_CHECK', 'apiServerCheck.check(8L)', 'API_SERVER_CHECK_8 总共耗时：11毫秒', '0', '', '2019-08-29 13:02:40');
INSERT INTO `sys_job_log` VALUES ('296', 'API_SERVER_CHECK_8', 'API_SERVER_CHECK', 'apiServerCheck.check(8L)', 'API_SERVER_CHECK_8 总共耗时：11毫秒', '0', '', '2019-08-29 13:03:40');
INSERT INTO `sys_job_log` VALUES ('297', 'API_SERVER_CHECK_8', 'API_SERVER_CHECK', 'apiServerCheck.check(8L)', 'API_SERVER_CHECK_8 总共耗时：11毫秒', '0', '', '2019-08-29 13:04:40');
INSERT INTO `sys_job_log` VALUES ('298', 'API_SERVER_CHECK_8', 'API_SERVER_CHECK', 'apiServerCheck.check(8L)', 'API_SERVER_CHECK_8 总共耗时：11毫秒', '0', '', '2019-08-29 13:05:40');
INSERT INTO `sys_job_log` VALUES ('299', 'API_SERVER_CHECK_8', 'API_SERVER_CHECK', 'apiServerCheck.check(8L)', 'API_SERVER_CHECK_8 总共耗时：12毫秒', '0', '', '2019-08-29 13:06:40');
INSERT INTO `sys_job_log` VALUES ('300', 'API_SERVER_CHECK_8', 'API_SERVER_CHECK', 'apiServerCheck.check(8L)', 'API_SERVER_CHECK_8 总共耗时：10毫秒', '0', '', '2019-08-29 13:07:40');
INSERT INTO `sys_job_log` VALUES ('301', 'API_SERVER_CHECK_8', 'API_SERVER_CHECK', 'apiServerCheck.check(8L)', 'API_SERVER_CHECK_8 总共耗时：11毫秒', '0', '', '2019-08-29 13:08:40');
INSERT INTO `sys_job_log` VALUES ('302', 'API_SERVER_CHECK_8', 'API_SERVER_CHECK', 'apiServerCheck.check(8L)', 'API_SERVER_CHECK_8 总共耗时：10毫秒', '0', '', '2019-08-29 13:09:40');
INSERT INTO `sys_job_log` VALUES ('303', 'API_SERVER_CHECK_8', 'API_SERVER_CHECK', 'apiServerCheck.check(8L)', 'API_SERVER_CHECK_8 总共耗时：11毫秒', '0', '', '2019-08-29 13:10:40');
INSERT INTO `sys_job_log` VALUES ('304', 'API_SERVER_CHECK_8', 'API_SERVER_CHECK', 'apiServerCheck.check(8L)', 'API_SERVER_CHECK_8 总共耗时：11毫秒', '0', '', '2019-08-29 13:11:40');
INSERT INTO `sys_job_log` VALUES ('305', 'API_SERVER_CHECK_8', 'API_SERVER_CHECK', 'apiServerCheck.check(8L)', 'API_SERVER_CHECK_8 总共耗时：10毫秒', '0', '', '2019-08-29 13:12:40');
INSERT INTO `sys_job_log` VALUES ('306', 'API_SERVER_CHECK_8', 'API_SERVER_CHECK', 'apiServerCheck.check(8L)', 'API_SERVER_CHECK_8 总共耗时：12毫秒', '0', '', '2019-08-29 13:13:40');
INSERT INTO `sys_job_log` VALUES ('307', 'API_SERVER_CHECK_8', 'API_SERVER_CHECK', 'apiServerCheck.check(8L)', 'API_SERVER_CHECK_8 总共耗时：10毫秒', '0', '', '2019-08-29 13:14:40');
INSERT INTO `sys_job_log` VALUES ('308', 'API_SERVER_CHECK_8', 'API_SERVER_CHECK', 'apiServerCheck.check(8L)', 'API_SERVER_CHECK_8 总共耗时：10毫秒', '0', '', '2019-08-29 13:15:40');
INSERT INTO `sys_job_log` VALUES ('309', 'API_SERVER_CHECK_8', 'API_SERVER_CHECK', 'apiServerCheck.check(8L)', 'API_SERVER_CHECK_8 总共耗时：11毫秒', '0', '', '2019-08-29 13:16:40');
INSERT INTO `sys_job_log` VALUES ('310', 'API_SERVER_CHECK_8', 'API_SERVER_CHECK', 'apiServerCheck.check(8L)', 'API_SERVER_CHECK_8 总共耗时：11毫秒', '0', '', '2019-08-29 13:17:40');
INSERT INTO `sys_job_log` VALUES ('311', 'API_SERVER_CHECK_8', 'API_SERVER_CHECK', 'apiServerCheck.check(8L)', 'API_SERVER_CHECK_8 总共耗时：12毫秒', '0', '', '2019-08-29 13:18:40');
INSERT INTO `sys_job_log` VALUES ('312', 'API_SERVER_CHECK_8', 'API_SERVER_CHECK', 'apiServerCheck.check(8L)', 'API_SERVER_CHECK_8 总共耗时：10毫秒', '0', '', '2019-08-29 13:19:40');
INSERT INTO `sys_job_log` VALUES ('313', 'API_SERVER_CHECK_8', 'API_SERVER_CHECK', 'apiServerCheck.check(8L)', 'API_SERVER_CHECK_8 总共耗时：11毫秒', '0', '', '2019-08-29 13:20:40');
INSERT INTO `sys_job_log` VALUES ('314', 'API_SERVER_CHECK_8', 'API_SERVER_CHECK', 'apiServerCheck.check(8L)', 'API_SERVER_CHECK_8 总共耗时：11毫秒', '0', '', '2019-08-29 13:21:40');
INSERT INTO `sys_job_log` VALUES ('315', 'API_SERVER_CHECK_8', 'API_SERVER_CHECK', 'apiServerCheck.check(8L)', 'API_SERVER_CHECK_8 总共耗时：11毫秒', '0', '', '2019-08-29 13:22:40');
INSERT INTO `sys_job_log` VALUES ('316', 'API_SERVER_CHECK_8', 'API_SERVER_CHECK', 'apiServerCheck.check(8L)', 'API_SERVER_CHECK_8 总共耗时：10毫秒', '0', '', '2019-08-29 13:23:40');
INSERT INTO `sys_job_log` VALUES ('317', 'API_SERVER_CHECK_8', 'API_SERVER_CHECK', 'apiServerCheck.check(8L)', 'API_SERVER_CHECK_8 总共耗时：10毫秒', '0', '', '2019-08-29 13:24:40');
INSERT INTO `sys_job_log` VALUES ('318', 'API_SERVER_CHECK_8', 'API_SERVER_CHECK', 'apiServerCheck.check(8L)', 'API_SERVER_CHECK_8 总共耗时：10毫秒', '0', '', '2019-08-29 13:25:40');
INSERT INTO `sys_job_log` VALUES ('319', 'API_SERVER_CHECK_8', 'API_SERVER_CHECK', 'apiServerCheck.check(8L)', 'API_SERVER_CHECK_8 总共耗时：11毫秒', '0', '', '2019-08-29 13:26:40');
INSERT INTO `sys_job_log` VALUES ('320', 'API_SERVER_CHECK_8', 'API_SERVER_CHECK', 'apiServerCheck.check(8L)', 'API_SERVER_CHECK_8 总共耗时：11毫秒', '0', '', '2019-08-29 13:27:40');
INSERT INTO `sys_job_log` VALUES ('321', 'API_SERVER_CHECK_8', 'API_SERVER_CHECK', 'apiServerCheck.check(8L)', 'API_SERVER_CHECK_8 总共耗时：10毫秒', '0', '', '2019-08-29 13:28:40');
INSERT INTO `sys_job_log` VALUES ('322', 'API_SERVER_CHECK_8', 'API_SERVER_CHECK', 'apiServerCheck.check(8L)', 'API_SERVER_CHECK_8 总共耗时：12毫秒', '0', '', '2019-08-29 13:29:40');
INSERT INTO `sys_job_log` VALUES ('323', 'API_SERVER_CHECK_8', 'API_SERVER_CHECK', 'apiServerCheck.check(8L)', 'API_SERVER_CHECK_8 总共耗时：10毫秒', '0', '', '2019-08-29 13:30:40');
INSERT INTO `sys_job_log` VALUES ('324', 'API_SERVER_CHECK_8', 'API_SERVER_CHECK', 'apiServerCheck.check(8L)', 'API_SERVER_CHECK_8 总共耗时：11毫秒', '0', '', '2019-08-29 13:31:40');
INSERT INTO `sys_job_log` VALUES ('325', 'API_SERVER_CHECK_8', 'API_SERVER_CHECK', 'apiServerCheck.check(8L)', 'API_SERVER_CHECK_8 总共耗时：14毫秒', '0', '', '2019-08-29 13:32:40');
INSERT INTO `sys_job_log` VALUES ('326', 'API_SERVER_CHECK_8', 'API_SERVER_CHECK', 'apiServerCheck.check(8L)', 'API_SERVER_CHECK_8 总共耗时：10毫秒', '0', '', '2019-08-29 13:33:40');
INSERT INTO `sys_job_log` VALUES ('327', 'API_SERVER_CHECK_8', 'API_SERVER_CHECK', 'apiServerCheck.check(8L)', 'API_SERVER_CHECK_8 总共耗时：11毫秒', '0', '', '2019-08-29 13:34:40');
INSERT INTO `sys_job_log` VALUES ('328', 'API_SERVER_CHECK_8', 'API_SERVER_CHECK', 'apiServerCheck.check(8L)', 'API_SERVER_CHECK_8 总共耗时：12毫秒', '0', '', '2019-08-29 13:35:40');
INSERT INTO `sys_job_log` VALUES ('329', 'API_SERVER_CHECK_8', 'API_SERVER_CHECK', 'apiServerCheck.check(8L)', 'API_SERVER_CHECK_8 总共耗时：10毫秒', '0', '', '2019-08-29 13:36:40');
INSERT INTO `sys_job_log` VALUES ('330', 'API_SERVER_CHECK_8', 'API_SERVER_CHECK', 'apiServerCheck.check(8L)', 'API_SERVER_CHECK_8 总共耗时：10毫秒', '0', '', '2019-08-29 13:37:40');
INSERT INTO `sys_job_log` VALUES ('331', 'API_SERVER_CHECK_8', 'API_SERVER_CHECK', 'apiServerCheck.check(8L)', 'API_SERVER_CHECK_8 总共耗时：10毫秒', '0', '', '2019-08-29 13:38:40');
INSERT INTO `sys_job_log` VALUES ('332', 'API_SERVER_CHECK_8', 'API_SERVER_CHECK', 'apiServerCheck.check(8L)', 'API_SERVER_CHECK_8 总共耗时：10毫秒', '0', '', '2019-08-29 13:39:40');
INSERT INTO `sys_job_log` VALUES ('333', 'API_SERVER_CHECK_8', 'API_SERVER_CHECK', 'apiServerCheck.check(8L)', 'API_SERVER_CHECK_8 总共耗时：12毫秒', '0', '', '2019-08-29 13:40:40');
INSERT INTO `sys_job_log` VALUES ('334', 'API_SERVER_CHECK_8', 'API_SERVER_CHECK', 'apiServerCheck.check(8L)', 'API_SERVER_CHECK_8 总共耗时：11毫秒', '0', '', '2019-08-29 13:41:40');
INSERT INTO `sys_job_log` VALUES ('335', 'API_SERVER_CHECK_8', 'API_SERVER_CHECK', 'apiServerCheck.check(8L)', 'API_SERVER_CHECK_8 总共耗时：13毫秒', '0', '', '2019-08-29 13:42:40');
INSERT INTO `sys_job_log` VALUES ('336', 'API_SERVER_CHECK_8', 'API_SERVER_CHECK', 'apiServerCheck.check(8L)', 'API_SERVER_CHECK_8 总共耗时：11毫秒', '0', '', '2019-08-29 13:43:40');
INSERT INTO `sys_job_log` VALUES ('337', 'API_SERVER_CHECK_8', 'API_SERVER_CHECK', 'apiServerCheck.check(8L)', 'API_SERVER_CHECK_8 总共耗时：10毫秒', '0', '', '2019-08-29 13:44:40');
INSERT INTO `sys_job_log` VALUES ('338', 'API_SERVER_CHECK_8', 'API_SERVER_CHECK', 'apiServerCheck.check(8L)', 'API_SERVER_CHECK_8 总共耗时：11毫秒', '0', '', '2019-08-29 13:45:40');
INSERT INTO `sys_job_log` VALUES ('339', 'API_SERVER_CHECK_8', 'API_SERVER_CHECK', 'apiServerCheck.check(8L)', 'API_SERVER_CHECK_8 总共耗时：10毫秒', '0', '', '2019-08-29 13:46:40');
INSERT INTO `sys_job_log` VALUES ('340', 'API_SERVER_CHECK_8', 'API_SERVER_CHECK', 'apiServerCheck.check(8L)', 'API_SERVER_CHECK_8 总共耗时：11毫秒', '0', '', '2019-08-29 13:47:40');
INSERT INTO `sys_job_log` VALUES ('341', 'API_SERVER_CHECK_8', 'API_SERVER_CHECK', 'apiServerCheck.check(8L)', 'API_SERVER_CHECK_8 总共耗时：11毫秒', '0', '', '2019-08-29 13:48:40');
INSERT INTO `sys_job_log` VALUES ('342', 'API_SERVER_CHECK_8', 'API_SERVER_CHECK', 'apiServerCheck.check(8L)', 'API_SERVER_CHECK_8 总共耗时：12毫秒', '0', '', '2019-08-29 13:49:40');
INSERT INTO `sys_job_log` VALUES ('343', 'API_SERVER_CHECK_8', 'API_SERVER_CHECK', 'apiServerCheck.check(8L)', 'API_SERVER_CHECK_8 总共耗时：13毫秒', '0', '', '2019-08-29 13:50:40');
INSERT INTO `sys_job_log` VALUES ('344', 'API_SERVER_CHECK_8', 'API_SERVER_CHECK', 'apiServerCheck.check(8L)', 'API_SERVER_CHECK_8 总共耗时：10毫秒', '0', '', '2019-08-29 13:51:40');
INSERT INTO `sys_job_log` VALUES ('345', 'API_SERVER_CHECK_8', 'API_SERVER_CHECK', 'apiServerCheck.check(8L)', 'API_SERVER_CHECK_8 总共耗时：10毫秒', '0', '', '2019-08-29 13:52:40');
INSERT INTO `sys_job_log` VALUES ('346', 'API_SERVER_CHECK_8', 'API_SERVER_CHECK', 'apiServerCheck.check(8L)', 'API_SERVER_CHECK_8 总共耗时：12毫秒', '0', '', '2019-08-29 13:53:40');
INSERT INTO `sys_job_log` VALUES ('347', 'API_SERVER_CHECK_8', 'API_SERVER_CHECK', 'apiServerCheck.check(8L)', 'API_SERVER_CHECK_8 总共耗时：10毫秒', '0', '', '2019-08-29 13:54:40');
INSERT INTO `sys_job_log` VALUES ('348', 'API_SERVER_CHECK_8', 'API_SERVER_CHECK', 'apiServerCheck.check(8L)', 'API_SERVER_CHECK_8 总共耗时：13毫秒', '0', '', '2019-08-29 13:55:40');
INSERT INTO `sys_job_log` VALUES ('349', 'API_SERVER_CHECK_8', 'API_SERVER_CHECK', 'apiServerCheck.check(8L)', 'API_SERVER_CHECK_8 总共耗时：12毫秒', '0', '', '2019-08-29 13:56:40');
INSERT INTO `sys_job_log` VALUES ('350', 'API_SERVER_CHECK_8', 'API_SERVER_CHECK', 'apiServerCheck.check(8L)', 'API_SERVER_CHECK_8 总共耗时：13毫秒', '0', '', '2019-08-29 13:57:40');
INSERT INTO `sys_job_log` VALUES ('351', 'API_SERVER_CHECK_8', 'API_SERVER_CHECK', 'apiServerCheck.check(8L)', 'API_SERVER_CHECK_8 总共耗时：11毫秒', '0', '', '2019-08-29 13:58:40');
INSERT INTO `sys_job_log` VALUES ('352', 'API_SERVER_CHECK_8', 'API_SERVER_CHECK', 'apiServerCheck.check(8L)', 'API_SERVER_CHECK_8 总共耗时：12毫秒', '0', '', '2019-08-29 13:59:40');
INSERT INTO `sys_job_log` VALUES ('353', 'API_SERVER_CHECK_8', 'API_SERVER_CHECK', 'apiServerCheck.check(8L)', 'API_SERVER_CHECK_8 总共耗时：12毫秒', '0', '', '2019-08-29 14:00:40');
INSERT INTO `sys_job_log` VALUES ('354', 'API_SERVER_CHECK_8', 'API_SERVER_CHECK', 'apiServerCheck.check(8L)', 'API_SERVER_CHECK_8 总共耗时：12毫秒', '0', '', '2019-08-29 14:01:40');
INSERT INTO `sys_job_log` VALUES ('355', 'API_SERVER_CHECK_8', 'API_SERVER_CHECK', 'apiServerCheck.check(8L)', 'API_SERVER_CHECK_8 总共耗时：15毫秒', '0', '', '2019-08-29 14:02:40');
INSERT INTO `sys_job_log` VALUES ('356', 'API_SERVER_CHECK_8', 'API_SERVER_CHECK', 'apiServerCheck.check(8L)', 'API_SERVER_CHECK_8 总共耗时：14毫秒', '0', '', '2019-08-29 14:03:40');
INSERT INTO `sys_job_log` VALUES ('357', 'API_SERVER_CHECK_8', 'API_SERVER_CHECK', 'apiServerCheck.check(8L)', 'API_SERVER_CHECK_8 总共耗时：101毫秒', '0', '', '2019-08-29 14:04:40');
INSERT INTO `sys_job_log` VALUES ('358', 'API_SERVER_CHECK_8', 'API_SERVER_CHECK', 'apiServerCheck.check(8L)', 'API_SERVER_CHECK_8 总共耗时：18毫秒', '0', '', '2019-08-29 14:05:40');
INSERT INTO `sys_job_log` VALUES ('359', 'API_SERVER_CHECK_8', 'API_SERVER_CHECK', 'apiServerCheck.check(8L)', 'API_SERVER_CHECK_8 总共耗时：13毫秒', '0', '', '2019-08-29 14:06:40');
INSERT INTO `sys_job_log` VALUES ('360', 'API_SERVER_CHECK_8', 'API_SERVER_CHECK', 'apiServerCheck.check(8L)', 'API_SERVER_CHECK_8 总共耗时：12毫秒', '0', '', '2019-08-29 14:07:40');
INSERT INTO `sys_job_log` VALUES ('361', 'API_SERVER_CHECK_8', 'API_SERVER_CHECK', 'apiServerCheck.check(8L)', 'API_SERVER_CHECK_8 总共耗时：12毫秒', '0', '', '2019-08-29 14:08:40');
INSERT INTO `sys_job_log` VALUES ('362', 'API_SERVER_CHECK_8', 'API_SERVER_CHECK', 'apiServerCheck.check(8L)', 'API_SERVER_CHECK_8 总共耗时：15毫秒', '0', '', '2019-08-29 14:09:40');
INSERT INTO `sys_job_log` VALUES ('363', 'API_SERVER_CHECK_8', 'API_SERVER_CHECK', 'apiServerCheck.check(8L)', 'API_SERVER_CHECK_8 总共耗时：12毫秒', '0', '', '2019-08-29 14:10:40');
INSERT INTO `sys_job_log` VALUES ('364', 'API_SERVER_CHECK_8', 'API_SERVER_CHECK', 'apiServerCheck.check(8L)', 'API_SERVER_CHECK_8 总共耗时：12毫秒', '0', '', '2019-08-29 14:11:40');
INSERT INTO `sys_job_log` VALUES ('365', 'API_SERVER_CHECK_8', 'API_SERVER_CHECK', 'apiServerCheck.check(8L)', 'API_SERVER_CHECK_8 总共耗时：11毫秒', '0', '', '2019-08-29 14:12:40');
INSERT INTO `sys_job_log` VALUES ('366', 'API_SERVER_CHECK_8', 'API_SERVER_CHECK', 'apiServerCheck.check(8L)', 'API_SERVER_CHECK_8 总共耗时：11毫秒', '0', '', '2019-08-29 14:13:40');
INSERT INTO `sys_job_log` VALUES ('367', 'API_SERVER_CHECK_8', 'API_SERVER_CHECK', 'apiServerCheck.check(8L)', 'API_SERVER_CHECK_8 总共耗时：12毫秒', '0', '', '2019-08-29 14:14:40');
INSERT INTO `sys_job_log` VALUES ('368', 'API_SERVER_CHECK_8', 'API_SERVER_CHECK', 'apiServerCheck.check(8L)', 'API_SERVER_CHECK_8 总共耗时：14毫秒', '0', '', '2019-08-29 14:15:40');
INSERT INTO `sys_job_log` VALUES ('369', 'API_SERVER_CHECK_8', 'API_SERVER_CHECK', 'apiServerCheck.check(8L)', 'API_SERVER_CHECK_8 总共耗时：15毫秒', '0', '', '2019-08-29 14:16:40');
INSERT INTO `sys_job_log` VALUES ('370', 'API_SERVER_CHECK_8', 'API_SERVER_CHECK', 'apiServerCheck.check(8L)', 'API_SERVER_CHECK_8 总共耗时：12毫秒', '0', '', '2019-08-29 14:17:40');
INSERT INTO `sys_job_log` VALUES ('371', 'API_SERVER_CHECK_8', 'API_SERVER_CHECK', 'apiServerCheck.check(8L)', 'API_SERVER_CHECK_8 总共耗时：13毫秒', '0', '', '2019-08-29 14:18:40');
INSERT INTO `sys_job_log` VALUES ('372', 'API_SERVER_CHECK_8', 'API_SERVER_CHECK', 'apiServerCheck.check(8L)', 'API_SERVER_CHECK_8 总共耗时：15毫秒', '0', '', '2019-08-29 14:19:40');
INSERT INTO `sys_job_log` VALUES ('373', 'API_SERVER_CHECK_8', 'API_SERVER_CHECK', 'apiServerCheck.check(8L)', 'API_SERVER_CHECK_8 总共耗时：12毫秒', '0', '', '2019-08-29 14:20:40');
INSERT INTO `sys_job_log` VALUES ('374', 'API_SERVER_CHECK_8', 'API_SERVER_CHECK', 'apiServerCheck.check(8L)', 'API_SERVER_CHECK_8 总共耗时：12毫秒', '0', '', '2019-08-29 14:21:40');
INSERT INTO `sys_job_log` VALUES ('375', 'API_SERVER_CHECK_8', 'API_SERVER_CHECK', 'apiServerCheck.check(8L)', 'API_SERVER_CHECK_8 总共耗时：13毫秒', '0', '', '2019-08-29 14:22:40');
INSERT INTO `sys_job_log` VALUES ('376', 'API_SERVER_CHECK_8', 'API_SERVER_CHECK', 'apiServerCheck.check(8L)', 'API_SERVER_CHECK_8 总共耗时：12毫秒', '0', '', '2019-08-29 14:23:40');
INSERT INTO `sys_job_log` VALUES ('377', 'API_SERVER_CHECK_8', 'API_SERVER_CHECK', 'apiServerCheck.check(8L)', 'API_SERVER_CHECK_8 总共耗时：12毫秒', '0', '', '2019-08-29 14:24:40');
INSERT INTO `sys_job_log` VALUES ('378', 'API_SERVER_CHECK_8', 'API_SERVER_CHECK', 'apiServerCheck.check(8L)', 'API_SERVER_CHECK_8 总共耗时：16毫秒', '0', '', '2019-08-29 14:25:40');
INSERT INTO `sys_job_log` VALUES ('379', 'API_SERVER_CHECK_8', 'API_SERVER_CHECK', 'apiServerCheck.check(8L)', 'API_SERVER_CHECK_8 总共耗时：20毫秒', '0', '', '2019-08-29 14:27:40');
INSERT INTO `sys_job_log` VALUES ('380', 'API_SERVER_CHECK_8', 'API_SERVER_CHECK', 'apiServerCheck.check(8L)', 'API_SERVER_CHECK_8 总共耗时：13毫秒', '0', '', '2019-08-29 14:28:40');
INSERT INTO `sys_job_log` VALUES ('381', 'API_SERVER_CHECK_8', 'API_SERVER_CHECK', 'apiServerCheck.check(8L)', 'API_SERVER_CHECK_8 总共耗时：13毫秒', '0', '', '2019-08-29 14:29:40');
INSERT INTO `sys_job_log` VALUES ('382', 'API_SERVER_CHECK_8', 'API_SERVER_CHECK', 'apiServerCheck.check(8L)', 'API_SERVER_CHECK_8 总共耗时：16毫秒', '0', '', '2019-08-29 14:33:40');
INSERT INTO `sys_job_log` VALUES ('383', 'API_SERVER_CHECK_8', 'API_SERVER_CHECK', 'apiServerCheck.check(8L)', 'API_SERVER_CHECK_8 总共耗时：11毫秒', '0', '', '2019-08-29 14:34:40');
INSERT INTO `sys_job_log` VALUES ('384', 'API_SERVER_CHECK_8', 'API_SERVER_CHECK', 'apiServerCheck.check(8L)', 'API_SERVER_CHECK_8 总共耗时：12毫秒', '0', '', '2019-08-29 14:35:40');
INSERT INTO `sys_job_log` VALUES ('385', 'API_SERVER_CHECK_8', 'API_SERVER_CHECK', 'apiServerCheck.check(8L)', 'API_SERVER_CHECK_8 总共耗时：12毫秒', '0', '', '2019-08-29 14:36:40');
INSERT INTO `sys_job_log` VALUES ('386', 'API_SERVER_CHECK_8', 'API_SERVER_CHECK', 'apiServerCheck.check(8L)', 'API_SERVER_CHECK_8 总共耗时：13毫秒', '0', '', '2019-08-29 14:37:40');
INSERT INTO `sys_job_log` VALUES ('387', 'API_SERVER_CHECK_8', 'API_SERVER_CHECK', 'apiServerCheck.check(8L)', 'API_SERVER_CHECK_8 总共耗时：13毫秒', '0', '', '2019-08-29 14:38:40');
INSERT INTO `sys_job_log` VALUES ('388', 'API_SERVER_CHECK_8', 'API_SERVER_CHECK', 'apiServerCheck.check(8L)', 'API_SERVER_CHECK_8 总共耗时：16毫秒', '0', '', '2019-08-29 14:39:40');
INSERT INTO `sys_job_log` VALUES ('389', 'API_SERVER_CHECK_8', 'API_SERVER_CHECK', 'apiServerCheck.check(8L)', 'API_SERVER_CHECK_8 总共耗时：149毫秒', '0', '', '2019-08-29 14:41:40');
INSERT INTO `sys_job_log` VALUES ('390', 'API_SERVER_CHECK_8', 'API_SERVER_CHECK', 'apiServerCheck.check(8L)', 'API_SERVER_CHECK_8 总共耗时：22毫秒', '0', '', '2019-08-29 14:42:40');
INSERT INTO `sys_job_log` VALUES ('391', 'API_SERVER_CHECK_8', 'API_SERVER_CHECK', 'apiServerCheck.check(8L)', 'API_SERVER_CHECK_8 总共耗时：13毫秒', '0', '', '2019-08-29 14:43:40');
INSERT INTO `sys_job_log` VALUES ('392', 'API_SERVER_CHECK_8', 'API_SERVER_CHECK', 'apiServerCheck.check(8L)', 'API_SERVER_CHECK_8 总共耗时：12毫秒', '0', '', '2019-08-29 14:44:40');
INSERT INTO `sys_job_log` VALUES ('393', 'API_SERVER_CHECK_8', 'API_SERVER_CHECK', 'apiServerCheck.check(8L)', 'API_SERVER_CHECK_8 总共耗时：15毫秒', '0', '', '2019-08-29 14:45:40');
INSERT INTO `sys_job_log` VALUES ('394', 'API_SERVER_CHECK_8', 'API_SERVER_CHECK', 'apiServerCheck.check(8L)', 'API_SERVER_CHECK_8 总共耗时：13毫秒', '0', '', '2019-08-29 14:46:40');
INSERT INTO `sys_job_log` VALUES ('395', 'API_SERVER_CHECK_8', 'API_SERVER_CHECK', 'apiServerCheck.check(8L)', 'API_SERVER_CHECK_8 总共耗时：11毫秒', '0', '', '2019-08-29 14:47:40');
INSERT INTO `sys_job_log` VALUES ('396', 'API_SERVER_CHECK_8', 'API_SERVER_CHECK', 'apiServerCheck.check(8L)', 'API_SERVER_CHECK_8 总共耗时：12毫秒', '0', '', '2019-08-29 14:48:40');
INSERT INTO `sys_job_log` VALUES ('397', 'API_SERVER_CHECK_8', 'API_SERVER_CHECK', 'apiServerCheck.check(8L)', 'API_SERVER_CHECK_8 总共耗时：12毫秒', '0', '', '2019-08-29 14:49:40');
INSERT INTO `sys_job_log` VALUES ('398', 'API_SERVER_CHECK_8', 'API_SERVER_CHECK', 'apiServerCheck.check(8L)', 'API_SERVER_CHECK_8 总共耗时：15毫秒', '0', '', '2019-08-29 14:50:40');
INSERT INTO `sys_job_log` VALUES ('399', 'API_SERVER_CHECK_8', 'API_SERVER_CHECK', 'apiServerCheck.check(8L)', 'API_SERVER_CHECK_8 总共耗时：11毫秒', '0', '', '2019-08-29 14:51:40');
INSERT INTO `sys_job_log` VALUES ('400', 'API_SERVER_CHECK_8', 'API_SERVER_CHECK', 'apiServerCheck.check(8L)', 'API_SERVER_CHECK_8 总共耗时：14毫秒', '0', '', '2019-08-29 14:52:40');
INSERT INTO `sys_job_log` VALUES ('401', 'API_SERVER_CHECK_8', 'API_SERVER_CHECK', 'apiServerCheck.check(8L)', 'API_SERVER_CHECK_8 总共耗时：12毫秒', '0', '', '2019-08-29 14:53:40');
INSERT INTO `sys_job_log` VALUES ('402', 'API_SERVER_CHECK_8', 'API_SERVER_CHECK', 'apiServerCheck.check(8L)', 'API_SERVER_CHECK_8 总共耗时：11毫秒', '0', '', '2019-08-29 14:54:40');
INSERT INTO `sys_job_log` VALUES ('403', 'API_SERVER_CHECK_8', 'API_SERVER_CHECK', 'apiServerCheck.check(8L)', 'API_SERVER_CHECK_8 总共耗时：12毫秒', '0', '', '2019-08-29 14:55:40');
INSERT INTO `sys_job_log` VALUES ('404', 'API_SERVER_CHECK_8', 'API_SERVER_CHECK', 'apiServerCheck.check(8L)', 'API_SERVER_CHECK_8 总共耗时：13毫秒', '0', '', '2019-08-29 14:56:40');
INSERT INTO `sys_job_log` VALUES ('405', 'API_SERVER_CHECK_8', 'API_SERVER_CHECK', 'apiServerCheck.check(8L)', 'API_SERVER_CHECK_8 总共耗时：12毫秒', '0', '', '2019-08-29 14:57:40');
INSERT INTO `sys_job_log` VALUES ('406', 'API_SERVER_CHECK_8', 'API_SERVER_CHECK', 'apiServerCheck.check(8L)', 'API_SERVER_CHECK_8 总共耗时：11毫秒', '0', '', '2019-08-29 14:58:40');
INSERT INTO `sys_job_log` VALUES ('407', 'API_SERVER_CHECK_8', 'API_SERVER_CHECK', 'apiServerCheck.check(8L)', 'API_SERVER_CHECK_8 总共耗时：12毫秒', '0', '', '2019-08-29 14:59:40');
INSERT INTO `sys_job_log` VALUES ('408', 'API_SERVER_CHECK_8', 'API_SERVER_CHECK', 'apiServerCheck.check(8L)', 'API_SERVER_CHECK_8 总共耗时：13毫秒', '0', '', '2019-08-29 15:00:40');
INSERT INTO `sys_job_log` VALUES ('409', 'API_SERVER_CHECK_8', 'API_SERVER_CHECK', 'apiServerCheck.check(8L)', 'API_SERVER_CHECK_8 总共耗时：11毫秒', '0', '', '2019-08-29 15:01:40');
INSERT INTO `sys_job_log` VALUES ('410', 'API_SERVER_CHECK_8', 'API_SERVER_CHECK', 'apiServerCheck.check(8L)', 'API_SERVER_CHECK_8 总共耗时：13毫秒', '0', '', '2019-08-29 15:02:40');
INSERT INTO `sys_job_log` VALUES ('411', 'API_SERVER_CHECK_8', 'API_SERVER_CHECK', 'apiServerCheck.check(8L)', 'API_SERVER_CHECK_8 总共耗时：12毫秒', '0', '', '2019-08-29 15:03:40');
INSERT INTO `sys_job_log` VALUES ('412', 'API_SERVER_CHECK_8', 'API_SERVER_CHECK', 'apiServerCheck.check(8L)', 'API_SERVER_CHECK_8 总共耗时：14毫秒', '0', '', '2019-08-29 15:04:40');
INSERT INTO `sys_job_log` VALUES ('413', 'API_SERVER_CHECK_8', 'API_SERVER_CHECK', 'apiServerCheck.check(8L)', 'API_SERVER_CHECK_8 总共耗时：14毫秒', '0', '', '2019-08-29 15:05:40');
INSERT INTO `sys_job_log` VALUES ('414', 'API_SERVER_CHECK_8', 'API_SERVER_CHECK', 'apiServerCheck.check(8L)', 'API_SERVER_CHECK_8 总共耗时：14毫秒', '0', '', '2019-08-29 15:06:40');
INSERT INTO `sys_job_log` VALUES ('415', 'API_SERVER_CHECK_8', 'API_SERVER_CHECK', 'apiServerCheck.check(8L)', 'API_SERVER_CHECK_8 总共耗时：12毫秒', '0', '', '2019-08-29 15:07:40');
INSERT INTO `sys_job_log` VALUES ('416', 'API_SERVER_CHECK_8', 'API_SERVER_CHECK', 'apiServerCheck.check(8L)', 'API_SERVER_CHECK_8 总共耗时：13毫秒', '0', '', '2019-08-29 15:08:40');
INSERT INTO `sys_job_log` VALUES ('417', 'API_SERVER_CHECK_8', 'API_SERVER_CHECK', 'apiServerCheck.check(8L)', 'API_SERVER_CHECK_8 总共耗时：13毫秒', '0', '', '2019-08-29 15:09:40');
INSERT INTO `sys_job_log` VALUES ('418', 'API_SERVER_CHECK_8', 'API_SERVER_CHECK', 'apiServerCheck.check(8L)', 'API_SERVER_CHECK_8 总共耗时：11毫秒', '0', '', '2019-08-29 15:10:40');
INSERT INTO `sys_job_log` VALUES ('419', 'API_SERVER_CHECK_8', 'API_SERVER_CHECK', 'apiServerCheck.check(8L)', 'API_SERVER_CHECK_8 总共耗时：13毫秒', '0', '', '2019-08-29 15:11:40');
INSERT INTO `sys_job_log` VALUES ('420', 'API_SERVER_CHECK_8', 'API_SERVER_CHECK', 'apiServerCheck.check(8L)', 'API_SERVER_CHECK_8 总共耗时：11毫秒', '0', '', '2019-08-29 15:12:40');
INSERT INTO `sys_job_log` VALUES ('421', 'API_SERVER_CHECK_8', 'API_SERVER_CHECK', 'apiServerCheck.check(8L)', 'API_SERVER_CHECK_8 总共耗时：13毫秒', '0', '', '2019-08-29 15:13:40');
INSERT INTO `sys_job_log` VALUES ('422', 'API_SERVER_CHECK_8', 'API_SERVER_CHECK', 'apiServerCheck.check(8L)', 'API_SERVER_CHECK_8 总共耗时：11毫秒', '0', '', '2019-08-29 15:14:40');
INSERT INTO `sys_job_log` VALUES ('423', 'API_SERVER_CHECK_8', 'API_SERVER_CHECK', 'apiServerCheck.check(8L)', 'API_SERVER_CHECK_8 总共耗时：14毫秒', '0', '', '2019-08-29 15:15:40');
INSERT INTO `sys_job_log` VALUES ('424', 'API_SERVER_CHECK_8', 'API_SERVER_CHECK', 'apiServerCheck.check(8L)', 'API_SERVER_CHECK_8 总共耗时：13毫秒', '0', '', '2019-08-29 15:16:40');
INSERT INTO `sys_job_log` VALUES ('425', 'API_SERVER_CHECK_8', 'API_SERVER_CHECK', 'apiServerCheck.check(8L)', 'API_SERVER_CHECK_8 总共耗时：15毫秒', '0', '', '2019-08-29 15:17:40');
INSERT INTO `sys_job_log` VALUES ('426', 'API_SERVER_CHECK_8', 'API_SERVER_CHECK', 'apiServerCheck.check(8L)', 'API_SERVER_CHECK_8 总共耗时：11毫秒', '0', '', '2019-08-29 15:18:40');
INSERT INTO `sys_job_log` VALUES ('427', 'API_SERVER_CHECK_8', 'API_SERVER_CHECK', 'apiServerCheck.check(8L)', 'API_SERVER_CHECK_8 总共耗时：12毫秒', '0', '', '2019-08-29 15:19:40');
INSERT INTO `sys_job_log` VALUES ('428', 'API_SERVER_CHECK_8', 'API_SERVER_CHECK', 'apiServerCheck.check(8L)', 'API_SERVER_CHECK_8 总共耗时：12毫秒', '0', '', '2019-08-29 15:20:40');
INSERT INTO `sys_job_log` VALUES ('429', 'API_SERVER_CHECK_8', 'API_SERVER_CHECK', 'apiServerCheck.check(8L)', 'API_SERVER_CHECK_8 总共耗时：18毫秒', '0', '', '2019-08-29 15:21:40');
INSERT INTO `sys_job_log` VALUES ('430', 'API_SERVER_CHECK_8', 'API_SERVER_CHECK', 'apiServerCheck.check(8L)', 'API_SERVER_CHECK_8 总共耗时：11毫秒', '0', '', '2019-08-29 15:22:40');
INSERT INTO `sys_job_log` VALUES ('431', 'API_SERVER_CHECK_8', 'API_SERVER_CHECK', 'apiServerCheck.check(8L)', 'API_SERVER_CHECK_8 总共耗时：11毫秒', '0', '', '2019-08-29 15:23:40');
INSERT INTO `sys_job_log` VALUES ('432', 'API_SERVER_CHECK_8', 'API_SERVER_CHECK', 'apiServerCheck.check(8L)', 'API_SERVER_CHECK_8 总共耗时：11毫秒', '0', '', '2019-08-29 15:24:40');
INSERT INTO `sys_job_log` VALUES ('433', 'API_SERVER_CHECK_8', 'API_SERVER_CHECK', 'apiServerCheck.check(8L)', 'API_SERVER_CHECK_8 总共耗时：13毫秒', '0', '', '2019-08-29 15:25:40');
INSERT INTO `sys_job_log` VALUES ('434', 'API_SERVER_CHECK_8', 'API_SERVER_CHECK', 'apiServerCheck.check(8L)', 'API_SERVER_CHECK_8 总共耗时：13毫秒', '0', '', '2019-08-29 15:26:40');
INSERT INTO `sys_job_log` VALUES ('435', 'API_SERVER_CHECK_8', 'API_SERVER_CHECK', 'apiServerCheck.check(8L)', 'API_SERVER_CHECK_8 总共耗时：12毫秒', '0', '', '2019-08-29 15:27:40');
INSERT INTO `sys_job_log` VALUES ('436', 'API_SERVER_CHECK_8', 'API_SERVER_CHECK', 'apiServerCheck.check(8L)', 'API_SERVER_CHECK_8 总共耗时：11毫秒', '0', '', '2019-08-29 15:28:40');
INSERT INTO `sys_job_log` VALUES ('437', 'API_SERVER_CHECK_8', 'API_SERVER_CHECK', 'apiServerCheck.check(8L)', 'API_SERVER_CHECK_8 总共耗时：11毫秒', '0', '', '2019-08-29 15:29:40');
INSERT INTO `sys_job_log` VALUES ('438', 'API_SERVER_CHECK_8', 'API_SERVER_CHECK', 'apiServerCheck.check(8L)', 'API_SERVER_CHECK_8 总共耗时：13毫秒', '0', '', '2019-08-29 15:30:40');
INSERT INTO `sys_job_log` VALUES ('439', 'API_SERVER_CHECK_8', 'API_SERVER_CHECK', 'apiServerCheck.check(8L)', 'API_SERVER_CHECK_8 总共耗时：11毫秒', '0', '', '2019-08-29 15:31:40');
INSERT INTO `sys_job_log` VALUES ('440', 'API_SERVER_CHECK_8', 'API_SERVER_CHECK', 'apiServerCheck.check(8L)', 'API_SERVER_CHECK_8 总共耗时：11毫秒', '0', '', '2019-08-29 15:32:40');
INSERT INTO `sys_job_log` VALUES ('441', 'API_SERVER_CHECK_8', 'API_SERVER_CHECK', 'apiServerCheck.check(8L)', 'API_SERVER_CHECK_8 总共耗时：10毫秒', '0', '', '2019-08-29 15:33:40');
INSERT INTO `sys_job_log` VALUES ('442', 'API_SERVER_CHECK_8', 'API_SERVER_CHECK', 'apiServerCheck.check(8L)', 'API_SERVER_CHECK_8 总共耗时：12毫秒', '0', '', '2019-08-29 15:34:40');
INSERT INTO `sys_job_log` VALUES ('443', 'API_SERVER_CHECK_8', 'API_SERVER_CHECK', 'apiServerCheck.check(8L)', 'API_SERVER_CHECK_8 总共耗时：13毫秒', '0', '', '2019-08-29 15:35:40');
INSERT INTO `sys_job_log` VALUES ('444', 'API_SERVER_CHECK_8', 'API_SERVER_CHECK', 'apiServerCheck.check(8L)', 'API_SERVER_CHECK_8 总共耗时：11毫秒', '0', '', '2019-08-29 15:36:40');
INSERT INTO `sys_job_log` VALUES ('445', 'API_SERVER_CHECK_8', 'API_SERVER_CHECK', 'apiServerCheck.check(8L)', 'API_SERVER_CHECK_8 总共耗时：11毫秒', '0', '', '2019-08-29 15:37:40');
INSERT INTO `sys_job_log` VALUES ('446', 'API_SERVER_CHECK_8', 'API_SERVER_CHECK', 'apiServerCheck.check(8L)', 'API_SERVER_CHECK_8 总共耗时：14毫秒', '0', '', '2019-08-29 15:38:40');
INSERT INTO `sys_job_log` VALUES ('447', 'API_SERVER_CHECK_8', 'API_SERVER_CHECK', 'apiServerCheck.check(8L)', 'API_SERVER_CHECK_8 总共耗时：17毫秒', '0', '', '2019-08-29 15:39:40');
INSERT INTO `sys_job_log` VALUES ('448', 'API_SERVER_CHECK_8', 'API_SERVER_CHECK', 'apiServerCheck.check(8L)', 'API_SERVER_CHECK_8 总共耗时：11毫秒', '0', '', '2019-08-29 15:40:40');
INSERT INTO `sys_job_log` VALUES ('449', 'API_SERVER_CHECK_8', 'API_SERVER_CHECK', 'apiServerCheck.check(8L)', 'API_SERVER_CHECK_8 总共耗时：10毫秒', '0', '', '2019-08-29 15:41:40');
INSERT INTO `sys_job_log` VALUES ('450', 'API_SERVER_CHECK_8', 'API_SERVER_CHECK', 'apiServerCheck.check(8L)', 'API_SERVER_CHECK_8 总共耗时：15毫秒', '0', '', '2019-08-29 15:42:40');
INSERT INTO `sys_job_log` VALUES ('451', 'API_SERVER_CHECK_8', 'API_SERVER_CHECK', 'apiServerCheck.check(8L)', 'API_SERVER_CHECK_8 总共耗时：12毫秒', '0', '', '2019-08-29 15:43:40');
INSERT INTO `sys_job_log` VALUES ('452', 'API_SERVER_CHECK_8', 'API_SERVER_CHECK', 'apiServerCheck.check(8L)', 'API_SERVER_CHECK_8 总共耗时：11毫秒', '0', '', '2019-08-29 15:44:40');
INSERT INTO `sys_job_log` VALUES ('453', 'API_SERVER_CHECK_8', 'API_SERVER_CHECK', 'apiServerCheck.check(8L)', 'API_SERVER_CHECK_8 总共耗时：12毫秒', '0', '', '2019-08-29 15:45:40');
INSERT INTO `sys_job_log` VALUES ('454', 'API_SERVER_CHECK_8', 'API_SERVER_CHECK', 'apiServerCheck.check(8L)', 'API_SERVER_CHECK_8 总共耗时：11毫秒', '0', '', '2019-08-29 15:46:40');
INSERT INTO `sys_job_log` VALUES ('455', 'API_SERVER_CHECK_8', 'API_SERVER_CHECK', 'apiServerCheck.check(8L)', 'API_SERVER_CHECK_8 总共耗时：11毫秒', '0', '', '2019-08-29 15:47:40');
INSERT INTO `sys_job_log` VALUES ('456', 'API_SERVER_CHECK_8', 'API_SERVER_CHECK', 'apiServerCheck.check(8L)', 'API_SERVER_CHECK_8 总共耗时：11毫秒', '0', '', '2019-08-29 15:48:40');
INSERT INTO `sys_job_log` VALUES ('457', 'API_SERVER_CHECK_8', 'API_SERVER_CHECK', 'apiServerCheck.check(8L)', 'API_SERVER_CHECK_8 总共耗时：12毫秒', '0', '', '2019-08-29 15:49:40');
INSERT INTO `sys_job_log` VALUES ('458', 'API_SERVER_CHECK_8', 'API_SERVER_CHECK', 'apiServerCheck.check(8L)', 'API_SERVER_CHECK_8 总共耗时：12毫秒', '0', '', '2019-08-29 15:50:40');
INSERT INTO `sys_job_log` VALUES ('459', 'API_SERVER_CHECK_8', 'API_SERVER_CHECK', 'apiServerCheck.check(8L)', 'API_SERVER_CHECK_8 总共耗时：13毫秒', '0', '', '2019-08-29 15:51:40');
INSERT INTO `sys_job_log` VALUES ('460', 'API_SERVER_CHECK_8', 'API_SERVER_CHECK', 'apiServerCheck.check(8L)', 'API_SERVER_CHECK_8 总共耗时：12毫秒', '0', '', '2019-08-29 15:52:40');
INSERT INTO `sys_job_log` VALUES ('461', 'API_SERVER_CHECK_8', 'API_SERVER_CHECK', 'apiServerCheck.check(8L)', 'API_SERVER_CHECK_8 总共耗时：14毫秒', '0', '', '2019-08-29 15:53:40');
INSERT INTO `sys_job_log` VALUES ('462', 'API_SERVER_CHECK_8', 'API_SERVER_CHECK', 'apiServerCheck.check(8L)', 'API_SERVER_CHECK_8 总共耗时：14毫秒', '0', '', '2019-08-29 15:54:40');
INSERT INTO `sys_job_log` VALUES ('463', 'API_SERVER_CHECK_8', 'API_SERVER_CHECK', 'apiServerCheck.check(8L)', 'API_SERVER_CHECK_8 总共耗时：10毫秒', '0', '', '2019-08-29 15:55:40');
INSERT INTO `sys_job_log` VALUES ('464', 'API_SERVER_CHECK_8', 'API_SERVER_CHECK', 'apiServerCheck.check(8L)', 'API_SERVER_CHECK_8 总共耗时：14毫秒', '0', '', '2019-08-29 15:56:40');
INSERT INTO `sys_job_log` VALUES ('465', 'API_SERVER_CHECK_8', 'API_SERVER_CHECK', 'apiServerCheck.check(8L)', 'API_SERVER_CHECK_8 总共耗时：11毫秒', '0', '', '2019-08-29 15:57:40');
INSERT INTO `sys_job_log` VALUES ('466', 'API_SERVER_CHECK_8', 'API_SERVER_CHECK', 'apiServerCheck.check(8L)', 'API_SERVER_CHECK_8 总共耗时：11毫秒', '0', '', '2019-08-29 15:58:40');
INSERT INTO `sys_job_log` VALUES ('467', 'API_SERVER_CHECK_8', 'API_SERVER_CHECK', 'apiServerCheck.check(8L)', 'API_SERVER_CHECK_8 总共耗时：16毫秒', '0', '', '2019-08-29 15:59:40');
INSERT INTO `sys_job_log` VALUES ('468', 'API_SERVER_CHECK_8', 'API_SERVER_CHECK', 'apiServerCheck.check(8L)', 'API_SERVER_CHECK_8 总共耗时：11毫秒', '0', '', '2019-08-29 16:00:40');
INSERT INTO `sys_job_log` VALUES ('469', 'API_SERVER_CHECK_8', 'API_SERVER_CHECK', 'apiServerCheck.check(8L)', 'API_SERVER_CHECK_8 总共耗时：10毫秒', '0', '', '2019-08-29 16:01:40');
INSERT INTO `sys_job_log` VALUES ('470', 'API_SERVER_CHECK_8', 'API_SERVER_CHECK', 'apiServerCheck.check(8L)', 'API_SERVER_CHECK_8 总共耗时：13毫秒', '0', '', '2019-08-29 16:02:40');
INSERT INTO `sys_job_log` VALUES ('471', 'API_SERVER_CHECK_8', 'API_SERVER_CHECK', 'apiServerCheck.check(8L)', 'API_SERVER_CHECK_8 总共耗时：13毫秒', '0', '', '2019-08-29 16:03:40');
INSERT INTO `sys_job_log` VALUES ('472', 'API_SERVER_CHECK_8', 'API_SERVER_CHECK', 'apiServerCheck.check(8L)', 'API_SERVER_CHECK_8 总共耗时：10毫秒', '0', '', '2019-08-29 16:04:40');
INSERT INTO `sys_job_log` VALUES ('473', 'API_SERVER_CHECK_8', 'API_SERVER_CHECK', 'apiServerCheck.check(8L)', 'API_SERVER_CHECK_8 总共耗时：11毫秒', '0', '', '2019-08-29 16:05:40');
INSERT INTO `sys_job_log` VALUES ('474', 'API_SERVER_CHECK_8', 'API_SERVER_CHECK', 'apiServerCheck.check(8L)', 'API_SERVER_CHECK_8 总共耗时：13毫秒', '0', '', '2019-08-29 16:06:40');
INSERT INTO `sys_job_log` VALUES ('475', 'API_SERVER_CHECK_8', 'API_SERVER_CHECK', 'apiServerCheck.check(8L)', 'API_SERVER_CHECK_8 总共耗时：10毫秒', '0', '', '2019-08-29 16:07:40');
INSERT INTO `sys_job_log` VALUES ('476', 'API_SERVER_CHECK_8', 'API_SERVER_CHECK', 'apiServerCheck.check(8L)', 'API_SERVER_CHECK_8 总共耗时：12毫秒', '0', '', '2019-08-29 16:08:40');
INSERT INTO `sys_job_log` VALUES ('477', 'API_SERVER_CHECK_8', 'API_SERVER_CHECK', 'apiServerCheck.check(8L)', 'API_SERVER_CHECK_8 总共耗时：11毫秒', '0', '', '2019-08-29 16:09:40');
INSERT INTO `sys_job_log` VALUES ('478', 'API_SERVER_CHECK_8', 'API_SERVER_CHECK', 'apiServerCheck.check(8L)', 'API_SERVER_CHECK_8 总共耗时：11毫秒', '0', '', '2019-08-29 16:10:40');
INSERT INTO `sys_job_log` VALUES ('479', 'API_SERVER_CHECK_8', 'API_SERVER_CHECK', 'apiServerCheck.check(8L)', 'API_SERVER_CHECK_8 总共耗时：12毫秒', '0', '', '2019-08-29 16:11:40');

-- ----------------------------
-- Table structure for sys_logininfor
-- ----------------------------
DROP TABLE IF EXISTS `sys_logininfor`;
CREATE TABLE `sys_logininfor` (
  `info_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '访问ID',
  `login_name` varchar(50) DEFAULT '' COMMENT '登录账号',
  `ipaddr` varchar(50) DEFAULT '' COMMENT '登录IP地址',
  `login_location` varchar(255) DEFAULT '' COMMENT '登录地点',
  `browser` varchar(50) DEFAULT '' COMMENT '浏览器类型',
  `os` varchar(50) DEFAULT '' COMMENT '操作系统',
  `status` char(1) DEFAULT '0' COMMENT '登录状态（0成功 1失败）',
  `msg` varchar(255) DEFAULT '' COMMENT '提示消息',
  `login_time` datetime DEFAULT NULL COMMENT '访问时间',
  PRIMARY KEY (`info_id`)
) ENGINE=InnoDB AUTO_INCREMENT=214 DEFAULT CHARSET=utf8 COMMENT='系统访问记录';

-- ----------------------------
-- Records of sys_logininfor
-- ----------------------------
INSERT INTO `sys_logininfor` VALUES ('100', 'admin', '127.0.0.1', '内网IP', 'Chrome', 'Windows 7', '1', '密码输入错误1次', '2019-08-05 14:03:38');
INSERT INTO `sys_logininfor` VALUES ('101', 'admin', '127.0.0.1', '内网IP', 'Chrome', 'Windows 7', '0', '登录成功', '2019-08-05 14:03:45');
INSERT INTO `sys_logininfor` VALUES ('102', 'admin', '127.0.0.1', '内网IP', 'Chrome', 'Windows 7', '0', '退出成功', '2019-08-05 17:02:02');
INSERT INTO `sys_logininfor` VALUES ('103', 'admin', '127.0.0.1', '内网IP', 'Chrome', 'Windows 7', '0', '登录成功', '2019-08-05 17:02:06');
INSERT INTO `sys_logininfor` VALUES ('104', 'admin', '127.0.0.1', '内网IP', 'Chrome', 'Windows 7', '0', '退出成功', '2019-08-12 15:22:15');
INSERT INTO `sys_logininfor` VALUES ('105', 'admin', '127.0.0.1', '内网IP', 'Chrome', 'Windows 7', '1', '验证码错误', '2019-08-12 15:22:16');
INSERT INTO `sys_logininfor` VALUES ('106', 'admin', '127.0.0.1', '内网IP', 'Chrome', 'Windows 7', '0', '登录成功', '2019-08-12 15:22:19');
INSERT INTO `sys_logininfor` VALUES ('107', 'admin', '127.0.0.1', '内网IP', 'Chrome', 'Windows 7', '1', '验证码错误', '2019-08-12 16:18:12');
INSERT INTO `sys_logininfor` VALUES ('108', 'admin', '127.0.0.1', '内网IP', 'Chrome', 'Windows 7', '0', '登录成功', '2019-08-12 16:18:14');
INSERT INTO `sys_logininfor` VALUES ('109', 'admin', '127.0.0.1', '内网IP', 'Chrome', 'Windows 7', '0', '登录成功', '2019-08-12 16:22:47');
INSERT INTO `sys_logininfor` VALUES ('110', 'admin', '127.0.0.1', '内网IP', 'Chrome', 'Windows 7', '1', '验证码错误', '2019-08-13 09:51:58');
INSERT INTO `sys_logininfor` VALUES ('111', 'admin', '127.0.0.1', '内网IP', 'Chrome', 'Windows 7', '0', '登录成功', '2019-08-13 09:52:06');
INSERT INTO `sys_logininfor` VALUES ('112', 'admin', '127.0.0.1', '内网IP', 'Chrome', 'Windows 7', '0', '登录成功', '2019-08-13 13:35:20');
INSERT INTO `sys_logininfor` VALUES ('113', 'admin', '127.0.0.1', '内网IP', 'Chrome', 'Windows 7', '0', '登录成功', '2019-08-13 15:12:35');
INSERT INTO `sys_logininfor` VALUES ('114', 'admin', '127.0.0.1', '内网IP', 'Chrome', 'Windows 7', '0', '登录成功', '2019-08-13 17:08:53');
INSERT INTO `sys_logininfor` VALUES ('115', 'admin', '127.0.0.1', '内网IP', 'Chrome', 'Windows 7', '0', '登录成功', '2019-08-14 09:19:22');
INSERT INTO `sys_logininfor` VALUES ('116', 'admin', '127.0.0.1', '内网IP', 'Chrome', 'Windows 7', '0', '登录成功', '2019-08-14 10:35:39');
INSERT INTO `sys_logininfor` VALUES ('117', 'admin', '127.0.0.1', '内网IP', 'Chrome', 'Windows 7', '0', '登录成功', '2019-08-14 11:27:28');
INSERT INTO `sys_logininfor` VALUES ('118', 'admin', '127.0.0.1', '内网IP', 'Chrome', 'Windows 7', '0', '登录成功', '2019-08-14 14:03:39');
INSERT INTO `sys_logininfor` VALUES ('119', 'admin', '127.0.0.1', '内网IP', 'Chrome', 'Windows 7', '0', '登录成功', '2019-08-14 15:17:03');
INSERT INTO `sys_logininfor` VALUES ('120', 'admin', '127.0.0.1', '内网IP', 'Chrome', 'Windows 7', '0', '登录成功', '2019-08-14 16:03:24');
INSERT INTO `sys_logininfor` VALUES ('121', 'admin', '127.0.0.1', '内网IP', 'Chrome', 'Windows 7', '0', '登录成功', '2019-08-14 16:56:35');
INSERT INTO `sys_logininfor` VALUES ('122', 'admin', '127.0.0.1', '内网IP', 'Chrome', 'Windows 7', '0', '登录成功', '2019-08-15 00:15:22');
INSERT INTO `sys_logininfor` VALUES ('123', 'admin', '127.0.0.1', '内网IP', 'Chrome', 'Windows 7', '0', '登录成功', '2019-08-15 09:40:27');
INSERT INTO `sys_logininfor` VALUES ('124', 'admin', '127.0.0.1', '内网IP', 'Chrome', 'Windows 7', '0', '登录成功', '2019-08-15 14:17:43');
INSERT INTO `sys_logininfor` VALUES ('125', 'admin', '127.0.0.1', '内网IP', 'Chrome', 'Windows 7', '0', '登录成功', '2019-08-15 14:21:36');
INSERT INTO `sys_logininfor` VALUES ('126', 'admin', '127.0.0.1', '内网IP', 'Chrome', 'Windows 7', '0', '登录成功', '2019-08-15 15:38:24');
INSERT INTO `sys_logininfor` VALUES ('127', 'admin', '127.0.0.1', '内网IP', 'Chrome', 'Windows 7', '0', '登录成功', '2019-08-15 17:17:25');
INSERT INTO `sys_logininfor` VALUES ('128', 'admin', '127.0.0.1', '内网IP', 'Chrome', 'Windows 7', '1', '验证码错误', '2019-08-16 14:44:12');
INSERT INTO `sys_logininfor` VALUES ('129', 'admin', '127.0.0.1', '内网IP', 'Chrome', 'Windows 7', '0', '登录成功', '2019-08-16 14:44:15');
INSERT INTO `sys_logininfor` VALUES ('130', 'admin', '127.0.0.1', '内网IP', 'Chrome', 'Windows 7', '0', '登录成功', '2019-08-19 09:17:45');
INSERT INTO `sys_logininfor` VALUES ('131', 'admin', '127.0.0.1', '内网IP', 'Chrome', 'Windows 7', '0', '登录成功', '2019-08-19 11:40:02');
INSERT INTO `sys_logininfor` VALUES ('132', 'admin', '127.0.0.1', '内网IP', 'Chrome', 'Windows 7', '0', '登录成功', '2019-08-19 16:15:34');
INSERT INTO `sys_logininfor` VALUES ('133', 'admin', '127.0.0.1', '内网IP', 'Chrome', 'Windows 7', '0', '登录成功', '2019-08-20 10:04:26');
INSERT INTO `sys_logininfor` VALUES ('134', 'admin', '127.0.0.1', '内网IP', 'Chrome', 'Windows 7', '0', '登录成功', '2019-08-20 10:40:59');
INSERT INTO `sys_logininfor` VALUES ('135', 'admin', '127.0.0.1', '内网IP', 'Chrome', 'Windows 7', '1', '验证码错误', '2019-08-20 17:12:51');
INSERT INTO `sys_logininfor` VALUES ('136', 'admin', '127.0.0.1', '内网IP', 'Chrome', 'Windows 7', '0', '登录成功', '2019-08-20 17:12:53');
INSERT INTO `sys_logininfor` VALUES ('137', 'admin', '127.0.0.1', '内网IP', 'Chrome', 'Windows 7', '0', '登录成功', '2019-08-21 10:07:16');
INSERT INTO `sys_logininfor` VALUES ('138', 'admin', '127.0.0.1', '内网IP', 'Chrome', 'Windows 7', '1', '验证码错误', '2019-08-21 11:32:53');
INSERT INTO `sys_logininfor` VALUES ('139', 'admin', '127.0.0.1', '内网IP', 'Chrome', 'Windows 7', '0', '登录成功', '2019-08-21 11:32:56');
INSERT INTO `sys_logininfor` VALUES ('140', 'admin', '127.0.0.1', '内网IP', 'Chrome', 'Windows 7', '0', '登录成功', '2019-08-21 13:47:33');
INSERT INTO `sys_logininfor` VALUES ('141', 'admin', '127.0.0.1', '内网IP', 'Chrome', 'Windows 7', '0', '登录成功', '2019-08-21 14:35:16');
INSERT INTO `sys_logininfor` VALUES ('142', 'admin', '127.0.0.1', '内网IP', 'Chrome', 'Windows 7', '0', '登录成功', '2019-08-21 14:56:51');
INSERT INTO `sys_logininfor` VALUES ('143', 'admin', '127.0.0.1', '内网IP', 'Chrome', 'Windows 7', '0', '登录成功', '2019-08-21 15:04:54');
INSERT INTO `sys_logininfor` VALUES ('144', 'admin', '127.0.0.1', '内网IP', 'Chrome', 'Windows 7', '0', '登录成功', '2019-08-21 15:48:54');
INSERT INTO `sys_logininfor` VALUES ('145', 'admin', '127.0.0.1', '内网IP', 'Chrome', 'Windows 7', '0', '登录成功', '2019-08-21 15:49:33');
INSERT INTO `sys_logininfor` VALUES ('146', 'admin', '127.0.0.1', '内网IP', 'Chrome', 'Windows 7', '0', '登录成功', '2019-08-21 15:53:07');
INSERT INTO `sys_logininfor` VALUES ('147', 'admin', '127.0.0.1', '内网IP', 'Chrome', 'Windows 7', '1', '验证码错误', '2019-08-21 16:17:07');
INSERT INTO `sys_logininfor` VALUES ('148', 'admin', '127.0.0.1', '内网IP', 'Chrome', 'Windows 7', '0', '登录成功', '2019-08-21 16:17:08');
INSERT INTO `sys_logininfor` VALUES ('149', 'admin', '127.0.0.1', '内网IP', 'Chrome', 'Windows 7', '1', '验证码错误', '2019-08-21 16:23:19');
INSERT INTO `sys_logininfor` VALUES ('150', 'admin', '127.0.0.1', '内网IP', 'Chrome', 'Windows 7', '1', '验证码错误', '2019-08-21 16:23:25');
INSERT INTO `sys_logininfor` VALUES ('151', 'admin', '127.0.0.1', '内网IP', 'Chrome', 'Windows 7', '1', '验证码错误', '2019-08-21 16:23:33');
INSERT INTO `sys_logininfor` VALUES ('152', 'admin', '127.0.0.1', '内网IP', 'Chrome', 'Windows 7', '1', '验证码错误', '2019-08-21 16:47:19');
INSERT INTO `sys_logininfor` VALUES ('153', 'admin', '127.0.0.1', '内网IP', 'Chrome', 'Windows 7', '1', '验证码错误', '2019-08-21 16:47:21');
INSERT INTO `sys_logininfor` VALUES ('154', 'admin', '127.0.0.1', '内网IP', 'Chrome', 'Windows 7', '0', '登录成功', '2019-08-21 16:47:24');
INSERT INTO `sys_logininfor` VALUES ('155', 'admin', '127.0.0.1', '内网IP', 'Chrome', 'Windows 7', '0', '登录成功', '2019-08-21 17:07:17');
INSERT INTO `sys_logininfor` VALUES ('156', 'admin', '127.0.0.1', '内网IP', 'Chrome', 'Windows 7', '1', '验证码错误', '2019-08-21 17:14:22');
INSERT INTO `sys_logininfor` VALUES ('157', 'admin', '127.0.0.1', '内网IP', 'Chrome', 'Windows 7', '0', '登录成功', '2019-08-21 17:14:24');
INSERT INTO `sys_logininfor` VALUES ('158', 'admin', '127.0.0.1', '内网IP', 'Chrome', 'Windows 7', '1', '验证码错误', '2019-08-21 17:23:17');
INSERT INTO `sys_logininfor` VALUES ('159', 'admin', '127.0.0.1', '内网IP', 'Chrome', 'Windows 7', '1', '验证码错误', '2019-08-21 17:24:07');
INSERT INTO `sys_logininfor` VALUES ('160', 'admin', '127.0.0.1', '内网IP', 'Chrome', 'Windows 7', '0', '登录成功', '2019-08-22 13:41:59');
INSERT INTO `sys_logininfor` VALUES ('161', 'admin', '127.0.0.1', '内网IP', 'Chrome', 'Windows 7', '0', '登录成功', '2019-08-22 14:00:46');
INSERT INTO `sys_logininfor` VALUES ('162', 'admin', '127.0.0.1', '内网IP', 'Chrome', 'Windows 7', '0', '登录成功', '2019-08-22 15:09:02');
INSERT INTO `sys_logininfor` VALUES ('163', 'admin', '127.0.0.1', '内网IP', 'Chrome', 'Windows 7', '0', '登录成功', '2019-08-22 15:24:20');
INSERT INTO `sys_logininfor` VALUES ('164', 'admin', '127.0.0.1', '内网IP', 'Chrome', 'Windows 7', '0', '登录成功', '2019-08-22 16:38:12');
INSERT INTO `sys_logininfor` VALUES ('165', 'admin', '127.0.0.1', '内网IP', 'Chrome', 'Windows 7', '0', '登录成功', '2019-08-22 17:19:11');
INSERT INTO `sys_logininfor` VALUES ('166', 'admin', '127.0.0.1', '内网IP', 'Chrome', 'Windows 7', '0', '登录成功', '2019-08-22 17:19:30');
INSERT INTO `sys_logininfor` VALUES ('167', 'admin', '127.0.0.1', '内网IP', 'Chrome', 'Windows 7', '0', '登录成功', '2019-08-23 10:04:35');
INSERT INTO `sys_logininfor` VALUES ('168', 'admin', '127.0.0.1', '内网IP', 'Chrome', 'Windows 7', '1', '验证码错误', '2019-08-23 10:20:07');
INSERT INTO `sys_logininfor` VALUES ('169', 'admin', '127.0.0.1', '内网IP', 'Chrome', 'Windows 7', '0', '登录成功', '2019-08-23 10:20:10');
INSERT INTO `sys_logininfor` VALUES ('170', 'admin', '127.0.0.1', '内网IP', 'Chrome', 'Windows 7', '0', '登录成功', '2019-08-23 10:20:33');
INSERT INTO `sys_logininfor` VALUES ('171', 'admin', '127.0.0.1', '内网IP', 'Chrome', 'Windows 7', '0', '登录成功', '2019-08-23 10:56:37');
INSERT INTO `sys_logininfor` VALUES ('172', 'admin', '127.0.0.1', '内网IP', 'Chrome', 'Windows 7', '0', '登录成功', '2019-08-23 17:03:32');
INSERT INTO `sys_logininfor` VALUES ('173', 'admin', '127.0.0.1', '内网IP', 'Chrome', 'Windows 7', '0', '登录成功', '2019-08-23 17:25:11');
INSERT INTO `sys_logininfor` VALUES ('174', 'admin', '127.0.0.1', '内网IP', 'Chrome', 'Windows 7', '0', '登录成功', '2019-08-26 09:42:30');
INSERT INTO `sys_logininfor` VALUES ('175', 'admin', '127.0.0.1', '内网IP', 'Chrome', 'Windows 7', '0', '登录成功', '2019-08-26 09:48:29');
INSERT INTO `sys_logininfor` VALUES ('176', 'admin', '127.0.0.1', '内网IP', 'Chrome', 'Windows 7', '0', '登录成功', '2019-08-26 09:49:33');
INSERT INTO `sys_logininfor` VALUES ('177', 'admin', '127.0.0.1', '内网IP', 'Chrome', 'Windows 7', '0', '登录成功', '2019-08-26 10:29:37');
INSERT INTO `sys_logininfor` VALUES ('178', 'admin', '127.0.0.1', '内网IP', 'Chrome', 'Windows 7', '0', '登录成功', '2019-08-26 10:30:42');
INSERT INTO `sys_logininfor` VALUES ('179', 'admin', '127.0.0.1', '内网IP', 'Chrome', 'Windows 7', '0', '登录成功', '2019-08-26 10:30:53');
INSERT INTO `sys_logininfor` VALUES ('180', 'admin', '127.0.0.1', '内网IP', 'Chrome', 'Windows 7', '0', '登录成功', '2019-08-26 10:38:48');
INSERT INTO `sys_logininfor` VALUES ('181', 'admin', '127.0.0.1', '内网IP', 'Chrome', 'Windows 7', '0', '登录成功', '2019-08-26 11:09:07');
INSERT INTO `sys_logininfor` VALUES ('182', 'admin', '127.0.0.1', '内网IP', 'Chrome', 'Windows 7', '0', '登录成功', '2019-08-26 13:43:54');
INSERT INTO `sys_logininfor` VALUES ('183', 'admin', '127.0.0.1', '内网IP', 'Chrome', 'Windows 7', '0', '登录成功', '2019-08-26 17:03:59');
INSERT INTO `sys_logininfor` VALUES ('184', 'admin', '127.0.0.1', '内网IP', 'Chrome', 'Windows 7', '0', '登录成功', '2019-08-26 17:06:26');
INSERT INTO `sys_logininfor` VALUES ('185', 'admin', '127.0.0.1', '内网IP', 'Chrome', 'Windows 7', '1', '验证码错误', '2019-08-26 17:24:49');
INSERT INTO `sys_logininfor` VALUES ('186', 'admin', '127.0.0.1', '内网IP', 'Chrome', 'Windows 7', '0', '登录成功', '2019-08-26 17:25:55');
INSERT INTO `sys_logininfor` VALUES ('187', 'admin', '127.0.0.1', '内网IP', 'Chrome', 'Windows 7', '1', '验证码错误', '2019-08-27 10:16:39');
INSERT INTO `sys_logininfor` VALUES ('188', 'admin', '127.0.0.1', '内网IP', 'Chrome', 'Windows 7', '0', '登录成功', '2019-08-27 10:16:43');
INSERT INTO `sys_logininfor` VALUES ('189', 'admin', '127.0.0.1', '内网IP', 'Chrome', 'Windows 7', '0', '登录成功', '2019-08-27 14:34:08');
INSERT INTO `sys_logininfor` VALUES ('190', 'admin', '127.0.0.1', '内网IP', 'Chrome', 'Windows 7', '0', '登录成功', '2019-08-27 15:28:47');
INSERT INTO `sys_logininfor` VALUES ('191', 'admin', '127.0.0.1', '内网IP', 'Chrome', 'Windows 7', '0', '登录成功', '2019-08-28 10:55:54');
INSERT INTO `sys_logininfor` VALUES ('192', 'admin', '127.0.0.1', '内网IP', 'Chrome', 'Windows 7', '0', '登录成功', '2019-08-28 11:12:26');
INSERT INTO `sys_logininfor` VALUES ('193', 'admin', '127.0.0.1', '内网IP', 'Chrome', 'Windows 7', '0', '登录成功', '2019-08-28 11:39:06');
INSERT INTO `sys_logininfor` VALUES ('194', 'admin', '127.0.0.1', '内网IP', 'Chrome', 'Windows 7', '0', '登录成功', '2019-08-28 13:33:12');
INSERT INTO `sys_logininfor` VALUES ('195', 'admin', '127.0.0.1', '内网IP', 'Chrome', 'Windows 7', '0', '登录成功', '2019-08-28 13:34:57');
INSERT INTO `sys_logininfor` VALUES ('196', 'admin', '127.0.0.1', '内网IP', 'Chrome', 'Windows 7', '1', '验证码错误', '2019-08-28 13:42:39');
INSERT INTO `sys_logininfor` VALUES ('197', 'admin', '127.0.0.1', '内网IP', 'Chrome', 'Windows 7', '1', '验证码错误', '2019-08-28 13:53:58');
INSERT INTO `sys_logininfor` VALUES ('198', 'admin', '127.0.0.1', '内网IP', 'Chrome', 'Windows 7', '0', '登录成功', '2019-08-28 13:54:00');
INSERT INTO `sys_logininfor` VALUES ('199', 'admin', '127.0.0.1', '内网IP', 'Chrome', 'Windows 7', '1', '验证码错误', '2019-08-28 15:26:42');
INSERT INTO `sys_logininfor` VALUES ('200', 'admin', '127.0.0.1', '内网IP', 'Chrome', 'Windows 7', '0', '登录成功', '2019-08-28 15:26:44');
INSERT INTO `sys_logininfor` VALUES ('201', 'admin', '127.0.0.1', '内网IP', 'Chrome', 'Windows 7', '0', '退出成功', '2019-08-28 15:28:13');
INSERT INTO `sys_logininfor` VALUES ('202', 'admin', '127.0.0.1', '内网IP', 'Chrome', 'Windows 7', '0', '登录成功', '2019-08-28 16:22:05');
INSERT INTO `sys_logininfor` VALUES ('203', 'admin', '127.0.0.1', '内网IP', 'Chrome', 'Windows 7', '0', '登录成功', '2019-08-29 11:47:50');
INSERT INTO `sys_logininfor` VALUES ('204', 'admin', '127.0.0.1', '内网IP', 'Chrome', 'Windows 7', '0', '登录成功', '2019-08-29 13:27:56');
INSERT INTO `sys_logininfor` VALUES ('205', 'admin', '127.0.0.1', '内网IP', 'Chrome', 'Windows 7', '1', '验证码错误', '2019-08-29 14:04:23');
INSERT INTO `sys_logininfor` VALUES ('206', 'admin', '127.0.0.1', '内网IP', 'Chrome', 'Windows 7', '0', '登录成功', '2019-08-29 14:04:25');
INSERT INTO `sys_logininfor` VALUES ('207', 'admin', '127.0.0.1', '内网IP', 'Chrome', 'Windows 7', '0', '登录成功', '2019-08-29 14:29:01');
INSERT INTO `sys_logininfor` VALUES ('208', 'admin', '127.0.0.1', '内网IP', 'Chrome', 'Windows 7', '0', '登录成功', '2019-08-29 14:40:49');
INSERT INTO `sys_logininfor` VALUES ('209', 'admin', '127.0.0.1', '内网IP', 'Chrome', 'Windows 7', '1', '验证码错误', '2019-08-29 14:53:19');
INSERT INTO `sys_logininfor` VALUES ('210', 'admin', '127.0.0.1', '内网IP', 'Chrome', 'Windows 7', '0', '登录成功', '2019-08-29 14:53:21');
INSERT INTO `sys_logininfor` VALUES ('211', 'admin', '127.0.0.1', '内网IP', 'Chrome', 'Windows 7', '0', '登录成功', '2019-08-29 15:20:34');
INSERT INTO `sys_logininfor` VALUES ('212', 'admin', '127.0.0.1', '内网IP', 'Chrome', 'Windows 7', '0', '退出成功', '2019-08-29 15:33:31');
INSERT INTO `sys_logininfor` VALUES ('213', 'admin', '127.0.0.1', '内网IP', 'Chrome', 'Windows 7', '0', '登录成功', '2019-08-29 15:38:42');

-- ----------------------------
-- Table structure for sys_menu
-- ----------------------------
DROP TABLE IF EXISTS `sys_menu`;
CREATE TABLE `sys_menu` (
  `menu_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '菜单ID',
  `menu_name` varchar(50) NOT NULL COMMENT '菜单名称',
  `parent_id` bigint(20) DEFAULT '0' COMMENT '父菜单ID',
  `order_num` int(4) DEFAULT '0' COMMENT '显示顺序',
  `url` varchar(200) DEFAULT '#' COMMENT '请求地址',
  `target` varchar(20) DEFAULT '' COMMENT '打开方式（menuItem页签 menuBlank新窗口）',
  `menu_type` char(1) DEFAULT '' COMMENT '菜单类型（M目录 C菜单 F按钮）',
  `visible` char(1) DEFAULT '0' COMMENT '菜单状态（0显示 1隐藏）',
  `perms` varchar(100) DEFAULT NULL COMMENT '权限标识',
  `icon` varchar(100) DEFAULT '#' COMMENT '菜单图标',
  `create_by` varchar(64) DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) DEFAULT '' COMMENT '备注',
  PRIMARY KEY (`menu_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2025 DEFAULT CHARSET=utf8 COMMENT='菜单权限表';

-- ----------------------------
-- Records of sys_menu
-- ----------------------------
INSERT INTO `sys_menu` VALUES ('1', '系统管理', '0', '1', '#', '', 'M', '0', '', 'fa fa-gear', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00', '系统管理目录');
INSERT INTO `sys_menu` VALUES ('2', '系统监控', '0', '2', '#', '', 'M', '0', '', 'fa fa-video-camera', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00', '系统监控目录');
INSERT INTO `sys_menu` VALUES ('3', '系统工具', '0', '3', '#', '', 'M', '0', '', 'fa fa-bars', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00', '系统工具目录');
INSERT INTO `sys_menu` VALUES ('100', '用户管理', '1', '1', '/system/user', '', 'C', '0', 'system:user:view', '#', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00', '用户管理菜单');
INSERT INTO `sys_menu` VALUES ('101', '角色管理', '1', '2', '/system/role', 'menuItem', 'C', '0', 'system:role:view', '#', 'admin', '2018-03-16 11:33:00', 'admin', '2019-08-13 16:30:54', '角色管理菜单');
INSERT INTO `sys_menu` VALUES ('102', '菜单管理', '1', '3', '/system/menu', 'menuItem', 'C', '0', 'system:menu:view', '#', 'admin', '2018-03-16 11:33:00', 'admin', '2019-08-05 14:07:32', '菜单管理菜单');
INSERT INTO `sys_menu` VALUES ('103', '部门管理', '1', '4', '/system/dept', 'menuItem', 'C', '1', 'system:dept:view', '#', 'admin', '2018-03-16 11:33:00', 'admin', '2019-08-05 14:07:39', '部门管理菜单');
INSERT INTO `sys_menu` VALUES ('104', '岗位管理', '1', '5', '/system/post', 'menuItem', 'C', '1', 'system:post:view', '#', 'admin', '2018-03-16 11:33:00', 'admin', '2019-08-05 14:07:45', '岗位管理菜单');
INSERT INTO `sys_menu` VALUES ('105', '字典管理', '1', '6', '/system/dict', '', 'C', '0', 'system:dict:view', '#', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00', '字典管理菜单');
INSERT INTO `sys_menu` VALUES ('106', '参数设置', '1', '7', '/system/config', '', 'C', '0', 'system:config:view', '#', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00', '参数设置菜单');
INSERT INTO `sys_menu` VALUES ('107', '通知公告', '1', '8', '/system/notice', 'menuItem', 'C', '1', 'system:notice:view', '#', 'admin', '2018-03-16 11:33:00', 'admin', '2019-08-05 14:07:52', '通知公告菜单');
INSERT INTO `sys_menu` VALUES ('108', '日志管理', '1', '9', '#', '', 'M', '0', '', '#', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00', '日志管理菜单');
INSERT INTO `sys_menu` VALUES ('109', '在线用户', '2', '1', '/monitor/online', '', 'C', '0', 'monitor:online:view', '#', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00', '在线用户菜单');
INSERT INTO `sys_menu` VALUES ('110', '定时任务', '2', '2', '/monitor/job', '', 'C', '0', 'monitor:job:view', '#', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00', '定时任务菜单');
INSERT INTO `sys_menu` VALUES ('111', '数据监控', '2', '3', '/monitor/data', '', 'C', '0', 'monitor:data:view', '#', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00', '数据监控菜单');
INSERT INTO `sys_menu` VALUES ('112', '服务监控', '2', '3', '/monitor/server', '', 'C', '0', 'monitor:server:view', '#', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00', '服务监控菜单');
INSERT INTO `sys_menu` VALUES ('113', '表单构建', '3', '1', '/tool/build', '', 'C', '0', 'tool:build:view', '#', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00', '表单构建菜单');
INSERT INTO `sys_menu` VALUES ('114', '代码生成', '3', '2', '/tool/gen', '', 'C', '0', 'tool:gen:view', '#', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00', '代码生成菜单');
INSERT INTO `sys_menu` VALUES ('115', '系统接口', '3', '3', '/tool/swagger', '', 'C', '0', 'tool:swagger:view', '#', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00', '系统接口菜单');
INSERT INTO `sys_menu` VALUES ('500', '操作日志', '108', '1', '/monitor/operlog', '', 'C', '0', 'monitor:operlog:view', '#', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00', '操作日志菜单');
INSERT INTO `sys_menu` VALUES ('501', '登录日志', '108', '2', '/monitor/logininfor', '', 'C', '0', 'monitor:logininfor:view', '#', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00', '登录日志菜单');
INSERT INTO `sys_menu` VALUES ('1000', '用户查询', '100', '1', '#', '', 'F', '0', 'system:user:list', '#', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00', '');
INSERT INTO `sys_menu` VALUES ('1001', '用户新增', '100', '2', '#', '', 'F', '0', 'system:user:add', '#', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00', '');
INSERT INTO `sys_menu` VALUES ('1002', '用户修改', '100', '3', '#', '', 'F', '0', 'system:user:edit', '#', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00', '');
INSERT INTO `sys_menu` VALUES ('1003', '用户删除', '100', '4', '#', '', 'F', '0', 'system:user:remove', '#', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00', '');
INSERT INTO `sys_menu` VALUES ('1004', '用户导出', '100', '5', '#', '', 'F', '0', 'system:user:export', '#', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00', '');
INSERT INTO `sys_menu` VALUES ('1005', '用户导入', '100', '6', '#', '', 'F', '0', 'system:user:import', '#', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00', '');
INSERT INTO `sys_menu` VALUES ('1006', '重置密码', '100', '7', '#', '', 'F', '0', 'system:user:resetPwd', '#', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00', '');
INSERT INTO `sys_menu` VALUES ('1007', '角色查询', '101', '1', '#', '', 'F', '0', 'system:role:list', '#', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00', '');
INSERT INTO `sys_menu` VALUES ('1008', '角色新增', '101', '2', '#', '', 'F', '0', 'system:role:add', '#', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00', '');
INSERT INTO `sys_menu` VALUES ('1009', '角色修改', '101', '3', '#', '', 'F', '0', 'system:role:edit', '#', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00', '');
INSERT INTO `sys_menu` VALUES ('1010', '角色删除', '101', '4', '#', '', 'F', '0', 'system:role:remove', '#', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00', '');
INSERT INTO `sys_menu` VALUES ('1011', '角色导出', '101', '5', '#', '', 'F', '0', 'system:role:export', '#', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00', '');
INSERT INTO `sys_menu` VALUES ('1012', '菜单查询', '102', '1', '#', '', 'F', '0', 'system:menu:list', '#', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00', '');
INSERT INTO `sys_menu` VALUES ('1013', '菜单新增', '102', '2', '#', '', 'F', '0', 'system:menu:add', '#', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00', '');
INSERT INTO `sys_menu` VALUES ('1014', '菜单修改', '102', '3', '#', '', 'F', '0', 'system:menu:edit', '#', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00', '');
INSERT INTO `sys_menu` VALUES ('1015', '菜单删除', '102', '4', '#', '', 'F', '0', 'system:menu:remove', '#', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00', '');
INSERT INTO `sys_menu` VALUES ('1016', '部门查询', '103', '1', '#', '', 'F', '0', 'system:dept:list', '#', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00', '');
INSERT INTO `sys_menu` VALUES ('1017', '部门新增', '103', '2', '#', '', 'F', '0', 'system:dept:add', '#', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00', '');
INSERT INTO `sys_menu` VALUES ('1018', '部门修改', '103', '3', '#', '', 'F', '0', 'system:dept:edit', '#', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00', '');
INSERT INTO `sys_menu` VALUES ('1019', '部门删除', '103', '4', '#', '', 'F', '0', 'system:dept:remove', '#', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00', '');
INSERT INTO `sys_menu` VALUES ('1020', '岗位查询', '104', '1', '#', '', 'F', '0', 'system:post:list', '#', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00', '');
INSERT INTO `sys_menu` VALUES ('1021', '岗位新增', '104', '2', '#', '', 'F', '0', 'system:post:add', '#', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00', '');
INSERT INTO `sys_menu` VALUES ('1022', '岗位修改', '104', '3', '#', '', 'F', '0', 'system:post:edit', '#', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00', '');
INSERT INTO `sys_menu` VALUES ('1023', '岗位删除', '104', '4', '#', '', 'F', '0', 'system:post:remove', '#', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00', '');
INSERT INTO `sys_menu` VALUES ('1024', '岗位导出', '104', '5', '#', '', 'F', '0', 'system:post:export', '#', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00', '');
INSERT INTO `sys_menu` VALUES ('1025', '字典查询', '105', '1', '#', '', 'F', '0', 'system:dict:list', '#', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00', '');
INSERT INTO `sys_menu` VALUES ('1026', '字典新增', '105', '2', '#', '', 'F', '0', 'system:dict:add', '#', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00', '');
INSERT INTO `sys_menu` VALUES ('1027', '字典修改', '105', '3', '#', '', 'F', '0', 'system:dict:edit', '#', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00', '');
INSERT INTO `sys_menu` VALUES ('1028', '字典删除', '105', '4', '#', '', 'F', '0', 'system:dict:remove', '#', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00', '');
INSERT INTO `sys_menu` VALUES ('1029', '字典导出', '105', '5', '#', '', 'F', '0', 'system:dict:export', '#', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00', '');
INSERT INTO `sys_menu` VALUES ('1030', '参数查询', '106', '1', '#', '', 'F', '0', 'system:config:list', '#', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00', '');
INSERT INTO `sys_menu` VALUES ('1031', '参数新增', '106', '2', '#', '', 'F', '0', 'system:config:add', '#', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00', '');
INSERT INTO `sys_menu` VALUES ('1032', '参数修改', '106', '3', '#', '', 'F', '0', 'system:config:edit', '#', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00', '');
INSERT INTO `sys_menu` VALUES ('1033', '参数删除', '106', '4', '#', '', 'F', '0', 'system:config:remove', '#', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00', '');
INSERT INTO `sys_menu` VALUES ('1034', '参数导出', '106', '5', '#', '', 'F', '0', 'system:config:export', '#', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00', '');
INSERT INTO `sys_menu` VALUES ('1035', '公告查询', '107', '1', '#', '', 'F', '0', 'system:notice:list', '#', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00', '');
INSERT INTO `sys_menu` VALUES ('1036', '公告新增', '107', '2', '#', '', 'F', '0', 'system:notice:add', '#', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00', '');
INSERT INTO `sys_menu` VALUES ('1037', '公告修改', '107', '3', '#', '', 'F', '0', 'system:notice:edit', '#', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00', '');
INSERT INTO `sys_menu` VALUES ('1038', '公告删除', '107', '4', '#', '', 'F', '0', 'system:notice:remove', '#', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00', '');
INSERT INTO `sys_menu` VALUES ('1039', '操作查询', '500', '1', '#', '', 'F', '0', 'monitor:operlog:list', '#', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00', '');
INSERT INTO `sys_menu` VALUES ('1040', '操作删除', '500', '2', '#', '', 'F', '0', 'monitor:operlog:remove', '#', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00', '');
INSERT INTO `sys_menu` VALUES ('1041', '详细信息', '500', '3', '#', '', 'F', '0', 'monitor:operlog:detail', '#', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00', '');
INSERT INTO `sys_menu` VALUES ('1042', '日志导出', '500', '4', '#', '', 'F', '0', 'monitor:operlog:export', '#', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00', '');
INSERT INTO `sys_menu` VALUES ('1043', '登录查询', '501', '1', '#', '', 'F', '0', 'monitor:logininfor:list', '#', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00', '');
INSERT INTO `sys_menu` VALUES ('1044', '登录删除', '501', '2', '#', '', 'F', '0', 'monitor:logininfor:remove', '#', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00', '');
INSERT INTO `sys_menu` VALUES ('1045', '日志导出', '501', '3', '#', '', 'F', '0', 'monitor:logininfor:export', '#', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00', '');
INSERT INTO `sys_menu` VALUES ('1046', '在线查询', '109', '1', '#', '', 'F', '0', 'monitor:online:list', '#', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00', '');
INSERT INTO `sys_menu` VALUES ('1047', '批量强退', '109', '2', '#', '', 'F', '0', 'monitor:online:batchForceLogout', '#', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00', '');
INSERT INTO `sys_menu` VALUES ('1048', '单条强退', '109', '3', '#', '', 'F', '0', 'monitor:online:forceLogout', '#', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00', '');
INSERT INTO `sys_menu` VALUES ('1049', '任务查询', '110', '1', '#', '', 'F', '0', 'monitor:job:list', '#', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00', '');
INSERT INTO `sys_menu` VALUES ('1050', '任务新增', '110', '2', '#', '', 'F', '0', 'monitor:job:add', '#', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00', '');
INSERT INTO `sys_menu` VALUES ('1051', '任务修改', '110', '3', '#', '', 'F', '0', 'monitor:job:edit', '#', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00', '');
INSERT INTO `sys_menu` VALUES ('1052', '任务删除', '110', '4', '#', '', 'F', '0', 'monitor:job:remove', '#', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00', '');
INSERT INTO `sys_menu` VALUES ('1053', '状态修改', '110', '5', '#', '', 'F', '0', 'monitor:job:changeStatus', '#', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00', '');
INSERT INTO `sys_menu` VALUES ('1054', '任务详细', '110', '6', '#', '', 'F', '0', 'monitor:job:detail', '#', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00', '');
INSERT INTO `sys_menu` VALUES ('1055', '任务导出', '110', '7', '#', '', 'F', '0', 'monitor:job:export', '#', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00', '');
INSERT INTO `sys_menu` VALUES ('1056', '生成查询', '114', '1', '#', '', 'F', '0', 'tool:gen:list', '#', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00', '');
INSERT INTO `sys_menu` VALUES ('1057', '生成修改', '114', '2', '#', '', 'F', '0', 'tool:gen:edit', '#', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00', '');
INSERT INTO `sys_menu` VALUES ('1058', '生成删除', '114', '3', '#', '', 'F', '0', 'tool:gen:remove', '#', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00', '');
INSERT INTO `sys_menu` VALUES ('1059', '预览代码', '114', '4', '#', '', 'F', '0', 'tool:gen:preview', '#', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00', '');
INSERT INTO `sys_menu` VALUES ('1060', '生成代码', '114', '5', '#', '', 'F', '0', 'tool:gen:code', '#', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00', '');
INSERT INTO `sys_menu` VALUES ('2000', '服务器管理', '2005', '1', '/api/server', 'menuItem', 'C', '0', 'api:server:view', '#', 'admin', '2018-03-01 00:00:00', 'admin', '2019-08-29 15:29:36', 'api服务分组菜单');
INSERT INTO `sys_menu` VALUES ('2001', 'api服务分组查询', '2000', '1', '#', 'menuItem', 'F', '0', 'api:server:list', '#', 'admin', '2018-03-01 00:00:00', 'admin', '2019-08-05 16:36:39', '');
INSERT INTO `sys_menu` VALUES ('2002', 'api服务分组新增', '2000', '2', '#', 'menuItem', 'F', '0', 'api:server:add', '#', 'admin', '2018-03-01 00:00:00', 'admin', '2019-08-05 16:36:47', '');
INSERT INTO `sys_menu` VALUES ('2003', 'api服务分组修改', '2000', '3', '#', 'menuItem', 'F', '0', 'api:server:edit', '#', 'admin', '2018-03-01 00:00:00', 'admin', '2019-08-05 16:36:55', '');
INSERT INTO `sys_menu` VALUES ('2004', 'api服务分组删除', '2000', '4', '#', 'menuItem', 'F', '0', 'api:server:remove', '#', 'admin', '2018-03-01 00:00:00', 'admin', '2019-08-05 16:37:04', '');
INSERT INTO `sys_menu` VALUES ('2005', 'api服务', '0', '1', '#', 'menuItem', 'M', '0', null, 'fa fa-cogs', 'admin', '2019-08-05 16:35:58', '', null, '');
INSERT INTO `sys_menu` VALUES ('2006', '开放api', '2005', '0', '/api/apiUrl', 'menuItem', 'C', '0', 'api:url:view', '#', 'admin', '2019-08-12 13:39:44', 'admin', '2019-08-12 13:40:23', '');
INSERT INTO `sys_menu` VALUES ('2007', '列表', '2006', '0', '#', 'menuItem', 'F', '0', 'api:url:list', '#', 'admin', '2019-08-12 13:40:52', '', null, '');
INSERT INTO `sys_menu` VALUES ('2008', '导出', '2006', '1', '#', 'menuItem', 'F', '0', 'api:url:export', '#', 'admin', '2019-08-12 13:41:15', '', null, '');
INSERT INTO `sys_menu` VALUES ('2009', '添加', '2006', '2', '#', 'menuItem', 'F', '0', 'api:url:add', '#', 'admin', '2019-08-12 13:41:31', '', null, '');
INSERT INTO `sys_menu` VALUES ('2010', '修改', '2006', '3', '#', 'menuItem', 'F', '0', 'api:url:edit', '#', 'admin', '2019-08-12 13:41:51', '', null, '');
INSERT INTO `sys_menu` VALUES ('2011', '删除', '2006', '4', '#', 'menuItem', 'F', '0', 'api:url:remove', '#', 'admin', '2019-08-12 13:42:08', '', null, '');
INSERT INTO `sys_menu` VALUES ('2012', 'api账号', '2005', '2', '/api/account', 'menuItem', 'C', '0', 'api:account:view', '#', 'admin', '2019-08-13 13:46:54', 'admin', '2019-08-13 13:47:04', '');
INSERT INTO `sys_menu` VALUES ('2013', '列表', '2012', '0', '#', 'menuItem', 'F', '0', 'api:account:list', '#', 'admin', '2019-08-13 13:48:15', '', null, '');
INSERT INTO `sys_menu` VALUES ('2014', '导出', '2012', '1', '#', 'menuItem', 'F', '0', 'api:account:export', '#', 'admin', '2019-08-13 13:48:37', '', null, '');
INSERT INTO `sys_menu` VALUES ('2015', '添加', '2012', '2', '#', 'menuItem', 'F', '0', 'api:account:add', '#', 'admin', '2019-08-13 13:48:59', '', null, '');
INSERT INTO `sys_menu` VALUES ('2017', '删除', '2012', '4', '#', 'menuItem', 'F', '0', 'api:account:remove', '#', 'admin', '2019-08-13 13:49:32', '', null, '');
INSERT INTO `sys_menu` VALUES ('2018', '参数配置', '2006', '5', '#', 'menuItem', 'F', '0', 'api:param:view', '#', 'admin', '2019-08-19 09:47:56', '', null, '');
INSERT INTO `sys_menu` VALUES ('2019', '权限配置', '2012', '5', '#', 'menuItem', 'F', '0', 'api:accountApiLimit:view', '#', 'admin', '2019-08-19 09:50:28', '', null, '');
INSERT INTO `sys_menu` VALUES ('2020', '请求记录', '2005', '0', '/api/record', 'menuItem', 'C', '0', 'api:record:view', '#', 'admin', '2019-08-22 16:39:07', '', null, '');
INSERT INTO `sys_menu` VALUES ('2021', '列表', '2020', '0', '#', 'menuItem', 'F', '0', 'api:record:list', '#', 'admin', '2019-08-22 16:39:33', '', null, '');
INSERT INTO `sys_menu` VALUES ('2022', '导出', '2020', '1', '#', 'menuItem', 'F', '0', 'api:record:export', '#', 'admin', '2019-08-22 16:39:48', '', null, '');
INSERT INTO `sys_menu` VALUES ('2023', '详情', '2005', '2', '#', 'menuItem', 'F', '0', 'api:record:detail', '#', 'admin', '2019-08-22 16:40:02', '', null, '');
INSERT INTO `sys_menu` VALUES ('2024', '清空', '2005', '3', '#', 'menuItem', 'F', '0', 'api:record:remove', '#', 'admin', '2019-08-22 16:40:19', '', null, '');

-- ----------------------------
-- Table structure for sys_notice
-- ----------------------------
DROP TABLE IF EXISTS `sys_notice`;
CREATE TABLE `sys_notice` (
  `notice_id` int(4) NOT NULL AUTO_INCREMENT COMMENT '公告ID',
  `notice_title` varchar(50) NOT NULL COMMENT '公告标题',
  `notice_type` char(1) NOT NULL COMMENT '公告类型（1通知 2公告）',
  `notice_content` varchar(2000) DEFAULT NULL COMMENT '公告内容',
  `status` char(1) DEFAULT '0' COMMENT '公告状态（0正常 1关闭）',
  `create_by` varchar(64) DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(255) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`notice_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COMMENT='通知公告表';

-- ----------------------------
-- Records of sys_notice
-- ----------------------------
INSERT INTO `sys_notice` VALUES ('1', '温馨提醒：2018-07-01 若依新版本发布啦', '2', '新版本内容', '0', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00', '管理员');
INSERT INTO `sys_notice` VALUES ('2', '维护通知：2018-07-01 若依系统凌晨维护', '1', '维护内容', '0', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00', '管理员');

-- ----------------------------
-- Table structure for sys_oper_log
-- ----------------------------
DROP TABLE IF EXISTS `sys_oper_log`;
CREATE TABLE `sys_oper_log` (
  `oper_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '日志主键',
  `title` varchar(50) DEFAULT '' COMMENT '模块标题',
  `business_type` int(2) DEFAULT '0' COMMENT '业务类型（0其它 1新增 2修改 3删除）',
  `method` varchar(100) DEFAULT '' COMMENT '方法名称',
  `operator_type` int(1) DEFAULT '0' COMMENT '操作类别（0其它 1后台用户 2手机端用户）',
  `oper_name` varchar(50) DEFAULT '' COMMENT '操作人员',
  `dept_name` varchar(50) DEFAULT '' COMMENT '部门名称',
  `oper_url` varchar(255) DEFAULT '' COMMENT '请求URL',
  `oper_ip` varchar(50) DEFAULT '' COMMENT '主机地址',
  `oper_location` varchar(255) DEFAULT '' COMMENT '操作地点',
  `oper_param` varchar(2000) DEFAULT '' COMMENT '请求参数',
  `status` int(1) DEFAULT '0' COMMENT '操作状态（0正常 1异常）',
  `error_msg` varchar(2000) DEFAULT '' COMMENT '错误消息',
  `oper_time` datetime DEFAULT NULL COMMENT '操作时间',
  PRIMARY KEY (`oper_id`)
) ENGINE=InnoDB AUTO_INCREMENT=308 DEFAULT CHARSET=utf8 COMMENT='操作日志记录';

-- ----------------------------
-- Records of sys_oper_log
-- ----------------------------
INSERT INTO `sys_oper_log` VALUES ('100', '菜单管理', '2', 'com.ruoyi.project.system.menu.controller.MenuController.editSave()', '1', 'admin', '研发部门', '/system/menu/edit', '127.0.0.1', '内网IP', '{\"menuId\":[\"101\"],\"parentId\":[\"1\"],\"menuType\":[\"C\"],\"menuName\":[\"角色管理\"],\"url\":[\"/system/role\"],\"target\":[\"menuItem\"],\"perms\":[\"system:role:view\"],\"orderNum\":[\"2\"],\"icon\":[\"#\"],\"visible\":[\"1\"]}', '0', null, '2019-08-05 14:07:18');
INSERT INTO `sys_oper_log` VALUES ('101', '菜单管理', '2', 'com.ruoyi.project.system.menu.controller.MenuController.editSave()', '1', 'admin', '研发部门', '/system/menu/edit', '127.0.0.1', '内网IP', '{\"menuId\":[\"102\"],\"parentId\":[\"1\"],\"menuType\":[\"C\"],\"menuName\":[\"菜单管理\"],\"url\":[\"/system/menu\"],\"target\":[\"menuItem\"],\"perms\":[\"system:menu:view\"],\"orderNum\":[\"3\"],\"icon\":[\"#\"],\"visible\":[\"1\"]}', '0', null, '2019-08-05 14:07:25');
INSERT INTO `sys_oper_log` VALUES ('102', '菜单管理', '2', 'com.ruoyi.project.system.menu.controller.MenuController.editSave()', '1', 'admin', '研发部门', '/system/menu/edit', '127.0.0.1', '内网IP', '{\"menuId\":[\"102\"],\"parentId\":[\"1\"],\"menuType\":[\"C\"],\"menuName\":[\"菜单管理\"],\"url\":[\"/system/menu\"],\"target\":[\"menuItem\"],\"perms\":[\"system:menu:view\"],\"orderNum\":[\"3\"],\"icon\":[\"#\"],\"visible\":[\"0\"]}', '0', null, '2019-08-05 14:07:32');
INSERT INTO `sys_oper_log` VALUES ('103', '菜单管理', '2', 'com.ruoyi.project.system.menu.controller.MenuController.editSave()', '1', 'admin', '研发部门', '/system/menu/edit', '127.0.0.1', '内网IP', '{\"menuId\":[\"103\"],\"parentId\":[\"1\"],\"menuType\":[\"C\"],\"menuName\":[\"部门管理\"],\"url\":[\"/system/dept\"],\"target\":[\"menuItem\"],\"perms\":[\"system:dept:view\"],\"orderNum\":[\"4\"],\"icon\":[\"#\"],\"visible\":[\"1\"]}', '0', null, '2019-08-05 14:07:40');
INSERT INTO `sys_oper_log` VALUES ('104', '菜单管理', '2', 'com.ruoyi.project.system.menu.controller.MenuController.editSave()', '1', 'admin', '研发部门', '/system/menu/edit', '127.0.0.1', '内网IP', '{\"menuId\":[\"104\"],\"parentId\":[\"1\"],\"menuType\":[\"C\"],\"menuName\":[\"岗位管理\"],\"url\":[\"/system/post\"],\"target\":[\"menuItem\"],\"perms\":[\"system:post:view\"],\"orderNum\":[\"5\"],\"icon\":[\"#\"],\"visible\":[\"1\"]}', '0', null, '2019-08-05 14:07:45');
INSERT INTO `sys_oper_log` VALUES ('105', '菜单管理', '2', 'com.ruoyi.project.system.menu.controller.MenuController.editSave()', '1', 'admin', '研发部门', '/system/menu/edit', '127.0.0.1', '内网IP', '{\"menuId\":[\"107\"],\"parentId\":[\"1\"],\"menuType\":[\"C\"],\"menuName\":[\"通知公告\"],\"url\":[\"/system/notice\"],\"target\":[\"menuItem\"],\"perms\":[\"system:notice:view\"],\"orderNum\":[\"8\"],\"icon\":[\"#\"],\"visible\":[\"1\"]}', '0', null, '2019-08-05 14:07:52');
INSERT INTO `sys_oper_log` VALUES ('106', '代码生成', '8', 'com.ruoyi.project.tool.gen.controller.GenController.batchGenCode()', '1', 'admin', '研发部门', '/tool/gen/batchGenCode', '127.0.0.1', '内网IP', '{\"tables\":[\"api_server,api_server_group\"]}', '0', null, '2019-08-05 14:17:24');
INSERT INTO `sys_oper_log` VALUES ('107', '代码生成', '8', 'com.ruoyi.project.tool.gen.controller.GenController.batchGenCode()', '1', 'admin', '研发部门', '/tool/gen/batchGenCode', '127.0.0.1', '内网IP', '{\"tables\":[\"api_server,api_server_group\"]}', '0', null, '2019-08-05 14:17:25');
INSERT INTO `sys_oper_log` VALUES ('108', '代码生成', '8', 'com.ruoyi.project.tool.gen.controller.GenController.batchGenCode()', '1', 'admin', '研发部门', '/tool/gen/batchGenCode', '127.0.0.1', '内网IP', '{\"tables\":[\"api_server,api_server_group\"]}', '0', null, '2019-08-05 14:26:53');
INSERT INTO `sys_oper_log` VALUES ('109', '代码生成', '8', 'com.ruoyi.project.tool.gen.controller.GenController.batchGenCode()', '1', 'admin', '研发部门', '/tool/gen/batchGenCode', '127.0.0.1', '内网IP', '{\"tables\":[\"api_server,api_server_group\"]}', '0', null, '2019-08-05 14:28:24');
INSERT INTO `sys_oper_log` VALUES ('110', '代码生成', '8', 'com.ruoyi.project.tool.gen.controller.GenController.batchGenCode()', '1', 'admin', '研发部门', '/tool/gen/batchGenCode', '127.0.0.1', '内网IP', '{\"tables\":[\"api_server,api_server_group\"]}', '0', null, '2019-08-05 14:28:33');
INSERT INTO `sys_oper_log` VALUES ('111', '菜单管理', '2', 'com.ruoyi.project.system.menu.controller.MenuController.editSave()', '1', 'admin', null, '/system/menu/edit', '127.0.0.1', '内网IP', '{\"menuId\":[\"2000\"],\"parentId\":[\"3\"],\"menuType\":[\"C\"],\"menuName\":[\"api后端服务\"],\"url\":[\"/api/server\"],\"target\":[\"menuItem\"],\"perms\":[\"api:server:view\"],\"orderNum\":[\"1\"],\"icon\":[\"#\"],\"visible\":[\"0\"]}', '0', null, '2019-08-05 16:34:41');
INSERT INTO `sys_oper_log` VALUES ('112', '菜单管理', '1', 'com.ruoyi.project.system.menu.controller.MenuController.addSave()', '1', 'admin', null, '/system/menu/add', '127.0.0.1', '内网IP', '{\"parentId\":[\"0\"],\"menuType\":[\"M\"],\"menuName\":[\"api服务\"],\"url\":[\"\"],\"target\":[\"menuItem\"],\"perms\":[\"\"],\"orderNum\":[\"1\"],\"icon\":[\"fa fa-cogs\"],\"visible\":[\"0\"]}', '0', null, '2019-08-05 16:35:58');
INSERT INTO `sys_oper_log` VALUES ('113', '菜单管理', '2', 'com.ruoyi.project.system.menu.controller.MenuController.editSave()', '1', 'admin', null, '/system/menu/edit', '127.0.0.1', '内网IP', '{\"menuId\":[\"2000\"],\"parentId\":[\"2005\"],\"menuType\":[\"C\"],\"menuName\":[\"api后端服务\"],\"url\":[\"/api/server\"],\"target\":[\"menuItem\"],\"perms\":[\"api:server:view\"],\"orderNum\":[\"1\"],\"icon\":[\"#\"],\"visible\":[\"0\"]}', '0', null, '2019-08-05 16:36:11');
INSERT INTO `sys_oper_log` VALUES ('114', '菜单管理', '2', 'com.ruoyi.project.system.menu.controller.MenuController.editSave()', '1', 'admin', null, '/system/menu/edit', '127.0.0.1', '内网IP', '{\"menuId\":[\"2000\"],\"parentId\":[\"2005\"],\"menuType\":[\"C\"],\"menuName\":[\"api后端管理\"],\"url\":[\"/api/server\"],\"target\":[\"menuItem\"],\"perms\":[\"api:server:view\"],\"orderNum\":[\"1\"],\"icon\":[\"#\"],\"visible\":[\"0\"]}', '0', null, '2019-08-05 16:36:32');
INSERT INTO `sys_oper_log` VALUES ('115', '菜单管理', '2', 'com.ruoyi.project.system.menu.controller.MenuController.editSave()', '1', 'admin', null, '/system/menu/edit', '127.0.0.1', '内网IP', '{\"menuId\":[\"2001\"],\"parentId\":[\"2000\"],\"menuType\":[\"F\"],\"menuName\":[\"api服务分组查询\"],\"url\":[\"#\"],\"target\":[\"menuItem\"],\"perms\":[\"api:server:list\"],\"orderNum\":[\"1\"],\"icon\":[\"#\"],\"visible\":[\"0\"]}', '0', null, '2019-08-05 16:36:39');
INSERT INTO `sys_oper_log` VALUES ('116', '菜单管理', '2', 'com.ruoyi.project.system.menu.controller.MenuController.editSave()', '1', 'admin', null, '/system/menu/edit', '127.0.0.1', '内网IP', '{\"menuId\":[\"2002\"],\"parentId\":[\"2000\"],\"menuType\":[\"F\"],\"menuName\":[\"api服务分组新增\"],\"url\":[\"#\"],\"target\":[\"menuItem\"],\"perms\":[\"api:server:add\"],\"orderNum\":[\"2\"],\"icon\":[\"#\"],\"visible\":[\"0\"]}', '0', null, '2019-08-05 16:36:47');
INSERT INTO `sys_oper_log` VALUES ('117', '菜单管理', '2', 'com.ruoyi.project.system.menu.controller.MenuController.editSave()', '1', 'admin', null, '/system/menu/edit', '127.0.0.1', '内网IP', '{\"menuId\":[\"2003\"],\"parentId\":[\"2000\"],\"menuType\":[\"F\"],\"menuName\":[\"api服务分组修改\"],\"url\":[\"#\"],\"target\":[\"menuItem\"],\"perms\":[\"api:server:edit\"],\"orderNum\":[\"3\"],\"icon\":[\"#\"],\"visible\":[\"0\"]}', '0', null, '2019-08-05 16:36:55');
INSERT INTO `sys_oper_log` VALUES ('118', '菜单管理', '2', 'com.ruoyi.project.system.menu.controller.MenuController.editSave()', '1', 'admin', null, '/system/menu/edit', '127.0.0.1', '内网IP', '{\"menuId\":[\"2004\"],\"parentId\":[\"2000\"],\"menuType\":[\"F\"],\"menuName\":[\"api服务分组删除\"],\"url\":[\"#\"],\"target\":[\"menuItem\"],\"perms\":[\"api:server:remove\"],\"orderNum\":[\"4\"],\"icon\":[\"#\"],\"visible\":[\"0\"]}', '0', null, '2019-08-05 16:37:04');
INSERT INTO `sys_oper_log` VALUES ('119', 'api服务', '3', 'com.ruoyi.project.api.server.controller.ApiServerGroupController.remove()', '1', 'admin', null, '/api/serverGroup/remove', '127.0.0.1', '内网IP', '{}', '1', '', '2019-08-06 14:59:19');
INSERT INTO `sys_oper_log` VALUES ('120', 'api服务', '3', 'com.ruoyi.project.api.server.controller.ApiServerGroupController.remove()', '1', 'admin', null, '/api/serverGroup/remove', '127.0.0.1', '内网IP', '{}', '1', '', '2019-08-06 15:00:15');
INSERT INTO `sys_oper_log` VALUES ('121', 'api服务', '3', 'com.ruoyi.project.api.server.controller.ApiServerGroupController.remove()', '1', 'admin', null, '/api/serverGroup/remove', '127.0.0.1', '内网IP', '{\"ids\":[\"1\"]}', '0', null, '2019-08-06 15:02:44');
INSERT INTO `sys_oper_log` VALUES ('122', 'api服务', '1', 'com.ruoyi.project.api.server.controller.ApiServerGroupController.addSave()', '1', 'admin', null, '/api/serverGroup/add', '127.0.0.1', '内网IP', '{\"serverGroupName\":[\"管廊\"],\"remark\":[\"两学一做两学一做两学一做两学一做两学一做两学一做两学一做两学一做两学一做两学一做两学一做两学一做两学一做两学一做两学一做两学一做两学一做两学一做两学一做两学一做两学一做两学一做两学一做两学一做两学一做两学一做两学一做两学一做两学一做两学一做两学一做两学一做两学一做两学一做两学一做两学一做两学一做两学一做两学一做两学一做两学一做两学一做两学一做两学一做两学一做两学一做两学一做两学一做两学一做两学一做两学一做两学一做两学一做两学一做两学一做两学一做两学一做两学一做两学一做两学一做两学一做两学一做两学一做两学一做两学一做两学一做两学一做两学一做两学一做两学一做两学一做两学一做两学一做两学一做两学一做两学一做两学一做两学一做两学一做两学一做两学一做两学一做两学一做两学一做两学一做两学一做两学一做两学一做两学一做两学一做两学一做两学一做两学一做两学一做两学一做两学一做两学一做两学一做两学一做两学一做两学一做两学一做两学一做两学一做两学一做两学一做两学一做两学一做两学一做两学一做两学一做两学一做两学一做两学一做两学一做两学一做两学一做两学一做两学一做两学一做两学一做两学一做两学一做两学一做两学一做两学一做两学一做两学一做两学一做两学一做两学一做两学一做两学一做两学一做两学一做两学一做两学一做两学一做两学一做两学一做两学一做两学一做两学一做两学一做两学一做两学一做两学一做两学一做两学一做两学一做两学一做两学一做两学一做两学一做两学一做两学一做两学一做两学一做两学一做两学一做两学一做两学一做两学一做两学一做两学一做两学一做两学一做两学一做两学一做两学一做两学一做两学一做两学一做两学一做两学一做两学一做两学一做两学一做两学一做两学一做两学一做两学一做两学一做两学一做两学一做两学一做两学一做两学一做两学一做两学一做两学一做两学一做两学一做两学一做两学一做两学一做两学一做两学一做两学一做两学一做两学一做两学一做两学一做两学一做两学一做两学一做两学一做两学一做两学一做两学一做两学一做两学一做两学一做两学一做两学一做两学一做两学一做两学一做两学一做两学一做两学一做两学一做两学一做两学一做两学一做两学一做两学一做两学一做两学一做两学一做两学一做两学一做两学一做两学一做两学一做两学一做两学一做两学一做两学一做两学一做两学一做两学一做两学一做两学一做两学一做两学一做两学一做两学一做两学一做两学一做两学一做两学一做两学一做两学一做两学一做两学一做\"]}', '1', '\r\n### Error updating database.  Cause: com.mysql.cj.jdbc.exceptions.MysqlDataTruncation: Data truncation: Data too long for column \'remark\' at row 1\r\n### The error may involve com.ruoyi.project.api.server.mapper.ApiServerGroupMapper.insert-Inline\r\n### The error occurred while setting parameters\r\n### SQL: insert into api_server_group (server_group_id, server_group_name, server_group_code,        create_by, create_time, update_by,        update_time, remark)     values (?, ?, ?,        ?, ?, ?,        ?, ?)\r\n### Cause: com.mysql.cj.jdbc.exceptions.MysqlDataTruncation: Data truncation: Data too long for column \'remark\' at row 1\n; Data truncation: Data too long for column \'remark\' at row 1; nested exception is com.mysql.cj.jdbc.exceptions.MysqlDataTruncation: Data truncation: Data too long for column \'remark\' at row 1', '2019-08-06 15:29:06');
INSERT INTO `sys_oper_log` VALUES ('123', 'api服务', '1', 'com.ruoyi.project.api.server.controller.ApiServerGroupController.addSave()', '1', 'admin', null, '/api/serverGroup/add', '127.0.0.1', '内网IP', '{\"serverGroupName\":[\"管廊\"],\"remark\":[\"两学一做\"]}', '0', null, '2019-08-06 15:29:41');
INSERT INTO `sys_oper_log` VALUES ('124', 'api服务', '3', 'com.ruoyi.project.api.server.controller.ApiServerGroupController.remove()', '1', 'admin', null, '/api/serverGroup/remove', '127.0.0.1', '内网IP', '{\"ids\":[\"2\"]}', '0', null, '2019-08-06 15:31:44');
INSERT INTO `sys_oper_log` VALUES ('125', 'api服务', '1', 'com.ruoyi.project.api.server.controller.ApiServerGroupController.addSave()', '1', 'admin', null, '/api/serverGroup/add', '127.0.0.1', '内网IP', '{\"serverGroupName\":[\"管廊\"],\"remark\":[\"两学一做\"]}', '0', null, '2019-08-06 15:31:52');
INSERT INTO `sys_oper_log` VALUES ('126', 'api服务', '2', 'com.ruoyi.project.api.server.controller.ApiServerGroupController.editSave()', '1', 'admin', null, '/api/serverGroup/edit', '127.0.0.1', '内网IP', '{\"serverGroupId\":[\"3\"],\"serverGroupName\":[\"管廊\"],\"remark\":[\"两学一做22\"]}', '0', null, '2019-08-06 15:54:53');
INSERT INTO `sys_oper_log` VALUES ('127', 'api服务', '2', 'com.ruoyi.project.api.server.controller.ApiServerGroupController.editSave()', '1', 'admin', null, '/api/serverGroup/edit', '127.0.0.1', '内网IP', '{\"serverGroupId\":[\"3\"],\"serverGroupName\":[\"管廊2\"],\"remark\":[\"两学一做22\"]}', '0', null, '2019-08-06 15:54:59');
INSERT INTO `sys_oper_log` VALUES ('128', 'api服务', '2', 'com.ruoyi.project.api.server.controller.ApiServerGroupController.editSave()', '1', 'admin', null, '/api/serverGroup/edit', '127.0.0.1', '内网IP', '{\"serverGroupId\":[\"3\"],\"serverGroupName\":[\"管廊\"],\"remark\":[\"两学一做22\"]}', '0', null, '2019-08-06 15:55:03');
INSERT INTO `sys_oper_log` VALUES ('129', 'api服务', '1', 'com.ruoyi.project.api.server.controller.ApiServerGroupController.addSave()', '1', 'admin', null, '/api/serverGroup/add', '127.0.0.1', '内网IP', '{\"serverGroupName\":[\"管廊2\"],\"remark\":[\"\"]}', '0', null, '2019-08-06 15:55:10');
INSERT INTO `sys_oper_log` VALUES ('130', 'api服务', '3', 'com.ruoyi.project.api.server.controller.ApiServerGroupController.remove()', '1', 'admin', null, '/api/serverGroup/remove', '127.0.0.1', '内网IP', '{\"ids\":[\"4\"]}', '0', null, '2019-08-06 15:55:12');
INSERT INTO `sys_oper_log` VALUES ('131', 'api服务', '1', 'com.ruoyi.project.api.server.controller.ApiServerController.addSave()', '1', 'admin', '研发部门', '/api/server/add', '127.0.0.1', '内网IP', '{\"serverName\":[\"test\"],\"serverCode\":[\"test\"],\"serverUrl\":[\"http://192.168.8.132:8080/app\\t\"],\"serverGroup\":[\"\"],\"remark\":[\"两学一做\"],\"serverAutoCheck\":[\"false\"],\"serverLive\":[\"false\"]}', '0', null, '2019-08-08 10:06:37');
INSERT INTO `sys_oper_log` VALUES ('132', 'api服务', '1', 'com.ruoyi.project.api.server.controller.ApiServerController.addSave()', '1', 'admin', '研发部门', '/api/server/add', '127.0.0.1', '内网IP', '{\"serverName\":[\"test2\"],\"serverCode\":[\"test2\"],\"serverUrl\":[\"http://192.168.8.132:8080/app\\t\"],\"serverGroup\":[\"3\"],\"remark\":[\"两学一做\"],\"serverAutoCheck\":[\"true\"],\"checkCycleMinute\":[\"5\"],\"serverCheckUrl\":[\"http://192.168.8.132:8080/app\"],\"checkResultType\":[\"string\"],\"checkType\":[\"contain\"],\"checkValue\":[\"login\"]}', '1', '\r\n### Error updating database.  Cause: java.sql.SQLIntegrityConstraintViolationException: Column \'server_live\' cannot be null\r\n### The error may involve com.ruoyi.project.api.server.mapper.ApiServerMapper.insert-Inline\r\n### The error occurred while setting parameters\r\n### SQL: insert into api_server (server_id, server_name, server_code,        server_head, server_domain, server_suffix,        server_url, server_auto_check, server_check_url,        server_live, server_group, create_by,        create_time, update_by, update_time,        remark, check_result_type, check_type,        check_json_key, check_value, check_cycle_minute       )     values (?, ?, ?,        ?, ?, ?,        ?, ?, ?,        ?, ?, ?,        ?, ?, ?,        ?, ?, ?,        ?, ?, ?       )\r\n### Cause: java.sql.SQLIntegrityConstraintViolationException: Column \'server_live\' cannot be null\n; Column \'server_live\' cannot be null; nested exception is java.sql.SQLIntegrityConstraintViolationException: Column \'server_live\' cannot be null', '2019-08-08 10:11:30');
INSERT INTO `sys_oper_log` VALUES ('133', 'api服务', '1', 'com.ruoyi.project.api.server.controller.ApiServerController.addSave()', '1', 'admin', null, '/api/server/add', '127.0.0.1', '内网IP', '{\"serverName\":[\"test2\"],\"serverCode\":[\"test2\"],\"serverUrl\":[\"http://192.168.8.132:8080/app\\t\"],\"serverGroup\":[\"3\"],\"remark\":[\"两学一做\"],\"serverAutoCheck\":[\"true\"],\"checkCycleMinute\":[\"5\"],\"serverCheckUrl\":[\"http://192.168.8.132:8080/app\"],\"checkResultType\":[\"string\"],\"checkType\":[\"contain\"],\"checkValue\":[\"login\"]}', '0', null, '2019-08-08 10:13:11');
INSERT INTO `sys_oper_log` VALUES ('134', 'api服务', '1', 'com.ruoyi.project.api.server.controller.ApiServerController.addSave()', '1', 'admin', null, '/api/server/add', '127.0.0.1', '内网IP', '{\"serverName\":[\"test3\"],\"serverCode\":[\"test3\"],\"serverUrl\":[\"http://localhost/#\"],\"serverGroup\":[\"3\"],\"remark\":[\"\"],\"serverAutoCheck\":[\"true\"],\"checkCycleMinute\":[\"5\"],\"serverCheckUrl\":[\"http://localhost/#\"],\"checkResultType\":[\"json\"],\"checkJsonKey\":[\"k.k\"],\"checkType\":[\"contain\"],\"checkValue\":[\"1\"]}', '0', null, '2019-08-08 10:15:17');
INSERT INTO `sys_oper_log` VALUES ('135', 'api服务', '2', 'com.ruoyi.project.api.server.controller.ApiServerController.editSave()', '1', 'admin', '研发部门', '/api/server/edit', '127.0.0.1', '内网IP', '{\"serverId\":[\"2\"],\"serverName\":[\"test\"],\"serverCode\":[\"test\"],\"serverUrl\":[\"http://192.168.8.132:8080/app\\t\"],\"serverGroup\":[\"\"],\"remark\":[\"两学一做\"],\"serverAutoCheck\":[\"false\"],\"serverLive\":[\"true\"]}', '0', null, '2019-08-08 14:10:49');
INSERT INTO `sys_oper_log` VALUES ('136', 'api服务', '2', 'com.ruoyi.project.api.server.controller.ApiServerController.editSave()', '1', 'admin', '研发部门', '/api/server/edit', '127.0.0.1', '内网IP', '{\"serverId\":[\"2\"],\"serverName\":[\"test\"],\"serverCode\":[\"test\"],\"serverUrl\":[\"http://192.168.8.132:8080/app\\t\"],\"serverGroup\":[\"\"],\"remark\":[\"两学一做\"],\"serverAutoCheck\":[\"false\"],\"serverLive\":[\"false\"]}', '0', null, '2019-08-08 14:13:01');
INSERT INTO `sys_oper_log` VALUES ('137', 'api服务', '2', 'com.ruoyi.project.api.server.controller.ApiServerController.editSave()', '1', 'admin', '研发部门', '/api/server/edit', '127.0.0.1', '内网IP', '{\"serverId\":[\"2\"],\"serverName\":[\"test\"],\"serverCode\":[\"test\"],\"serverUrl\":[\"http://192.168.8.132:8080/app\\t\"],\"serverGroup\":[\"\"],\"remark\":[\"两学一做\"],\"serverAutoCheck\":[\"true\"],\"checkCycleMinute\":[\"5\"],\"serverCheckUrl\":[\"http://localhost/#\"],\"checkResultType\":[\"string\"],\"checkType\":[\"contain\"],\"checkValue\":[\"500\"]}', '0', null, '2019-08-08 14:13:21');
INSERT INTO `sys_oper_log` VALUES ('138', 'api服务', '1', 'com.ruoyi.project.api.server.controller.ApiServerController.addSave()', '1', 'admin', null, '/api/server/add', '127.0.0.1', '内网IP', '{\"serverName\":[\"管廊app\"],\"serverCode\":[\"guanlang_app\"],\"serverDomain\":[\"http://192.168.8.132\"],\"serverPort\":[\"8080\"],\"serverSuffix\":[\"/app\"],\"serverGroup\":[\"3\"],\"remark\":[\"\"],\"serverAutoCheck\":[\"false\"],\"serverLive\":[\"true\"]}', '0', null, '2019-08-08 16:45:12');
INSERT INTO `sys_oper_log` VALUES ('139', 'api服务', '2', 'com.ruoyi.project.api.server.controller.ApiServerController.editSave()', '1', 'admin', null, '/api/server/edit', '127.0.0.1', '内网IP', '{\"serverId\":[\"5\"],\"serverName\":[\"管廊app\"],\"serverCode\":[\"guanlang_app\"],\"serverDomain\":[\"http://192.168.8.132\"],\"serverPort\":[\"8080\"],\"serverSuffix\":[\"/app\"],\"serverGroup\":[\"3\"],\"remark\":[\"\"],\"serverAutoCheck\":[\"false\"],\"serverLive\":[\"true\"]}', '0', null, '2019-08-08 16:50:16');
INSERT INTO `sys_oper_log` VALUES ('140', '菜单管理', '1', 'com.ruoyi.project.system.menu.controller.MenuController.addSave()', '1', 'admin', '研发部门', '/system/menu/add', '127.0.0.1', '内网IP', '{\"parentId\":[\"2005\"],\"menuType\":[\"C\"],\"menuName\":[\"开放api\"],\"url\":[\"/api/apiUrl\"],\"target\":[\"menuItem\"],\"perms\":[\"api:url:list\"],\"orderNum\":[\"0\"],\"icon\":[\"\"],\"visible\":[\"0\"]}', '0', null, '2019-08-12 13:39:44');
INSERT INTO `sys_oper_log` VALUES ('141', '菜单管理', '2', 'com.ruoyi.project.system.menu.controller.MenuController.editSave()', '1', 'admin', '研发部门', '/system/menu/edit', '127.0.0.1', '内网IP', '{\"menuId\":[\"2006\"],\"parentId\":[\"2005\"],\"menuType\":[\"C\"],\"menuName\":[\"开放api\"],\"url\":[\"/api/apiUrl\"],\"target\":[\"menuItem\"],\"perms\":[\"api:url:view\"],\"orderNum\":[\"0\"],\"icon\":[\"#\"],\"visible\":[\"0\"]}', '0', null, '2019-08-12 13:40:23');
INSERT INTO `sys_oper_log` VALUES ('142', '菜单管理', '1', 'com.ruoyi.project.system.menu.controller.MenuController.addSave()', '1', 'admin', '研发部门', '/system/menu/add', '127.0.0.1', '内网IP', '{\"parentId\":[\"2006\"],\"menuType\":[\"F\"],\"menuName\":[\"列表\"],\"url\":[\"\"],\"target\":[\"menuItem\"],\"perms\":[\"api:url:list\"],\"orderNum\":[\"0\"],\"icon\":[\"\"],\"visible\":[\"0\"]}', '0', null, '2019-08-12 13:40:52');
INSERT INTO `sys_oper_log` VALUES ('143', '菜单管理', '1', 'com.ruoyi.project.system.menu.controller.MenuController.addSave()', '1', 'admin', '研发部门', '/system/menu/add', '127.0.0.1', '内网IP', '{\"parentId\":[\"2006\"],\"menuType\":[\"F\"],\"menuName\":[\"导出\"],\"url\":[\"\"],\"target\":[\"menuItem\"],\"perms\":[\"api:url:export\"],\"orderNum\":[\"1\"],\"icon\":[\"\"],\"visible\":[\"0\"]}', '0', null, '2019-08-12 13:41:15');
INSERT INTO `sys_oper_log` VALUES ('144', '菜单管理', '1', 'com.ruoyi.project.system.menu.controller.MenuController.addSave()', '1', 'admin', '研发部门', '/system/menu/add', '127.0.0.1', '内网IP', '{\"parentId\":[\"2006\"],\"menuType\":[\"F\"],\"menuName\":[\"添加\"],\"url\":[\"\"],\"target\":[\"menuItem\"],\"perms\":[\"api:url:add\"],\"orderNum\":[\"2\"],\"icon\":[\"\"],\"visible\":[\"0\"]}', '0', null, '2019-08-12 13:41:31');
INSERT INTO `sys_oper_log` VALUES ('145', '菜单管理', '1', 'com.ruoyi.project.system.menu.controller.MenuController.addSave()', '1', 'admin', '研发部门', '/system/menu/add', '127.0.0.1', '内网IP', '{\"parentId\":[\"2006\"],\"menuType\":[\"F\"],\"menuName\":[\"修改\"],\"url\":[\"\"],\"target\":[\"menuItem\"],\"perms\":[\"api:url:edit\"],\"orderNum\":[\"3\"],\"icon\":[\"\"],\"visible\":[\"0\"]}', '0', null, '2019-08-12 13:41:51');
INSERT INTO `sys_oper_log` VALUES ('146', '菜单管理', '1', 'com.ruoyi.project.system.menu.controller.MenuController.addSave()', '1', 'admin', '研发部门', '/system/menu/add', '127.0.0.1', '内网IP', '{\"parentId\":[\"2006\"],\"menuType\":[\"F\"],\"menuName\":[\"删除\"],\"url\":[\"\"],\"target\":[\"menuItem\"],\"perms\":[\"api:url:remove\"],\"orderNum\":[\"4\"],\"icon\":[\"\"],\"visible\":[\"0\"]}', '0', null, '2019-08-12 13:42:08');
INSERT INTO `sys_oper_log` VALUES ('147', 'api服务', '1', 'com.ruoyi.project.api.apiurl.controller.ApiUrlController.addSave()', '1', 'admin', null, '/api/apiUrl/add', '127.0.0.1', '内网IP', '{\"apiName\":[\"获取用户信息\"],\"serverGroup\":[\"3\"],\"apiUrlSuffix\":[\"/user/getUserById\"],\"apiServerUrlSuffix\":[\"/user/getUserById\"],\"apiServerIds\":[\"5\"],\"apiServerRequestWay\":[\"weight_round_robin\"]}', '0', null, '2019-08-12 16:41:06');
INSERT INTO `sys_oper_log` VALUES ('148', 'api服务', '2', 'com.ruoyi.project.api.server.controller.ApiServerController.editSave()', '1', 'admin', null, '/api/server/edit', '127.0.0.1', '内网IP', '{}', '0', null, '2019-08-13 10:39:25');
INSERT INTO `sys_oper_log` VALUES ('149', 'api服务', '2', 'com.ruoyi.project.api.apiurl.controller.ApiUrlController.editSave()', '1', 'admin', null, '/api/apiUrl/edit', '127.0.0.1', '内网IP', '{}', '0', null, '2019-08-13 10:40:06');
INSERT INTO `sys_oper_log` VALUES ('150', 'api服务', '2', 'com.ruoyi.project.api.apiurl.controller.ApiUrlController.editSave()', '1', 'admin', null, '/api/apiUrl/edit', '127.0.0.1', '内网IP', '{}', '0', null, '2019-08-13 10:40:12');
INSERT INTO `sys_oper_log` VALUES ('151', 'api服务', '2', 'com.ruoyi.project.api.apiurl.controller.ApiUrlController.editSave()', '1', 'admin', null, '/api/apiUrl/edit', '127.0.0.1', '内网IP', '{}', '0', null, '2019-08-13 10:41:40');
INSERT INTO `sys_oper_log` VALUES ('152', 'api服务', '2', 'com.ruoyi.project.api.apiurl.controller.ApiUrlController.editSave()', '1', 'admin', null, '/api/apiUrl/edit', '127.0.0.1', '内网IP', '{\"apiId\":[\"1\"],\"apiName\":[\"获取用户信息\"],\"serverGroup\":[\"\"],\"remark\":[\"管廊用户信息\"],\"apiUrlSuffix\":[\"/user/getUserById\"],\"apiServerUrlSuffix\":[\"/user/getUserById\"],\"apiServerIds\":[\"5\"],\"apiServerRequestWay\":[\"weight_round_robin\"]}', '0', null, '2019-08-13 10:42:12');
INSERT INTO `sys_oper_log` VALUES ('153', 'api服务', '2', 'com.ruoyi.project.api.apiurl.controller.ApiUrlController.editSave()', '1', 'admin', null, '/api/apiUrl/edit', '127.0.0.1', '内网IP', '{\"apiId\":[\"1\"],\"apiName\":[\"获取用户信息\"],\"serverGroup\":[\"3\"],\"remark\":[\"\"],\"apiUrlSuffix\":[\"/user/getUserById\"],\"apiServerUrlSuffix\":[\"/user/getUserById\"],\"apiServerIds\":[\"5\"],\"apiServerRequestWay\":[\"weight_round_robin\"]}', '0', null, '2019-08-13 10:42:17');
INSERT INTO `sys_oper_log` VALUES ('154', 'api服务', '2', 'com.ruoyi.project.api.apiurl.controller.ApiUrlController.editSave()', '1', 'admin', null, '/api/apiUrl/edit', '127.0.0.1', '内网IP', '{\"apiId\":[\"1\"],\"apiName\":[\"获取用户信息\"],\"apiGroupId\":[\"3\"],\"remark\":[\"管廊用户信息\"],\"apiUrlSuffix\":[\"/user/getUserById\"],\"apiServerUrlSuffix\":[\"/user/getUserById\"],\"apiServerIds\":[\"5\"],\"apiServerRequestWay\":[\"weight_round_robin\"]}', '0', null, '2019-08-13 10:43:16');
INSERT INTO `sys_oper_log` VALUES ('155', 'api服务', '2', 'com.ruoyi.project.api.apiurl.controller.ApiUrlController.editSave()', '1', 'admin', null, '/api/apiUrl/edit', '127.0.0.1', '内网IP', '{\"apiId\":[\"1\"],\"apiName\":[\"获取用户信息\"],\"apiGroupId\":[\"\"],\"remark\":[\"\"],\"apiUrlSuffix\":[\"/user/getUserById\"],\"apiServerUrlSuffix\":[\"/user/getUserById\"],\"apiServerIds\":[\"5\"],\"apiServerRequestWay\":[\"weight_round_robin\"]}', '0', null, '2019-08-13 10:55:57');
INSERT INTO `sys_oper_log` VALUES ('156', 'api服务', '2', 'com.ruoyi.project.api.apiurl.controller.ApiUrlController.editSave()', '1', 'admin', null, '/api/apiUrl/edit', '127.0.0.1', '内网IP', '{\"apiId\":[\"1\"],\"apiName\":[\"获取用户信息\"],\"apiGroupId\":[\"\"],\"remark\":[\"\"],\"apiUrlSuffix\":[\"/user/getUserById\"],\"apiServerUrlSuffix\":[\"/user/getUserById\"],\"apiServerIds\":[\"5\"],\"apiServerRequestWay\":[\"weight_round_robin\"]}', '0', null, '2019-08-13 11:01:37');
INSERT INTO `sys_oper_log` VALUES ('157', 'api服务', '2', 'com.ruoyi.project.api.apiurl.controller.ApiUrlController.editSave()', '1', 'admin', null, '/api/apiUrl/edit', '127.0.0.1', '内网IP', '{\"apiId\":[\"1\"],\"apiName\":[\"获取用户信息\"],\"apiGroupId\":[\"\"],\"remark\":[\"\"],\"apiUrlSuffix\":[\"/user/getUserById\"],\"apiServerUrlSuffix\":[\"/user/getUserById\"],\"apiServerIds\":[\"5\"],\"apiServerRequestWay\":[\"weight_round_robin\"]}', '0', null, '2019-08-13 11:02:40');
INSERT INTO `sys_oper_log` VALUES ('158', '菜单管理', '1', 'com.ruoyi.project.system.menu.controller.MenuController.addSave()', '1', 'admin', null, '/system/menu/add', '127.0.0.1', '内网IP', '{\"parentId\":[\"2005\"],\"menuType\":[\"C\"],\"menuName\":[\"api账号\"],\"url\":[\"/api/account\"],\"target\":[\"menuItem\"],\"perms\":[\"api:account:view\"],\"orderNum\":[\"0\"],\"icon\":[\"\"],\"visible\":[\"0\"]}', '0', null, '2019-08-13 13:46:54');
INSERT INTO `sys_oper_log` VALUES ('159', '菜单管理', '2', 'com.ruoyi.project.system.menu.controller.MenuController.editSave()', '1', 'admin', null, '/system/menu/edit', '127.0.0.1', '内网IP', '{\"menuId\":[\"2012\"],\"parentId\":[\"2005\"],\"menuType\":[\"C\"],\"menuName\":[\"api账号\"],\"url\":[\"/api/account\"],\"target\":[\"menuItem\"],\"perms\":[\"api:account:view\"],\"orderNum\":[\"2\"],\"icon\":[\"#\"],\"visible\":[\"0\"]}', '0', null, '2019-08-13 13:47:04');
INSERT INTO `sys_oper_log` VALUES ('160', '菜单管理', '1', 'com.ruoyi.project.system.menu.controller.MenuController.addSave()', '1', 'admin', null, '/system/menu/add', '127.0.0.1', '内网IP', '{\"parentId\":[\"2012\"],\"menuType\":[\"F\"],\"menuName\":[\"列表\"],\"url\":[\"\"],\"target\":[\"menuItem\"],\"perms\":[\"api:account:list\"],\"orderNum\":[\"0\"],\"icon\":[\"\"],\"visible\":[\"0\"]}', '0', null, '2019-08-13 13:48:15');
INSERT INTO `sys_oper_log` VALUES ('161', '菜单管理', '1', 'com.ruoyi.project.system.menu.controller.MenuController.addSave()', '1', 'admin', null, '/system/menu/add', '127.0.0.1', '内网IP', '{\"parentId\":[\"2012\"],\"menuType\":[\"F\"],\"menuName\":[\"导出\"],\"url\":[\"\"],\"target\":[\"menuItem\"],\"perms\":[\"api:account:export\"],\"orderNum\":[\"1\"],\"icon\":[\"\"],\"visible\":[\"0\"]}', '0', null, '2019-08-13 13:48:37');
INSERT INTO `sys_oper_log` VALUES ('162', '菜单管理', '1', 'com.ruoyi.project.system.menu.controller.MenuController.addSave()', '1', 'admin', null, '/system/menu/add', '127.0.0.1', '内网IP', '{\"parentId\":[\"2012\"],\"menuType\":[\"F\"],\"menuName\":[\"添加\"],\"url\":[\"\"],\"target\":[\"menuItem\"],\"perms\":[\"api:account:add\"],\"orderNum\":[\"2\"],\"icon\":[\"\"],\"visible\":[\"0\"]}', '0', null, '2019-08-13 13:48:59');
INSERT INTO `sys_oper_log` VALUES ('163', '菜单管理', '1', 'com.ruoyi.project.system.menu.controller.MenuController.addSave()', '1', 'admin', null, '/system/menu/add', '127.0.0.1', '内网IP', '{\"parentId\":[\"2012\"],\"menuType\":[\"F\"],\"menuName\":[\"修改\"],\"url\":[\"\"],\"target\":[\"menuItem\"],\"perms\":[\"api:account:edit\"],\"orderNum\":[\"3\"],\"icon\":[\"\"],\"visible\":[\"0\"]}', '0', null, '2019-08-13 13:49:15');
INSERT INTO `sys_oper_log` VALUES ('164', '菜单管理', '1', 'com.ruoyi.project.system.menu.controller.MenuController.addSave()', '1', 'admin', null, '/system/menu/add', '127.0.0.1', '内网IP', '{\"parentId\":[\"2012\"],\"menuType\":[\"F\"],\"menuName\":[\"删除\"],\"url\":[\"\"],\"target\":[\"menuItem\"],\"perms\":[\"api:account:remove\"],\"orderNum\":[\"4\"],\"icon\":[\"\"],\"visible\":[\"0\"]}', '0', null, '2019-08-13 13:49:32');
INSERT INTO `sys_oper_log` VALUES ('165', 'api服务', '1', 'com.ruoyi.project.api.account.controller.ApiAccountController.addSave()', '1', 'admin', null, '/api/account/add', '127.0.0.1', '内网IP', '{\"accountName\":[\"\"],\"remark\":[\"\"]}', '0', null, '2019-08-13 13:52:00');
INSERT INTO `sys_oper_log` VALUES ('166', 'api服务', '3', 'com.ruoyi.project.api.account.controller.ApiAccountController.remove()', '1', 'admin', null, '/api/account/remove', '127.0.0.1', '内网IP', '{\"ids\":[\"undefined\"]}', '1', 'For input string: \"undefined\"', '2019-08-13 13:52:02');
INSERT INTO `sys_oper_log` VALUES ('167', 'api服务', '3', 'com.ruoyi.project.api.account.controller.ApiAccountController.remove()', '1', 'admin', null, '/api/account/remove', '127.0.0.1', '内网IP', '{\"ids\":[\"undefined\"]}', '1', 'For input string: \"undefined\"', '2019-08-13 13:52:23');
INSERT INTO `sys_oper_log` VALUES ('168', 'api服务', '1', 'com.ruoyi.project.api.account.controller.ApiAccountController.addSave()', '1', 'admin', null, '/api/account/add', '127.0.0.1', '内网IP', '{\"accountName\":[\"测试账号\"],\"remark\":[\"\"]}', '0', null, '2019-08-13 13:53:31');
INSERT INTO `sys_oper_log` VALUES ('169', 'api服务', '3', 'com.ruoyi.project.api.account.controller.ApiAccountController.remove()', '1', 'admin', null, '/api/account/remove', '127.0.0.1', '内网IP', '{\"ids\":[\"undefined\"]}', '1', 'For input string: \"undefined\"', '2019-08-13 13:53:35');
INSERT INTO `sys_oper_log` VALUES ('170', 'api服务', '3', 'com.ruoyi.project.api.account.controller.ApiAccountController.remove()', '1', 'admin', null, '/api/account/remove', '127.0.0.1', '内网IP', '{\"ids\":[\"undefined\"]}', '1', 'For input string: \"undefined\"', '2019-08-13 13:53:40');
INSERT INTO `sys_oper_log` VALUES ('171', 'api服务', '3', 'com.ruoyi.project.api.account.controller.ApiAccountController.remove()', '1', 'admin', null, '/api/account/remove', '127.0.0.1', '内网IP', '{\"ids\":[\"undefined\"]}', '1', 'For input string: \"undefined\"', '2019-08-13 13:54:00');
INSERT INTO `sys_oper_log` VALUES ('172', 'api服务', '3', 'com.ruoyi.project.api.account.controller.ApiAccountController.remove()', '1', 'admin', null, '/api/account/remove', '127.0.0.1', '内网IP', '{\"ids\":[\"undefined\"]}', '1', 'For input string: \"undefined\"', '2019-08-13 13:54:19');
INSERT INTO `sys_oper_log` VALUES ('173', 'api服务', '3', 'com.ruoyi.project.api.account.controller.ApiAccountController.remove()', '1', 'admin', null, '/api/account/remove', '127.0.0.1', '内网IP', '{\"ids\":[\"1\"]}', '0', null, '2019-08-13 13:55:45');
INSERT INTO `sys_oper_log` VALUES ('174', 'api服务', '3', 'com.ruoyi.project.api.account.controller.ApiAccountController.remove()', '1', 'admin', null, '/api/account/remove', '127.0.0.1', '内网IP', '{\"ids\":[\"2\"]}', '0', null, '2019-08-13 14:14:40');
INSERT INTO `sys_oper_log` VALUES ('175', 'api服务', '1', 'com.ruoyi.project.api.account.controller.ApiAccountController.addSave()', '1', 'admin', null, '/api/account/add', '127.0.0.1', '内网IP', '{\"accountName\":[\"测试账号\\t\"],\"remark\":[\"测试账号\\t\"]}', '0', null, '2019-08-13 14:14:44');
INSERT INTO `sys_oper_log` VALUES ('176', 'api服务', '3', 'com.ruoyi.project.api.account.controller.ApiAccountController.remove()', '1', 'admin', null, '/api/account/remove', '127.0.0.1', '内网IP', '{\"ids\":[\"3\"]}', '0', null, '2019-08-13 14:16:30');
INSERT INTO `sys_oper_log` VALUES ('177', 'api服务', '1', 'com.ruoyi.project.api.account.controller.ApiAccountController.addSave()', '1', 'admin', null, '/api/account/add', '127.0.0.1', '内网IP', '{\"accountName\":[\"测试账号\"],\"remark\":[\"\"]}', '0', null, '2019-08-13 14:16:46');
INSERT INTO `sys_oper_log` VALUES ('178', 'api服务', '1', 'com.ruoyi.project.api.account.controller.ApiAccountController.addSave()', '1', 'admin', null, '/api/account/add', '127.0.0.1', '内网IP', '{\"accountName\":[\"测试账号\\t2\"],\"remark\":[\"\"]}', '0', null, '2019-08-13 14:16:58');
INSERT INTO `sys_oper_log` VALUES ('179', 'api服务', '2', 'com.ruoyi.project.api.apiurl.controller.ApiUrlController.editSave()', '1', 'admin', '研发部门', '/api/apiUrl/edit', '127.0.0.1', '内网IP', '{\"apiId\":[\"1\"],\"apiName\":[\"获取用户信息\"],\"apiGroupId\":[\"\"],\"remark\":[\"\"],\"apiUrlSuffix\":[\"/user/getUserById\"],\"apiServerUrlSuffix\":[\"/user/getUserById\"],\"apiRequestMethod\":[\"GET/POST\"],\"apiServerIds\":[\"5\"],\"apiServerRequestWay\":[\"weight_round_robin\"]}', '0', null, '2019-08-13 15:16:24');
INSERT INTO `sys_oper_log` VALUES ('180', 'api服务', '1', 'com.ruoyi.project.api.account.controller.ApiAccountController.addSave()', '1', 'admin', null, '/api/account/add', '127.0.0.1', '内网IP', '{\"paramName\":[\"id\"],\"paramRequired\":[\"true\"],\"paramType\":[\"number\"],\"paramCheckRegex\":[\"\"],\"remark\":[\"用户id\"]}', '0', null, '2019-08-13 16:22:01');
INSERT INTO `sys_oper_log` VALUES ('181', 'api服务', '3', 'com.ruoyi.project.api.account.controller.ApiAccountController.remove()', '1', 'admin', null, '/api/account/remove', '127.0.0.1', '内网IP', '{\"ids\":[\"6\"]}', '0', null, '2019-08-13 16:22:17');
INSERT INTO `sys_oper_log` VALUES ('182', 'api服务', '1', 'com.ruoyi.project.api.apiurl.controller.ApiUrlParamController.addSave()', '1', 'admin', null, '/api/apiUrlParam/add', '127.0.0.1', '内网IP', '{\"apiId\":[\"1\"],\"paramName\":[\"id\"],\"paramRequired\":[\"false\"],\"paramType\":[\"number\"],\"paramCheckRegex\":[\"\"],\"remark\":[\"用户id\"]}', '0', null, '2019-08-13 16:28:19');
INSERT INTO `sys_oper_log` VALUES ('183', 'api服务', '1', 'com.ruoyi.project.api.apiurl.controller.ApiUrlParamController.addSave()', '1', 'admin', null, '/api/apiUrlParam/add', '127.0.0.1', '内网IP', '{\"apiId\":[\"1\"],\"paramName\":[\"id\"],\"paramRequired\":[\"false\"],\"paramType\":[\"string\"],\"paramCheckRegex\":[\"\"],\"remark\":[\"\"]}', '0', null, '2019-08-13 16:28:34');
INSERT INTO `sys_oper_log` VALUES ('184', '菜单管理', '2', 'com.ruoyi.project.system.menu.controller.MenuController.editSave()', '1', 'admin', null, '/system/menu/edit', '127.0.0.1', '内网IP', '{\"menuId\":[\"101\"],\"parentId\":[\"1\"],\"menuType\":[\"C\"],\"menuName\":[\"角色管理\"],\"url\":[\"/system/role\"],\"target\":[\"menuItem\"],\"perms\":[\"system:role:view\"],\"orderNum\":[\"2\"],\"icon\":[\"#\"],\"visible\":[\"0\"]}', '0', null, '2019-08-13 16:30:54');
INSERT INTO `sys_oper_log` VALUES ('185', '代码生成', '8', 'com.ruoyi.project.tool.gen.controller.GenController.genCode()', '1', 'admin', '研发部门', '/tool/gen/genCode/account_api_limit', '127.0.0.1', '内网IP', '{}', '0', null, '2019-08-14 17:01:33');
INSERT INTO `sys_oper_log` VALUES ('186', '代码生成', '8', 'com.ruoyi.project.tool.gen.controller.GenController.genCode()', '1', 'admin', '研发部门', '/tool/gen/genCode/account_api_limit', '127.0.0.1', '内网IP', '{}', '0', null, '2019-08-14 17:01:35');
INSERT INTO `sys_oper_log` VALUES ('187', 'api服务', '1', 'com.ruoyi.project.api.accountapilimit.controller.AccountApiLimitController.addSave()', '1', 'admin', '研发部门', '/api/accountApiLimit/add', '127.0.0.1', '内网IP', '{\"accountId\":[\"4\"],\"apiId\":[\"1\"],\"remark\":[\"\"],\"hasLimit\":[\"false\"]}', '0', null, '2019-08-15 14:22:48');
INSERT INTO `sys_oper_log` VALUES ('188', 'api服务', '1', 'com.ruoyi.project.api.accountapilimit.controller.AccountApiLimitController.addSave()', '1', 'admin', '研发部门', '/api/accountApiLimit/add', '127.0.0.1', '内网IP', '{\"accountId\":[\"4\"],\"apiId\":[\"1\"],\"remark\":[\"\"],\"hasLimit\":[\"true\"],\"limitType\":[\"time_limit\"],\"limitTimeNumber\":[\"1\"],\"limitTimeUnit\":[\"minute\"],\"limitNumber\":[\"5\"]}', '0', null, '2019-08-15 15:47:32');
INSERT INTO `sys_oper_log` VALUES ('189', 'api服务', '2', 'com.ruoyi.project.api.accountapilimit.controller.AccountApiLimitController.editSave()', '1', 'admin', '研发部门', '/api/accountApiLimit/edit', '127.0.0.1', '内网IP', '{\"accountId\":[\"4\"],\"apiId\":[\"1\"],\"remark\":[\"\"],\"hasLimit\":[\"true\"],\"limitType\":[\"time_limit\"],\"limitTimeNumber\":[\"1\"],\"limitTimeUnit\":[\"minute\"],\"limitNumber\":[\"5\"]}', '0', null, '2019-08-15 15:48:54');
INSERT INTO `sys_oper_log` VALUES ('190', 'api服务', '2', 'com.ruoyi.project.api.accountapilimit.controller.AccountApiLimitController.editSave()', '1', 'admin', null, '/api/accountApiLimit/edit', '127.0.0.1', '内网IP', '{\"accountId\":[\"4\"],\"apiId\":[\"1\"],\"remark\":[\"\"],\"hasLimit\":[\"true\"],\"limitType\":[\"total_limit\"],\"limitNumber\":[\"5\"],\"limitRestNumber\":[\"5\"]}', '1', '\r\n### Error updating database.  Cause: java.sql.SQLIntegrityConstraintViolationException: Column \'limit_time_number\' cannot be null\r\n### The error may involve com.ruoyi.project.api.accountapilimit.mapper.AccountApiLimitMapper.updateByPrimaryKey-Inline\r\n### The error occurred while setting parameters\r\n### SQL: update account_api_limit     set has_limit = ?,       limit_type = ?,       limit_number = ?,       limit_time_number = ?,       limit_time_unit = ?,       limit_rest_number = ?,       create_by = ?,       create_time = ?,       update_by = ?,       update_time = ?,       remark = ?     where account_id = ?       and api_id = ?\r\n### Cause: java.sql.SQLIntegrityConstraintViolationException: Column \'limit_time_number\' cannot be null\n; Column \'limit_time_number\' cannot be null; nested exception is java.sql.SQLIntegrityConstraintViolationException: Column \'limit_time_number\' cannot be null', '2019-08-15 16:09:39');
INSERT INTO `sys_oper_log` VALUES ('191', 'api服务', '2', 'com.ruoyi.project.api.accountapilimit.controller.AccountApiLimitController.editSave()', '1', 'admin', null, '/api/accountApiLimit/edit', '127.0.0.1', '内网IP', '{\"accountId\":[\"4\"],\"apiId\":[\"1\"],\"remark\":[\"\"],\"hasLimit\":[\"true\"],\"limitType\":[\"total_limit\"],\"limitNumber\":[\"5\"],\"limitRestNumber\":[\"5\"]}', '1', '\r\n### Error updating database.  Cause: java.sql.SQLIntegrityConstraintViolationException: Column \'limit_time_number\' cannot be null\r\n### The error may involve com.ruoyi.project.api.accountapilimit.mapper.AccountApiLimitMapper.updateByPrimaryKey-Inline\r\n### The error occurred while setting parameters\r\n### SQL: update account_api_limit     set has_limit = ?,       limit_type = ?,       limit_number = ?,       limit_time_number = ?,       limit_time_unit = ?,       limit_rest_number = ?,       create_by = ?,       create_time = ?,       update_by = ?,       update_time = ?,       remark = ?     where account_id = ?       and api_id = ?\r\n### Cause: java.sql.SQLIntegrityConstraintViolationException: Column \'limit_time_number\' cannot be null\n; Column \'limit_time_number\' cannot be null; nested exception is java.sql.SQLIntegrityConstraintViolationException: Column \'limit_time_number\' cannot be null', '2019-08-15 16:09:48');
INSERT INTO `sys_oper_log` VALUES ('192', 'api服务', '2', 'com.ruoyi.project.api.accountapilimit.controller.AccountApiLimitController.editSave()', '1', 'admin', null, '/api/accountApiLimit/edit', '127.0.0.1', '内网IP', '{\"accountId\":[\"4\"],\"apiId\":[\"1\"],\"remark\":[\"\"],\"hasLimit\":[\"true\"],\"limitType\":[\"total_limit\"],\"limitNumber\":[\"5\"],\"limitRestNumber\":[\"5\"]}', '0', null, '2019-08-15 16:10:26');
INSERT INTO `sys_oper_log` VALUES ('193', 'api服务', '2', 'com.ruoyi.project.api.accountapilimit.controller.AccountApiLimitController.editSave()', '1', 'admin', null, '/api/accountApiLimit/edit', '127.0.0.1', '内网IP', '{\"accountId\":[\"4\"],\"apiId\":[\"1\"],\"remark\":[\"\"],\"hasLimit\":[\"true\"],\"limitType\":[\"time_limit\"],\"limitTimeNumber\":[\"1\"],\"limitTimeUnit\":[\"minute\"],\"limitNumber\":[\"3\"]}', '0', null, '2019-08-15 16:13:28');
INSERT INTO `sys_oper_log` VALUES ('194', 'api服务', '1', 'com.ruoyi.project.api.server.controller.ApiServerController.addSave()', '1', 'admin', '研发部门', '/api/server/add', '127.0.0.1', '内网IP', '{\"serverName\":[\"管廊web\"],\"serverCode\":[\"guanlang_web\"],\"serverDomain\":[\"http://192.168.8.132\"],\"serverPort\":[\"8080\"],\"serverSuffix\":[\"/web\"],\"serverWeight\":[\"1\"],\"serverGroup\":[\"3\"],\"remark\":[\"\"],\"serverAutoCheck\":[\"false\"],\"serverLive\":[\"true\"]}', '0', null, '2019-08-19 09:19:44');
INSERT INTO `sys_oper_log` VALUES ('195', 'api服务', '1', 'com.ruoyi.project.api.apiurl.controller.ApiUrlController.addSave()', '1', 'admin', '研发部门', '/api/apiUrl/add', '127.0.0.1', '内网IP', '{\"apiName\":[\"获取消息列表\"],\"apiGroupId\":[\"3\"],\"remark\":[\"\"],\"apiUrlSuffix\":[\"/message\"],\"apiServerUrlSuffix\":[\"/message/list\"],\"apiRequestMethod\":[\"POST\"],\"apiServerIds\":[\"6\"],\"apiServerRequestWay\":[\"weight_round_robin\"]}', '0', null, '2019-08-19 09:20:29');
INSERT INTO `sys_oper_log` VALUES ('196', 'api服务', '1', 'com.ruoyi.project.api.apiurl.controller.ApiUrlParamController.addSave()', '1', 'admin', '研发部门', '/api/apiUrlParam/add', '127.0.0.1', '内网IP', '{\"apiId\":[\"2\"],\"paramName\":[\"userId\"],\"paramRequired\":[\"true\"],\"paramType\":[\"number\"],\"paramCheckRegex\":[\"\"],\"remark\":[\"\"]}', '0', null, '2019-08-19 09:20:45');
INSERT INTO `sys_oper_log` VALUES ('197', 'api服务', '1', 'com.ruoyi.project.api.apiurl.controller.ApiUrlParamController.addSave()', '1', 'admin', '研发部门', '/api/apiUrlParam/add', '127.0.0.1', '内网IP', '{\"apiId\":[\"2\"],\"paramName\":[\"beginTime\"],\"paramRequired\":[\"false\"],\"paramType\":[\"date\"],\"paramCheckRegex\":[\"\"],\"remark\":[\"\"]}', '0', null, '2019-08-19 09:20:55');
INSERT INTO `sys_oper_log` VALUES ('198', 'api服务', '1', 'com.ruoyi.project.api.apiurl.controller.ApiUrlParamController.addSave()', '1', 'admin', '研发部门', '/api/apiUrlParam/add', '127.0.0.1', '内网IP', '{\"apiId\":[\"2\"],\"paramName\":[\"endTime\"],\"paramRequired\":[\"false\"],\"paramType\":[\"date\"],\"paramCheckRegex\":[\"\"],\"remark\":[\"\"]}', '0', null, '2019-08-19 09:21:03');
INSERT INTO `sys_oper_log` VALUES ('199', 'api服务', '1', 'com.ruoyi.project.api.apiurl.controller.ApiUrlParamController.addSave()', '1', 'admin', '研发部门', '/api/apiUrlParam/add', '127.0.0.1', '内网IP', '{\"apiId\":[\"2\"],\"paramName\":[\"readStatus\"],\"paramRequired\":[\"false\"],\"paramType\":[\"number\"],\"paramCheckRegex\":[\"\"],\"remark\":[\"0未读，1已读\"]}', '0', null, '2019-08-19 09:21:18');
INSERT INTO `sys_oper_log` VALUES ('200', 'api服务', '1', 'com.ruoyi.project.api.apiurl.controller.ApiUrlParamController.addSave()', '1', 'admin', '研发部门', '/api/apiUrlParam/add', '127.0.0.1', '内网IP', '{\"apiId\":[\"2\"],\"paramName\":[\"pageNum\"],\"paramRequired\":[\"false\"],\"paramType\":[\"number\"],\"paramCheckRegex\":[\"\"],\"remark\":[\"页码\\r\\n\"]}', '0', null, '2019-08-19 09:21:34');
INSERT INTO `sys_oper_log` VALUES ('201', 'api服务', '1', 'com.ruoyi.project.api.apiurl.controller.ApiUrlParamController.addSave()', '1', 'admin', '研发部门', '/api/apiUrlParam/add', '127.0.0.1', '内网IP', '{\"apiId\":[\"2\"],\"paramName\":[\"pageSize\"],\"paramRequired\":[\"false\"],\"paramType\":[\"number\"],\"paramCheckRegex\":[\"\"],\"remark\":[\"页面大小\\r\\n\"]}', '0', null, '2019-08-19 09:21:48');
INSERT INTO `sys_oper_log` VALUES ('202', 'api服务', '1', 'com.ruoyi.project.api.apiurl.controller.ApiUrlParamController.addSave()', '1', 'admin', '研发部门', '/api/apiUrlParam/add', '127.0.0.1', '内网IP', '{\"apiId\":[\"2\"],\"paramName\":[\"messageLevel\"],\"paramRequired\":[\"false\"],\"paramType\":[\"number\"],\"paramCheckRegex\":[\"\"],\"remark\":[\"1/2，2级报警(红色)>1级报警(黄色)\"]}', '0', null, '2019-08-19 09:22:02');
INSERT INTO `sys_oper_log` VALUES ('203', '菜单管理', '1', 'com.ruoyi.project.system.menu.controller.MenuController.addSave()', '1', 'admin', null, '/system/menu/add', '127.0.0.1', '内网IP', '{\"parentId\":[\"2006\"],\"menuType\":[\"F\"],\"menuName\":[\"参数配置\"],\"url\":[\"\"],\"target\":[\"menuItem\"],\"perms\":[\"api:param:view\"],\"orderNum\":[\"5\"],\"icon\":[\"\"],\"visible\":[\"0\"]}', '0', null, '2019-08-19 09:47:56');
INSERT INTO `sys_oper_log` VALUES ('204', '菜单管理', '1', 'com.ruoyi.project.system.menu.controller.MenuController.addSave()', '1', 'admin', null, '/system/menu/add', '127.0.0.1', '内网IP', '{\"parentId\":[\"2012\"],\"menuType\":[\"F\"],\"menuName\":[\"权限配置\"],\"url\":[\"\"],\"target\":[\"menuItem\"],\"perms\":[\"api:accountApiLimit:view\"],\"orderNum\":[\"5\"],\"icon\":[\"\"],\"visible\":[\"0\"]}', '0', null, '2019-08-19 09:50:28');
INSERT INTO `sys_oper_log` VALUES ('205', '菜单管理', '3', 'com.ruoyi.project.system.menu.controller.MenuController.remove()', '1', 'admin', null, '/system/menu/remove/2016', '127.0.0.1', '内网IP', '{}', '0', null, '2019-08-19 09:51:39');
INSERT INTO `sys_oper_log` VALUES ('206', 'api服务', '2', 'com.ruoyi.project.api.apiurl.controller.ApiUrlParamController.editSave()', '1', 'admin', null, '/api/apiUrlParam/edit', '127.0.0.1', '内网IP', '{\"paramId\":[\"3\"],\"paramName\":[\"id\"],\"paramRequired\":[\"true\"],\"paramType\":[\"number\"],\"paramCheckRegex\":[\"\"],\"remark\":[\"用户id\"]}', '1', '\r\n### Error updating database.  Cause: java.sql.SQLIntegrityConstraintViolationException: Column \'api_id\' cannot be null\r\n### The error may involve com.ruoyi.project.api.apiurl.mapper.ApiUrlParamMapper.updateByPrimaryKey-Inline\r\n### The error occurred while setting parameters\r\n### SQL: update api_url_param     set api_id = ?,       param_name = ?,       param_required = ?,       param_not_empty = ?,       param_type = ?,       param_check_regex = ?,       create_by = ?,       create_time = ?,       update_by = ?,       update_time = ?,       remark = ?     where param_id = ?\r\n### Cause: java.sql.SQLIntegrityConstraintViolationException: Column \'api_id\' cannot be null\n; Column \'api_id\' cannot be null; nested exception is java.sql.SQLIntegrityConstraintViolationException: Column \'api_id\' cannot be null', '2019-08-21 10:15:00');
INSERT INTO `sys_oper_log` VALUES ('207', 'api服务', '2', 'com.ruoyi.project.api.apiurl.controller.ApiUrlParamController.editSave()', '1', 'admin', null, '/api/apiUrlParam/edit', '127.0.0.1', '内网IP', '{\"paramId\":[\"3\"],\"apiId\":[\"1\"],\"paramName\":[\"id\"],\"paramRequired\":[\"true\"],\"paramType\":[\"number\"],\"paramCheckRegex\":[\"\"],\"remark\":[\"用户id\"]}', '0', null, '2019-08-21 10:16:08');
INSERT INTO `sys_oper_log` VALUES ('208', 'api服务', '1', 'com.ruoyi.project.api.apiurl.controller.ApiUrlController.addSave()', '1', 'admin', '研发部门', '/api/apiUrl/add', '127.0.0.1', '内网IP', '{\"apiName\":[\"转发\"],\"apiGroupId\":[\"\"],\"remark\":[\"\"],\"apiUrlSuffix\":[\"/app/*\"],\"apiServerUrlSuffix\":[\"/*\"],\"apiRequestMethod\":[\"GET\"],\"apiServerIds\":[\"5\"],\"apiServerRequestWay\":[\"weight_round_robin\"]}', '0', null, '2019-08-21 11:41:47');
INSERT INTO `sys_oper_log` VALUES ('209', 'api服务', '2', 'com.ruoyi.project.api.apiurl.controller.ApiUrlController.editSave()', '1', 'admin', null, '/api/apiUrl/edit', '127.0.0.1', '内网IP', '{\"apiId\":[\"3\"],\"apiName\":[\"转发\"],\"apiGroupId\":[\"\"],\"remark\":[\"\"],\"apiUrlSuffix\":[\"/app/*\"],\"apiServerUrlSuffix\":[\"/*\"],\"apiRequestMethod\":[\"GET\"],\"apiServerIds\":[\"5\"],\"apiServerRequestWay\":[\"weight_round_robin\"]}', '0', null, '2019-08-21 11:53:45');
INSERT INTO `sys_oper_log` VALUES ('210', 'api服务', '2', 'com.ruoyi.project.api.apiurl.controller.ApiUrlController.editSave()', '1', 'admin', '研发部门', '/api/apiUrl/edit', '127.0.0.1', '内网IP', '{\"apiId\":[\"3\"],\"apiName\":[\"转发\"],\"apiGroupId\":[\"\"],\"remark\":[\"\"],\"apiUrlSuffix\":[\"/app/*\"],\"apiServerUrlSuffix\":[\"/*\"],\"apiRequestMethod\":[\"GET/POST\"],\"apiServerIds\":[\"5\"],\"apiServerRequestWay\":[\"weight_round_robin\"]}', '0', null, '2019-08-21 13:47:40');
INSERT INTO `sys_oper_log` VALUES ('211', 'api服务', '1', 'com.ruoyi.project.api.accountapilimit.controller.AccountApiLimitController.addSave()', '1', 'admin', '研发部门', '/api/accountApiLimit/add', '127.0.0.1', '内网IP', '{\"accountId\":[\"4\"],\"apiId\":[\"3\"],\"remark\":[\"\"],\"hasLimit\":[\"false\"]}', '0', null, '2019-08-21 13:48:08');
INSERT INTO `sys_oper_log` VALUES ('212', 'api服务', '2', 'com.ruoyi.project.api.apiurl.controller.ApiUrlController.editSave()', '1', 'admin', '研发部门', '/api/apiUrl/edit', '127.0.0.1', '内网IP', '{\"apiId\":[\"3\"],\"apiName\":[\"转发\"],\"apiGroupId\":[\"\"],\"remark\":[\"\"],\"apiUrlSuffix\":[\"/app/*\"],\"apiServerUrlSuffix\":[\"/*\"],\"apiRequestMethod\":[\"GET/POST\"],\"apiServerIds\":[\"5\"],\"apiServerRequestWay\":[\"weight_round_robin\"]}', '0', null, '2019-08-21 15:05:26');
INSERT INTO `sys_oper_log` VALUES ('213', 'api服务', '1', 'com.ruoyi.project.api.server.controller.ApiServerController.addSave()', '1', 'admin', '研发部门', '/api/server/add', '127.0.0.1', '内网IP', '{\"serverName\":[\"管廊后台\"],\"serverCode\":[\"guanlang\"],\"serverDomain\":[\"http://192.168.8.132\"],\"serverPort\":[\"8080\"],\"serverSuffix\":[\"\"],\"serverWeight\":[\"1\"],\"serverGroup\":[\"\"],\"remark\":[\"\"],\"serverAutoCheck\":[\"false\"],\"serverLive\":[\"true\"]}', '0', null, '2019-08-21 15:50:52');
INSERT INTO `sys_oper_log` VALUES ('214', 'api服务', '1', 'com.ruoyi.project.api.apiurl.controller.ApiUrlController.addSave()', '1', 'admin', '研发部门', '/api/apiUrl/add', '127.0.0.1', '内网IP', '{\"apiName\":[\"转发2\"],\"apiGroupId\":[\"\"],\"remark\":[\"\"],\"apiUrlSuffix\":[\"/*\"],\"apiServerUrlSuffix\":[\"/*\"],\"apiRequestMethod\":[\"GET/POST\"],\"apiServerIds\":[\"7\"],\"apiServerRequestWay\":[\"weight_round_robin\"]}', '0', null, '2019-08-21 15:54:57');
INSERT INTO `sys_oper_log` VALUES ('215', 'api服务', '1', 'com.ruoyi.project.api.accountapilimit.controller.AccountApiLimitController.addSave()', '1', 'admin', '研发部门', '/api/accountApiLimit/add', '127.0.0.1', '内网IP', '{\"accountId\":[\"4\"],\"apiId\":[\"4\"],\"remark\":[\"\"],\"hasLimit\":[\"false\"]}', '0', null, '2019-08-21 16:01:38');
INSERT INTO `sys_oper_log` VALUES ('216', 'api服务', '3', 'com.ruoyi.project.api.server.controller.ApiServerController.remove()', '1', 'admin', '研发部门', '/api/server/remove', '127.0.0.1', '内网IP', '{\"ids\":[\"7\"]}', '0', null, '2019-08-21 16:03:47');
INSERT INTO `sys_oper_log` VALUES ('217', 'api服务', '1', 'com.ruoyi.project.api.server.controller.ApiServerController.addSave()', '1', 'admin', '研发部门', '/api/server/add', '127.0.0.1', '内网IP', '{\"serverName\":[\"管廊\"],\"serverCode\":[\"guanlang\"],\"serverDomain\":[\"http://192.168.8.132\"],\"serverPort\":[\"8080\"],\"serverSuffix\":[\"\"],\"serverWeight\":[\"1\"],\"serverGroup\":[\"\"],\"remark\":[\"\"],\"serverAutoCheck\":[\"false\"],\"serverLive\":[\"true\"]}', '0', null, '2019-08-21 16:18:29');
INSERT INTO `sys_oper_log` VALUES ('218', 'api服务', '2', 'com.ruoyi.project.api.apiurl.controller.ApiUrlController.editSave()', '1', 'admin', '研发部门', '/api/apiUrl/edit', '127.0.0.1', '内网IP', '{\"apiId\":[\"4\"],\"apiName\":[\"转发2\"],\"apiGroupId\":[\"\"],\"remark\":[\"\"],\"apiUrlSuffix\":[\"/*\"],\"apiServerUrlSuffix\":[\"/*\"],\"apiRequestMethod\":[\"GET/POST\"],\"apiServerIds\":[\"8\"],\"apiServerRequestWay\":[\"weight_round_robin\"]}', '0', null, '2019-08-21 16:18:44');
INSERT INTO `sys_oper_log` VALUES ('219', '代码生成', '8', 'com.ruoyi.project.tool.gen.controller.GenController.genCode()', '1', 'admin', '研发部门', '/tool/gen/genCode/api_request_record', '127.0.0.1', '内网IP', '{}', '0', null, '2019-08-22 13:42:14');
INSERT INTO `sys_oper_log` VALUES ('220', '菜单管理', '1', 'com.ruoyi.project.system.menu.controller.MenuController.addSave()', '1', 'admin', '研发部门', '/system/menu/add', '127.0.0.1', '内网IP', '{\"parentId\":[\"2005\"],\"menuType\":[\"C\"],\"menuName\":[\"请求记录\"],\"url\":[\"/api/record\"],\"target\":[\"menuItem\"],\"perms\":[\"api:record:view\"],\"orderNum\":[\"0\"],\"icon\":[\"\"],\"visible\":[\"0\"]}', '0', null, '2019-08-22 16:39:07');
INSERT INTO `sys_oper_log` VALUES ('221', '菜单管理', '1', 'com.ruoyi.project.system.menu.controller.MenuController.addSave()', '1', 'admin', '研发部门', '/system/menu/add', '127.0.0.1', '内网IP', '{\"parentId\":[\"2020\"],\"menuType\":[\"F\"],\"menuName\":[\"列表\"],\"url\":[\"\"],\"target\":[\"menuItem\"],\"perms\":[\"api:record:list\"],\"orderNum\":[\"0\"],\"icon\":[\"\"],\"visible\":[\"0\"]}', '0', null, '2019-08-22 16:39:33');
INSERT INTO `sys_oper_log` VALUES ('222', '菜单管理', '1', 'com.ruoyi.project.system.menu.controller.MenuController.addSave()', '1', 'admin', '研发部门', '/system/menu/add', '127.0.0.1', '内网IP', '{\"parentId\":[\"2020\"],\"menuType\":[\"F\"],\"menuName\":[\"导出\"],\"url\":[\"\"],\"target\":[\"menuItem\"],\"perms\":[\"api:record:export\"],\"orderNum\":[\"1\"],\"icon\":[\"\"],\"visible\":[\"0\"]}', '0', null, '2019-08-22 16:39:48');
INSERT INTO `sys_oper_log` VALUES ('223', '菜单管理', '1', 'com.ruoyi.project.system.menu.controller.MenuController.addSave()', '1', 'admin', '研发部门', '/system/menu/add', '127.0.0.1', '内网IP', '{\"parentId\":[\"2005\"],\"menuType\":[\"F\"],\"menuName\":[\"详情\"],\"url\":[\"\"],\"target\":[\"menuItem\"],\"perms\":[\"api:record:detail\"],\"orderNum\":[\"2\"],\"icon\":[\"\"],\"visible\":[\"0\"]}', '0', null, '2019-08-22 16:40:02');
INSERT INTO `sys_oper_log` VALUES ('224', '菜单管理', '1', 'com.ruoyi.project.system.menu.controller.MenuController.addSave()', '1', 'admin', '研发部门', '/system/menu/add', '127.0.0.1', '内网IP', '{\"parentId\":[\"2005\"],\"menuType\":[\"F\"],\"menuName\":[\"清空\"],\"url\":[\"\"],\"target\":[\"menuItem\"],\"perms\":[\"api:record:remove\"],\"orderNum\":[\"3\"],\"icon\":[\"\"],\"visible\":[\"0\"]}', '0', null, '2019-08-22 16:40:19');
INSERT INTO `sys_oper_log` VALUES ('225', '操作日志', '9', 'com.ruoyi.project.api.record.controller.ApiRequestRecordController.clean()', '1', 'admin', '研发部门', '/api/record/clean', '127.0.0.1', '内网IP', '{}', '0', null, '2019-08-22 16:50:23');
INSERT INTO `sys_oper_log` VALUES ('226', '操作日志', '5', 'com.ruoyi.project.api.record.controller.ApiRequestRecordController.export()', '1', 'admin', '研发部门', '/api/record/export', '127.0.0.1', '内网IP', '{\"appKey\":[\"\"],\"requestUrl\":[\"\"],\"params[beginTime]\":[\"\"],\"params[endTime]\":[\"\"]}', '0', null, '2019-08-22 17:16:29');
INSERT INTO `sys_oper_log` VALUES ('227', '操作日志', '9', 'com.ruoyi.project.api.record.controller.ApiRequestRecordController.clean()', '1', 'admin', '研发部门', '/api/record/clean', '127.0.0.1', '内网IP', '{}', '0', null, '2019-08-23 10:20:18');
INSERT INTO `sys_oper_log` VALUES ('228', '操作日志', '9', 'com.ruoyi.project.api.record.controller.ApiRequestRecordController.clean()', '1', 'admin', '研发部门', '/api/record/clean', '127.0.0.1', '内网IP', '{}', '0', null, '2019-08-23 11:18:15');
INSERT INTO `sys_oper_log` VALUES ('229', 'api服务', '2', 'com.ruoyi.project.api.accountapilimit.controller.AccountApiLimitController.editSave()', '1', 'admin', '研发部门', '/api/accountApiLimit/edit', '127.0.0.1', '内网IP', '{\"accountId\":[\"4\"],\"apiId\":[\"1\"],\"remark\":[\"\"],\"hasLimit\":[\"true\"],\"limitType\":[\"time_limit\"],\"limitTimeNumber\":[\"1\"],\"limitTimeUnit\":[\"minute\"],\"limitNumber\":[\"100\"]}', '0', null, '2019-08-23 17:13:25');
INSERT INTO `sys_oper_log` VALUES ('230', '操作日志', '9', 'com.ruoyi.project.api.record.controller.ApiRequestRecordController.clean()', '1', 'admin', '研发部门', '/api/record/clean', '127.0.0.1', '内网IP', '{}', '0', null, '2019-08-23 17:15:06');
INSERT INTO `sys_oper_log` VALUES ('231', '操作日志', '9', 'com.ruoyi.project.api.record.controller.ApiRequestRecordController.clean()', '1', 'admin', '研发部门', '/api/record/clean', '127.0.0.1', '内网IP', '{}', '0', null, '2019-08-23 17:20:37');
INSERT INTO `sys_oper_log` VALUES ('232', '操作日志', '9', 'com.ruoyi.project.api.record.controller.ApiRequestRecordController.clean()', '1', 'admin', '研发部门', '/api/record/clean', '127.0.0.1', '内网IP', '{}', '0', null, '2019-08-26 09:42:36');
INSERT INTO `sys_oper_log` VALUES ('233', 'api服务', '2', 'com.ruoyi.project.api.server.controller.ApiServerController.editSave()', '1', 'admin', '研发部门', '/api/server/edit', '127.0.0.1', '内网IP', '{\"serverId\":[\"5\"],\"serverName\":[\"管廊app1\"],\"serverCode\":[\"guanlang_app1\"],\"serverDomain\":[\"http://192.168.8.132\"],\"serverPort\":[\"8080\"],\"serverSuffix\":[\"/app\"],\"serverWeight\":[\"1\"],\"serverGroup\":[\"3\"],\"remark\":[\"\"],\"serverAutoCheck\":[\"false\"],\"serverLive\":[\"true\"]}', '0', null, '2019-08-26 09:43:25');
INSERT INTO `sys_oper_log` VALUES ('234', 'api服务', '2', 'com.ruoyi.project.api.apiurl.controller.ApiUrlController.editSave()', '1', 'admin', '研发部门', '/api/apiUrl/edit', '127.0.0.1', '内网IP', '{\"apiId\":[\"1\"],\"apiName\":[\"获取用户信息\"],\"apiGroupId\":[\"\"],\"remark\":[\"\"],\"apiUrlSuffix\":[\"/user/getUserById\"],\"apiServerUrlSuffix\":[\"/user/getUserById\"],\"apiRequestMethod\":[\"GET/POST\"],\"apiServerIds\":[\"5\",\"9\",\"10\"],\"apiServerRequestWay\":[\"weight_round_robin\"]}', '1', '', '2019-08-26 09:44:33');
INSERT INTO `sys_oper_log` VALUES ('235', 'api服务', '2', 'com.ruoyi.project.api.apiurl.controller.ApiUrlController.editSave()', '1', 'admin', '研发部门', '/api/apiUrl/edit', '127.0.0.1', '内网IP', '{\"apiId\":[\"1\"],\"apiName\":[\"获取用户信息\"],\"apiGroupId\":[\"\"],\"remark\":[\"\"],\"apiUrlSuffix\":[\"/user/getUserById\"],\"apiServerUrlSuffix\":[\"/user/getUserById\"],\"apiRequestMethod\":[\"GET/POST\"],\"apiServerIds\":[\"5\",\"9\",\"10\"],\"apiServerRequestWay\":[\"weight_round_robin\"]}', '1', '', '2019-08-26 09:45:23');
INSERT INTO `sys_oper_log` VALUES ('236', 'api服务', '2', 'com.ruoyi.project.api.apiurl.controller.ApiUrlController.editSave()', '1', 'admin', '研发部门', '/api/apiUrl/edit', '127.0.0.1', '内网IP', '{\"apiId\":[\"1\"],\"apiName\":[\"获取用户信息\"],\"apiGroupId\":[\"\"],\"remark\":[\"\"],\"apiUrlSuffix\":[\"/user/getUserById\"],\"apiServerUrlSuffix\":[\"/user/getUserById\"],\"apiRequestMethod\":[\"GET/POST\"],\"apiServerIds\":[\"5\",\"9\",\"10\"],\"apiServerRequestWay\":[\"weight_round_robin\"]}', '1', '', '2019-08-26 09:45:28');
INSERT INTO `sys_oper_log` VALUES ('237', 'api服务', '2', 'com.ruoyi.project.api.server.controller.ApiServerController.editSave()', '1', 'admin', '研发部门', '/api/server/edit', '127.0.0.1', '内网IP', '{\"serverId\":[\"5\"],\"serverName\":[\"管廊app1\"],\"serverCode\":[\"guanlang_app1\"],\"serverDomain\":[\"http://192.168.8.132\"],\"serverPort\":[\"8080\"],\"serverSuffix\":[\"/app\"],\"serverWeight\":[\"4\"],\"serverGroup\":[\"3\"],\"remark\":[\"\"],\"serverAutoCheck\":[\"false\"],\"serverLive\":[\"true\"]}', '0', null, '2019-08-26 09:49:03');
INSERT INTO `sys_oper_log` VALUES ('238', 'api服务', '2', 'com.ruoyi.project.api.server.controller.ApiServerController.editSave()', '1', 'admin', '研发部门', '/api/server/edit', '127.0.0.1', '内网IP', '{\"serverId\":[\"9\"],\"serverName\":[\"管廊app2\"],\"serverCode\":[\"guanlang_app2\"],\"serverDomain\":[\"http://192.168.8.132\"],\"serverPort\":[\"8080\"],\"serverSuffix\":[\"/app\"],\"serverWeight\":[\"3\"],\"serverGroup\":[\"3\"],\"remark\":[\"\"],\"serverAutoCheck\":[\"false\"],\"serverLive\":[\"true\"]}', '0', null, '2019-08-26 09:49:10');
INSERT INTO `sys_oper_log` VALUES ('239', 'api服务', '2', 'com.ruoyi.project.api.server.controller.ApiServerController.editSave()', '1', 'admin', '研发部门', '/api/server/edit', '127.0.0.1', '内网IP', '{\"serverId\":[\"10\"],\"serverName\":[\"管廊app3\"],\"serverCode\":[\"guanlang_app3\"],\"serverDomain\":[\"http://192.168.8.132\"],\"serverPort\":[\"8080\"],\"serverSuffix\":[\"/app\"],\"serverWeight\":[\"2\"],\"serverGroup\":[\"3\"],\"remark\":[\"\"],\"serverAutoCheck\":[\"false\"],\"serverLive\":[\"true\"]}', '0', null, '2019-08-26 09:49:13');
INSERT INTO `sys_oper_log` VALUES ('240', '操作日志', '9', 'com.ruoyi.project.api.record.controller.ApiRequestRecordController.clean()', '1', 'admin', '研发部门', '/api/record/clean', '127.0.0.1', '内网IP', '{}', '0', null, '2019-08-26 10:29:44');
INSERT INTO `sys_oper_log` VALUES ('241', 'api服务', '1', 'com.ruoyi.project.api.server.controller.ApiServerController.addSave()', '1', 'admin', '研发部门', '/api/server/add', '127.0.0.1', '内网IP', '{\"serverName\":[\"本地\"],\"serverCode\":[\"test\"],\"serverDomain\":[\"http://localhost\"],\"serverPort\":[\"80\"],\"serverSuffix\":[\"\"],\"serverWeight\":[\"1\"],\"serverGroup\":[\"\"],\"remark\":[\"\"],\"serverAutoCheck\":[\"false\"],\"serverLive\":[\"true\"]}', '0', null, '2019-08-26 17:04:58');
INSERT INTO `sys_oper_log` VALUES ('242', 'api服务', '1', 'com.ruoyi.project.api.apiurl.controller.ApiUrlController.addSave()', '1', 'admin', '研发部门', '/api/apiUrl/add', '127.0.0.1', '内网IP', '{\"apiName\":[\"文件上传测试\"],\"apiGroupId\":[\"\"],\"remark\":[\"\"],\"apiUrlSuffix\":[\"/api/test/fileUpload\"],\"apiServerUrlSuffix\":[\"/api/test/fileUpload\"],\"apiRequestMethod\":[\"GET\"],\"apiServerIds\":[\"11\"],\"apiServerRequestWay\":[\"weight_round_robin\"]}', '0', null, '2019-08-26 17:05:54');
INSERT INTO `sys_oper_log` VALUES ('243', 'api服务', '1', 'com.ruoyi.project.api.accountapilimit.controller.AccountApiLimitController.addSave()', '1', 'admin', '研发部门', '/api/accountApiLimit/add', '127.0.0.1', '内网IP', '{\"accountId\":[\"4\"],\"apiId\":[\"5\"],\"remark\":[\"\"],\"hasLimit\":[\"false\"]}', '1', 'nested exception is org.apache.ibatis.exceptions.PersistenceException: \r\n### Error updating database.  Cause: java.lang.NullPointerException\r\n### Cause: java.lang.NullPointerException', '2019-08-26 17:06:42');
INSERT INTO `sys_oper_log` VALUES ('244', 'api服务', '2', 'com.ruoyi.project.api.apiurl.controller.ApiUrlController.editSave()', '1', 'admin', '研发部门', '/api/apiUrl/edit', '127.0.0.1', '内网IP', '{\"apiId\":[\"5\"],\"apiName\":[\"文件上传测试\"],\"apiGroupId\":[\"\"],\"remark\":[\"\"],\"apiUrlSuffix\":[\"/api/test/fileUpload\"],\"apiServerUrlSuffix\":[\"/api/test/fileUpload\"],\"apiRequestMethod\":[\"GET/POST\"],\"apiServerIds\":[\"11\"],\"apiServerRequestWay\":[\"weight_round_robin\"]}', '0', null, '2019-08-26 17:07:12');
INSERT INTO `sys_oper_log` VALUES ('245', 'api服务', '1', 'com.ruoyi.project.api.accountapilimit.controller.AccountApiLimitController.addSave()', '1', 'admin', '研发部门', '/api/accountApiLimit/add', '127.0.0.1', '内网IP', '{\"accountId\":[\"4\"],\"apiId\":[\"5\"],\"remark\":[\"\"],\"hasLimit\":[\"false\"]}', '1', 'nested exception is org.apache.ibatis.exceptions.PersistenceException: \r\n### Error updating database.  Cause: java.lang.NullPointerException\r\n### Cause: java.lang.NullPointerException', '2019-08-26 17:07:54');
INSERT INTO `sys_oper_log` VALUES ('246', 'api服务', '1', 'com.ruoyi.project.api.accountapilimit.controller.AccountApiLimitController.addSave()', '1', 'admin', '研发部门', '/api/accountApiLimit/add', '127.0.0.1', '内网IP', '{\"accountId\":[\"4\"],\"apiId\":[\"5\"],\"remark\":[\"\"],\"hasLimit\":[\"false\"]}', '1', 'nested exception is org.apache.ibatis.exceptions.PersistenceException: \r\n### Error updating database.  Cause: java.lang.NullPointerException\r\n### Cause: java.lang.NullPointerException', '2019-08-26 17:09:00');
INSERT INTO `sys_oper_log` VALUES ('247', 'api服务', '1', 'com.ruoyi.project.api.accountapilimit.controller.AccountApiLimitController.addSave()', '1', 'admin', '研发部门', '/api/accountApiLimit/add', '127.0.0.1', '内网IP', '{\"accountId\":[\"4\"],\"apiId\":[\"5\"],\"remark\":[\"\"],\"hasLimit\":[\"false\"]}', '1', 'nested exception is org.apache.ibatis.exceptions.PersistenceException: \r\n### Error updating database.  Cause: java.lang.NullPointerException\r\n### Cause: java.lang.NullPointerException', '2019-08-26 17:10:05');
INSERT INTO `sys_oper_log` VALUES ('248', 'api服务', '1', 'com.ruoyi.project.api.accountapilimit.controller.AccountApiLimitController.addSave()', '1', 'admin', '研发部门', '/api/accountApiLimit/add', '127.0.0.1', '内网IP', '{\"accountId\":[\"4\"],\"apiId\":[\"5\"],\"remark\":[\"\"],\"hasLimit\":[\"false\"]}', '1', 'nested exception is org.apache.ibatis.exceptions.PersistenceException: \r\n### Error updating database.  Cause: java.lang.NullPointerException\r\n### Cause: java.lang.NullPointerException', '2019-08-26 17:10:21');
INSERT INTO `sys_oper_log` VALUES ('249', 'api服务', '1', 'com.ruoyi.project.api.accountapilimit.controller.AccountApiLimitController.addSave()', '1', 'admin', '研发部门', '/api/accountApiLimit/add', '127.0.0.1', '内网IP', '{\"accountId\":[\"4\"],\"apiId\":[\"5\"],\"remark\":[\"\"],\"hasLimit\":[\"false\"]}', '1', 'nested exception is org.apache.ibatis.exceptions.PersistenceException: \r\n### Error updating database.  Cause: java.lang.NullPointerException\r\n### Cause: java.lang.NullPointerException', '2019-08-26 17:10:26');
INSERT INTO `sys_oper_log` VALUES ('250', 'api服务', '1', 'com.ruoyi.project.api.accountapilimit.controller.AccountApiLimitController.addSave()', '1', 'admin', '研发部门', '/api/accountApiLimit/add', '127.0.0.1', '内网IP', '{\"accountId\":[\"4\"],\"apiId\":[\"5\"],\"remark\":[\"\"],\"hasLimit\":[\"false\"]}', '1', 'nested exception is org.apache.ibatis.exceptions.PersistenceException: \r\n### Error updating database.  Cause: java.lang.NullPointerException\r\n### Cause: java.lang.NullPointerException', '2019-08-26 17:10:55');
INSERT INTO `sys_oper_log` VALUES ('251', 'api服务', '1', 'com.ruoyi.project.api.accountapilimit.controller.AccountApiLimitController.addSave()', '1', 'admin', '研发部门', '/api/accountApiLimit/add', '127.0.0.1', '内网IP', '{\"accountId\":[\"4\"],\"apiId\":[\"5\"],\"remark\":[\"\"],\"hasLimit\":[\"false\"]}', '1', 'nested exception is org.apache.ibatis.exceptions.PersistenceException: \r\n### Error updating database.  Cause: java.lang.NullPointerException\r\n### Cause: java.lang.NullPointerException', '2019-08-26 17:12:00');
INSERT INTO `sys_oper_log` VALUES ('252', 'api服务', '1', 'com.ruoyi.project.api.accountapilimit.controller.AccountApiLimitController.addSave()', '1', 'admin', '研发部门', '/api/accountApiLimit/add', '127.0.0.1', '内网IP', '{\"accountId\":[\"4\"],\"apiId\":[\"5\"],\"remark\":[\"\"],\"hasLimit\":[\"false\"]}', '0', null, '2019-08-26 17:12:19');
INSERT INTO `sys_oper_log` VALUES ('253', 'api服务', '1', 'com.ruoyi.project.api.apiurl.controller.ApiUrlParamController.addSave()', '1', 'admin', '研发部门', '/api/apiUrlParam/add', '127.0.0.1', '内网IP', '{\"apiId\":[\"5\"],\"paramName\":[\"file\"],\"paramRequired\":[\"true\"],\"paramType\":[\"file\"],\"paramCheckRegex\":[\"\"],\"remark\":[\"\"]}', '0', null, '2019-08-26 17:27:25');
INSERT INTO `sys_oper_log` VALUES ('254', 'api服务', '3', 'com.ruoyi.project.api.server.controller.ApiServerController.remove()', '1', 'admin', '研发部门', '/api/server/remove', '127.0.0.1', '内网IP', '{\"ids\":[\"11\"]}', '0', null, '2019-08-27 14:46:14');
INSERT INTO `sys_oper_log` VALUES ('255', 'api服务', '3', 'com.ruoyi.project.api.server.controller.ApiServerController.remove()', '1', 'admin', '研发部门', '/api/server/remove', '127.0.0.1', '内网IP', '{\"ids\":[\"11\"]}', '0', null, '2019-08-27 14:47:21');
INSERT INTO `sys_oper_log` VALUES ('256', 'api服务', '3', 'com.ruoyi.project.api.server.controller.ApiServerController.remove()', '1', 'admin', '研发部门', '/api/server/remove', '127.0.0.1', '内网IP', '{\"ids\":[\"5\"]}', '0', null, '2019-08-27 15:29:02');
INSERT INTO `sys_oper_log` VALUES ('257', '字典数据', '1', 'com.ruoyi.project.system.dict.controller.DictDataController.addSave()', '1', 'admin', '研发部门', '/system/dict/data/add', '127.0.0.1', '内网IP', '{\"dictLabel\":[\"API服务器检查\"],\"dictValue\":[\"API_SERVER_CHECK\"],\"dictType\":[\"sys_job_group\"],\"cssClass\":[\"\"],\"dictSort\":[\"3\"],\"listClass\":[\"\"],\"isDefault\":[\"Y\"],\"status\":[\"0\"],\"remark\":[\"\"]}', '0', null, '2019-08-27 16:00:03');
INSERT INTO `sys_oper_log` VALUES ('258', '操作日志', '9', 'com.ruoyi.project.api.record.controller.ApiRequestRecordController.clean()', '1', 'admin', '研发部门', '/api/record/clean', '127.0.0.1', '内网IP', '{}', '0', null, '2019-08-28 11:05:46');
INSERT INTO `sys_oper_log` VALUES ('259', 'api服务', '2', 'com.ruoyi.project.api.server.controller.ApiServerController.editSave()', '1', 'admin', '研发部门', '/api/server/edit', '127.0.0.1', '内网IP', '{\"serverId\":[\"8\"],\"serverName\":[\"管廊\"],\"serverCode\":[\"guanlang\"],\"serverDomain\":[\"http://192.168.8.132\"],\"serverPort\":[\"8080\"],\"serverSuffix\":[\"\"],\"serverWeight\":[\"1\"],\"serverGroup\":[\"\"],\"remark\":[\"\"],\"serverAutoCheck\":[\"true\"],\"checkCycleMinute\":[\"1\"],\"serverCheckUrl\":[\"http://192.168.8.132:8080/app/user/getUserById?id=1\"],\"checkResultType\":[\"json\"],\"checkJsonKey\":[\"JSON.code\"],\"checkType\":[\"contain\"],\"checkValue\":[\"0\"]}', '1', '', '2019-08-28 11:06:55');
INSERT INTO `sys_oper_log` VALUES ('260', 'api服务', '2', 'com.ruoyi.project.api.server.controller.ApiServerController.editSave()', '1', 'admin', '研发部门', '/api/server/edit', '127.0.0.1', '内网IP', '{\"serverId\":[\"8\"],\"serverName\":[\"管廊\"],\"serverCode\":[\"guanlang\"],\"serverDomain\":[\"http://192.168.8.132\"],\"serverPort\":[\"8080\"],\"serverSuffix\":[\"\"],\"serverWeight\":[\"1\"],\"serverGroup\":[\"\"],\"remark\":[\"\"],\"serverAutoCheck\":[\"true\"],\"checkCycleMinute\":[\"1\"],\"serverCheckUrl\":[\"http://192.168.8.132:8080/app/user/getUserById?id=1\"],\"checkResultType\":[\"json\"],\"checkJsonKey\":[\"JSON.code\"],\"checkType\":[\"contain\"],\"checkValue\":[\"0\"]}', '1', '', '2019-08-28 11:12:43');
INSERT INTO `sys_oper_log` VALUES ('261', 'api服务', '2', 'com.ruoyi.project.api.server.controller.ApiServerController.editSave()', '1', 'admin', '研发部门', '/api/server/edit', '127.0.0.1', '内网IP', '{\"serverId\":[\"8\"],\"serverName\":[\"管廊\"],\"serverCode\":[\"guanlang\"],\"serverDomain\":[\"http://192.168.8.132\"],\"serverPort\":[\"8080\"],\"serverSuffix\":[\"\"],\"serverWeight\":[\"1\"],\"serverGroup\":[\"\"],\"remark\":[\"\"],\"serverAutoCheck\":[\"true\"],\"checkCycleMinute\":[\"1\"],\"serverCheckUrl\":[\"http://192.168.8.132:8080/app/user/getUserById?id=1\"],\"checkResultType\":[\"json\"],\"checkJsonKey\":[\"JSON.code\"],\"checkType\":[\"contain\"],\"checkValue\":[\"0\"]}', '1', '', '2019-08-28 11:13:13');
INSERT INTO `sys_oper_log` VALUES ('262', 'api服务', '2', 'com.ruoyi.project.api.server.controller.ApiServerController.editSave()', '1', 'admin', '研发部门', '/api/server/edit', '127.0.0.1', '内网IP', '{\"serverId\":[\"8\"],\"serverName\":[\"管廊\"],\"serverCode\":[\"guanlang\"],\"serverDomain\":[\"http://192.168.8.132\"],\"serverPort\":[\"8080\"],\"serverSuffix\":[\"\"],\"serverWeight\":[\"1\"],\"serverGroup\":[\"\"],\"remark\":[\"\"],\"serverAutoCheck\":[\"false\"],\"serverLive\":[\"false\"]}', '0', null, '2019-08-28 11:14:53');
INSERT INTO `sys_oper_log` VALUES ('263', 'api服务', '2', 'com.ruoyi.project.api.server.controller.ApiServerController.editSave()', '1', 'admin', '研发部门', '/api/server/edit', '127.0.0.1', '内网IP', '{\"serverId\":[\"8\"],\"serverName\":[\"管廊\"],\"serverCode\":[\"guanlang\"],\"serverDomain\":[\"http://192.168.8.132\"],\"serverPort\":[\"8080\"],\"serverSuffix\":[\"\"],\"serverWeight\":[\"1\"],\"serverGroup\":[\"\"],\"remark\":[\"\"],\"serverAutoCheck\":[\"false\"],\"serverLive\":[\"true\"]}', '0', null, '2019-08-28 11:15:44');
INSERT INTO `sys_oper_log` VALUES ('264', 'api服务', '2', 'com.ruoyi.project.api.server.controller.ApiServerController.editSave()', '1', 'admin', '研发部门', '/api/server/edit', '127.0.0.1', '内网IP', '{\"serverId\":[\"8\"],\"serverName\":[\"管廊\"],\"serverCode\":[\"guanlang\"],\"serverDomain\":[\"http://192.168.8.132\"],\"serverPort\":[\"8080\"],\"serverSuffix\":[\"\"],\"serverWeight\":[\"1\"],\"serverGroup\":[\"\"],\"remark\":[\"\"],\"serverAutoCheck\":[\"false\"],\"serverLive\":[\"false\"]}', '0', null, '2019-08-28 11:16:47');
INSERT INTO `sys_oper_log` VALUES ('265', 'api服务', '2', 'com.ruoyi.project.api.server.controller.ApiServerController.editSave()', '1', 'admin', '研发部门', '/api/server/edit', '127.0.0.1', '内网IP', '{\"serverId\":[\"8\"],\"serverName\":[\"管廊\"],\"serverCode\":[\"guanlang\"],\"serverDomain\":[\"http://192.168.8.132\"],\"serverPort\":[\"8080\"],\"serverSuffix\":[\"\"],\"serverWeight\":[\"1\"],\"serverGroup\":[\"\"],\"remark\":[\"\"],\"serverAutoCheck\":[\"false\"],\"serverLive\":[\"true\"]}', '0', null, '2019-08-28 11:17:53');
INSERT INTO `sys_oper_log` VALUES ('266', 'api服务', '2', 'com.ruoyi.project.api.server.controller.ApiServerController.editSave()', '1', 'admin', '研发部门', '/api/server/edit', '127.0.0.1', '内网IP', '{\"serverId\":[\"8\"],\"serverName\":[\"管廊\"],\"serverCode\":[\"guanlang\"],\"serverDomain\":[\"http://192.168.8.132\"],\"serverPort\":[\"8080\"],\"serverSuffix\":[\"\"],\"serverWeight\":[\"1\"],\"serverGroup\":[\"\"],\"remark\":[\"\"],\"serverAutoCheck\":[\"false\"],\"serverLive\":[\"false\"]}', '0', null, '2019-08-28 11:18:21');
INSERT INTO `sys_oper_log` VALUES ('267', 'api服务', '2', 'com.ruoyi.project.api.server.controller.ApiServerController.editSave()', '1', 'admin', '研发部门', '/api/server/edit', '127.0.0.1', '内网IP', '{\"serverId\":[\"8\"],\"serverName\":[\"管廊\"],\"serverCode\":[\"guanlang\"],\"serverDomain\":[\"http://192.168.8.132\"],\"serverPort\":[\"8080\"],\"serverSuffix\":[\"\"],\"serverWeight\":[\"1\"],\"serverGroup\":[\"\"],\"remark\":[\"\"],\"serverAutoCheck\":[\"false\"],\"serverLive\":[\"true\"]}', '0', null, '2019-08-28 11:18:56');
INSERT INTO `sys_oper_log` VALUES ('268', 'api服务', '2', 'com.ruoyi.project.api.server.controller.ApiServerController.editSave()', '1', 'admin', '研发部门', '/api/server/edit', '127.0.0.1', '内网IP', '{\"serverId\":[\"8\"],\"serverName\":[\"管廊\"],\"serverCode\":[\"guanlang\"],\"serverDomain\":[\"http://192.168.8.132\"],\"serverPort\":[\"8080\"],\"serverSuffix\":[\"\"],\"serverWeight\":[\"1\"],\"serverGroup\":[\"\"],\"remark\":[\"\"],\"serverAutoCheck\":[\"true\"],\"checkCycleMinute\":[\"1\"],\"serverCheckUrl\":[\"http://192.168.8.132:8080/app/user/getUserById?id=1\"],\"checkResultType\":[\"json\"],\"checkJsonKey\":[\"JSON.code\"],\"checkType\":[\"contain\"],\"checkValue\":[\"0\"]}', '0', null, '2019-08-28 11:22:13');
INSERT INTO `sys_oper_log` VALUES ('269', 'api服务', '2', 'com.ruoyi.project.api.server.controller.ApiServerController.editSave()', '1', 'admin', '研发部门', '/api/server/edit', '127.0.0.1', '内网IP', '{\"serverId\":[\"8\"],\"serverName\":[\"管廊\"],\"serverCode\":[\"guanlang\"],\"serverDomain\":[\"http://192.168.8.132\"],\"serverPort\":[\"8080\"],\"serverSuffix\":[\"\"],\"serverWeight\":[\"1\"],\"serverGroup\":[\"\"],\"remark\":[\"\"],\"serverAutoCheck\":[\"true\"],\"checkCycleMinute\":[\"1\"],\"serverCheckUrl\":[\"http://192.168.8.132:8080/app/user/getUserById?id=1\"],\"checkResultType\":[\"json\"],\"checkJsonKey\":[\"JSON.code\"],\"checkType\":[\"contain\"],\"checkValue\":[\"0\"]}', '0', null, '2019-08-28 11:27:13');
INSERT INTO `sys_oper_log` VALUES ('270', 'api服务', '2', 'com.ruoyi.project.api.server.controller.ApiServerController.editSave()', '1', 'admin', '研发部门', '/api/server/edit', '127.0.0.1', '内网IP', '{\"serverId\":[\"8\"],\"serverName\":[\"管廊\"],\"serverCode\":[\"guanlang\"],\"serverDomain\":[\"http://192.168.8.132\"],\"serverPort\":[\"8080\"],\"serverSuffix\":[\"\"],\"serverWeight\":[\"1\"],\"serverGroup\":[\"\"],\"remark\":[\"\"],\"serverAutoCheck\":[\"true\"],\"checkCycleMinute\":[\"1\"],\"serverCheckUrl\":[\"http://192.168.8.132:8080/app/user/getUserById?id=1\"],\"checkResultType\":[\"json\"],\"checkJsonKey\":[\"JSON.code\"],\"checkType\":[\"contain\"],\"checkValue\":[\"0\"]}', '0', null, '2019-08-28 11:29:03');
INSERT INTO `sys_oper_log` VALUES ('271', 'api服务', '2', 'com.ruoyi.project.api.server.controller.ApiServerController.editSave()', '1', 'admin', '研发部门', '/api/server/edit', '127.0.0.1', '内网IP', '{\"serverId\":[\"8\"],\"serverName\":[\"管廊\"],\"serverCode\":[\"guanlang\"],\"serverDomain\":[\"http://192.168.8.132\"],\"serverPort\":[\"8080\"],\"serverSuffix\":[\"\"],\"serverWeight\":[\"1\"],\"serverGroup\":[\"\"],\"remark\":[\"\"],\"serverAutoCheck\":[\"true\"],\"checkCycleMinute\":[\"1\"],\"serverCheckUrl\":[\"http://192.168.8.132:8080/app/user/getUserById?id=1\"],\"checkResultType\":[\"json\"],\"checkJsonKey\":[\"JSON.code\"],\"checkType\":[\"contain\"],\"checkValue\":[\"0\"]}', '0', null, '2019-08-28 11:31:13');
INSERT INTO `sys_oper_log` VALUES ('272', '定时任务', '2', 'com.ruoyi.project.monitor.job.controller.JobController.run()', '1', 'admin', '研发部门', '/monitor/job/run', '127.0.0.1', '内网IP', '{\"jobId\":[\"8\"],\"jobGroup\":[\"API_SERVER_CHECK\"]}', '0', null, '2019-08-28 11:31:21');
INSERT INTO `sys_oper_log` VALUES ('273', '定时任务', '2', 'com.ruoyi.project.monitor.job.controller.JobController.changeStatus()', '1', 'admin', '研发部门', '/monitor/job/changeStatus', '127.0.0.1', '内网IP', '{\"jobId\":[\"8\"],\"jobGroup\":[\"API_SERVER_CHECK\"],\"status\":[\"1\"]}', '0', null, '2019-08-28 11:34:30');
INSERT INTO `sys_oper_log` VALUES ('274', '定时任务', '2', 'com.ruoyi.project.monitor.job.controller.JobController.run()', '1', 'admin', '研发部门', '/monitor/job/run', '127.0.0.1', '内网IP', '{\"jobId\":[\"8\"],\"jobGroup\":[\"API_SERVER_CHECK\"]}', '0', null, '2019-08-28 11:34:32');
INSERT INTO `sys_oper_log` VALUES ('275', '定时任务', '2', 'com.ruoyi.project.monitor.job.controller.JobController.run()', '1', 'admin', '研发部门', '/monitor/job/run', '127.0.0.1', '内网IP', '{\"jobId\":[\"8\"],\"jobGroup\":[\"API_SERVER_CHECK\"]}', '0', null, '2019-08-28 11:35:45');
INSERT INTO `sys_oper_log` VALUES ('276', '定时任务', '2', 'com.ruoyi.project.monitor.job.controller.JobController.run()', '1', 'admin', '研发部门', '/monitor/job/run', '127.0.0.1', '内网IP', '{\"jobId\":[\"8\"],\"jobGroup\":[\"API_SERVER_CHECK\"]}', '0', null, '2019-08-28 11:36:24');
INSERT INTO `sys_oper_log` VALUES ('277', '定时任务', '2', 'com.ruoyi.project.monitor.job.controller.JobController.changeStatus()', '1', 'admin', '研发部门', '/monitor/job/changeStatus', '127.0.0.1', '内网IP', '{\"jobId\":[\"9\"],\"jobGroup\":[\"API_SERVER_CHECK\"],\"status\":[\"1\"]}', '0', null, '2019-08-28 11:39:17');
INSERT INTO `sys_oper_log` VALUES ('278', '定时任务', '2', 'com.ruoyi.project.monitor.job.controller.JobController.run()', '1', 'admin', '研发部门', '/monitor/job/run', '127.0.0.1', '内网IP', '{\"jobId\":[\"9\"],\"jobGroup\":[\"API_SERVER_CHECK\"]}', '0', null, '2019-08-28 11:39:19');
INSERT INTO `sys_oper_log` VALUES ('279', '定时任务', '2', 'com.ruoyi.project.monitor.job.controller.JobController.run()', '1', 'admin', '研发部门', '/monitor/job/run', '127.0.0.1', '内网IP', '{\"jobId\":[\"9\"],\"jobGroup\":[\"API_SERVER_CHECK\"]}', '0', null, '2019-08-28 11:39:33');
INSERT INTO `sys_oper_log` VALUES ('280', '定时任务', '2', 'com.ruoyi.project.monitor.job.controller.JobController.run()', '1', 'admin', '研发部门', '/monitor/job/run', '127.0.0.1', '内网IP', '{\"jobId\":[\"9\"],\"jobGroup\":[\"API_SERVER_CHECK\"]}', '0', null, '2019-08-28 11:40:05');
INSERT INTO `sys_oper_log` VALUES ('281', '定时任务', '2', 'com.ruoyi.project.monitor.job.controller.JobController.changeStatus()', '1', 'admin', '研发部门', '/monitor/job/changeStatus', '127.0.0.1', '内网IP', '{\"jobId\":[\"9\"],\"jobGroup\":[\"API_SERVER_CHECK\"],\"status\":[\"0\"]}', '0', null, '2019-08-28 11:40:35');
INSERT INTO `sys_oper_log` VALUES ('282', '调度日志', '9', 'com.ruoyi.project.monitor.job.controller.JobLogController.clean()', '1', 'admin', '研发部门', '/monitor/jobLog/clean', '127.0.0.1', '内网IP', '{}', '0', null, '2019-08-28 11:41:13');
INSERT INTO `sys_oper_log` VALUES ('283', 'api服务', '2', 'com.ruoyi.project.api.server.controller.ApiServerController.editSave()', '1', 'admin', '研发部门', '/api/server/edit', '127.0.0.1', '内网IP', '{\"serverId\":[\"8\"],\"serverName\":[\"管廊\"],\"serverCode\":[\"guanlang\"],\"serverDomain\":[\"http://192.168.8.132\"],\"serverPort\":[\"8080\"],\"serverSuffix\":[\"\"],\"serverWeight\":[\"1\"],\"serverGroup\":[\"\"],\"remark\":[\"\"],\"serverAutoCheck\":[\"true\"],\"checkCycleMinute\":[\"1\"],\"serverCheckUrl\":[\"http://192.168.8.132:8080/app/user/getUserById?id=1\"],\"checkResultType\":[\"json\"],\"checkJsonKey\":[\"JSON.code\"],\"checkType\":[\"contain\"],\"checkValue\":[\"0\"]}', '0', null, '2019-08-28 13:33:20');
INSERT INTO `sys_oper_log` VALUES ('284', '定时任务', '2', 'com.ruoyi.project.monitor.job.controller.JobController.run()', '1', 'admin', '研发部门', '/monitor/job/run', '127.0.0.1', '内网IP', '{\"jobId\":[\"10\"],\"jobGroup\":[\"API_SERVER_CHECK\"]}', '0', null, '2019-08-28 13:33:30');
INSERT INTO `sys_oper_log` VALUES ('285', 'api服务', '2', 'com.ruoyi.project.api.server.controller.ApiServerController.editSave()', '1', 'admin', '研发部门', '/api/server/edit', '127.0.0.1', '内网IP', '{\"serverId\":[\"9\"],\"serverName\":[\"管廊app2\"],\"serverCode\":[\"guanlang_app2\"],\"serverDomain\":[\"http://192.168.8.132\"],\"serverPort\":[\"8080\"],\"serverSuffix\":[\"/app\"],\"serverWeight\":[\"2\"],\"serverGroup\":[\"3\"],\"remark\":[\"\"],\"serverAutoCheck\":[\"false\"],\"serverLive\":[\"true\"]}', '0', null, '2019-08-28 13:34:18');
INSERT INTO `sys_oper_log` VALUES ('286', 'api服务', '2', 'com.ruoyi.project.api.server.controller.ApiServerController.editSave()', '1', 'admin', '研发部门', '/api/server/edit', '127.0.0.1', '内网IP', '{\"serverId\":[\"5\"],\"serverName\":[\"管廊app1\"],\"serverCode\":[\"guanlang_app1\"],\"serverDomain\":[\"http://192.168.8.132\"],\"serverPort\":[\"8080\"],\"serverSuffix\":[\"/app\"],\"serverWeight\":[\"5\"],\"serverGroup\":[\"3\"],\"remark\":[\"\"],\"serverAutoCheck\":[\"false\"],\"serverLive\":[\"true\"]}', '0', null, '2019-08-28 13:35:20');
INSERT INTO `sys_oper_log` VALUES ('287', '操作日志', '9', 'com.ruoyi.project.api.record.controller.ApiRequestRecordController.clean()', '1', 'admin', '研发部门', '/api/record/clean', '127.0.0.1', '内网IP', '{}', '0', null, '2019-08-28 13:36:49');
INSERT INTO `sys_oper_log` VALUES ('288', 'api服务', '2', 'com.ruoyi.project.api.server.controller.ApiServerController.editSave()', '1', 'admin', '研发部门', '/api/server/edit', '127.0.0.1', '内网IP', '{\"serverId\":[\"5\"],\"serverName\":[\"管廊app1\"],\"serverCode\":[\"guanlang_app1\"],\"serverDomain\":[\"http://192.168.8.132\"],\"serverPort\":[\"8080\"],\"serverSuffix\":[\"/app\"],\"serverWeight\":[\"6\"],\"serverGroup\":[\"3\"],\"remark\":[\"\"],\"serverAutoCheck\":[\"false\"],\"serverLive\":[\"true\"]}', '0', null, '2019-08-28 13:36:56');
INSERT INTO `sys_oper_log` VALUES ('289', '定时任务', '2', 'com.ruoyi.project.monitor.job.controller.JobController.changeStatus()', '1', 'admin', '研发部门', '/monitor/job/changeStatus', '127.0.0.1', '内网IP', '{\"jobId\":[\"10\"],\"jobGroup\":[\"API_SERVER_CHECK\"],\"status\":[\"1\"]}', '0', null, '2019-08-28 13:41:27');
INSERT INTO `sys_oper_log` VALUES ('290', '定时任务', '2', 'com.ruoyi.project.monitor.job.controller.JobController.run()', '1', 'admin', '研发部门', '/monitor/job/run', '127.0.0.1', '内网IP', '{\"jobId\":[\"10\"],\"jobGroup\":[\"API_SERVER_CHECK\"]}', '0', null, '2019-08-28 13:41:31');
INSERT INTO `sys_oper_log` VALUES ('291', '操作日志', '9', 'com.ruoyi.project.api.record.controller.ApiRequestRecordController.clean()', '1', 'admin', '研发部门', '/api/record/clean', '127.0.0.1', '内网IP', '{}', '0', null, '2019-08-28 13:54:08');
INSERT INTO `sys_oper_log` VALUES ('292', '定时任务', '2', 'com.ruoyi.project.monitor.job.controller.JobController.changeStatus()', '1', 'admin', '研发部门', '/monitor/job/changeStatus', '127.0.0.1', '内网IP', '{\"jobId\":[\"12\"],\"jobGroup\":[\"API_SERVER_CHECK\"],\"status\":[\"1\"]}', '0', null, '2019-08-28 13:54:13');
INSERT INTO `sys_oper_log` VALUES ('293', '调度日志', '9', 'com.ruoyi.project.monitor.job.controller.JobLogController.clean()', '1', 'admin', '研发部门', '/monitor/jobLog/clean', '127.0.0.1', '内网IP', '{}', '0', null, '2019-08-28 13:54:19');
INSERT INTO `sys_oper_log` VALUES ('294', '定时任务', '2', 'com.ruoyi.project.monitor.job.controller.JobController.run()', '1', 'admin', '研发部门', '/monitor/job/run', '127.0.0.1', '内网IP', '{\"jobId\":[\"12\"],\"jobGroup\":[\"API_SERVER_CHECK\"]}', '0', null, '2019-08-28 13:54:31');
INSERT INTO `sys_oper_log` VALUES ('295', '定时任务', '2', 'com.ruoyi.project.monitor.job.controller.JobController.run()', '1', 'admin', '研发部门', '/monitor/job/run', '127.0.0.1', '内网IP', '{\"jobId\":[\"12\"],\"jobGroup\":[\"API_SERVER_CHECK\"]}', '0', null, '2019-08-28 13:55:04');
INSERT INTO `sys_oper_log` VALUES ('296', 'api服务', '2', 'com.ruoyi.project.api.server.controller.ApiServerController.editSave()', '1', 'admin', '研发部门', '/api/server/edit', '127.0.0.1', '内网IP', '{\"serverId\":[\"8\"],\"serverName\":[\"管廊\"],\"serverCode\":[\"guanlang\"],\"serverDomain\":[\"http://192.168.8.132\"],\"serverPort\":[\"8080\"],\"serverSuffix\":[\"\"],\"serverWeight\":[\"2\"],\"serverGroup\":[\"\"],\"remark\":[\"\"],\"serverAutoCheck\":[\"true\"],\"checkCycleMinute\":[\"1\"],\"serverCheckUrl\":[\"http://192.168.8.132:8080/app/user/getUserById?id=1\"],\"checkResultType\":[\"json\"],\"checkJsonKey\":[\"JSON.code\"],\"checkType\":[\"contain\"],\"checkValue\":[\"0\"]}', '0', null, '2019-08-28 13:56:16');
INSERT INTO `sys_oper_log` VALUES ('297', '定时任务', '2', 'com.ruoyi.project.monitor.job.controller.JobController.run()', '1', 'admin', '研发部门', '/monitor/job/run', '127.0.0.1', '内网IP', '{\"jobId\":[\"12\"],\"jobGroup\":[\"API_SERVER_CHECK\"]}', '1', 'Couldn\'t store trigger \'DEFAULT.MT_1wnnjm53dagq9\' for \'API_SERVER_CHECK.TASK_CLASS_NAME12\' job:The job (API_SERVER_CHECK.TASK_CLASS_NAME12) referenced by the trigger does not exist.', '2019-08-28 13:56:23');
INSERT INTO `sys_oper_log` VALUES ('298', '定时任务', '2', 'com.ruoyi.project.monitor.job.controller.JobController.changeStatus()', '1', 'admin', '研发部门', '/monitor/job/changeStatus', '127.0.0.1', '内网IP', '{\"jobId\":[\"13\"],\"jobGroup\":[\"API_SERVER_CHECK\"],\"status\":[\"1\"]}', '0', null, '2019-08-28 13:56:49');
INSERT INTO `sys_oper_log` VALUES ('299', '定时任务', '2', 'com.ruoyi.project.monitor.job.controller.JobController.run()', '1', 'admin', '研发部门', '/monitor/job/run', '127.0.0.1', '内网IP', '{\"jobId\":[\"13\"],\"jobGroup\":[\"API_SERVER_CHECK\"]}', '0', null, '2019-08-28 13:57:08');
INSERT INTO `sys_oper_log` VALUES ('300', 'api服务', '2', 'com.ruoyi.project.api.server.controller.ApiServerController.editSave()', '1', 'admin', '研发部门', '/api/server/edit', '127.0.0.1', '内网IP', '{\"serverId\":[\"8\"],\"serverName\":[\"管廊\"],\"serverCode\":[\"guanlang\"],\"serverDomain\":[\"http://192.168.8.132\"],\"serverPort\":[\"8080\"],\"serverSuffix\":[\"\"],\"serverWeight\":[\"2\"],\"serverGroup\":[\"\"],\"remark\":[\"\"],\"serverAutoCheck\":[\"true\"],\"checkCycleMinute\":[\"1\"],\"serverCheckUrl\":[\"http://192.168.8.132:8080/app/user/getUserById?id=1\"],\"checkResultType\":[\"json\"],\"checkJsonKey\":[\"JSON.code\"],\"checkType\":[\"notContain\"],\"checkValue\":[\"200\"]}', '0', null, '2019-08-28 13:57:51');
INSERT INTO `sys_oper_log` VALUES ('301', '定时任务', '2', 'com.ruoyi.project.monitor.job.controller.JobController.changeStatus()', '1', 'admin', '研发部门', '/monitor/job/changeStatus', '127.0.0.1', '内网IP', '{\"jobId\":[\"14\"],\"jobGroup\":[\"API_SERVER_CHECK\"],\"status\":[\"1\"]}', '0', null, '2019-08-28 13:57:57');
INSERT INTO `sys_oper_log` VALUES ('302', '定时任务', '2', 'com.ruoyi.project.monitor.job.controller.JobController.run()', '1', 'admin', '研发部门', '/monitor/job/run', '127.0.0.1', '内网IP', '{\"jobId\":[\"14\"],\"jobGroup\":[\"API_SERVER_CHECK\"]}', '0', null, '2019-08-28 13:57:59');
INSERT INTO `sys_oper_log` VALUES ('303', '定时任务', '2', 'com.ruoyi.project.monitor.job.controller.JobController.run()', '1', 'admin', '研发部门', '/monitor/job/run', '127.0.0.1', '内网IP', '{\"jobId\":[\"14\"],\"jobGroup\":[\"API_SERVER_CHECK\"]}', '0', null, '2019-08-28 13:58:16');
INSERT INTO `sys_oper_log` VALUES ('304', 'api服务', '2', 'com.ruoyi.project.api.server.controller.ApiServerController.editSave()', '1', 'admin', '研发部门', '/api/server/edit', '127.0.0.1', '内网IP', '{\"serverId\":[\"8\"],\"serverName\":[\"管廊\"],\"serverCode\":[\"guanlang\"],\"serverDomain\":[\"http://192.168.8.132\"],\"serverPort\":[\"8080\"],\"serverSuffix\":[\"\"],\"serverWeight\":[\"1\"],\"serverGroup\":[\"3\"],\"remark\":[\"\"],\"serverAutoCheck\":[\"true\"],\"checkCycleMinute\":[\"1\"],\"serverCheckUrl\":[\"http://192.168.8.132:8080/app/user/getUserById?id=1\"],\"checkResultType\":[\"json\"],\"checkJsonKey\":[\"JSON.code\"],\"checkType\":[\"notContain\"],\"checkValue\":[\"200\"]}', '0', null, '2019-08-28 13:59:28');
INSERT INTO `sys_oper_log` VALUES ('305', '定时任务', '2', 'com.ruoyi.project.monitor.job.controller.JobController.changeStatus()', '1', 'admin', '研发部门', '/monitor/job/changeStatus', '127.0.0.1', '内网IP', '{\"jobId\":[\"15\"],\"jobGroup\":[\"API_SERVER_CHECK\"],\"status\":[\"1\"]}', '0', null, '2019-08-28 13:59:33');
INSERT INTO `sys_oper_log` VALUES ('306', '定时任务', '2', 'com.ruoyi.project.monitor.job.controller.JobController.run()', '1', 'admin', '研发部门', '/monitor/job/run', '127.0.0.1', '内网IP', '{\"jobId\":[\"15\"],\"jobGroup\":[\"API_SERVER_CHECK\"]}', '0', null, '2019-08-28 13:59:37');
INSERT INTO `sys_oper_log` VALUES ('307', '菜单管理', '2', 'com.ruoyi.project.system.menu.controller.MenuController.editSave()', '1', 'admin', '研发部门', '/system/menu/edit', '127.0.0.1', '内网IP', '{\"menuId\":[\"2000\"],\"parentId\":[\"2005\"],\"menuType\":[\"C\"],\"menuName\":[\"服务器管理\"],\"url\":[\"/api/server\"],\"target\":[\"menuItem\"],\"perms\":[\"api:server:view\"],\"orderNum\":[\"1\"],\"icon\":[\"#\"],\"visible\":[\"0\"]}', '0', null, '2019-08-29 15:29:36');

-- ----------------------------
-- Table structure for sys_post
-- ----------------------------
DROP TABLE IF EXISTS `sys_post`;
CREATE TABLE `sys_post` (
  `post_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '岗位ID',
  `post_code` varchar(64) NOT NULL COMMENT '岗位编码',
  `post_name` varchar(50) NOT NULL COMMENT '岗位名称',
  `post_sort` int(4) NOT NULL COMMENT '显示顺序',
  `status` char(1) NOT NULL COMMENT '状态（0正常 1停用）',
  `create_by` varchar(64) DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`post_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COMMENT='岗位信息表';

-- ----------------------------
-- Records of sys_post
-- ----------------------------
INSERT INTO `sys_post` VALUES ('1', 'ceo', '董事长', '1', '0', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00', '');
INSERT INTO `sys_post` VALUES ('2', 'se', '项目经理', '2', '0', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00', '');
INSERT INTO `sys_post` VALUES ('3', 'hr', '人力资源', '3', '0', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00', '');
INSERT INTO `sys_post` VALUES ('4', 'user', '普通员工', '4', '0', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00', '');

-- ----------------------------
-- Table structure for sys_role
-- ----------------------------
DROP TABLE IF EXISTS `sys_role`;
CREATE TABLE `sys_role` (
  `role_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '角色ID',
  `role_name` varchar(30) NOT NULL COMMENT '角色名称',
  `role_key` varchar(100) NOT NULL COMMENT '角色权限字符串',
  `role_sort` int(4) NOT NULL COMMENT '显示顺序',
  `data_scope` char(1) DEFAULT '1' COMMENT '数据范围（1：全部数据权限 2：自定数据权限 3：本部门数据权限 4：本部门及以下数据权限）',
  `status` char(1) NOT NULL COMMENT '角色状态（0正常 1停用）',
  `del_flag` char(1) DEFAULT '0' COMMENT '删除标志（0代表存在 2代表删除）',
  `create_by` varchar(64) DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`role_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COMMENT='角色信息表';

-- ----------------------------
-- Records of sys_role
-- ----------------------------
INSERT INTO `sys_role` VALUES ('1', '管理员', 'admin', '1', '1', '0', '0', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00', '管理员');
INSERT INTO `sys_role` VALUES ('2', '普通角色', 'common', '2', '2', '0', '0', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00', '普通角色');

-- ----------------------------
-- Table structure for sys_role_dept
-- ----------------------------
DROP TABLE IF EXISTS `sys_role_dept`;
CREATE TABLE `sys_role_dept` (
  `role_id` bigint(20) NOT NULL COMMENT '角色ID',
  `dept_id` bigint(20) NOT NULL COMMENT '部门ID',
  PRIMARY KEY (`role_id`,`dept_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='角色和部门关联表';

-- ----------------------------
-- Records of sys_role_dept
-- ----------------------------
INSERT INTO `sys_role_dept` VALUES ('2', '100');
INSERT INTO `sys_role_dept` VALUES ('2', '101');
INSERT INTO `sys_role_dept` VALUES ('2', '105');

-- ----------------------------
-- Table structure for sys_role_menu
-- ----------------------------
DROP TABLE IF EXISTS `sys_role_menu`;
CREATE TABLE `sys_role_menu` (
  `role_id` bigint(20) NOT NULL COMMENT '角色ID',
  `menu_id` bigint(20) NOT NULL COMMENT '菜单ID',
  PRIMARY KEY (`role_id`,`menu_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='角色和菜单关联表';

-- ----------------------------
-- Records of sys_role_menu
-- ----------------------------
INSERT INTO `sys_role_menu` VALUES ('2', '1');
INSERT INTO `sys_role_menu` VALUES ('2', '2');
INSERT INTO `sys_role_menu` VALUES ('2', '3');
INSERT INTO `sys_role_menu` VALUES ('2', '100');
INSERT INTO `sys_role_menu` VALUES ('2', '101');
INSERT INTO `sys_role_menu` VALUES ('2', '102');
INSERT INTO `sys_role_menu` VALUES ('2', '103');
INSERT INTO `sys_role_menu` VALUES ('2', '104');
INSERT INTO `sys_role_menu` VALUES ('2', '105');
INSERT INTO `sys_role_menu` VALUES ('2', '106');
INSERT INTO `sys_role_menu` VALUES ('2', '107');
INSERT INTO `sys_role_menu` VALUES ('2', '108');
INSERT INTO `sys_role_menu` VALUES ('2', '109');
INSERT INTO `sys_role_menu` VALUES ('2', '110');
INSERT INTO `sys_role_menu` VALUES ('2', '111');
INSERT INTO `sys_role_menu` VALUES ('2', '112');
INSERT INTO `sys_role_menu` VALUES ('2', '113');
INSERT INTO `sys_role_menu` VALUES ('2', '114');
INSERT INTO `sys_role_menu` VALUES ('2', '115');
INSERT INTO `sys_role_menu` VALUES ('2', '500');
INSERT INTO `sys_role_menu` VALUES ('2', '501');
INSERT INTO `sys_role_menu` VALUES ('2', '1000');
INSERT INTO `sys_role_menu` VALUES ('2', '1001');
INSERT INTO `sys_role_menu` VALUES ('2', '1002');
INSERT INTO `sys_role_menu` VALUES ('2', '1003');
INSERT INTO `sys_role_menu` VALUES ('2', '1004');
INSERT INTO `sys_role_menu` VALUES ('2', '1005');
INSERT INTO `sys_role_menu` VALUES ('2', '1006');
INSERT INTO `sys_role_menu` VALUES ('2', '1007');
INSERT INTO `sys_role_menu` VALUES ('2', '1008');
INSERT INTO `sys_role_menu` VALUES ('2', '1009');
INSERT INTO `sys_role_menu` VALUES ('2', '1010');
INSERT INTO `sys_role_menu` VALUES ('2', '1011');
INSERT INTO `sys_role_menu` VALUES ('2', '1012');
INSERT INTO `sys_role_menu` VALUES ('2', '1013');
INSERT INTO `sys_role_menu` VALUES ('2', '1014');
INSERT INTO `sys_role_menu` VALUES ('2', '1015');
INSERT INTO `sys_role_menu` VALUES ('2', '1016');
INSERT INTO `sys_role_menu` VALUES ('2', '1017');
INSERT INTO `sys_role_menu` VALUES ('2', '1018');
INSERT INTO `sys_role_menu` VALUES ('2', '1019');
INSERT INTO `sys_role_menu` VALUES ('2', '1020');
INSERT INTO `sys_role_menu` VALUES ('2', '1021');
INSERT INTO `sys_role_menu` VALUES ('2', '1022');
INSERT INTO `sys_role_menu` VALUES ('2', '1023');
INSERT INTO `sys_role_menu` VALUES ('2', '1024');
INSERT INTO `sys_role_menu` VALUES ('2', '1025');
INSERT INTO `sys_role_menu` VALUES ('2', '1026');
INSERT INTO `sys_role_menu` VALUES ('2', '1027');
INSERT INTO `sys_role_menu` VALUES ('2', '1028');
INSERT INTO `sys_role_menu` VALUES ('2', '1029');
INSERT INTO `sys_role_menu` VALUES ('2', '1030');
INSERT INTO `sys_role_menu` VALUES ('2', '1031');
INSERT INTO `sys_role_menu` VALUES ('2', '1032');
INSERT INTO `sys_role_menu` VALUES ('2', '1033');
INSERT INTO `sys_role_menu` VALUES ('2', '1034');
INSERT INTO `sys_role_menu` VALUES ('2', '1035');
INSERT INTO `sys_role_menu` VALUES ('2', '1036');
INSERT INTO `sys_role_menu` VALUES ('2', '1037');
INSERT INTO `sys_role_menu` VALUES ('2', '1038');
INSERT INTO `sys_role_menu` VALUES ('2', '1039');
INSERT INTO `sys_role_menu` VALUES ('2', '1040');
INSERT INTO `sys_role_menu` VALUES ('2', '1041');
INSERT INTO `sys_role_menu` VALUES ('2', '1042');
INSERT INTO `sys_role_menu` VALUES ('2', '1043');
INSERT INTO `sys_role_menu` VALUES ('2', '1044');
INSERT INTO `sys_role_menu` VALUES ('2', '1045');
INSERT INTO `sys_role_menu` VALUES ('2', '1046');
INSERT INTO `sys_role_menu` VALUES ('2', '1047');
INSERT INTO `sys_role_menu` VALUES ('2', '1048');
INSERT INTO `sys_role_menu` VALUES ('2', '1049');
INSERT INTO `sys_role_menu` VALUES ('2', '1050');
INSERT INTO `sys_role_menu` VALUES ('2', '1051');
INSERT INTO `sys_role_menu` VALUES ('2', '1052');
INSERT INTO `sys_role_menu` VALUES ('2', '1053');
INSERT INTO `sys_role_menu` VALUES ('2', '1054');
INSERT INTO `sys_role_menu` VALUES ('2', '1055');
INSERT INTO `sys_role_menu` VALUES ('2', '1056');
INSERT INTO `sys_role_menu` VALUES ('2', '1057');
INSERT INTO `sys_role_menu` VALUES ('2', '1058');
INSERT INTO `sys_role_menu` VALUES ('2', '1059');
INSERT INTO `sys_role_menu` VALUES ('2', '1060');

-- ----------------------------
-- Table structure for sys_user
-- ----------------------------
DROP TABLE IF EXISTS `sys_user`;
CREATE TABLE `sys_user` (
  `user_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '用户ID',
  `dept_id` bigint(20) DEFAULT NULL COMMENT '部门ID',
  `login_name` varchar(30) NOT NULL COMMENT '登录账号',
  `user_name` varchar(30) NOT NULL COMMENT '用户昵称',
  `user_type` varchar(2) DEFAULT '00' COMMENT '用户类型（00系统用户）',
  `email` varchar(50) DEFAULT '' COMMENT '用户邮箱',
  `phonenumber` varchar(11) DEFAULT '' COMMENT '手机号码',
  `sex` char(1) DEFAULT '0' COMMENT '用户性别（0男 1女 2未知）',
  `avatar` varchar(100) DEFAULT '' COMMENT '头像路径',
  `password` varchar(50) DEFAULT '' COMMENT '密码',
  `salt` varchar(20) DEFAULT '' COMMENT '盐加密',
  `status` char(1) DEFAULT '0' COMMENT '帐号状态（0正常 1停用）',
  `del_flag` char(1) DEFAULT '0' COMMENT '删除标志（0代表存在 2代表删除）',
  `login_ip` varchar(50) DEFAULT '' COMMENT '最后登陆IP',
  `login_date` datetime DEFAULT NULL COMMENT '最后登陆时间',
  `create_by` varchar(64) DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COMMENT='用户信息表';

-- ----------------------------
-- Records of sys_user
-- ----------------------------
INSERT INTO `sys_user` VALUES ('1', '103', 'admin', '若依', '00', 'ry@163.com', '15888888888', '1', '', '29c67a30398638269fe600f73a054934', '111111', '0', '0', '127.0.0.1', '2019-08-29 15:43:02', 'admin', '2018-03-16 11:33:00', 'ry', '2019-08-29 15:38:42', '管理员');
INSERT INTO `sys_user` VALUES ('2', '105', 'ry', '若依', '00', 'ry@qq.com', '15666666666', '1', '', '8e6d98b90472783cc73c17047ddccf36', '222222', '0', '0', '127.0.0.1', '2018-03-16 11:33:00', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00', '测试员');

-- ----------------------------
-- Table structure for sys_user_online
-- ----------------------------
DROP TABLE IF EXISTS `sys_user_online`;
CREATE TABLE `sys_user_online` (
  `sessionId` varchar(50) NOT NULL DEFAULT '' COMMENT '用户会话id',
  `login_name` varchar(50) DEFAULT '' COMMENT '登录账号',
  `dept_name` varchar(50) DEFAULT '' COMMENT '部门名称',
  `ipaddr` varchar(50) DEFAULT '' COMMENT '登录IP地址',
  `login_location` varchar(255) DEFAULT '' COMMENT '登录地点',
  `browser` varchar(50) DEFAULT '' COMMENT '浏览器类型',
  `os` varchar(50) DEFAULT '' COMMENT '操作系统',
  `status` varchar(10) DEFAULT '' COMMENT '在线状态on_line在线off_line离线',
  `start_timestamp` datetime DEFAULT NULL COMMENT 'session创建时间',
  `last_access_time` datetime DEFAULT NULL COMMENT 'session最后访问时间',
  `expire_time` int(5) DEFAULT '0' COMMENT '超时时间，单位为分钟',
  PRIMARY KEY (`sessionId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='在线用户记录';

-- ----------------------------
-- Records of sys_user_online
-- ----------------------------

-- ----------------------------
-- Table structure for sys_user_post
-- ----------------------------
DROP TABLE IF EXISTS `sys_user_post`;
CREATE TABLE `sys_user_post` (
  `user_id` bigint(20) NOT NULL COMMENT '用户ID',
  `post_id` bigint(20) NOT NULL COMMENT '岗位ID',
  PRIMARY KEY (`user_id`,`post_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='用户与岗位关联表';

-- ----------------------------
-- Records of sys_user_post
-- ----------------------------
INSERT INTO `sys_user_post` VALUES ('1', '1');
INSERT INTO `sys_user_post` VALUES ('2', '2');

-- ----------------------------
-- Table structure for sys_user_role
-- ----------------------------
DROP TABLE IF EXISTS `sys_user_role`;
CREATE TABLE `sys_user_role` (
  `user_id` bigint(20) NOT NULL COMMENT '用户ID',
  `role_id` bigint(20) NOT NULL COMMENT '角色ID',
  PRIMARY KEY (`user_id`,`role_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='用户和角色关联表';

-- ----------------------------
-- Records of sys_user_role
-- ----------------------------
INSERT INTO `sys_user_role` VALUES ('1', '1');
INSERT INTO `sys_user_role` VALUES ('2', '2');
