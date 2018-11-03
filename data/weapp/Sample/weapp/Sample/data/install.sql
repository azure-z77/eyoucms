/*
Navicat MySQL Data Transfer

Source Server         : localhost_3306
Source Server Version : 50553
Source Host           : localhost:3306
Source Database       : eyoucms_develop

Target Server Type    : MYSQL
Target Server Version : 50553
File Encoding         : 65001

Date: 2018-09-13 14:30:27
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for #@__weapp_sample
-- ----------------------------
DROP TABLE IF EXISTS `#@__weapp_sample`;
CREATE TABLE `#@__weapp_sample` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `typeid` tinyint(1) DEFAULT '1' COMMENT '类型：1=文字链接，2=图片链接',
  `title` varchar(50) DEFAULT '' COMMENT '网站标题',
  `url` varchar(100) DEFAULT '' COMMENT '网站地址',
  `logo` varchar(255) DEFAULT '' COMMENT '网站LOGO',
  `sort_order` int(11) DEFAULT '0' COMMENT '排序号',
  `target` tinyint(1) DEFAULT '0' COMMENT '是否开启浏览器新窗口',
  `email` varchar(50) DEFAULT NULL,
  `intro` text COMMENT '网站简况',
  `status` tinyint(1) DEFAULT '1' COMMENT '状态(1=显示，0=屏蔽)',
  `delete_time` int(11) DEFAULT '0' COMMENT '软删除时间',
  `add_time` int(11) DEFAULT '0' COMMENT '新增时间',
  `update_time` int(11) DEFAULT '0' COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of #@__weapp_sample
-- ----------------------------
INSERT INTO `#@__weapp_sample` VALUES ('2', '1', '易优CMS', 'http://www.eyoucms.com', '', '100', '1', '', '', '1', '0', '1524975826', '0');
INSERT INTO `#@__weapp_sample` VALUES ('3', '2', '织梦58', 'http://www.dede58.com', 'http://www.eyoucms.dev/public/upload/system/2018/04/29/814ece093a0ba636209255dc20bd6e62.png', '100', '0', '', '', '1', '0', '1524976095', '1524976135');
INSERT INTO `#@__weapp_sample` VALUES ('4', '1', '素材58', 'http://www.sucai58.com', '', '100', '1', '', '', '1', '0', '1525266497', '1525266608');
INSERT INTO `#@__weapp_sample` VALUES ('5', '1', '微信小程序开发', 'http://www.yiyongtong.com', '', '100', '1', '', '', '1', '0', '1525748425', '0');
INSERT INTO `#@__weapp_sample` VALUES ('6', '1', 'yuyuyu', 'yuyu', '', '100', '1', '', '', '1', '0', '1536639106', '1536639106');
