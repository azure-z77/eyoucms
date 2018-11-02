/*
 Navicat Premium Data Transfer

 Source Server         : localhost
 Source Server Type    : MySQL
 Source Server Version : 100131
 Source Host           : localhost:3306
 Source Schema         : eyoucms

 Target Server Type    : MySQL
 Target Server Version : 100131
 File Encoding         : 65001

 Date: 02/11/2018 15:41:42
*/

SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for #@__weapp_form
-- ----------------------------
DROP TABLE IF EXISTS `#@__weapp_form`;
CREATE TABLE `#@__weapp_form` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(20) DEFAULT '' COMMENT '表单名称',
  `tag` varchar(20) NOT NULL DEFAULT '' COMMENT '表单标识',
  `templist` varchar(30) DEFAULT '' COMMENT '表单列表模板',
  `tempview` varchar(30) DEFAULT '' COMMENT '表单内容模板',
  `is_show` int(1) DEFAULT '0' COMMENT '是否前端展示',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for #@__weapp_form_attrbute
-- ----------------------------
DROP TABLE IF EXISTS `#@__weapp_form_attrbute`;
CREATE TABLE `#@__weapp_form_attrbute` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `form_tag` varchar(20) NOT NULL DEFAULT '' COMMENT '所属标识',
  `attr_name` varchar(20) NOT NULL DEFAULT '' COMMENT '字段名称',
  `attr_tag` varchar(20) NOT NULL DEFAULT '' COMMENT '字段标识',
  `attr_type` varchar(20) NOT NULL DEFAULT '' COMMENT '字段类型',
  `attr_text` varchar(100) DEFAULT '' COMMENT '字段描述',
  `attr_value` varchar(0) DEFAULT '' COMMENT '字段默认值',
  `is_show` int(2) DEFAULT '0' COMMENT '是否前台显示',
  `sort_order` int(11) DEFAULT '100' COMMENT '排序id',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
