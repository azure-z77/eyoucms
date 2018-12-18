/*
Navicat MySQL Data Transfer

Source Server         : localhost_3306
Source Server Version : 50553
Source Host           : localhost:3306
Source Database       : eyoucms_release

Target Server Type    : MYSQL
Target Server Version : 50553
File Encoding         : 65001

Date: 2018-12-18 08:47:08
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for ey_ad
-- ----------------------------
DROP TABLE IF EXISTS `ey_ad`;
CREATE TABLE `ey_ad` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '广告id',
  `pid` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '广告位置ID',
  `media_type` tinyint(1) DEFAULT '0' COMMENT '广告类型',
  `title` varchar(60) DEFAULT '' COMMENT '广告名称',
  `links` varchar(255) DEFAULT '' COMMENT '广告链接',
  `litpic` varchar(255) DEFAULT '' COMMENT '图片地址',
  `start_time` int(11) DEFAULT '0' COMMENT '投放时间',
  `end_time` int(11) DEFAULT '0' COMMENT '结束时间',
  `intro` text COMMENT '描述',
  `link_man` varchar(60) DEFAULT '' COMMENT '添加人',
  `link_email` varchar(60) DEFAULT '' COMMENT '添加人邮箱',
  `link_phone` varchar(60) DEFAULT '' COMMENT '添加人联系电话',
  `click` int(11) DEFAULT '0' COMMENT '点击量',
  `bgcolor` varchar(30) DEFAULT '' COMMENT '背景颜色',
  `status` tinyint(1) unsigned DEFAULT '1' COMMENT '1=显示，0=屏蔽',
  `sort_order` int(11) DEFAULT '0' COMMENT '排序',
  `target` varchar(50) DEFAULT '' COMMENT '是否开启浏览器新窗口',
  `admin_id` int(10) DEFAULT '0' COMMENT '管理员ID',
  `lang` varchar(50) DEFAULT 'cn' COMMENT '多语言',
  `add_time` int(11) DEFAULT '0' COMMENT '新增时间',
  `update_time` int(11) DEFAULT '0' COMMENT '更新时间',
  PRIMARY KEY (`id`),
  KEY `position_id` (`pid`) USING BTREE,
  KEY `status` (`status`) USING BTREE
) ENGINE=MyISAM AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COMMENT='广告表';

-- ----------------------------
-- Records of ey_ad
-- ----------------------------
INSERT INTO `ey_ad` VALUES ('1', '1', '1', '共展蓝图', 'http://www.eyoucms.com', '/public/upload/other/2018/06/01/7fd4167b47cbe5eefb4249ae669c6f10.jpg', '1524215594', '0', '&lt;p&gt;填写广告的备注信息，方便于后期的跟进&lt;/p&gt;', '', '', '', '0', '', '1', '100', '0', '0', 'cn', '1524215652', '1527824535');
INSERT INTO `ey_ad` VALUES ('2', '1', '1', '易优模板库', 'http://www.eyoucms.com', '/public/upload/other/2018/06/01/9f1b15b03aef06830f07a2591f5c7708.jpg', '0', '0', '&lt;p&gt;填写广告的备注信息，方便于后期的跟进&lt;/p&gt;', '', '', '', '0', '', '1', '100', '0', '0', 'cn', '1524214017', '1531724625');

-- ----------------------------
-- Table structure for ey_admin
-- ----------------------------
DROP TABLE IF EXISTS `ey_admin`;
CREATE TABLE `ey_admin` (
  `admin_id` smallint(5) unsigned NOT NULL AUTO_INCREMENT COMMENT '用户id',
  `user_name` varchar(20) NOT NULL DEFAULT '' COMMENT '用户名',
  `pen_name` varchar(50) DEFAULT '' COMMENT '笔名（发布文章后显示责任编辑的名字）',
  `true_name` varchar(20) DEFAULT '' COMMENT '真实姓名',
  `mobile` varchar(11) DEFAULT '' COMMENT '手机号码',
  `email` varchar(60) DEFAULT '' COMMENT 'email',
  `password` varchar(32) NOT NULL DEFAULT '' COMMENT '密码',
  `last_login` int(11) DEFAULT '0' COMMENT '最后登录时间',
  `last_ip` varchar(15) DEFAULT '' COMMENT '最后登录ip',
  `login_cnt` int(11) DEFAULT '0' COMMENT '登录次数',
  `session_id` varchar(50) DEFAULT '' COMMENT 'session_id',
  `parent_id` int(10) DEFAULT '0' COMMENT '父管理员ID',
  `role_id` int(10) NOT NULL DEFAULT '-1' COMMENT '角色组ID（-1表示超级管理员）',
  `mark_lang` varchar(50) DEFAULT 'cn' COMMENT '当前语言标识',
  `status` tinyint(1) DEFAULT '1' COMMENT '状态(0=屏蔽，1=正常)',
  `add_time` int(11) DEFAULT '0' COMMENT '添加时间',
  `update_time` int(11) DEFAULT '0' COMMENT '更新时间',
  PRIMARY KEY (`admin_id`),
  KEY `user_name` (`user_name`) USING BTREE
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='管理员表';

-- ----------------------------
-- Records of ey_admin
-- ----------------------------
INSERT INTO `ey_admin` VALUES ('1', 'admin', '', 'admin', '', '', '7959ec68e999edd0380ff0809f76fa42', '1540970915', '127.0.0.1', '39', '5cunfv8qiotif8798aubfvmu01', '0', '-1', 'sq', '1', '1531707001', '1543802837');

-- ----------------------------
-- Table structure for ey_admin_log
-- ----------------------------
DROP TABLE IF EXISTS `ey_admin_log`;
CREATE TABLE `ey_admin_log` (
  `log_id` bigint(16) unsigned NOT NULL AUTO_INCREMENT COMMENT '表id',
  `admin_id` int(10) DEFAULT NULL COMMENT '管理员id',
  `log_info` varchar(255) DEFAULT NULL COMMENT '日志描述',
  `log_ip` varchar(30) DEFAULT NULL COMMENT 'ip地址',
  `log_url` varchar(255) DEFAULT NULL COMMENT 'url',
  `log_time` int(10) DEFAULT NULL COMMENT '日志时间',
  PRIMARY KEY (`log_id`),
  KEY `admin_id` (`admin_id`) USING BTREE
) ENGINE=MyISAM AUTO_INCREMENT=128 DEFAULT CHARSET=utf8 COMMENT='管理员操作日志表';

-- ----------------------------
-- Records of ey_admin_log
-- ----------------------------
INSERT INTO `ey_admin_log` VALUES ('118', '1', '后台登录', '127.0.0.1', '/login.php', '1540962138');
INSERT INTO `ey_admin_log` VALUES ('119', '1', '安全退出', '127.0.0.1', '/login.php', '1540968879');
INSERT INTO `ey_admin_log` VALUES ('120', '1', '后台登录', '127.0.0.1', '/login.php', '1540968885');
INSERT INTO `ey_admin_log` VALUES ('121', '1', '安全退出', '127.0.0.1', '/login.php', '1540970909');
INSERT INTO `ey_admin_log` VALUES ('122', '1', '后台登录', '127.0.0.1', '/login.php', '1540970915');
INSERT INTO `ey_admin_log` VALUES ('123', '1', '编辑图集：客户案例三', '127.0.0.1', '/login.php', '1543798501');
INSERT INTO `ey_admin_log` VALUES ('124', '1', '录入商业授权', '127.0.0.1', '/login.php', '1543801473');
INSERT INTO `ey_admin_log` VALUES ('125', '1', '录入商业授权', '127.0.0.1', '/login.php', '1543801503');
INSERT INTO `ey_admin_log` VALUES ('126', '1', '新增多语言：Albanian', '127.0.0.1', '/login.php', '1543801522');
INSERT INTO `ey_admin_log` VALUES ('127', '1', '删除多语言：Albanian', '127.0.0.1', '/login.php', '1543805286');

-- ----------------------------
-- Table structure for ey_ad_position
-- ----------------------------
DROP TABLE IF EXISTS `ey_ad_position`;
CREATE TABLE `ey_ad_position` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(60) DEFAULT '' COMMENT '广告位置名称',
  `width` smallint(5) unsigned DEFAULT '0' COMMENT '广告位宽度',
  `height` smallint(5) unsigned DEFAULT '0' COMMENT '广告位高度',
  `intro` text COMMENT '广告描述',
  `status` tinyint(1) DEFAULT '1' COMMENT '0关闭1开启',
  `lang` varchar(50) DEFAULT 'cn' COMMENT '多语言',
  `admin_id` int(10) DEFAULT '0' COMMENT '管理员ID',
  `add_time` int(11) DEFAULT '0' COMMENT '新增时间',
  `update_time` int(11) DEFAULT '0' COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='广告位置表';

-- ----------------------------
-- Records of ey_ad_position
-- ----------------------------
INSERT INTO `ey_ad_position` VALUES ('1', '首页-大幻灯片', '1920', '550', '广告图片的宽高度随着浏览器大小而改变', '1', 'cn', '0', '1524209276', '1524209365');

-- ----------------------------
-- Table structure for ey_archives
-- ----------------------------
DROP TABLE IF EXISTS `ey_archives`;
CREATE TABLE `ey_archives` (
  `aid` int(10) NOT NULL AUTO_INCREMENT,
  `typeid` int(10) NOT NULL DEFAULT '0' COMMENT '当前栏目',
  `channel` int(10) NOT NULL DEFAULT '0' COMMENT '模型ID',
  `is_b` tinyint(1) DEFAULT '0' COMMENT '加粗',
  `title` varchar(200) DEFAULT '' COMMENT '标题',
  `litpic` varchar(250) DEFAULT '' COMMENT '封面图',
  `is_head` tinyint(1) DEFAULT '0' COMMENT '头条（0=否，1=是）',
  `is_special` tinyint(1) DEFAULT '0' COMMENT '特荐（0=否，1=是）',
  `is_top` tinyint(1) DEFAULT '0' COMMENT '置顶（0=否，1=是）',
  `is_recom` tinyint(1) DEFAULT '0' COMMENT '推荐（0=否，1=是）',
  `is_jump` tinyint(1) DEFAULT '0' COMMENT '跳转链接（0=否，1=是）',
  `author` varchar(200) DEFAULT '' COMMENT '编辑者',
  `click` int(10) DEFAULT '0' COMMENT '浏览量',
  `arcrank` tinyint(1) DEFAULT '0' COMMENT '阅读权限：0=开放浏览，-1=待审核稿件',
  `jumplinks` varchar(200) DEFAULT '' COMMENT '外链跳转',
  `ismake` tinyint(1) DEFAULT '0' COMMENT '是否静态页面（0=动态，1=静态）',
  `seo_title` varchar(200) DEFAULT '' COMMENT 'SEO标题',
  `seo_keywords` varchar(200) DEFAULT '' COMMENT 'SEO关键词',
  `seo_description` text COMMENT 'SEO描述',
  `status` tinyint(1) DEFAULT '1' COMMENT '状态(0=屏蔽，1=正常)',
  `sort_order` int(10) DEFAULT '0' COMMENT '排序号',
  `lang` varchar(50) DEFAULT 'cn' COMMENT '语言标识',
  `admin_id` int(10) DEFAULT '0' COMMENT '管理员ID',
  `add_time` int(11) DEFAULT '0' COMMENT '新增时间',
  `update_time` int(11) DEFAULT '0' COMMENT '更新时间',
  PRIMARY KEY (`aid`),
  KEY `aid` (`typeid`,`channel`) USING BTREE
) ENGINE=MyISAM AUTO_INCREMENT=48 DEFAULT CHARSET=utf8 COMMENT='文档主表';

-- ----------------------------
-- Records of ey_archives
-- ----------------------------
INSERT INTO `ey_archives` VALUES ('1', '1', '6', '0', '关于我们', '', '0', '0', '0', '0', '0', '', '0', '0', '', '0', '', '', '', '1', '100', 'cn', '0', '1526539465', '1527836335');
INSERT INTO `ey_archives` VALUES ('2', '8', '6', '0', '公司简介', '', '0', '0', '0', '0', '0', '', '0', '0', '', '0', '', '', '', '1', '100', 'cn', '0', '1526540452', '1527836706');
INSERT INTO `ey_archives` VALUES ('3', '13', '6', '0', '单页面', '', '0', '0', '0', '0', '0', '', '4', '0', '', '0', '', '', '', '1', '100', 'cn', '0', '1526540573', '1531710225');
INSERT INTO `ey_archives` VALUES ('4', '11', '1', '1', 'seo是什么？', '/public/upload/remote/2018/05/17/5afd3acbd5c92.png', '0', '0', '0', '0', '0', '', '130', '0', '', '0', '', '', '在了解seo是什么意思之后，才能学习seo。什么是seo，从官方解释来看，seo=Search（搜索）Engine（引擎）Optimization（优化），即搜索引擎优化。使用过百度或其他搜索引擎，在', '1', '100', 'cn', '0', '1526545072', '1531711714');
INSERT INTO `ey_archives` VALUES ('39', '12', '1', '0', '回顾中国饮料40年发展史，总有一款是你儿时记忆的味道', '', '0', '0', '0', '0', '0', '', '177', '0', '', '0', '', '', '对于记忆来说，味道往往是最美的，儿时喝过的饮料，至今回想起来依然觉得津津有味。今天是六一儿童节，青山资本梳理了中国40年来饮料发展的简史，权当节日的小消遣，顺便看看能否找到你记忆深处的那个味道？第一阶段：国人味蕾的开启时代百事可乐在华第一家工厂开业1981年，可口可乐在中国第一条生产线正式投产，主要供应旅游饭店，卖给外国人收取外汇，百事可乐也在深圳建立了第一家罐装厂。1982年，国家把饮料纳入“国家计划管理产品”，可口可乐开始在北京市场进行内销。', '1', '100', 'cn', '0', '1527824652', '1531709817');
INSERT INTO `ey_archives` VALUES ('9', '10', '1', '0', '用户界面设计和体验设计的差别', '', '0', '0', '0', '0', '0', '', '168', '0', '', '0', '', '', '有时候我们需要获取图集中的第一张图片，下面给出解决办法： 第一步：修改include/extend.func.php 添加  // 提取图集第一张大图', '1', '100', 'cn', '0', '1526552582', '1531711820');
INSERT INTO `ey_archives` VALUES ('10', '10', '1', '0', '新手科普文！什么是用户界面和体验设计？', '', '0', '0', '0', '0', '0', '', '129', '0', '', '0', '', '', '在仿站时，我们常常会自定义很多字段，那么如何在首页调用呢，下面给出方法：一、指定channelid属性（channelid=\'17\' 17是指内容模型里面指定的模型ID) 二、指定要调用出来的字段ad', '1', '100', 'cn', '0', '1526552685', '1531711845');
INSERT INTO `ey_archives` VALUES ('12', '10', '1', '1', '一文读懂互联网女皇和她的报告：互联网领域的投资圣经、选股指南', '/public/upload/remote/2018/05/31/5b0fed15cd53d.png', '0', '0', '0', '0', '0', '', '266', '0', '', '0', '', '', '北京时间 5 月 31 日凌晨，有“互联网女皇”之称的玛丽·米克尔发布了 2018 年的互联网趋势报告，这也是她第 23 年公布互联网报告。\r\n每年的互联网女皇报告几乎都会成为每个互联网创业者的必读报告。那么，互联网女皇是谁?为什么她的报告会如此受关注呢?', '1', '100', 'cn', '0', '1526552714', '1531709449');
INSERT INTO `ey_archives` VALUES ('13', '12', '1', '0', '网站建设的五大核心要素', '/public/upload/article/2018/07/16/dba832d6114e6a85b7eb472bf8dc52ed.jpg', '0', '0', '0', '0', '0', '', '158', '0', '', '0', 'SEO标', 'O关键', 'SEO描述', '1', '100', 'cn', '0', '1526608216', '1531709954');
INSERT INTO `ey_archives` VALUES ('14', '10', '1', '0', '网站建设，静态页面和动态页面如何选择', '/public/upload/remote/2018/05/18/5afe365fa6716.png', '0', '0', '0', '0', '0', '', '148', '0', '', '0', '', '', '网站建设，静态页面和动态页面如何选择　　电商网站建设为什么要使用静态页面制作。我们都知道，网站制作有分为静态页面制作和动态网页制作，那么建设电商网站采用哪种网站设计技术更好呢?　　我们建设网站最终目的', '1', '100', 'cn', '0', '1526609496', '1527770223');
INSERT INTO `ey_archives` VALUES ('19', '12', '1', '0', '从三方面完美的体验企业网站的核心价值', 'http://www.eyoucms.com/uploads/allimg/180426/150RQ155-0.jpg', '0', '0', '0', '0', '0', '', '144', '0', '', '0', '', '', '从三方面完美的体验企业网站的核心价值　　随着互联网的迅猛发展，一个企业的发展离不开互联网的发展，企业注重企业网站建设，那么必然会给其带来不错的效果。企业网站建设其核心价值直接体现在网站对于用户和商家而', '1', '100', 'cn', '0', '1526610848', '1526610848');
INSERT INTO `ey_archives` VALUES ('20', '11', '1', '0', 'CMS是如何应运而生的？', '', '0', '0', '0', '0', '0', '', '175', '0', '', '0', '', '', '随着网络应用的丰富和发展，很多网站往往不能迅速跟进大量信息衍生及业务模式变革的脚步，常常需要花费许多时间、人力和物力来处理信息更新和维护工作；遇到网站扩充的时候，整合内外网及分支网站的工作就变得更加复', '1', '100', 'cn', '0', '1526611606', '1527557542');
INSERT INTO `ey_archives` VALUES ('21', '11', '1', '0', '网站设计与SEO的关系，高手是从这4个维度分析的！', '', '0', '0', '0', '0', '0', '', '286', '0', '', '0', '', '', 'SEO（搜索引擎优化）和有效的网站设计是齐头并进的。好的网站设计是关于创建一个吸引目标受众的网站，并让他们采取某种行动。但是，如果该网站不遵循目前的SEO最佳做法，它的排名将会受到影响，从而会导致真正', '1', '100', 'cn', '0', '1526611744', '1531709637');
INSERT INTO `ey_archives` VALUES ('22', '23', '3', '0', '新闻模型下的图集', '/public/upload/images/2018/07/18/60a1a6f1760e1f8c22ca02980fd8374e.jpg', '0', '0', '0', '0', '0', '', '191', '0', '', '0', '', '', '新闻模型下的图集新闻模型下的图集新闻模型下的图集新闻模型下的图集新闻模型下的图集新闻模型下的图集新闻模型下的图集新闻模型下的图集新闻模型下的图集新闻模型下的图集新闻模型下的图集新闻模型下的图集新闻模型', '1', '100', 'cn', '0', '1526612277', '1531877783');
INSERT INTO `ey_archives` VALUES ('23', '23', '3', '0', '新闻模型下的图集二', '/public/upload/images/2018/07/18/aec51022b7fc0ae3ce67279161c6a0c2.jpg', '0', '0', '0', '0', '0', '', '286', '0', '', '0', '', '', '新闻模型下的图集二新闻模型下的图集二新闻模型下的图集二新闻模型下的图集二新闻模型下的图集二新闻模型下的图集二新闻模型下的图集二新闻模型下的图集二新闻模型下的图集二新闻模型下的图集二新闻模型下的图集二新', '1', '100', 'cn', '0', '1526612316', '1531877859');
INSERT INTO `ey_archives` VALUES ('27', '24', '2', '0', '华为HUAWEI NOTE 8', '/public/upload/product/2018/05/18/2b6cf3e6fdb8573d99024567c834d42c.jpg', '0', '0', '0', '0', '0', '', '289', '0', '', '0', '', '', '全向录音/指向回放、定向免提、指关节手势、分屏多窗口、语音控制、情景智能、单手操作、杂志锁屏、手机找回、无线WIFI打印、学生模式、多屏互动、运动健康全向录音/指向回放、定向免提、指关节手势、分屏多窗', '1', '100', 'cn', '0', '1526613043', '1531727096');
INSERT INTO `ey_archives` VALUES ('28', '26', '2', '0', '小米笔记本Air 13.3', '/public/upload/product/2018/05/18/7e04484a0e74d6dbbe24ba9cf81b62fd.jpg', '0', '0', '0', '0', '0', '', '149', '0', '', '0', '', '', '轻薄全金属机身/256GBSSD/第八代Intel酷睿i5处理器/FHD全贴合屏幕/指纹解锁/office激活不支持7天无理由退货...', '1', '100', 'cn', '0', '1526613271', '1531730814');
INSERT INTO `ey_archives` VALUES ('29', '27', '2', '0', ' 小米蓝牙项圈耳机', '/public/upload/product/2018/05/18/97714e2c8a418a4282063d9019134a86.jpg', '0', '0', '0', '0', '0', '', '211', '0', '', '0', '', '', '特性M3平板定制AKG品牌高保真耳机，配合M3平板享受HiFi音质...', '1', '100', 'cn', '0', '1526613739', '1526613820');
INSERT INTO `ey_archives` VALUES ('30', '5', '4', '0', '工程机械推土挖掘机类网站模板', '/public/upload/download/2018/07/16/cb1af02c061429dd8a99c69df4f07838.jpg', '0', '0', '0', '0', '0', '', '242', '0', '', '0', '', '', '宅男女神一号，多懂得...', '1', '100', 'cn', '0', '1526614069', '1531888267');
INSERT INTO `ey_archives` VALUES ('31', '5', '4', '0', '职业教育培训机构网站模板', '', '0', '0', '0', '0', '0', '', '167', '0', '', '0', '', '', '宅男女神二号种子，高手多是不懂的...', '1', '100', 'cn', '0', '1526614168', '1531888375');
INSERT INTO `ey_archives` VALUES ('40', '12', '1', '0', '社交媒体时代，如何对粉丝估值？', '/public/upload/article/2018/07/18/445c3092e834bb558044aac9530b5f47.jpg', '0', '0', '0', '0', '0', '', '173', '0', '', '0', '', '', '约翰·奎尔奇说，社交媒体有很多营销挑战，如何为粉丝来估值是一个大问题。从营销角度来思考，要关注强纽带和弱纽带。你可能以为，强纽带的密友产生最大的营销影响，研究发现不是这样的，产生更大的影响反而是跟你更疏远的人。演讲者｜约翰·奎尔奇（哈佛商学院教授，曾任伦敦商学院院长、中欧国际工商学院副院长）非常感谢大家在周日早上回来听我讲课。对于你们这些创业者，或者希望成为创业者的人，我今天准备了一个特别的讲座。很多创业者没有把最终愿景很好界定，所以每天都忙于灭火，忙于生存。创业营销，你必须做好规划今天将从创业营销这个话题开始，包括你如何生存和成功。创业营销包括四个关键领域，你必须很好地去规划：要有正确的目标客户和最终用户；要有正确的产品和服务要有一个非常好的人才团队，使得商业创意能够实现；要有好的合作伙伴，不是分销商，而是会计、律师等服务伙伴。那么，何为创业营销？？第一，这是从愿景到行动的逆向工程设计当星巴克只有5家店时，创始人就有一个愿景，让星巴克成为你生活中的第三空间。对创业者要从愿景开始，向后进行逆向工程的设计：看一下需要有什么样的行动，才能实现愿景。很多创业者没有把最终愿景很好界定，所以每天', '1', '100', 'cn', '0', '1527824837', '1531876546');
INSERT INTO `ey_archives` VALUES ('37', '24', '2', '0', 'Apple iPhone 6s 16GB 玫瑰金色 移动联通电信4G手机', '/public/upload/product/2018/05/28/22b1d3ab98046b377e795e70450a602f.jpg', '0', '0', '0', '0', '0', '', '300', '0', '', '0', '', '', '', '1', '100', 'cn', '0', '1527507844', '1531726969');
INSERT INTO `ey_archives` VALUES ('38', '11', '1', '0', '商梦网校：单页SEO站群技术，用10个网站优化排名！', 'http://www.eyoucms.com/uploads/allimg/180505/3-1P505101H3447.png', '0', '0', '0', '0', '0', '', '111', '0', '', '0', '', '', 'SEO很多伙伴都了解，就是搜索引擎排名优化，通过对网站内部和外部进行优化当用户搜索相应关键词时网站能够排名在搜索引擎前面，具体可以百度搜索“网络营销课程”查看商梦网校操作的案例！但单页SEO很多伙伴可能会有点陌生，单页SEO是将单页网站与内容内容结合为一体的SEO优化方案，主要是提升网站流量利用率让用户打开网站就能看到目标页面，转换更多订单，创造更多收益。单页SEO的操作理念也是由商梦网校提出，并一起推荐操作大家的模式。那什么又是单页SEO站群呢，因为操作SEO成功率并不是100%，也就是意味着你做了并不会绝对有排名。因为在任何时候搜索引擎，特别是百度的索引数据库里，只有60%的网页数量。也就是说，大量的网页它是没有收录进来，它本身的能力所限无法做到中文的所有几百亿个网页都收录进来。所以，对于大部分网站，都有被删除网页，没有排名，或被K的经历，或没有排名。处理办法：坦然面对这一切。一个网站的成本才多少钱？如果因此对SEO失去信心，那就是最大的失去了。不过我们也想到了一个更好的解决方案，这个方案在最早期我们开始操作，并且取得了非常不错的成绩就是“站群”，我们可以假设一个网站排名的机会为1', '1', '100', 'cn', '0', '1527555069', '1531709578');
INSERT INTO `ey_archives` VALUES ('41', '12', '1', '0', '《颠覆营销:大数据时代的商业革命》：大数据“多即少，少即多”', '', '0', '0', '0', '0', '0', '', '161', '0', '', '0', '', '', '各种行销手段早已令人眼花缭乱，但究其本质都是在研究客户（消费者），研究客户的所想、所需，使产品或服务有的放矢。大数据时代又给它赋予了新名词：精准营销。大数据最先应用的领域多为面对客户的行业，最先应用的情景也多为精准营销。“酒好也怕巷子深”，产品或服务的信息要送达客户才可能促成交易。一般认为，向客户传达产品或服务信息要靠广告。广告古已有之，“三碗不过岗”的酒幌子就是广告。没有互联网的时代，我们熟悉的是电视广告、广播广告、印刷品平面广告、户外广告牌等，当然，也包括吆喝叫卖。但过去的广告是千人一面、不区分受众的。后来商家对客户的信息有所采集就有了CRM，经过客户分类，可以更好地服务于不同的客户群体。互联网+大数据时代让CRM有了新的发展机遇，管理客户不再是简单的数字统计和没有个性的（或简单聚类的）直邮、定投。随着商家对客户知道更多、了解更深，便有机会为客户提供个性化的营销方案，进一步改善客户体验，成为了个性化营销或叫精准营销。大数据时代，让很多过去的不可能变为可能，营销活动也赢来了新的发展机遇。时代不同，商业经营的形式会变化，但本质就是两件事：开源，节流。开源是开拓新客户，发现新商机；节流是', '1', '100', 'cn', '0', '1527825125', '1527825125');
INSERT INTO `ey_archives` VALUES ('42', '4', '3', '0', '客户案例一', '/public/upload/images/2018/07/16/a6633714552fcccee2f49f2131f9d131.jpg', '0', '0', '0', '0', '0', '', '251', '0', '', '0', '', '', '', '1', '100', 'cn', '0', '1531731387', '1531732448');
INSERT INTO `ey_archives` VALUES ('43', '4', '3', '0', '客户案例二', '/public/upload/images/2018/07/16/2a97ea57a860f5ca2bfb007d06f0e47c.jpg', '0', '0', '0', '0', '0', '', '266', '0', '', '0', '', '', '', '1', '100', 'cn', '0', '1531732591', '1531732691');
INSERT INTO `ey_archives` VALUES ('44', '4', '3', '0', '客户案例三', '/public/upload/images/2018/07/16/c8053c217ad5d3e0b77108f54ed1db52.jpg', '0', '0', '0', '0', '0', '', '281', '0', '', '0', '', '', '', '1', '100', 'cn', '0', '1532078411', '1543798501');

-- ----------------------------
-- Table structure for ey_arcrank
-- ----------------------------
DROP TABLE IF EXISTS `ey_arcrank`;
CREATE TABLE `ey_arcrank` (
  `id` smallint(5) unsigned NOT NULL AUTO_INCREMENT COMMENT '权限ID',
  `rank` smallint(6) DEFAULT '0' COMMENT '权限值',
  `name` char(20) DEFAULT '' COMMENT '会员名称',
  `lang` varchar(50) DEFAULT 'cn' COMMENT '语言标识',
  `add_time` int(11) DEFAULT '0' COMMENT '新增时间',
  `update_time` int(11) DEFAULT '0' COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='文档阅读权限表';

-- ----------------------------
-- Records of ey_arcrank
-- ----------------------------
INSERT INTO `ey_arcrank` VALUES ('1', '0', '开放浏览', 'cn', '0', '0');
INSERT INTO `ey_arcrank` VALUES ('2', '-1', '待审核稿件', 'cn', '0', '0');

-- ----------------------------
-- Table structure for ey_arctype
-- ----------------------------
DROP TABLE IF EXISTS `ey_arctype`;
CREATE TABLE `ey_arctype` (
  `id` int(10) NOT NULL AUTO_INCREMENT COMMENT '栏目ID',
  `channeltype` int(10) DEFAULT '0' COMMENT '栏目顶级模型ID',
  `current_channel` int(10) DEFAULT '0' COMMENT '栏目当前模型ID',
  `parent_id` int(10) DEFAULT '0' COMMENT '栏目上级ID',
  `typename` varchar(200) DEFAULT '' COMMENT '栏目名称',
  `dirname` varchar(200) DEFAULT '' COMMENT '目录英文名',
  `dirpath` varchar(200) DEFAULT '' COMMENT '目录存放HTML路径',
  `englist_name` varchar(200) DEFAULT '' COMMENT '栏目英文名',
  `grade` tinyint(1) DEFAULT '0' COMMENT '栏目等级',
  `typelink` varchar(200) DEFAULT '' COMMENT '栏目链接',
  `litpic` varchar(250) DEFAULT '' COMMENT '栏目图片',
  `templist` varchar(200) DEFAULT '' COMMENT '列表模板文件名',
  `tempview` varchar(200) DEFAULT '' COMMENT '文档模板文件名',
  `seo_title` varchar(200) DEFAULT '' COMMENT 'SEO标题',
  `seo_keywords` varchar(200) DEFAULT '' COMMENT 'seo关键字',
  `seo_description` text COMMENT 'seo描述',
  `sort_order` int(10) DEFAULT '0' COMMENT '排序号',
  `is_hidden` tinyint(1) DEFAULT '0' COMMENT '是否隐藏栏目：0=显示，1=隐藏',
  `is_part` tinyint(1) DEFAULT '0' COMMENT '栏目属性：0=内容栏目，1=外部链接',
  `admin_id` int(10) DEFAULT '0' COMMENT '管理员ID',
  `is_del` tinyint(1) DEFAULT '0' COMMENT '伪删除，1=是，0=否',
  `status` tinyint(1) DEFAULT '1' COMMENT '启用 (1=正常，0=屏蔽)',
  `lang` varchar(50) DEFAULT 'cn' COMMENT '语言标识',
  `add_time` int(11) DEFAULT '0' COMMENT '新增时间',
  `update_time` int(11) DEFAULT '0' COMMENT '更新时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `dirname` (`dirname`,`lang`) USING BTREE,
  KEY `parent_id` (`channeltype`,`parent_id`) USING BTREE
) ENGINE=MyISAM AUTO_INCREMENT=54 DEFAULT CHARSET=utf8 COMMENT='文档栏目表';

-- ----------------------------
-- Records of ey_arctype
-- ----------------------------
INSERT INTO `ey_arctype` VALUES ('1', '6', '6', '0', '关于我们', 'guanyuwomen', '/html/guanyuwomen', '', '0', '', '', 'lists_single.htm', '', '', '', '', '100', '0', '0', '0', '0', '1', 'cn', '1526539465', '1527836335');
INSERT INTO `ey_arctype` VALUES ('2', '1', '1', '0', '新闻动态', 'xinwendongtai', '/html/xinwendongtai', '', '0', '', '', '', '', '', '', '', '100', '0', '0', '0', '0', '1', 'cn', '1526539487', '1526544623');
INSERT INTO `ey_arctype` VALUES ('3', '2', '2', '0', '产品展示', 'chanpinzhanshi', '/html/chanpinzhanshi', '', '0', '', '', '', '', '', '', '', '100', '0', '0', '0', '0', '1', 'cn', '1526539505', '1526539505');
INSERT INTO `ey_arctype` VALUES ('4', '3', '3', '0', '客户案例', 'kehuanli', '/html/kehuanli', '', '0', '', '', '', '', '', '', '', '100', '0', '0', '0', '0', '1', 'cn', '1526539517', '1526539517');
INSERT INTO `ey_arctype` VALUES ('5', '4', '4', '0', '资料下载', 'ziliaoxiazai', '/html/ziliaoxiazai', '', '0', '', '', '', '', '', '', '', '100', '0', '0', '0', '0', '1', 'cn', '1526539530', '1526539530');
INSERT INTO `ey_arctype` VALUES ('6', '8', '8', '0', '报名入口', 'baomingrukou', '/html/baomingrukou', '', '0', '', '', '', '', '', '', '', '100', '0', '0', '0', '0', '1', 'cn', '1526539546', '1526539546');
INSERT INTO `ey_arctype` VALUES ('8', '6', '6', '1', '公司简介', 'gongsijianjie', '/html/guanyuwomen/gongsijianjie', '', '1', '', '', 'lists_single.htm', '', '', '', '', '100', '0', '0', '0', '0', '1', 'cn', '1526540452', '1527836706');
INSERT INTO `ey_arctype` VALUES ('9', '6', '1', '1', '公司荣誉', 'gsry', '/html/guanyuwomen', '', '1', '', '', 'lists_article.htm', 'view_article.htm', '', '', '', '100', '0', '0', '0', '0', '1', 'cn', '1526540478', '1527836335');
INSERT INTO `ey_arctype` VALUES ('10', '1', '1', '2', '媒体报道', 'meitibaodao', '/html/xinwendongtai/meitibaodao', '', '1', '', '', '', '', '', '', '', '100', '0', '0', '0', '0', '1', 'cn', '1526540530', '1526544623');
INSERT INTO `ey_arctype` VALUES ('11', '1', '1', '2', 'SEO优化', 'xingyezixun', '/html/xinwendongtai/xingyezixun', '', '1', '', '', '', '', '', '', '', '100', '0', '0', '0', '0', '1', 'cn', '1526540543', '1526611564');
INSERT INTO `ey_arctype` VALUES ('12', '1', '1', '2', '企业运营', 'qiyexinwen', '/html/xinwendongtai/qiyexinwen', '', '1', '', '', '', '', '', '', '', '100', '0', '0', '0', '0', '1', 'cn', '1526540554', '1526608200');
INSERT INTO `ey_arctype` VALUES ('13', '1', '6', '2', '单页面', 'xinwendanye', '/html/xinwendongtai/xinwendanye', '', '1', '', '', 'lists_single.htm', '', '', '', '', '100', '0', '0', '0', '0', '1', 'cn', '1526540573', '1531710225');
INSERT INTO `ey_arctype` VALUES ('20', '2', '2', '3', '手机', 'shouji', '/html/chanpinzhanshi/shouji', '', '1', '', '', '', '', '', '', '', '100', '0', '0', '0', '0', '1', 'cn', '1526612114', '1526612114');
INSERT INTO `ey_arctype` VALUES ('21', '2', '2', '3', '电脑', 'diannao', '/html/chanpinzhanshi/diannao', '', '1', '', '', '', '', '', '', '', '100', '0', '0', '0', '0', '1', 'cn', '1526612188', '1526612188');
INSERT INTO `ey_arctype` VALUES ('22', '2', '2', '3', '通用配件', 'tongyongpeijian', '/html/chanpinzhanshi/tongyongpeijian', '', '1', '', '', '', '', '', '', '', '100', '0', '0', '0', '0', '1', 'cn', '1526612218', '1526612218');
INSERT INTO `ey_arctype` VALUES ('23', '1', '3', '2', '风景图集', 'fengjingtuji', '/html/xinwendongtai/fengjingtuji', '', '1', '', '', '', '', '', '', '', '100', '0', '0', '0', '0', '1', 'cn', '1526612255', '1526612255');
INSERT INTO `ey_arctype` VALUES ('24', '2', '2', '20', '智能手机', 'zhinenshouji', '/html/chanpinzhanshi/shouji/zhinenshouji', '', '2', '', '', '', '', '', '', '', '100', '0', '0', '0', '0', '1', 'cn', '1526612571', '1526612571');
INSERT INTO `ey_arctype` VALUES ('25', '2', '2', '20', '畅玩手机', 'changwanshouji', '/html/chanpinzhanshi/shouji/changwanshouji', '', '2', '', '', '', '', '', '', '', '100', '0', '0', '0', '0', '1', 'cn', '1526612606', '1526612606');
INSERT INTO `ey_arctype` VALUES ('26', '2', '2', '21', '笔记本电脑', 'bijibendiannao', '/html/chanpinzhanshi/diannao/bijibendiannao', '', '2', '', '', '', '', '', '', '', '100', '0', '0', '0', '0', '1', 'cn', '1526612635', '1526612635');
INSERT INTO `ey_arctype` VALUES ('27', '2', '2', '22', '耳机', 'erji', '/html/chanpinzhanshi/tongyongpeijian/erji', '', '2', '', '', '', '', '', '', '', '100', '0', '0', '0', '0', '1', 'cn', '1526612661', '1526612661');
INSERT INTO `ey_arctype` VALUES ('28', '2', '2', '22', '音箱', 'yinxiang', '/html/chanpinzhanshi/tongyongpeijian/yinxiang', '', '2', '', '', '', '', '', '', '', '100', '0', '0', '0', '0', '1', 'cn', '1526612678', '1526612678');
INSERT INTO `ey_arctype` VALUES ('29', '2', '2', '22', '充电宝', 'chongdianbao', '/html/chanpinzhanshi/tongyongpeijian/chongdianbao', '', '2', '', '', '', '', '', '', '', '100', '0', '0', '0', '0', '1', 'cn', '1526612691', '1526612691');
INSERT INTO `ey_arctype` VALUES ('30', '6', '8', '1', '预约面试', 'yuyuemianshi', '/html/guanyuwomen/yuyuemianshi', '', '1', '', '', 'lists_guestbook_30.htm', '', '', '', '', '100', '0', '0', '0', '0', '1', 'cn', '1526634493', '1527836335');

-- ----------------------------
-- Table structure for ey_article_content
-- ----------------------------
DROP TABLE IF EXISTS `ey_article_content`;
CREATE TABLE `ey_article_content` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `aid` int(10) DEFAULT '0' COMMENT '文档ID',
  `content` longtext COMMENT '内容详情',
  `add_time` int(11) DEFAULT '0' COMMENT '新增时间',
  `update_time` int(11) DEFAULT '0' COMMENT '更新时间',
  PRIMARY KEY (`id`),
  KEY `news_id` (`aid`) USING BTREE
) ENGINE=MyISAM AUTO_INCREMENT=18 DEFAULT CHARSET=utf8 COMMENT='文章附加表';

-- ----------------------------
-- Records of ey_article_content
-- ----------------------------
INSERT INTO `ey_article_content` VALUES ('1', '4', '&lt;p style=&quot;margin-top: 0px; margin-bottom: 15px; color: rgb(85, 85, 85); font-family: &amp;quot;Microsoft Yahei&amp;quot;, &amp;quot;Helvetica Neue&amp;quot;, Helvetica, Arial, sans-serif; font-size: 15px; text-indent: 30px; white-space: normal;&quot;&gt;在了解&lt;strong&gt;seo是什么意思&lt;/strong&gt;之后，才能学习seo。&lt;br/&gt;&lt;/p&gt;&lt;p style=&quot;margin-top: 0px; margin-bottom: 15px; color: rgb(85, 85, 85); font-family: &amp;quot;Microsoft Yahei&amp;quot;, &amp;quot;Helvetica Neue&amp;quot;, Helvetica, Arial, sans-serif; font-size: 15px; text-indent: 30px; white-space: normal;&quot;&gt;什么是seo，从官方解释来看，seo=Search（搜索） Engine（引擎） Optimization（优化），即搜索引擎优化。&lt;/p&gt;&lt;p style=&quot;margin-top: 0px; margin-bottom: 15px; color: rgb(85, 85, 85); font-family: &amp;quot;Microsoft Yahei&amp;quot;, &amp;quot;Helvetica Neue&amp;quot;, Helvetica, Arial, sans-serif; font-size: 15px; text-indent: 30px; white-space: normal;&quot;&gt;使用过百度或其他搜索引擎，在搜索框中输入某一个关键词，如铁艺大门，排名靠前带有广告字样，背景略不同的是竞价位置，为俗称的&lt;a href=&quot;http://www.xminseo.com/2376.html&quot; title=&quot;&quot; style=&quot;color: rgb(0, 166, 124); text-decoration: none;&quot;&gt;sem&lt;/a&gt;位置。&lt;/p&gt;&lt;p style=&quot;margin-top: 0px; margin-bottom: 15px; color: rgb(85, 85, 85); font-family: &amp;quot;Microsoft Yahei&amp;quot;, &amp;quot;Helvetica Neue&amp;quot;, Helvetica, Arial, sans-serif; font-size: 15px; text-indent: 30px; white-space: normal;&quot;&gt;seo是基于搜索引擎营销的一种网络营销方式，通过seo技术，提升网站关键词排名，获得展现，继而获得曝光，继而获得用户点击，继而获得转化。&lt;/p&gt;&lt;p style=&quot;margin-top: 0px; margin-bottom: 15px; color: rgb(85, 85, 85); font-family: &amp;quot;Microsoft Yahei&amp;quot;, &amp;quot;Helvetica Neue&amp;quot;, Helvetica, Arial, sans-serif; font-size: 15px; text-indent: 30px; white-space: normal;&quot;&gt;一：seo分类。&lt;/p&gt;&lt;p style=&quot;margin-top: 0px; margin-bottom: 15px; color: rgb(85, 85, 85); font-family: &amp;quot;Microsoft Yahei&amp;quot;, &amp;quot;Helvetica Neue&amp;quot;, Helvetica, Arial, sans-serif; font-size: 15px; text-indent: 30px; white-space: normal;&quot;&gt;细化来看，所有有利于网站关键词排名提升的点，都可以归纳于seo，为便于理解，我们将seo分为站内seo和站外seo。&lt;/p&gt;&lt;p style=&quot;margin-top: 0px; margin-bottom: 15px; color: rgb(85, 85, 85); font-family: &amp;quot;Microsoft Yahei&amp;quot;, &amp;quot;Helvetica Neue&amp;quot;, Helvetica, Arial, sans-serif; font-size: 15px; text-indent: 30px; white-space: normal;&quot;&gt;1：站内seo。&lt;/p&gt;&lt;p style=&quot;margin-top: 0px; margin-bottom: 15px; color: rgb(85, 85, 85); font-family: &amp;quot;Microsoft Yahei&amp;quot;, &amp;quot;Helvetica Neue&amp;quot;, Helvetica, Arial, sans-serif; font-size: 15px; text-indent: 30px; white-space: normal;&quot;&gt;什么是站内seo？通俗来讲，就是指网站内部优化，即网站本身内部的优化，包括代码标签优化、内容优化、安全建设、用户体验等。&lt;/p&gt;&lt;p style=&quot;margin-top: 0px; margin-bottom: 15px; color: rgb(85, 85, 85); font-family: &amp;quot;Microsoft Yahei&amp;quot;, &amp;quot;Helvetica Neue&amp;quot;, Helvetica, Arial, sans-serif; font-size: 15px; text-indent: 30px; white-space: normal;&quot;&gt;2：站外seo。&lt;/p&gt;&lt;p style=&quot;margin-top: 0px; margin-bottom: 15px; color: rgb(85, 85, 85); font-family: &amp;quot;Microsoft Yahei&amp;quot;, &amp;quot;Helvetica Neue&amp;quot;, Helvetica, Arial, sans-serif; font-size: 15px; text-indent: 30px; white-space: normal;&quot;&gt;什么是站外seo？通俗来讲，就是网站的外部优化，包括外链建设，品牌建设，速度优化，引流等。&lt;/p&gt;&lt;p style=&quot;margin-top: 0px; margin-bottom: 15px; color: rgb(85, 85, 85); font-family: &amp;quot;Microsoft Yahei&amp;quot;, &amp;quot;Helvetica Neue&amp;quot;, Helvetica, Arial, sans-serif; font-size: 15px; text-indent: 30px; white-space: normal;&quot;&gt;二：seo相关建议。&lt;/p&gt;&lt;p style=&quot;margin-top: 0px; margin-bottom: 15px; color: rgb(85, 85, 85); font-family: &amp;quot;Microsoft Yahei&amp;quot;, &amp;quot;Helvetica Neue&amp;quot;, Helvetica, Arial, sans-serif; font-size: 15px; text-indent: 30px; white-space: normal;&quot;&gt;1：建议把seo定位于一种网络营销方式，在学习，使用seo的过程中，将他作为一种获取流量的渠道。&lt;/p&gt;&lt;p style=&quot;margin-top: 0px; margin-bottom: 15px; color: rgb(85, 85, 85); font-family: &amp;quot;Microsoft Yahei&amp;quot;, &amp;quot;Helvetica Neue&amp;quot;, Helvetica, Arial, sans-serif; font-size: 15px; text-indent: 30px; white-space: normal;&quot;&gt;2：新手学习seo的理想平台是百度搜索资源平台而非其他；理论联系实际操作是更为有效的学习方式；有经验的seo高手教会更快的掌握好seo；多思考，多总结，才能领悟seo的精髓。&lt;/p&gt;&lt;p style=&quot;margin-top: 0px; margin-bottom: 15px; color: rgb(85, 85, 85); font-family: &amp;quot;Microsoft Yahei&amp;quot;, &amp;quot;Helvetica Neue&amp;quot;, Helvetica, Arial, sans-serif; font-size: 15px; text-indent: 30px; white-space: normal;&quot;&gt;3：学习seo之前，熟悉掌握相关seo术语很有必要。&lt;/p&gt;&lt;p style=&quot;margin-top: 0px; margin-bottom: 15px; color: rgb(85, 85, 85); font-family: &amp;quot;Microsoft Yahei&amp;quot;, &amp;quot;Helvetica Neue&amp;quot;, Helvetica, Arial, sans-serif; font-size: 15px; text-indent: 30px; white-space: normal;&quot;&gt;4：很多时候，seo的理论与现实是相违背的，也就是说seo的理论点不复杂，操作点却很难达到。&lt;/p&gt;&lt;p style=&quot;margin-top: 0px; margin-bottom: 15px; color: rgb(85, 85, 85); font-family: &amp;quot;Microsoft Yahei&amp;quot;, &amp;quot;Helvetica Neue&amp;quot;, Helvetica, Arial, sans-serif; font-size: 15px; text-indent: 30px; white-space: normal;&quot;&gt;新手接触seo，感觉无所适从，请熟读seo术语，后面会越来越轻松。&lt;/p&gt;&lt;p&gt;&lt;br/&gt;&lt;/p&gt;', '1526545072', '1531711714');
INSERT INTO `ey_article_content` VALUES ('5', '9', '&lt;p style=&quot;margin-top: 0px; margin-bottom: 24px; color: rgb(14, 14, 14); font-family: Arial, &amp;quot;Hiragino Sans GB&amp;quot;, 冬青黑, &amp;quot;Microsoft YaHei&amp;quot;, 微软雅黑, SimSun, 宋体, Helvetica, Tahoma, &amp;quot;Arial sans-serif&amp;quot;; text-align: justify; white-space: normal; background-color: rgb(255, 255, 255);&quot;&gt;&lt;span style=&quot;font-weight: 700;&quot;&gt;注：&lt;/span&gt;用户界面（UI，User Interface）设计是设计软件产品所涉及到的几个交叉学科之一。不论是用户体验（UX，User Experience）、交互设计（ID，Interaction Design），还是视觉/图形设计（Visual / Graphic Design），都能牵扯到用户界面设计。&lt;/p&gt;&lt;p style=&quot;margin-top: 0px; margin-bottom: 24px; color: rgb(14, 14, 14); font-family: Arial, &amp;quot;Hiragino Sans GB&amp;quot;, 冬青黑, &amp;quot;Microsoft YaHei&amp;quot;, 微软雅黑, SimSun, 宋体, Helvetica, Tahoma, &amp;quot;Arial sans-serif&amp;quot;; text-align: justify; white-space: normal; background-color: rgb(255, 255, 255);&quot;&gt;&lt;span style=&quot;color: rgb(54, 54, 54); font-family: Tahoma, Arial, &amp;quot;Hiragino Sans GB&amp;quot;, 冬青黑, &amp;quot;Microsoft YaHei&amp;quot;, 微软雅黑, SimSun, 宋体, Heiti, 黑体, sans-serif; font-size: 24px;&quot;&gt;一、什么是用户界面设计？&lt;/span&gt;&lt;/p&gt;&lt;p style=&quot;margin-top: 0px; margin-bottom: 24px; color: rgb(14, 14, 14); font-family: Arial, &amp;quot;Hiragino Sans GB&amp;quot;, 冬青黑, &amp;quot;Microsoft YaHei&amp;quot;, 微软雅黑, SimSun, 宋体, Helvetica, Tahoma, &amp;quot;Arial sans-serif&amp;quot;; text-align: justify; white-space: normal; background-color: rgb(255, 255, 255);&quot;&gt;广泛来讲，用户界面是人与机器交流的媒介。用户向机器发出指令，机器随即开始一段进程，回复信息，并给出反馈。用户可以根据用户反馈进行下一步操作的决策。&lt;/p&gt;&lt;p style=&quot;margin-top: 0px; margin-bottom: 24px; color: rgb(14, 14, 14); font-family: Arial, &amp;quot;Hiragino Sans GB&amp;quot;, 冬青黑, &amp;quot;Microsoft YaHei&amp;quot;, 微软雅黑, SimSun, 宋体, Helvetica, Tahoma, &amp;quot;Arial sans-serif&amp;quot;; text-align: justify; white-space: normal; background-color: rgb(255, 255, 255);&quot;&gt;人机交互（HCI，Human Computer Interaciton）所关注的主要是数字界面，即过去的打孔机、命令行，直至今天的图形界面（GUI，Graphic Design）。&lt;/p&gt;&lt;p style=&quot;margin-top: 0px; margin-bottom: 24px; color: rgb(14, 14, 14); font-family: Arial, &amp;quot;Hiragino Sans GB&amp;quot;, 冬青黑, &amp;quot;Microsoft YaHei&amp;quot;, 微软雅黑, SimSun, 宋体, Helvetica, Tahoma, &amp;quot;Arial sans-serif&amp;quot;; text-align: justify; white-space: normal; background-color: rgb(255, 255, 255);&quot;&gt;用户界面设计对于数码产品来说主要关注的是布局、信息结构，以及界面元素在显示屏和各种终端平台上的展示。电子游戏和电视界面也包括其中。&lt;/p&gt;&lt;p&gt;&lt;br/&gt;&lt;/p&gt;', '1526552582', '1531711820');
INSERT INTO `ey_article_content` VALUES ('15', '39', '&lt;p style=&quot;margin-top: 0px; margin-bottom: 32px; padding: 0px; text-align: justify; font-family: &amp;quot;Open Sans&amp;quot;, Arial, &amp;quot;Hiragino Sans GB&amp;quot;, &amp;quot;Microsoft YaHei&amp;quot;, 微软雅黑, STHeiti, &amp;quot;WenQuanYi Micro Hei&amp;quot;, SimSun, sans-serif, sans-serif; font-size: 18px; white-space: normal; background-color: rgb(255, 255, 255);&quot;&gt;对于记忆来说，味道往往是最美的，儿时喝过的饮料，至今回想起来依然觉得津津有味。&lt;br/&gt;&lt;/p&gt;&lt;p style=&quot;margin-top: 0px; margin-bottom: 32px; padding: 0px; text-align: justify; font-family: &amp;quot;Open Sans&amp;quot;, Arial, &amp;quot;Hiragino Sans GB&amp;quot;, &amp;quot;Microsoft YaHei&amp;quot;, 微软雅黑, STHeiti, &amp;quot;WenQuanYi Micro Hei&amp;quot;, SimSun, sans-serif, sans-serif; font-size: 18px; white-space: normal; background-color: rgb(255, 255, 255);&quot;&gt;今天是六一儿童节，青山资本梳理了中国40年来饮料发展的简史，权当节日的小消遣，顺便看看能否找到你记忆深处的那个味道？&lt;/p&gt;&lt;h2 style=&quot;margin: 0px; padding: 0px; font-size: 16px; font-family: &amp;quot;Open Sans&amp;quot;, Arial, &amp;quot;Hiragino Sans GB&amp;quot;, &amp;quot;Microsoft YaHei&amp;quot;, 微软雅黑, STHeiti, &amp;quot;WenQuanYi Micro Hei&amp;quot;, SimSun, sans-serif, sans-serif; white-space: normal; background-color: rgb(255, 255, 255);&quot;&gt;第一阶段：国人味蕾的开启时代&lt;/h2&gt;&lt;p style=&quot;margin-top: 0px; margin-bottom: 32px; padding: 0px; text-align: justify; font-family: &amp;quot;Open Sans&amp;quot;, Arial, &amp;quot;Hiragino Sans GB&amp;quot;, &amp;quot;Microsoft YaHei&amp;quot;, 微软雅黑, STHeiti, &amp;quot;WenQuanYi Micro Hei&amp;quot;, SimSun, sans-serif, sans-serif; font-size: 18px; white-space: normal; background-color: rgb(255, 255, 255);&quot;&gt;&lt;br/&gt;&lt;/p&gt;&lt;p style=&quot;margin-top: 0px; margin-bottom: 32px; padding: 0px; text-align: justify; font-family: &amp;quot;Open Sans&amp;quot;, Arial, &amp;quot;Hiragino Sans GB&amp;quot;, &amp;quot;Microsoft YaHei&amp;quot;, 微软雅黑, STHeiti, &amp;quot;WenQuanYi Micro Hei&amp;quot;, SimSun, sans-serif, sans-serif; font-size: 18px; white-space: normal; background-color: rgb(255, 255, 255);&quot;&gt;百事可乐在华第一家工厂开业&lt;/p&gt;&lt;p style=&quot;margin-top: 0px; margin-bottom: 32px; padding: 0px; text-align: justify; font-family: &amp;quot;Open Sans&amp;quot;, Arial, &amp;quot;Hiragino Sans GB&amp;quot;, &amp;quot;Microsoft YaHei&amp;quot;, 微软雅黑, STHeiti, &amp;quot;WenQuanYi Micro Hei&amp;quot;, SimSun, sans-serif, sans-serif; font-size: 18px; white-space: normal; background-color: rgb(255, 255, 255);&quot;&gt;1981年，可口可乐在中国第一条生产线正式投产，主要供应旅游饭店，卖给外国人收取外汇，百事可乐也在深圳建立了第一家罐装厂。&lt;/p&gt;&lt;p style=&quot;margin-top: 0px; margin-bottom: 32px; padding: 0px; text-align: justify; font-family: &amp;quot;Open Sans&amp;quot;, Arial, &amp;quot;Hiragino Sans GB&amp;quot;, &amp;quot;Microsoft YaHei&amp;quot;, 微软雅黑, STHeiti, &amp;quot;WenQuanYi Micro Hei&amp;quot;, SimSun, sans-serif, sans-serif; font-size: 18px; white-space: normal; background-color: rgb(255, 255, 255);&quot;&gt;1982年，国家把饮料纳入“国家计划管理产品”，可口可乐开始在北京市场进行内销。&lt;/p&gt;&lt;p&gt;&lt;br/&gt;&lt;/p&gt;', '1527824652', '1531709817');
INSERT INTO `ey_article_content` VALUES ('16', '40', '&lt;p style=&quot;margin-top: 0px; margin-bottom: 32px; padding: 0px; text-align: justify; font-family: &amp;quot;Open Sans&amp;quot;, Arial, &amp;quot;Hiragino Sans GB&amp;quot;, &amp;quot;Microsoft YaHei&amp;quot;, 微软雅黑, STHeiti, &amp;quot;WenQuanYi Micro Hei&amp;quot;, SimSun, sans-serif, sans-serif; font-size: 18px; white-space: normal; background-color: rgb(255, 255, 255);&quot;&gt;约翰·奎尔奇说， 社交媒体有很多营销挑战，如何为粉丝来估值是一个大问题。从营销角度来思考，要关注强纽带和弱纽带。你可能以为，强纽带的密友产生最大的营销影响，研究发现不是这样的，产生更大的影响反而是跟你更疏远的人。&lt;/p&gt;&lt;p&gt;&lt;span style=&quot;font-family: &amp;quot;Open Sans&amp;quot;, Arial, &amp;quot;Hiragino Sans GB&amp;quot;, &amp;quot;Microsoft YaHei&amp;quot;, 微软雅黑, STHeiti, &amp;quot;WenQuanYi Micro Hei&amp;quot;, SimSun, sans-serif, sans-serif; font-size: 18px; background-color: rgb(255, 255, 255);&quot;&gt;演讲者｜ 约翰·奎尔奇&lt;/span&gt;&lt;/p&gt;&lt;p style=&quot;margin-top: 0px; margin-bottom: 32px; padding: 0px; text-align: justify; font-family: &amp;quot;Open Sans&amp;quot;, Arial, &amp;quot;Hiragino Sans GB&amp;quot;, &amp;quot;Microsoft YaHei&amp;quot;, 微软雅黑, STHeiti, &amp;quot;WenQuanYi Micro Hei&amp;quot;, SimSun, sans-serif, sans-serif; font-size: 18px; white-space: normal; background-color: rgb(255, 255, 255);&quot;&gt;（ 哈佛商学院教授， 曾任伦敦商学院院长、中欧国际工商学院副院长）&lt;/p&gt;&lt;p style=&quot;margin-top: 0px; margin-bottom: 32px; padding: 0px; text-align: justify; font-family: &amp;quot;Open Sans&amp;quot;, Arial, &amp;quot;Hiragino Sans GB&amp;quot;, &amp;quot;Microsoft YaHei&amp;quot;, 微软雅黑, STHeiti, &amp;quot;WenQuanYi Micro Hei&amp;quot;, SimSun, sans-serif, sans-serif; font-size: 18px; white-space: normal; background-color: rgb(255, 255, 255);&quot;&gt;非常感谢大家在周日早上回来听我讲课。对于你们这些创业者，或者希望成为创业者的人，我今天准备了一个特别的讲座。&lt;/p&gt;&lt;p style=&quot;margin-top: 0px; margin-bottom: 32px; padding: 0px; text-align: justify; font-family: &amp;quot;Open Sans&amp;quot;, Arial, &amp;quot;Hiragino Sans GB&amp;quot;, &amp;quot;Microsoft YaHei&amp;quot;, 微软雅黑, STHeiti, &amp;quot;WenQuanYi Micro Hei&amp;quot;, SimSun, sans-serif, sans-serif; font-size: 18px; white-space: normal; background-color: rgb(255, 255, 255);&quot;&gt;很多创业者没有把最终愿景很好界定，所以每天都忙于灭火，忙于生存。&lt;/p&gt;&lt;p&gt;&lt;strong style=&quot;font-family: &amp;quot;Open Sans&amp;quot;, Arial, &amp;quot;Hiragino Sans GB&amp;quot;, &amp;quot;Microsoft YaHei&amp;quot;, 微软雅黑, STHeiti, &amp;quot;WenQuanYi Micro Hei&amp;quot;, SimSun, sans-serif, sans-serif; font-size: 18px; white-space: normal; background-color: rgb(255, 255, 255);&quot;&gt;创业营销，你必须做好规划&lt;/strong&gt;&lt;/p&gt;&lt;p style=&quot;margin-top: 0px; margin-bottom: 32px; padding: 0px; text-align: justify; font-family: &amp;quot;Open Sans&amp;quot;, Arial, &amp;quot;Hiragino Sans GB&amp;quot;, &amp;quot;Microsoft YaHei&amp;quot;, 微软雅黑, STHeiti, &amp;quot;WenQuanYi Micro Hei&amp;quot;, SimSun, sans-serif, sans-serif; font-size: 18px; white-space: normal; background-color: rgb(255, 255, 255);&quot;&gt;今天将从创业营销这个话题开始，包括你如何生存和成功。创业营销包括四个关键领域，你必须很好地去规划：&lt;/p&gt;&lt;ul style=&quot;list-style-type: inherit;&quot; class=&quot; list-paddingleft-2&quot;&gt;&lt;li&gt;&lt;p style=&quot;margin-top: 0px; margin-bottom: 0px; padding: 0px;&quot;&gt;要有正确的目标客户和最终用户；&lt;/p&gt;&lt;/li&gt;&lt;li&gt;&lt;p style=&quot;margin-top: 0px; margin-bottom: 0px; padding: 0px;&quot;&gt;要有正确的产品和服务&lt;/p&gt;&lt;/li&gt;&lt;li&gt;&lt;p style=&quot;margin-top: 0px; margin-bottom: 0px; padding: 0px;&quot;&gt;要有一个非常好的人才团队，使得商业创意能够实现；&lt;/p&gt;&lt;/li&gt;&lt;li&gt;&lt;p style=&quot;margin-top: 0px; margin-bottom: 0px; padding: 0px;&quot;&gt;要有好的合作伙伴，不是分销商，而是会计、律师等服务伙伴。&lt;/p&gt;&lt;/li&gt;&lt;/ul&gt;&lt;p style=&quot;margin-top: 0px; margin-bottom: 32px; padding: 0px; text-align: justify; font-family: &amp;quot;Open Sans&amp;quot;, Arial, &amp;quot;Hiragino Sans GB&amp;quot;, &amp;quot;Microsoft YaHei&amp;quot;, 微软雅黑, STHeiti, &amp;quot;WenQuanYi Micro Hei&amp;quot;, SimSun, sans-serif, sans-serif; font-size: 18px; white-space: normal; background-color: rgb(255, 255, 255);&quot;&gt;&lt;strong&gt;那么，何为创业营销？ ？&lt;/strong&gt;&lt;/p&gt;&lt;p style=&quot;margin-top: 0px; margin-bottom: 32px; padding: 0px; text-align: justify; font-family: &amp;quot;Open Sans&amp;quot;, Arial, &amp;quot;Hiragino Sans GB&amp;quot;, &amp;quot;Microsoft YaHei&amp;quot;, 微软雅黑, STHeiti, &amp;quot;WenQuanYi Micro Hei&amp;quot;, SimSun, sans-serif, sans-serif; font-size: 18px; white-space: normal; background-color: rgb(255, 255, 255);&quot;&gt;第一，这是从愿景到行动的逆向工程设计&lt;/p&gt;&lt;p style=&quot;margin-top: 0px; margin-bottom: 32px; padding: 0px; text-align: justify; font-family: &amp;quot;Open Sans&amp;quot;, Arial, &amp;quot;Hiragino Sans GB&amp;quot;, &amp;quot;Microsoft YaHei&amp;quot;, 微软雅黑, STHeiti, &amp;quot;WenQuanYi Micro Hei&amp;quot;, SimSun, sans-serif, sans-serif; font-size: 18px; white-space: normal; background-color: rgb(255, 255, 255);&quot;&gt;当星巴克只有 5 家店时，创始人就有一个愿景，让星巴克成为你生活中的第三空间。&lt;/p&gt;&lt;p style=&quot;margin-top: 0px; margin-bottom: 32px; padding: 0px; text-align: justify; font-family: &amp;quot;Open Sans&amp;quot;, Arial, &amp;quot;Hiragino Sans GB&amp;quot;, &amp;quot;Microsoft YaHei&amp;quot;, 微软雅黑, STHeiti, &amp;quot;WenQuanYi Micro Hei&amp;quot;, SimSun, sans-serif, sans-serif; font-size: 18px; white-space: normal; background-color: rgb(255, 255, 255);&quot;&gt;对创业者要从愿景开始，向后进行逆向工程的设计：看一下需要有什么样的行动，才能实现愿景。 很多创业者没有把最终愿景很好界定，所以每天都忙于灭火，忙于生存。&lt;/p&gt;&lt;p style=&quot;margin-top: 0px; margin-bottom: 32px; padding: 0px; text-align: justify; font-family: &amp;quot;Open Sans&amp;quot;, Arial, &amp;quot;Hiragino Sans GB&amp;quot;, &amp;quot;Microsoft YaHei&amp;quot;, 微软雅黑, STHeiti, &amp;quot;WenQuanYi Micro Hei&amp;quot;, SimSun, sans-serif, sans-serif; font-size: 18px; white-space: normal; background-color: rgb(255, 255, 255);&quot;&gt;第二，快速的周期，低成本进行试验，以提供证据&lt;/p&gt;&lt;p style=&quot;margin-top: 0px; margin-bottom: 32px; padding: 0px; text-align: justify; font-family: &amp;quot;Open Sans&amp;quot;, Arial, &amp;quot;Hiragino Sans GB&amp;quot;, &amp;quot;Microsoft YaHei&amp;quot;, 微软雅黑, STHeiti, &amp;quot;WenQuanYi Micro Hei&amp;quot;, SimSun, sans-serif, sans-serif; font-size: 18px; white-space: normal; background-color: rgb(255, 255, 255);&quot;&gt;有了愿景要去思考，怎样做一些快速的低成本实验测试创意，向合作伙伴、客户等证明，这是一个非常好的愿景。换句话说， 你需要短期的成就作为证据。&lt;/p&gt;&lt;p style=&quot;margin-top: 0px; margin-bottom: 32px; padding: 0px; text-align: justify; font-family: &amp;quot;Open Sans&amp;quot;, Arial, &amp;quot;Hiragino Sans GB&amp;quot;, &amp;quot;Microsoft YaHei&amp;quot;, 微软雅黑, STHeiti, &amp;quot;WenQuanYi Micro Hei&amp;quot;, SimSun, sans-serif, sans-serif; font-size: 18px; white-space: normal; background-color: rgb(255, 255, 255);&quot;&gt;第三，与高瞻远瞩的客户共同开发&lt;/p&gt;&lt;p style=&quot;margin-top: 0px; margin-bottom: 32px; padding: 0px; text-align: justify; font-family: &amp;quot;Open Sans&amp;quot;, Arial, &amp;quot;Hiragino Sans GB&amp;quot;, &amp;quot;Microsoft YaHei&amp;quot;, 微软雅黑, STHeiti, &amp;quot;WenQuanYi Micro Hei&amp;quot;, SimSun, sans-serif, sans-serif; font-size: 18px; white-space: normal; background-color: rgb(255, 255, 255);&quot;&gt;大多数的客户是保守的，不想浪费时间在新公司上。 你必须要找到有远见的客户，他们愿意在你身上冒风险。 他们可能是小的新兴客户，不是你想要进入的那个市场的好根基客户。&lt;/p&gt;&lt;p style=&quot;margin-top: 0px; margin-bottom: 32px; padding: 0px; text-align: justify; font-family: &amp;quot;Open Sans&amp;quot;, Arial, &amp;quot;Hiragino Sans GB&amp;quot;, &amp;quot;Microsoft YaHei&amp;quot;, 微软雅黑, STHeiti, &amp;quot;WenQuanYi Micro Hei&amp;quot;, SimSun, sans-serif, sans-serif; font-size: 18px; white-space: normal; background-color: rgb(255, 255, 255);&quot;&gt;第四：创建小步快跑的综合路线图&lt;/p&gt;&lt;p style=&quot;margin-top: 0px; margin-bottom: 32px; padding: 0px; text-align: justify; font-family: &amp;quot;Open Sans&amp;quot;, Arial, &amp;quot;Hiragino Sans GB&amp;quot;, &amp;quot;Microsoft YaHei&amp;quot;, 微软雅黑, STHeiti, &amp;quot;WenQuanYi Micro Hei&amp;quot;, SimSun, sans-serif, sans-serif; font-size: 18px; white-space: normal; background-color: rgb(255, 255, 255);&quot;&gt;包括创建产品路线图、客户图、合作伙伴路线图、人才路线图。 创业者应该有一个长达一年甚至三年的路线图，看下你希望这个公司在这四个维度上应该怎么样取得进步。&lt;/p&gt;&lt;p style=&quot;margin-top: 0px; margin-bottom: 32px; padding: 0px; text-align: justify; font-family: &amp;quot;Open Sans&amp;quot;, Arial, &amp;quot;Hiragino Sans GB&amp;quot;, &amp;quot;Microsoft YaHei&amp;quot;, 微软雅黑, STHeiti, &amp;quot;WenQuanYi Micro Hei&amp;quot;, SimSun, sans-serif, sans-serif; font-size: 18px; white-space: normal; background-color: rgb(255, 255, 255);&quot;&gt;&lt;strong&gt;举个例子&lt;/strong&gt;&lt;/p&gt;&lt;p style=&quot;margin-top: 0px; margin-bottom: 32px; padding: 0px; text-align: justify; font-family: &amp;quot;Open Sans&amp;quot;, Arial, &amp;quot;Hiragino Sans GB&amp;quot;, &amp;quot;Microsoft YaHei&amp;quot;, 微软雅黑, STHeiti, &amp;quot;WenQuanYi Micro Hei&amp;quot;, SimSun, sans-serif, sans-serif; font-size: 18px; white-space: normal; background-color: rgb(255, 255, 255);&quot;&gt;上世纪 90 年代末， John Osher 发明了 SpinBrush ，这是一个低成本的电动牙刷。因为 他洞察到市场上存在着一个很大的空白：普通手动牙刷每支两美元，电动牙刷要 50 美元。 但是这两者之间，没有任何中间产品。&lt;/p&gt;&lt;p style=&quot;margin-top: 0px; margin-bottom: 32px; padding: 0px; text-align: justify; font-family: &amp;quot;Open Sans&amp;quot;, Arial, &amp;quot;Hiragino Sans GB&amp;quot;, &amp;quot;Microsoft YaHei&amp;quot;, 微软雅黑, STHeiti, &amp;quot;WenQuanYi Micro Hei&amp;quot;, SimSun, sans-serif, sans-serif; font-size: 18px; white-space: normal; background-color: rgb(255, 255, 255);&quot;&gt;他想开发一个牙刷，价格介于两者之间。他思考了下新牙刷成功的性能标准：&lt;/p&gt;&lt;ul style=&quot;list-style-type: inherit;&quot; class=&quot; list-paddingleft-2&quot;&gt;&lt;li&gt;&lt;p style=&quot;margin-top: 0px; margin-bottom: 0px; padding: 0px;&quot;&gt;清洁上要优于手动牙刷，不然消费者不会付出更高的价格；&lt;/p&gt;&lt;/li&gt;&lt;li&gt;&lt;p style=&quot;margin-top: 0px; margin-bottom: 0px; padding: 0px;&quot;&gt;自带电池能用三个月，如果每周都要换电池太崩溃；&lt;/p&gt;&lt;/li&gt;&lt;li&gt;&lt;p style=&quot;margin-top: 0px; margin-bottom: 0px; padding: 0px;&quot;&gt;包装中有试用的特点，大家愿意看看牙刷启动后是怎么旋转的；&lt;/p&gt;&lt;/li&gt;&lt;li&gt;&lt;p style=&quot;margin-top: 0px; margin-bottom: 0px; padding: 0px;&quot;&gt;零售价不到 6 美元。&lt;/p&gt;&lt;/li&gt;&lt;/ul&gt;&lt;p style=&quot;margin-top: 0px; margin-bottom: 32px; padding: 0px; text-align: justify; font-family: &amp;quot;Open Sans&amp;quot;, Arial, &amp;quot;Hiragino Sans GB&amp;quot;, &amp;quot;Microsoft YaHei&amp;quot;, 微软雅黑, STHeiti, &amp;quot;WenQuanYi Micro Hei&amp;quot;, SimSun, sans-serif, sans-serif; font-size: 18px; white-space: normal; background-color: rgb(255, 255, 255);&quot;&gt;他对新牙刷的定位是：是更好的手动牙刷，而不是一个更便宜的电动牙刷。&lt;/p&gt;&lt;p style=&quot;margin-top: 0px; margin-bottom: 32px; padding: 0px; text-align: justify; font-family: &amp;quot;Open Sans&amp;quot;, Arial, &amp;quot;Hiragino Sans GB&amp;quot;, &amp;quot;Microsoft YaHei&amp;quot;, 微软雅黑, STHeiti, &amp;quot;WenQuanYi Micro Hei&amp;quot;, SimSun, sans-serif, sans-serif; font-size: 18px; white-space: normal; background-color: rgb(255, 255, 255);&quot;&gt;对于消费者，是从 2 美元增加到 6 美元，而不是从 50 美元降到 6 美元。因为如果是后者，零售商会觉得赔了：消费者只花了6美元，而以前是50美元。但是现在，消费者从花2块提高到了花6块。&lt;/p&gt;&lt;p style=&quot;margin-top: 0px; margin-bottom: 32px; padding: 0px; text-align: justify; font-family: &amp;quot;Open Sans&amp;quot;, Arial, &amp;quot;Hiragino Sans GB&amp;quot;, &amp;quot;Microsoft YaHei&amp;quot;, 微软雅黑, STHeiti, &amp;quot;WenQuanYi Micro Hei&amp;quot;, SimSun, sans-serif, sans-serif; font-size: 18px; white-space: normal; background-color: rgb(255, 255, 255);&quot;&gt;所以创业者不仅要考虑最终用户，还要思考如何让分销商多赚钱，因为你必须通过他们，产品才能到最终客户那里。 界定竞争的时候，好的定位声明非常重要。 最后，他把公司卖给了 宝洁，一共赚了4.8亿美元。&lt;/p&gt;&lt;p style=&quot;margin-top: 0px; margin-bottom: 32px; padding: 0px; text-align: justify; font-family: &amp;quot;Open Sans&amp;quot;, Arial, &amp;quot;Hiragino Sans GB&amp;quot;, &amp;quot;Microsoft YaHei&amp;quot;, 微软雅黑, STHeiti, &amp;quot;WenQuanYi Micro Hei&amp;quot;, SimSun, sans-serif, sans-serif; font-size: 18px; white-space: normal; background-color: rgb(255, 255, 255);&quot;&gt;大家看，其实非常简单，就是因为他有大量的消费者洞察，填补了没有任何人看见的市场空白。&lt;/p&gt;&lt;p style=&quot;margin-top: 0px; margin-bottom: 32px; padding: 0px; text-align: justify; font-family: &amp;quot;Open Sans&amp;quot;, Arial, &amp;quot;Hiragino Sans GB&amp;quot;, &amp;quot;Microsoft YaHei&amp;quot;, 微软雅黑, STHeiti, &amp;quot;WenQuanYi Micro Hei&amp;quot;, SimSun, sans-serif, sans-serif; font-size: 18px; white-space: normal; background-color: rgb(255, 255, 255);&quot;&gt;&lt;strong&gt;再举个例子&lt;/strong&gt;&lt;/p&gt;&lt;p style=&quot;margin-top: 0px; margin-bottom: 32px; padding: 0px; text-align: justify; font-family: &amp;quot;Open Sans&amp;quot;, Arial, &amp;quot;Hiragino Sans GB&amp;quot;, &amp;quot;Microsoft YaHei&amp;quot;, 微软雅黑, STHeiti, &amp;quot;WenQuanYi Micro Hei&amp;quot;, SimSun, sans-serif, sans-serif; font-size: 18px; white-space: normal; background-color: rgb(255, 255, 255);&quot;&gt;这家公司叫 Intuit ，创始人在20年前就发现，好多人在应对自己税务处理的时候，每年要填一个纳税申报单再交给政府，很麻烦。&lt;/p&gt;&lt;p style=&quot;margin-top: 0px; margin-bottom: 32px; padding: 0px; text-align: justify; font-family: &amp;quot;Open Sans&amp;quot;, Arial, &amp;quot;Hiragino Sans GB&amp;quot;, &amp;quot;Microsoft YaHei&amp;quot;, 微软雅黑, STHeiti, &amp;quot;WenQuanYi Micro Hei&amp;quot;, SimSun, sans-serif, sans-serif; font-size: 18px; white-space: normal; background-color: rgb(255, 255, 255);&quot;&gt;Intuit 是第一个开发个人理财软件的公司，尤其是做纳税管理方面的软件，不管是个人还是小企业都可以用。 但是这个好用的软件包，不知道卖向哪里，没人相信它能用。&lt;/p&gt;&lt;p style=&quot;margin-top: 0px; margin-bottom: 32px; padding: 0px; text-align: justify; font-family: &amp;quot;Open Sans&amp;quot;, Arial, &amp;quot;Hiragino Sans GB&amp;quot;, &amp;quot;Microsoft YaHei&amp;quot;, 微软雅黑, STHeiti, &amp;quot;WenQuanYi Micro Hei&amp;quot;, SimSun, sans-serif, sans-serif; font-size: 18px; white-space: normal; background-color: rgb(255, 255, 255);&quot;&gt;有时候你最大的问题就是，你的新产品如何把分销商搞定。他们分销很多东西，根本没时间花五小时检查你这个不知名的产品能不能用。&lt;/p&gt;&lt;p style=&quot;margin-top: 0px; margin-bottom: 32px; padding: 0px; text-align: justify; font-family: &amp;quot;Open Sans&amp;quot;, Arial, &amp;quot;Hiragino Sans GB&amp;quot;, &amp;quot;Microsoft YaHei&amp;quot;, 微软雅黑, STHeiti, &amp;quot;WenQuanYi Micro Hei&amp;quot;, SimSun, sans-serif, sans-serif; font-size: 18px; white-space: normal; background-color: rgb(255, 255, 255);&quot;&gt;最后他直接向消费者保证： 如果买了这个产品，六分钟内没学会怎么用，钱退给你，产品也送给你。&lt;/p&gt;&lt;p style=&quot;margin-top: 0px; margin-bottom: 32px; padding: 0px; text-align: justify; font-family: &amp;quot;Open Sans&amp;quot;, Arial, &amp;quot;Hiragino Sans GB&amp;quot;, &amp;quot;Microsoft YaHei&amp;quot;, 微软雅黑, STHeiti, &amp;quot;WenQuanYi Micro Hei&amp;quot;, SimSun, sans-serif, sans-serif; font-size: 18px; white-space: normal; background-color: rgb(255, 255, 255);&quot;&gt;除了退钱，他们还做了什么与众不同的事情呢？&lt;/p&gt;&lt;ul style=&quot;list-style-type: inherit;&quot; class=&quot; list-paddingleft-2&quot;&gt;&lt;li&gt;&lt;p style=&quot;margin-top: 0px; margin-bottom: 0px; padding: 0px;&quot;&gt;在买家允许下，跟着买家观察他的首次使用过程。&lt;/p&gt;&lt;/li&gt;&lt;li&gt;&lt;p style=&quot;margin-top: 0px; margin-bottom: 0px; padding: 0px;&quot;&gt;公司所有高管每个月必须花两小时做客户的技术支持，听客户遇到的问题；&lt;/p&gt;&lt;/li&gt;&lt;li&gt;&lt;p style=&quot;margin-top: 0px; margin-bottom: 0px; padding: 0px;&quot;&gt;做客户服务的技术支持，是公司里晋升的必经路径；&lt;/p&gt;&lt;/li&gt;&lt;li&gt;&lt;p style=&quot;margin-top: 0px; margin-bottom: 0px; padding: 0px;&quot;&gt;把客户的信当着所有高管的面大声朗读，不管是感谢还是指责。&lt;/p&gt;&lt;/li&gt;&lt;/ul&gt;&lt;p style=&quot;margin-top: 0px; margin-bottom: 32px; padding: 0px; text-align: justify; font-family: &amp;quot;Open Sans&amp;quot;, Arial, &amp;quot;Hiragino Sans GB&amp;quot;, &amp;quot;Microsoft YaHei&amp;quot;, 微软雅黑, STHeiti, &amp;quot;WenQuanYi Micro Hei&amp;quot;, SimSun, sans-serif, sans-serif; font-size: 18px; white-space: normal; background-color: rgb(255, 255, 255);&quot;&gt;这使得他们 50% 的销售是来自于口碑， 20% 的销售是来自于技术支持的推荐。&lt;/p&gt;&lt;p style=&quot;margin-top: 0px; margin-bottom: 32px; padding: 0px; text-align: justify; font-family: &amp;quot;Open Sans&amp;quot;, Arial, &amp;quot;Hiragino Sans GB&amp;quot;, &amp;quot;Microsoft YaHei&amp;quot;, 微软雅黑, STHeiti, &amp;quot;WenQuanYi Micro Hei&amp;quot;, SimSun, sans-serif, sans-serif; font-size: 18px; white-space: normal; background-color: rgb(255, 255, 255);&quot;&gt;&lt;em&gt;“ 客户真正想要的和技术真正能做好的交叉点 —— 在此处才能找到真正的伟大。 ”&lt;/em&gt;&lt;/p&gt;&lt;p style=&quot;margin-top: 0px; margin-bottom: 32px; padding: 0px; text-align: justify; font-family: &amp;quot;Open Sans&amp;quot;, Arial, &amp;quot;Hiragino Sans GB&amp;quot;, &amp;quot;Microsoft YaHei&amp;quot;, 微软雅黑, STHeiti, &amp;quot;WenQuanYi Micro Hei&amp;quot;, SimSun, sans-serif, sans-serif; font-size: 18px; white-space: normal; background-color: rgb(255, 255, 255);&quot;&gt;&lt;em&gt;“ 我们不管做什么，都是有客户存在的。 ”&lt;/em&gt;&lt;/p&gt;&lt;p style=&quot;margin-top: 0px; margin-bottom: 32px; padding: 0px; text-align: justify; font-family: &amp;quot;Open Sans&amp;quot;, Arial, &amp;quot;Hiragino Sans GB&amp;quot;, &amp;quot;Microsoft YaHei&amp;quot;, 微软雅黑, STHeiti, &amp;quot;WenQuanYi Micro Hei&amp;quot;, SimSun, sans-serif, sans-serif; font-size: 18px; white-space: normal; background-color: rgb(255, 255, 255);&quot;&gt;&lt;em&gt;——ScottCook（ Intuit创始人）&lt;/em&gt;&lt;/p&gt;&lt;p&gt;&lt;br/&gt;&lt;/p&gt;', '1527824837', '1531876546');
INSERT INTO `ey_article_content` VALUES ('17', '41', '&lt;p style=&quot;margin-top: 0px; margin-bottom: 32px; padding: 0px; text-align: justify; font-family: &amp;quot;Open Sans&amp;quot;, Arial, &amp;quot;Hiragino Sans GB&amp;quot;, &amp;quot;Microsoft YaHei&amp;quot;, 微软雅黑, STHeiti, &amp;quot;WenQuanYi Micro Hei&amp;quot;, SimSun, sans-serif, sans-serif; font-size: 18px; white-space: normal; background-color: rgb(255, 255, 255);&quot;&gt;各种行销手段早已令人眼花缭乱，但究其本质都是在研究客户（消费者），研究客户的所想、所需，使产品或服务有的放矢。大数据时代又给它赋予了新名词：精准营销。大数据最先应用的领域多为面对客户的行业，最先应用的情景也多为精准营销。&lt;/p&gt;&lt;p style=&quot;margin-top: 0px; margin-bottom: 32px; padding: 0px; text-align: justify; font-family: &amp;quot;Open Sans&amp;quot;, Arial, &amp;quot;Hiragino Sans GB&amp;quot;, &amp;quot;Microsoft YaHei&amp;quot;, 微软雅黑, STHeiti, &amp;quot;WenQuanYi Micro Hei&amp;quot;, SimSun, sans-serif, sans-serif; font-size: 18px; white-space: normal; background-color: rgb(255, 255, 255);&quot;&gt;“酒好也怕巷子深”，产品或服务的信息要送达客户才可能促成交易。一般认为，向客户传达产品或服务信息要靠广告。广告古已有之，“三碗不过岗”的酒幌子就是广告。没有互联网的时代，我们熟悉的是电视广告、广播广告、印刷品平面广告、户外广告牌等，当然，也包括吆喝叫卖。但过去的广告是千人一面、不区分受众的。后来商家对客户的信息有所采集就有了CRM，经过客户分类，可以更好地服务于不同的客户群体。互联网+大数据时代让CRM有了新的发展机遇，管理客户不再是简单的数字统计和没有个性的（或简单聚类的）直邮、定投。随着商家对客户知道更多、了解更深，便有机会为客户提供个性化的营销方案，进一步改善客户体验，成为了个性化营销或叫精准营销。大数据时代，让很多过去的不可能变为可能，营销活动也赢来了新的发展机遇。&lt;/p&gt;&lt;p style=&quot;margin-top: 0px; margin-bottom: 32px; padding: 0px; text-align: justify; font-family: &amp;quot;Open Sans&amp;quot;, Arial, &amp;quot;Hiragino Sans GB&amp;quot;, &amp;quot;Microsoft YaHei&amp;quot;, 微软雅黑, STHeiti, &amp;quot;WenQuanYi Micro Hei&amp;quot;, SimSun, sans-serif, sans-serif; font-size: 18px; white-space: normal; background-color: rgb(255, 255, 255);&quot;&gt;时代不同，商业经营的形式会变化，但本质就是两件事：开源，节流。开源是开拓新客户，发现新商机；节流是减少内部运营成本，提高资源利用效率。要实现这一切都需要以数据为依据的决策。过去，人们也在长期的经营活动中，采集和运用了与经营活动相关的很多强相关数据，也形成了选择客户的标准。鉴于当时的技术瓶颈，做大样本的数据采集及数据分析成本都过高，无法在更大范围推广运用。大数据时代，人们有了廉价采集数据和存储数据的可能，廉价的计算资源让数据分析成为了可能。&lt;/p&gt;&lt;p style=&quot;margin-top: 0px; margin-bottom: 32px; padding: 0px; text-align: justify; font-family: &amp;quot;Open Sans&amp;quot;, Arial, &amp;quot;Hiragino Sans GB&amp;quot;, &amp;quot;Microsoft YaHei&amp;quot;, 微软雅黑, STHeiti, &amp;quot;WenQuanYi Micro Hei&amp;quot;, SimSun, sans-serif, sans-serif; font-size: 18px; white-space: normal; background-color: rgb(255, 255, 255);&quot;&gt;大数据精准营销的背后，是用多维度的数据来观察客户，描述客户，就是说为客户画像。说“依托大数据，可以让营销人员比过去更了解客户，比客户自己更了解客户的需求”并不为过。营销人员无不想知道客户是谁、在哪里、消费习惯是什么、需要什么、什么时候需要、用什么方式向他们传递信息更为有效等等，通过数据采集和数据分析分析可以找到答案。精准营销不仅可以帮助商家开源---发现潜在客户，还可以帮助商家节流---发现潜在风险。当我们对客户了解更多，就会知道哪位客户可能在经营中存在风险。&lt;/p&gt;&lt;p style=&quot;margin-top: 0px; margin-bottom: 32px; padding: 0px; text-align: justify; font-family: &amp;quot;Open Sans&amp;quot;, Arial, &amp;quot;Hiragino Sans GB&amp;quot;, &amp;quot;Microsoft YaHei&amp;quot;, 微软雅黑, STHeiti, &amp;quot;WenQuanYi Micro Hei&amp;quot;, SimSun, sans-serif, sans-serif; font-size: 18px; white-space: normal; background-color: rgb(255, 255, 255);&quot;&gt;若问每个经营者是否会运用从业经验来进行营销，多数答案是肯定的。但若问经营者是否会利用数据进行营销，恐怕答案就是五花八门。一般认为，应用数据进行营销是大公司的事情，与小公司无缘。其实，大到跨国公司，小到街边小贩，运用数据进行营销，都会收到意想不到的结果。不相信吗？街边小贩留意一下天气预报（刮风，下雨，还是暴晒）就知道明天有哪些生意的机会，进而知道该如何备货。建议中小公司的人不要拒绝精准营销的理念，不妨学学精准营销的思想方法。即便是经营者有丰富的经验，把经验数据化对经营也会很有帮助。&lt;/p&gt;&lt;p style=&quot;margin-top: 0px; margin-bottom: 32px; padding: 0px; text-align: justify; font-family: &amp;quot;Open Sans&amp;quot;, Arial, &amp;quot;Hiragino Sans GB&amp;quot;, &amp;quot;Microsoft YaHei&amp;quot;, 微软雅黑, STHeiti, &amp;quot;WenQuanYi Micro Hei&amp;quot;, SimSun, sans-serif, sans-serif; font-size: 18px; white-space: normal; background-color: rgb(255, 255, 255);&quot;&gt;《颠覆营销》一书就是在教读者如何运用大数据来做营销。书中案例丰富、语言可读性强。值得关心大数据营销的各界朋友读一读。&lt;/p&gt;&lt;p style=&quot;margin-top: 0px; margin-bottom: 32px; padding: 0px; text-align: justify; font-family: &amp;quot;Open Sans&amp;quot;, Arial, &amp;quot;Hiragino Sans GB&amp;quot;, &amp;quot;Microsoft YaHei&amp;quot;, 微软雅黑, STHeiti, &amp;quot;WenQuanYi Micro Hei&amp;quot;, SimSun, sans-serif, sans-serif; font-size: 18px; white-space: normal; background-color: rgb(255, 255, 255);&quot;&gt;我认同书中的不少观点：“大数据重新定义产业竞争规则，比的不是数据规模大小，不是统计技术，也不是强大的计算能力，而是核心数据的解读能力”。在很多人纠结于大数据定义的今天，我们确实更应该关注数据的核心价值理解与应用。书中提出的“问对问题”也很重要。经营者平时的问题一定不少，但追问究竟时，就可能出现偏差，导致“失之毫厘谬以千里”。问对问题能力的提高涉及思想方法，需要在锻炼中提高。验证问题是否问对了，恰恰就是数据分析师可以做贡献的地方。&lt;/p&gt;&lt;p style=&quot;margin-top: 0px; margin-bottom: 32px; padding: 0px; text-align: justify; font-family: &amp;quot;Open Sans&amp;quot;, Arial, &amp;quot;Hiragino Sans GB&amp;quot;, &amp;quot;Microsoft YaHei&amp;quot;, 微软雅黑, STHeiti, &amp;quot;WenQuanYi Micro Hei&amp;quot;, SimSun, sans-serif, sans-serif; font-size: 18px; white-space: normal; background-color: rgb(255, 255, 255);&quot;&gt;本书还引起了二个值得更深入思考的问题：&lt;/p&gt;&lt;p style=&quot;margin-top: 0px; margin-bottom: 32px; padding: 0px; text-align: justify; font-family: &amp;quot;Open Sans&amp;quot;, Arial, &amp;quot;Hiragino Sans GB&amp;quot;, &amp;quot;Microsoft YaHei&amp;quot;, 微软雅黑, STHeiti, &amp;quot;WenQuanYi Micro Hei&amp;quot;, SimSun, sans-serif, sans-serif; font-size: 18px; white-space: normal; background-color: rgb(255, 255, 255);&quot;&gt;仅仅发现不同客户群体的消费习惯，适时提醒客户去消费，还远远不够。比如：某消费者一个月的正常理性消费在两千元的水平，一般在A，B两家商店消费。A商店运用了精准营销的理念会让消费者把这两千元都花在A商店，随着B商店的后来居上，消费者又可能重新回到B商店消费这两千元。在供给过剩需求不足的今天，既有的消费额在不同商家中进行分配或迁移都不能带来社会消费总量的增加。大数据营销的更高水平应用是提前知晓客户尚未被满足、甚至尚未被发现的需求。大数据的价值挖掘有机会把商家（含厂家）和客户连在一起，让商家提供更多的满足客户个性化需求的产品或服务，让客户的消费意愿提高。这是数据价值挖掘工作者面临的新挑战。&lt;/p&gt;&lt;p style=&quot;margin-top: 0px; margin-bottom: 32px; padding: 0px; text-align: justify; font-family: &amp;quot;Open Sans&amp;quot;, Arial, &amp;quot;Hiragino Sans GB&amp;quot;, &amp;quot;Microsoft YaHei&amp;quot;, 微软雅黑, STHeiti, &amp;quot;WenQuanYi Micro Hei&amp;quot;, SimSun, sans-serif, sans-serif; font-size: 18px; white-space: normal; background-color: rgb(255, 255, 255);&quot;&gt;数据真的越多越好吗？不少大数据公司热衷于用爬虫软件在网上“爬”各种数据。然而同一数据集在不同的应用场景价值密度是不一样的，针对特定应用场景也并非是数据维度越多就越好，一定要围绕应用目标来采集数据和使用数据。提升维度来采集更多数据一定是有助于更详尽地描述事物，但无疑也增加了处理数据的复杂性。每一次技术的进步，都给人类带来新的想象空间，难免欲望膨胀自信满满，对世界的认知也随之升维，甚至是无节制地升维。之后发现升维带来资源的占用，智慧跟不上，无节制地升维反而是解决方案复杂化，冷静下来会重新启动降维思考。也许人类的认知与智慧就是在升维、降维、再升维、再降维中交替前行的。本书的降维思考，必要时回归本元的思考给人们启示。&lt;/p&gt;&lt;p style=&quot;margin-top: 0px; margin-bottom: 32px; padding: 0px; text-align: justify; font-family: &amp;quot;Open Sans&amp;quot;, Arial, &amp;quot;Hiragino Sans GB&amp;quot;, &amp;quot;Microsoft YaHei&amp;quot;, 微软雅黑, STHeiti, &amp;quot;WenQuanYi Micro Hei&amp;quot;, SimSun, sans-serif, sans-serif; font-size: 18px; white-space: normal; background-color: rgb(255, 255, 255);&quot;&gt;大数据时代工具手段固然重要，思想方法更为重要。&lt;/p&gt;&lt;p&gt;&lt;br/&gt;&lt;/p&gt;', '1527825125', '1527825125');
INSERT INTO `ey_article_content` VALUES ('6', '10', '&lt;p style=&quot;margin-top: 0px; margin-bottom: 24px; color: rgb(14, 14, 14); font-family: Arial, &amp;quot;Hiragino Sans GB&amp;quot;, 冬青黑, &amp;quot;Microsoft YaHei&amp;quot;, 微软雅黑, SimSun, 宋体, Helvetica, Tahoma, &amp;quot;Arial sans-serif&amp;quot;; text-align: justify; white-space: normal; background-color: rgb(255, 255, 255);&quot;&gt;Z Yuhan：用户界面（UI，User Interface）设计是设计软件产品所涉及到的几个交叉学科之一。不论是用户体验（UX，User Experience）、交互设计（ID，Interaction Design），还是视觉/图形设计（Visual / Graphic Design），都能牵扯到用户界面设计。&lt;/p&gt;&lt;h4 style=&quot;margin: 28px 0px 14px; color: rgb(54, 54, 54); padding-left: 15px; border-left: 5px solid rgb(255, 200, 31); background-color: rgb(255, 255, 255); font-size: 24px; font-family: Tahoma, Arial, &amp;quot;Hiragino Sans GB&amp;quot;, 冬青黑, &amp;quot;Microsoft YaHei&amp;quot;, 微软雅黑, SimSun, 宋体, Heiti, 黑体, sans-serif; line-height: 32px; white-space: normal;&quot;&gt;一、什么是用户界面设计？&lt;/h4&gt;&lt;p style=&quot;margin-top: 0px; margin-bottom: 24px; color: rgb(14, 14, 14); font-family: Arial, &amp;quot;Hiragino Sans GB&amp;quot;, 冬青黑, &amp;quot;Microsoft YaHei&amp;quot;, 微软雅黑, SimSun, 宋体, Helvetica, Tahoma, &amp;quot;Arial sans-serif&amp;quot;; text-align: justify; white-space: normal; background-color: rgb(255, 255, 255);&quot;&gt;广泛来讲，用户界面是人与机器交流的媒介。用户向机器发出指令，机器随即开始一段进程，回复信息，并给出反馈。用户可以根据用户反馈进行下一步操作的决策。&lt;/p&gt;&lt;p style=&quot;margin-top: 0px; margin-bottom: 24px; color: rgb(14, 14, 14); font-family: Arial, &amp;quot;Hiragino Sans GB&amp;quot;, 冬青黑, &amp;quot;Microsoft YaHei&amp;quot;, 微软雅黑, SimSun, 宋体, Helvetica, Tahoma, &amp;quot;Arial sans-serif&amp;quot;; text-align: justify; white-space: normal; background-color: rgb(255, 255, 255);&quot;&gt;人机交互（HCI，Human Computer Interaciton）所关注的主要是数字界面，即过去的打孔机、命令行，直至今天的图形界面（GUI，Graphic Design）。&lt;/p&gt;&lt;p style=&quot;margin-top: 0px; margin-bottom: 24px; color: rgb(14, 14, 14); font-family: Arial, &amp;quot;Hiragino Sans GB&amp;quot;, 冬青黑, &amp;quot;Microsoft YaHei&amp;quot;, 微软雅黑, SimSun, 宋体, Helvetica, Tahoma, &amp;quot;Arial sans-serif&amp;quot;; text-align: justify; white-space: normal; background-color: rgb(255, 255, 255);&quot;&gt;用户界面设计对于数码产品来说主要关注的是布局、信息结构，以及界面元素在显示屏和各种终端平台上的展示。电子游戏和电视界面也包括其中。&lt;/p&gt;&lt;p&gt;&lt;br/&gt;&lt;/p&gt;', '1526552685', '1531711845');
INSERT INTO `ey_article_content` VALUES ('7', '12', '&lt;p&gt;北京时间 5 月 31 日凌晨，有“互联网女皇”之称的玛丽·米克尔发布了 2018 年的互联网趋势报告，这也是她第 23 年公布互联网报告。&lt;br/&gt;&lt;/p&gt;&lt;p&gt;每年的互联网女皇报告几乎都会成为每个互联网创业者的必读报告。那么，互联网女皇是谁?为什么她的报告会如此受关注呢?&lt;/p&gt;&lt;p&gt;&lt;strong&gt;互联网女皇： 90 年代华尔街的象征&lt;/strong&gt;&lt;/p&gt;&lt;p&gt;1958 年 9 月，玛丽·米克尔(Mary Meeker)出生于美国印第安纳州。&lt;/p&gt;&lt;p&gt;1982 年，米克尔加入了当时最负盛名的券商美林公司，担任股票经纪人。&lt;/p&gt;&lt;p&gt;米克尔的明星分析师之路开始于 1991 年，这年她加入了知名投行摩根士丹利，开始了自己辉煌的科技分析师生涯。&lt;/p&gt;&lt;p&gt;自 1995 年以来，米克尔的工作随着网络潮流变化而变化，她逐重于研究雅虎、美国在线及亚马孙等知名公司将如何调整结构并相互竞争。&lt;/p&gt;&lt;p&gt;1996 年，玛丽·米克尔如愿地成为摩根·斯坦利技术股票分析部的负责人，还创造出了华尔街闪耀的新职业——互联网分析师。就像垃圾债券代表了 80 年代华尔街一样，玛丽·米克尔成了 90 年代华尔街的象征。&lt;/p&gt;&lt;p&gt;2010 年底，米克尔辞去摩根士丹利董事总经理的职位，离开华尔街，去到加州成为知名风投KPCB的合伙人。KPCB公司(Kleiner\r\n Perkins Caufield &amp;amp; Byers)成立于 1972 年，是美国最大的风险基金，其最得意的杰作是网景公司的创立。&lt;/p&gt;&lt;p&gt;&lt;strong&gt;互联网女皇报告：互联网领域的投资圣经、选股指南&lt;/strong&gt;&lt;/p&gt;&lt;p&gt;1994 年，米克尔在《纽约时报》上偶然看到一篇讲述创业公司Mosaic研发网络浏览器的报道。米克尔立即意识到，这种网络浏览器可能会改变人们获取信息的方式。她随后就联系了Mosaic的两位创始人，并向华尔街投资者大力介绍这家公司。&lt;/p&gt;&lt;p&gt;Mosaic后来改名为网景，并在 1995 年在纽约上市。得益于米克尔与网景两位创始人的良好关系，摩根士丹利成为网景首次公开募股(IPO)的主承销商。&lt;/p&gt;&lt;p&gt;当年 8 月 9 日，网景上市首日收盘，股价从 14 美元的发行价暴增至 75 美元，创下了当时的上市公司首日涨幅记录。当年网景IPO也成为互联网时代到来的一大标志。&lt;/p&gt;&lt;p&gt;1995 年，除了负责网景的上市交易外，米克尔还与同事克里斯o德普开始发布《互联网报告》，并最早提出了“页面浏览量”等网络类股分析指标。这份报告被投资者视为互联网领域的投资圣经，并且成书公开发行，在整个科技行业引发了巨大反响。&lt;/p&gt;&lt;p&gt;1996- 1997 年，米克尔和摩根士丹利发布了《互联网广告报告》与《互联网零售业报告》，一举奠定了米克尔互联网领域第一分析师的地位。互联网女皇报告几乎成为当时每个互联网创业者的必读报告。&lt;/p&gt;&lt;p&gt;互联网女皇报告，无异于选股指南。她向投资者推荐的美国在线、戴尔、亚马逊、eBay等公司股票，都很快带来了超过十倍的投资回报。&lt;/p&gt;&lt;p&gt;&lt;strong&gt;互联网女皇报告中的“神预测”&lt;/strong&gt;&lt;/p&gt;&lt;p&gt;业界如此看重互联网女皇报告的最主要原因，在于米克尔的那些神预测。以下，我们简单罗列了几点互联网女皇报告中的神预测例子。&lt;/p&gt;', '1526552714', '1531709449');
INSERT INTO `ey_article_content` VALUES ('8', '13', '&lt;p style=&quot;box-sizing: border-box; margin-top: 0px; margin-bottom: 15px; white-space: normal; background-color: rgb(255, 255, 255); padding: 0px; line-height: 30px; color: rgb(51, 51, 51); font-family: 宋体; font-size: 14px;&quot;&gt;网站建设的五大核心要素&lt;/p&gt;&lt;p style=&quot;box-sizing: border-box; margin-top: 0px; margin-bottom: 15px; white-space: normal; background-color: rgb(255, 255, 255); padding: 0px; line-height: 30px; color: rgb(51, 51, 51); font-family: 宋体; font-size: 14px;&quot;&gt;&lt;img src=&quot;/public/upload/article/2018/07/16/dba832d6114e6a85b7eb472bf8dc52ed.jpg&quot;/&gt;&lt;/p&gt;&lt;p style=&quot;box-sizing: border-box; margin-top: 0px; margin-bottom: 15px; white-space: normal; background-color: rgb(255, 255, 255); padding: 0px; line-height: 30px; color: rgb(51, 51, 51); font-family: 宋体; font-size: 14px;&quot;&gt;　　企业要实行网络营销，首先需要进行网站制作。网站是由众多的Web页面组成的，而这些页面设计的好坏，直接影响到这个网站能否得到用户的欢迎。判断一个主页设计的好坏，要从多方面综合考虑，不能仅仅看它设计得是否生动漂亮，而应该看这个网站能否最大限度地替用户考虑。&lt;/p&gt;&lt;p&gt;&lt;img alt=&quot;&quot; class=&quot;limg&quot; src=&quot;http://www.eyoucms.com/uploads/allimg/180426/1510032P3-1.jpg&quot;/&gt;&lt;/p&gt;&lt;p style=&quot;box-sizing: border-box; margin-top: 0px; margin-bottom: 15px; white-space: normal; background-color: rgb(255, 255, 255); padding: 0px; line-height: 30px; color: rgb(51, 51, 51); font-family: 宋体; font-size: 14px;&quot;&gt;　　3、以产品为核心原则&lt;/p&gt;&lt;p style=&quot;box-sizing: border-box; margin-top: 0px; margin-bottom: 15px; white-space: normal; background-color: rgb(255, 255, 255); padding: 0px; line-height: 30px; color: rgb(51, 51, 51); font-family: 宋体; font-size: 14px;&quot;&gt;　　网站制作最重要的目的及功能就是为产品展示。顾客访问网站的主要目的是为了对产品和服务进行深入的了解，网站的价值也就在于灵活地向用户展示产品说明及图片甚至多媒体信息，即使一个功能简单的网站至少也相当于一本可以随时更新的产品宣传资料。过时的产品信息或者产品信息不完善不仅无法促进销售，同时也影响顾客的信心。顾客在访问网站时，关心的不是个人的信息，而是能够提供什么样的产品、产品的优势是什么。所以，以产品为核心是网站成功的一首要前提。&lt;/p&gt;&lt;p style=&quot;box-sizing: border-box; margin-top: 0px; margin-bottom: 15px; white-space: normal; background-color: rgb(255, 255, 255); padding: 0px; line-height: 30px; color: rgb(51, 51, 51); font-family: 宋体; font-size: 14px;&quot;&gt;　　产品信息一般应该包括以下几方面内容：产品名称产品规格、产品用途、产品特性、产品认证情况及产品图片等。其次，产品规格、产品用途和产品特性等信息应尽可能详细地描述。&lt;/p&gt;&lt;p style=&quot;box-sizing: border-box; margin-top: 0px; margin-bottom: 15px; white-space: normal; background-color: rgb(255, 255, 255); padding: 0px; line-height: 30px; color: rgb(51, 51, 51); font-family: 宋体; font-size: 14px;&quot;&gt;　　4、以网站的信息交互能力强为原则&lt;/p&gt;&lt;p style=&quot;box-sizing: border-box; margin-top: 0px; margin-bottom: 15px; white-space: normal; background-color: rgb(255, 255, 255); padding: 0px; line-height: 30px; color: rgb(51, 51, 51); font-family: 宋体; font-size: 14px;&quot;&gt;　　如果一个网站只能提供浏览者浏览，而不能引导浏览者参与到网站内容的一部分建设中，那么它的吸引力是有限的。只有当浏览者能够很方便地和信息发布者交流信息时，该网站的魅力才能充分体现出来。虚拟论坛的设计在产品使用者之间、产品使用者与产品开发经理之间展开对产品的各种讨论。在线营销人员还可以借此收集市场信息，制定有效的营销计划。而网站消费者的反馈信息直接在网上公布，能够吸引消费者回访该网站，并由此可形成与顾客的固定关系。&lt;/p&gt;&lt;p style=&quot;box-sizing: border-box; margin-top: 0px; margin-bottom: 15px; white-space: normal; background-color: rgb(255, 255, 255); padding: 0px; line-height: 30px; color: rgb(51, 51, 51); font-family: 宋体; font-size: 14px;&quot;&gt;　　当顾客在网上找到感兴趣的产品时，如何针对该产品及时进行询价和反馈?这不仅仅是通过电子函件方式就能够实现的。网站上应该提供相应的信息反馈模块，使顾客能够针对某个或多个产品方便快捷地进行询价或反馈。同时，企业的业务员应该能够及时查到顾客的反馈信息并及时回复：每个业务部门或业务员应该能够针对其发布的产品，方便地管理顾客的信息和反馈信息。通过网站可以为顾客提供各种在线服务和帮助信息，比如常见问题解答(FAQ)、详尽的联系信息、在线填写寻求帮助的表单、通过聊天实时回答顾客的咨询等。同时，利用网站还可以实现增进顾客关系的目的，比如通过发行各种免费邮件列表、提供有奖竞猜等方式吸引用户的参与。通过网站上的在线调查表，可以获得用户的反馈信息，用于产品调查、消费者行为调查、品牌形象调查等，是获得第一手市场资料有效的调查工具。&lt;/p&gt;&lt;p style=&quot;box-sizing: border-box; margin-top: 0px; margin-bottom: 15px; white-space: normal; background-color: rgb(255, 255, 255); padding: 0px; line-height: 30px; color: rgb(51, 51, 51); font-family: 宋体; font-size: 14px;&quot;&gt;　　5、以完善的检索能力为原则&lt;/p&gt;&lt;p style=&quot;box-sizing: border-box; margin-top: 0px; margin-bottom: 15px; white-space: normal; background-color: rgb(255, 255, 255); padding: 0px; line-height: 30px; color: rgb(51, 51, 51); font-family: 宋体; font-size: 14px;&quot;&gt;　　对于一个网站来说，如何合理地组织自己要发布的信息内容，以便让浏览者能够快速、准确地找到要找的信息，这是一个网站内容组织是否成功的关键。如果网站的结构设计不能使顾客方便、快捷地找到所需的信息，再好的设计也不能吸引长久的客户。即使将他吸引到了网站主页，将来也会中断访问。为了达到上述设计目标，一些网站在网页上设计了信息索引和目录索引。使用者能很快地找到感兴趣的那部分信息。&lt;/p&gt;&lt;p style=&quot;box-sizing: border-box; margin-top: 0px; margin-bottom: 15px; white-space: normal; background-color: rgb(255, 255, 255); padding: 0px; line-height: 30px; color: rgb(51, 51, 51); font-family: 宋体; font-size: 14px;&quot;&gt;　　因此，为了网站内容的实用，有一定规模的网站一定要提供检索功能，以便于用户查找本网站的信息。为了给浏览者创造方便条件，网页设计者经常将网页内容设计成树形结构，方便纵向查询。访问者从主页开始就可以层层深入到所有“树权”和“树梢”的信息内容。另外，还可以设计一个搜索系统，让访问者很容易地就找到相关的内容。网址的搜索系统，设计应相当周全，允许访问者从任一页面进入。同时，在网站的任何一个页面都要设计有“返回主页”的链接，以方便访问者回到“树干”。&lt;/p&gt;&lt;p&gt;&lt;br/&gt;&lt;/p&gt;', '1526608216', '1531709954');
INSERT INTO `ey_article_content` VALUES ('9', '14', '&lt;p style=&quot;box-sizing: border-box; margin-top: 0px; margin-bottom: 15px; white-space: normal; background-color: rgb(255, 255, 255); padding: 0px; line-height: 30px; color: rgb(51, 51, 51); font-family: 宋体; font-size: 14px;&quot;&gt;网站建设，静态页面和动态页面如何选择&lt;/p&gt;&lt;p style=&quot;box-sizing: border-box; margin-top: 0px; margin-bottom: 15px; white-space: normal; background-color: rgb(255, 255, 255); padding: 0px; line-height: 30px; color: rgb(51, 51, 51); font-family: 宋体; font-size: 14px;&quot;&gt;　　电商网站建设为什么要使用静态页面制作。我们都知道，网站制作有分为静态页面制作和动态网页制作，那么建设电商网站采用哪种网站设计技术更好呢?&lt;/p&gt;&lt;p style=&quot;box-sizing: border-box; margin-top: 0px; margin-bottom: 15px; white-space: normal; background-color: rgb(255, 255, 255); padding: 0px; line-height: 30px; color: rgb(51, 51, 51); font-family: 宋体; font-size: 14px;&quot;&gt;　　我们建设网站最终目的是为了给用户浏览，所以从用户的角度出发进行思考才是最实际的，使用动态网页制作技术虽然网页美观度大大提升了，但是却不利于网站优化，今天小编重点和大家谈谈，网站建设为什么要使用静态页面制作。&lt;/p&gt;&lt;p&gt;&lt;img alt=&quot;&quot; class=&quot;limg&quot; src=&quot;/public/upload/remote/2018/05/18/5afe365fa6716.png&quot;/&gt;&lt;/p&gt;&lt;p style=&quot;box-sizing: border-box; margin-top: 0px; margin-bottom: 15px; white-space: normal; background-color: rgb(255, 255, 255); padding: 0px; line-height: 30px; color: rgb(51, 51, 51); font-family: 宋体; font-size: 14px;&quot;&gt;　　做静态网站建设所采用的技术原理是一对一的形式，也就是说这样的网站上面，一个内容对应的就是一个页面，无论网站访问者如何操作都只是让服务器把固有的数据传送给请求者，没有脚本计算和后台数据库读取过程，大大降低了部分安全隐患。静态网站设计除了拥有上述的速度快，安全性高这两个特点之外还具有跨平台，跨服务器功能。&lt;/p&gt;&lt;p style=&quot;box-sizing: border-box; margin-top: 0px; margin-bottom: 15px; white-space: normal; background-color: rgb(255, 255, 255); padding: 0px; line-height: 30px; color: rgb(51, 51, 51); font-family: 宋体; font-size: 14px;&quot;&gt;　　现在熟悉搜索引擎原理工作原理的朋友应该都知道，它所提供给广大用户的信息是本身就存在于数据库当中的信息而不是实时的信息，固定的信息内容更容易接受和保存。我们可能常常会遇到这样的问题，当我们搜索自己所需要的信息时得出来的结果可能已经失效，这就是静态页面网站设计的不足之处，但又因为它的稳定，所以久久不会被删除。&lt;/p&gt;&lt;p style=&quot;box-sizing: border-box; margin-top: 0px; margin-bottom: 15px; white-space: normal; background-color: rgb(255, 255, 255); padding: 0px; line-height: 30px; color: rgb(51, 51, 51); font-family: 宋体; font-size: 14px;&quot;&gt;　　与静态页面网站设计不同，生成的动态页面信息不但不易被搜索引擎所检索，而且打开速度慢，再者也不稳定，这就是为什么这么多专业网站建设公司都一再建议客户使用静态形式的网站设计的原因，有些网站建设公司会考虑把页面进行伪静态处理，但不知道大家有没有注意过，伪静态处理的URL通常是不规则的。&lt;/p&gt;&lt;p&gt;&lt;br/&gt;&lt;/p&gt;', '1526609496', '1526609496');
INSERT INTO `ey_article_content` VALUES ('10', '19', '&lt;p style=&quot;box-sizing: border-box; margin-top: 0px; margin-bottom: 15px; white-space: normal; background-color: rgb(255, 255, 255); padding: 0px; line-height: 30px; color: rgb(51, 51, 51); font-family: 宋体; font-size: 14px;&quot;&gt;从三方面完美的体验企业网站的核心价值&lt;/p&gt;&lt;p style=&quot;box-sizing: border-box; margin-top: 0px; margin-bottom: 15px; white-space: normal; background-color: rgb(255, 255, 255); padding: 0px; line-height: 30px; color: rgb(51, 51, 51); font-family: 宋体; font-size: 14px;&quot;&gt;　　随着互联网的迅猛发展，一个企业的发展离不开互联网的发展，企业注重企业网站建设，那么必然会给其带来不错的效果。企业网站建设其核心价值直接体现在网站对于用户和商家而言，是否能够满足他们利益需求，能否提高企业发展，提高企业的发展渠道。&lt;/p&gt;&lt;p&gt;&lt;img class=&quot;rimg&quot; src=&quot;http://www.eyoucms.com/uploads/allimg/180426/150RQ155-0.jpg&quot;/&gt;&lt;/p&gt;&lt;p style=&quot;box-sizing: border-box; margin-top: 0px; margin-bottom: 15px; white-space: normal; background-color: rgb(255, 255, 255); padding: 0px; line-height: 30px; color: rgb(51, 51, 51); font-family: 宋体; font-size: 14px;&quot;&gt;　　一个好的导航系统就是一个好的导游，认为每一个网站设计方案都有权利与义务帮助客户及时准确的找到自己感兴趣的内容主体和需要的东西。&lt;/p&gt;&lt;p style=&quot;box-sizing: border-box; margin-top: 0px; margin-bottom: 15px; white-space: normal; background-color: rgb(255, 255, 255); padding: 0px; line-height: 30px; color: rgb(51, 51, 51); font-family: 宋体; font-size: 14px;&quot;&gt;　　另一方面体现在网站对商家现金利益需求的满足，而此却建立在网站对用户需求满足的基础之上。因为，如果网站不能够满足用户利益的需求，用户就不会为网站创造价值，不能吸引更多的用户参与到网站中来，不能实现网站价值循环式的增长，用户规模将会无法得到较大发展，很难实现对商家现金利益需求的满足，商家在网站投放广告是基于网站促进发生交易可能性的大小，交易可能性越大，商家才可以获得更大的现金利益，否则，将会白白浪费广告费。&lt;/p&gt;&lt;p style=&quot;box-sizing: border-box; margin-top: 0px; margin-bottom: 15px; white-space: normal; background-color: rgb(255, 255, 255); padding: 0px; line-height: 30px; color: rgb(51, 51, 51); font-family: 宋体; font-size: 14px;&quot;&gt;　　其次体现在对用户利益需求的满足，网站在发展初期更多的是要为用户提供他们需求的内容，积极的创造内容价值，满足用户各种基础性利益的需求，尤其是各类疑问的解答，相关兴趣或者专业资料的提供，各种资讯信息的发布。让用户能够基于某一种原因留下来，在基础性的工作做好的前提下，您可以着力于用户交易利益需求的满足，或者开始就将交易与用户的相关需求结合起来，打造一个个活跃度高的交易类版块，为用户提供此类交易最全面、最方便的资料和场所，积极促进用户活跃度的提高和迅速实现网站盈利。&lt;/p&gt;&lt;p style=&quot;box-sizing: border-box; margin-top: 0px; margin-bottom: 15px; white-space: normal; background-color: rgb(255, 255, 255); padding: 0px; line-height: 30px; color: rgb(51, 51, 51); font-family: 宋体; font-size: 14px;&quot;&gt;　　我们认为让客户在首页即可看到与自己寻找的讯息高度相关的行业信息是非常明智的抉择，一个没有大量行业专业信息体现的网站设计称不上合格的网站设计，也无法真正的为客户从根本上解决问题。&lt;/p&gt;&lt;p style=&quot;box-sizing: border-box; margin-top: 0px; margin-bottom: 15px; white-space: normal; background-color: rgb(255, 255, 255); padding: 0px; line-height: 30px; color: rgb(51, 51, 51); font-family: 宋体; font-size: 14px;&quot;&gt;　　我们只有尽量的在网站设计当中体现出如何才能在众多的行业竞争对手中脱颖而出，让客户可以信任我们呢?网站建设公司认为唯有尽量表现出自己的专业实力方可,当然除了这三点之外，网站设计仍旧有很多需要注意的地方，但不管怎么样，核心价值还是应该要重点体现，将重点放在核心内容上才是网站设计的真谛， 我们知道网站运营的核心理念是价值，站长们务必牢牢树立，一切从用户出发，积极满足用户需求，让用户发挥创造力，为网站创造价值，实现网站价值循环式增长，让站长运营变成用户运营是我们的终极目标，一劳永逸，盈利不断。&lt;/p&gt;&lt;p&gt;&lt;br/&gt;&lt;/p&gt;', '1526610848', '1526610848');
INSERT INTO `ey_article_content` VALUES ('11', '20', '&lt;p&gt;随着网络应用的丰富和发展，很多网站往往不能迅速跟进大量信息衍生及业务模式变革的脚步，常常需要花费许多时间、人力和物力来处理信息更新和维护工作；遇到网站扩充的时候，整合内外网及分支网站的工作就变得更加复杂，甚至还需重新建设网站；如此下去，用户始终在一个高成本、低效率的循环中升级、整合…&lt;/p&gt;&lt;p&gt;于是，我们听到许多用户这样的反馈：&lt;/p&gt;&lt;p&gt;页面制作无序，网站风格不统一，大量信息堆积，发布显得异常沉重；&lt;/p&gt;&lt;p&gt;内容繁杂，手工管理效率低下，手工链接视音频信息经常无法实现；&lt;/p&gt;&lt;p&gt;应用难度较高，许多工作需要技术人员配合才能完成，角色分工不明确；&lt;/p&gt;&lt;p&gt;改版工作量大，系统扩展能力差，集成其它应用时更是降低了灵活性；&lt;/p&gt;&lt;p&gt;对于网站建设和信息发布人员来说，他们最关注的系统的易用性和的功能的完善性，因此，这对网站建设和信息发布工具提出了一个很高的要求。&lt;/p&gt;&lt;p&gt;首先，角色定位明确，以充分保证工作人员的工作效率；其次，功能完整，满足各门道&amp;quot;把关人&amp;quot;应用所需，使信息发布准确无误。比如，为编辑、美工、主编及运维人员设置权限和实时管理功能。&lt;/p&gt;&lt;p&gt;此外，保障网站架构的安全性也是用户关注的焦点。能有效管理网站访问者的登陆权限，使内网数据库不受攻击，从而时刻保证网站的安全稳定，免于用户的后顾之忧。&lt;/p&gt;&lt;p&gt;根据以上需求，一套专业的内容管理系统CMS应运而生，来有效解决用户网站建设与信息发布中常见的问题和需求。对网站内容管理是该软件的最大优势，它流程完善、功能丰富，可把稿件分门别类并授权给合法用户编辑管理，而不需要用户去理会那些难懂的SQL语法。&lt;/p&gt;', '1526611606', '1527555060');
INSERT INTO `ey_article_content` VALUES ('12', '21', '&lt;p style=&quot;box-sizing: border-box; margin-top: 0px; margin-bottom: 24px; white-space: normal; background-color: rgb(255, 255, 255); color: rgb(14, 14, 14); font-family: Arial, &amp;quot;Hiragino Sans GB&amp;quot;, 冬青黑, &amp;quot;Microsoft YaHei&amp;quot;, 微软雅黑, SimSun, 宋体, Helvetica, Tahoma, &amp;quot;Arial sans-serif&amp;quot;; text-align: justify;&quot;&gt;SEO（搜索引擎优化）和有效的网站设计是齐头并进的。好的网站设计是关于创建一个吸引目标受众的网站，并让他们采取某种行动。但是，如果该网站不遵循目前的 SEO 最佳做法，它的排名将会受到影响，从而会导致真正参与该网站的访问者的数量的较少。&lt;/p&gt;&lt;p style=&quot;box-sizing: border-box; margin-top: 0px; margin-bottom: 24px; white-space: normal; background-color: rgb(255, 255, 255); color: rgb(14, 14, 14); font-family: Arial, &amp;quot;Hiragino Sans GB&amp;quot;, 冬青黑, &amp;quot;Microsoft YaHei&amp;quot;, 微软雅黑, SimSun, 宋体, Helvetica, Tahoma, &amp;quot;Arial sans-serif&amp;quot;; text-align: justify;&quot;&gt;相反地，如果将关注的焦点放在搜索引擎优化以及如何取悦搜索引擎蜘蛛上，那么网站可能会排名很高，并且会获得大量的搜索引擎流量，但是如果设计很不尽人意，那就不一样了。为了在当今的数字环境中取得成功，必须将重点放在网站设计和搜索引擎优化上。&lt;/p&gt;&lt;p style=&quot;box-sizing: border-box; margin-top: 0px; margin-bottom: 24px; white-space: normal; background-color: rgb(255, 255, 255); color: rgb(14, 14, 14); font-family: Arial, &amp;quot;Hiragino Sans GB&amp;quot;, 冬青黑, &amp;quot;Microsoft YaHei&amp;quot;, 微软雅黑, SimSun, 宋体, Helvetica, Tahoma, &amp;quot;Arial sans-serif&amp;quot;; text-align: justify;&quot;&gt;&lt;span style=&quot;box-sizing: border-box; font-weight: 700;&quot;&gt;一、但是，SEO 不会扼杀掉网页设计师的创造力吗？&lt;/span&gt;&lt;/p&gt;&lt;p style=&quot;box-sizing: border-box; margin-top: 0px; margin-bottom: 24px; white-space: normal; background-color: rgb(255, 255, 255); color: rgb(14, 14, 14); font-family: Arial, &amp;quot;Hiragino Sans GB&amp;quot;, 冬青黑, &amp;quot;Microsoft YaHei&amp;quot;, 微软雅黑, SimSun, 宋体, Helvetica, Tahoma, &amp;quot;Arial sans-serif&amp;quot;; text-align: justify;&quot;&gt;在过去的五年中，对“优化设计”的巨大需求已经被网页设计师所接受。在此之前，设计师们主要关注的是用户的体验，而不是“机器人”的体验。&lt;/p&gt;&lt;p style=&quot;box-sizing: border-box; margin-top: 0px; margin-bottom: 24px; white-space: normal; background-color: rgb(255, 255, 255); color: rgb(14, 14, 14); font-family: Arial, &amp;quot;Hiragino Sans GB&amp;quot;, 冬青黑, &amp;quot;Microsoft YaHei&amp;quot;, 微软雅黑, SimSun, 宋体, Helvetica, Tahoma, &amp;quot;Arial sans-serif&amp;quot;; text-align: justify;&quot;&gt;如今，设计师不仅要让网站看起来有吸引力，而且要确保行为召唤必须符合网站页面“折叠”的要求，网站的加载速度必须很快，必须使用面包屑路径，清晰明了的导航选择，必须使用&amp;nbsp;CSS，JavaScript 文件必须保持在最低限度…这是一项艰巨的任务。&lt;/p&gt;&lt;p style=&quot;box-sizing: border-box; margin-top: 0px; margin-bottom: 24px; white-space: normal; background-color: rgb(255, 255, 255); color: rgb(14, 14, 14); font-family: Arial, &amp;quot;Hiragino Sans GB&amp;quot;, 冬青黑, &amp;quot;Microsoft YaHei&amp;quot;, 微软雅黑, SimSun, 宋体, Helvetica, Tahoma, &amp;quot;Arial sans-serif&amp;quot;; text-align: justify;&quot;&gt;一些设计师可能想知道，所有这些新的 SEO 规则是否会损害创建网站的自由？&lt;/p&gt;&lt;p style=&quot;box-sizing: border-box; margin-top: 0px; margin-bottom: 24px; white-space: normal; background-color: rgb(255, 255, 255); color: rgb(14, 14, 14); font-family: Arial, &amp;quot;Hiragino Sans GB&amp;quot;, 冬青黑, &amp;quot;Microsoft YaHei&amp;quot;, 微软雅黑, SimSun, 宋体, Helvetica, Tahoma, &amp;quot;Arial sans-serif&amp;quot;; text-align: justify;&quot;&gt;对于“干净”的网站设计而言，它可以帮助一个网站快速加载，容易被搜索引擎蜘蛛抓取。因此，在现实中，创造力和最优化需要能够同时在一起“蓬勃发展”。&lt;/p&gt;&lt;p style=&quot;box-sizing: border-box; margin-top: 0px; margin-bottom: 24px; white-space: normal; background-color: rgb(255, 255, 255); color: rgb(14, 14, 14); font-family: Arial, &amp;quot;Hiragino Sans GB&amp;quot;, 冬青黑, &amp;quot;Microsoft YaHei&amp;quot;, 微软雅黑, SimSun, 宋体, Helvetica, Tahoma, &amp;quot;Arial sans-serif&amp;quot;; text-align: justify;&quot;&gt;&lt;span style=&quot;box-sizing: border-box; font-weight: 700;&quot;&gt;二、把它们结合在一起&lt;/span&gt;&lt;/p&gt;&lt;p style=&quot;box-sizing: border-box; margin-top: 0px; margin-bottom: 24px; white-space: normal; background-color: rgb(255, 255, 255); color: rgb(14, 14, 14); font-family: Arial, &amp;quot;Hiragino Sans GB&amp;quot;, 冬青黑, &amp;quot;Microsoft YaHei&amp;quot;, 微软雅黑, SimSun, 宋体, Helvetica, Tahoma, &amp;quot;Arial sans-serif&amp;quot;; text-align: justify;&quot;&gt;有一些核心元素支持每一个 SEO 策略和网站设计项目：&lt;/p&gt;&lt;p style=&quot;box-sizing: border-box; margin-top: 0px; margin-bottom: 24px; white-space: normal; background-color: rgb(255, 255, 255); color: rgb(14, 14, 14); font-family: Arial, &amp;quot;Hiragino Sans GB&amp;quot;, 冬青黑, &amp;quot;Microsoft YaHei&amp;quot;, 微软雅黑, SimSun, 宋体, Helvetica, Tahoma, &amp;quot;Arial sans-serif&amp;quot;; text-align: justify;&quot;&gt;&lt;span style=&quot;box-sizing: border-box; font-weight: 700;&quot;&gt;1.　关键词分析&lt;/span&gt;&lt;/p&gt;&lt;p style=&quot;box-sizing: border-box; margin-top: 0px; margin-bottom: 24px; white-space: normal; background-color: rgb(255, 255, 255); color: rgb(14, 14, 14); font-family: Arial, &amp;quot;Hiragino Sans GB&amp;quot;, 冬青黑, &amp;quot;Microsoft YaHei&amp;quot;, 微软雅黑, SimSun, 宋体, Helvetica, Tahoma, &amp;quot;Arial sans-serif&amp;quot;; text-align: justify;&quot;&gt;在启动一个商业网站项目时，必须进行彻底的关键词分析。为了做到这一点，网页设计师必须紧密深入地了解客户的目标受众，并定义受众中的人口结构是如何融入到企业正试图达到的更大的目标市场。然后，应该对网站进行适当的关键词/长尾关键词优化。&lt;/p&gt;&lt;p style=&quot;box-sizing: border-box; margin-top: 0px; margin-bottom: 24px; white-space: normal; background-color: rgb(255, 255, 255); color: rgb(14, 14, 14); font-family: Arial, &amp;quot;Hiragino Sans GB&amp;quot;, 冬青黑, &amp;quot;Microsoft YaHei&amp;quot;, 微软雅黑, SimSun, 宋体, Helvetica, Tahoma, &amp;quot;Arial sans-serif&amp;quot;; text-align: justify;&quot;&gt;&lt;span style=&quot;box-sizing: border-box; font-weight: 700;&quot;&gt;2.　内容层次结构&lt;/span&gt;&lt;/p&gt;&lt;p style=&quot;box-sizing: border-box; margin-top: 0px; margin-bottom: 24px; white-space: normal; background-color: rgb(255, 255, 255); color: rgb(14, 14, 14); font-family: Arial, &amp;quot;Hiragino Sans GB&amp;quot;, 冬青黑, &amp;quot;Microsoft YaHei&amp;quot;, 微软雅黑, SimSun, 宋体, Helvetica, Tahoma, &amp;quot;Arial sans-serif&amp;quot;; text-align: justify;&quot;&gt;对于一个企业来说，创建好的内容是不够的，他们还必须在战略上规划内容的位置。&lt;/p&gt;&lt;p style=&quot;box-sizing: border-box; margin-top: 0px; margin-bottom: 24px; white-space: normal; background-color: rgb(255, 255, 255); color: rgb(14, 14, 14); font-family: Arial, &amp;quot;Hiragino Sans GB&amp;quot;, 冬青黑, &amp;quot;Microsoft YaHei&amp;quot;, 微软雅黑, SimSun, 宋体, Helvetica, Tahoma, &amp;quot;Arial sans-serif&amp;quot;; text-align: justify;&quot;&gt;有效的计划意味着将相关的内容放到虚拟的容器中，通过创造性的设计和内部链接让内容层级结构一目了然。并且，一个经过优化的网站是对用户和搜索引擎蜘蛛都很友好的网站。&lt;/p&gt;&lt;p style=&quot;box-sizing: border-box; margin-top: 0px; margin-bottom: 24px; white-space: normal; background-color: rgb(255, 255, 255); color: rgb(14, 14, 14); font-family: Arial, &amp;quot;Hiragino Sans GB&amp;quot;, 冬青黑, &amp;quot;Microsoft YaHei&amp;quot;, 微软雅黑, SimSun, 宋体, Helvetica, Tahoma, &amp;quot;Arial sans-serif&amp;quot;; text-align: justify;&quot;&gt;&lt;span style=&quot;box-sizing: border-box; font-weight: 700;&quot;&gt;3.　从用户的角度思考&lt;/span&gt;&lt;/p&gt;&lt;p style=&quot;box-sizing: border-box; margin-top: 0px; margin-bottom: 24px; white-space: normal; background-color: rgb(255, 255, 255); color: rgb(14, 14, 14); font-family: Arial, &amp;quot;Hiragino Sans GB&amp;quot;, 冬青黑, &amp;quot;Microsoft YaHei&amp;quot;, 微软雅黑, SimSun, 宋体, Helvetica, Tahoma, &amp;quot;Arial sans-serif&amp;quot;; text-align: justify;&quot;&gt;通常情况下，你的网站有越多的页面或文章，目标用户找到你的机会就越多。当他们着陆这些特定的页面的时候，你需要确保你能帮助他们轻松的找到你。&lt;/p&gt;&lt;p style=&quot;box-sizing: border-box; margin-top: 0px; margin-bottom: 24px; white-space: normal; background-color: rgb(255, 255, 255); color: rgb(14, 14, 14); font-family: Arial, &amp;quot;Hiragino Sans GB&amp;quot;, 冬青黑, &amp;quot;Microsoft YaHei&amp;quot;, 微软雅黑, SimSun, 宋体, Helvetica, Tahoma, &amp;quot;Arial sans-serif&amp;quot;; text-align: justify;&quot;&gt;所以你必须从用户的角度进行思考，要让用户立即清楚地知道他们在进行访问的页面的当前位置，并帮助用户在尽可能少的点击下从页面转换到另一页面。&lt;/p&gt;&lt;p style=&quot;box-sizing: border-box; margin-top: 0px; margin-bottom: 24px; white-space: normal; background-color: rgb(255, 255, 255); color: rgb(14, 14, 14); font-family: Arial, &amp;quot;Hiragino Sans GB&amp;quot;, 冬青黑, &amp;quot;Microsoft YaHei&amp;quot;, 微软雅黑, SimSun, 宋体, Helvetica, Tahoma, &amp;quot;Arial sans-serif&amp;quot;; text-align: justify;&quot;&gt;&lt;span style=&quot;box-sizing: border-box; font-weight: 700;&quot;&gt;三、为什么&amp;nbsp;SEO 策略如此重要？&lt;/span&gt;&lt;/p&gt;&lt;p style=&quot;box-sizing: border-box; margin-top: 0px; margin-bottom: 24px; white-space: normal; background-color: rgb(255, 255, 255); color: rgb(14, 14, 14); font-family: Arial, &amp;quot;Hiragino Sans GB&amp;quot;, 冬青黑, &amp;quot;Microsoft YaHei&amp;quot;, 微软雅黑, SimSun, 宋体, Helvetica, Tahoma, &amp;quot;Arial sans-serif&amp;quot;; text-align: justify;&quot;&gt;拥有合适的网站结构和信息架构，最终将会帮助企业提供一种引人入胜的用户体验，同时减少对每一次新增长的需求。但是，除非你的品牌是众所周知的，否则通常是搜索引擎对网站所收到的大部分流量负责。SEO 策略有能力利用重要的客户数据，挖掘新的潜在收入流。&lt;/p&gt;&lt;p style=&quot;box-sizing: border-box; margin-top: 0px; margin-bottom: 24px; white-space: normal; background-color: rgb(255, 255, 255); color: rgb(14, 14, 14); font-family: Arial, &amp;quot;Hiragino Sans GB&amp;quot;, 冬青黑, &amp;quot;Microsoft YaHei&amp;quot;, 微软雅黑, SimSun, 宋体, Helvetica, Tahoma, &amp;quot;Arial sans-serif&amp;quot;; text-align: justify;&quot;&gt;对于那些试图进行搜索引擎优化的网站所有者来说，有一些地方经常是麻烦的。现在，我将为网站所有者提供搜索引擎优化建议，以获得更高排名的页面。&lt;/p&gt;&lt;p style=&quot;box-sizing: border-box; margin-top: 0px; margin-bottom: 24px; white-space: normal; background-color: rgb(255, 255, 255); color: rgb(14, 14, 14); font-family: Arial, &amp;quot;Hiragino Sans GB&amp;quot;, 冬青黑, &amp;quot;Microsoft YaHei&amp;quot;, 微软雅黑, SimSun, 宋体, Helvetica, Tahoma, &amp;quot;Arial sans-serif&amp;quot;; text-align: justify;&quot;&gt;&lt;span style=&quot;box-sizing: border-box; font-weight: 700;&quot;&gt;1. &amp;nbsp;URL 结构&lt;/span&gt;&lt;/p&gt;&lt;p style=&quot;box-sizing: border-box; margin-top: 0px; margin-bottom: 24px; white-space: normal; background-color: rgb(255, 255, 255); color: rgb(14, 14, 14); font-family: Arial, &amp;quot;Hiragino Sans GB&amp;quot;, 冬青黑, &amp;quot;Microsoft YaHei&amp;quot;, 微软雅黑, SimSun, 宋体, Helvetica, Tahoma, &amp;quot;Arial sans-serif&amp;quot;; text-align: justify;&quot;&gt;大多数网站创建的 URL 都包含很多随机字符，比如问号，没有关键词或任何有价值的内容。当搜索引擎的 URL 包含 SEO 的关键词或短语时，页面将会在搜索引擎中排名更高。因此，在 URL 中设置关键词非常重要。&lt;/p&gt;&lt;p style=&quot;box-sizing: border-box; margin-top: 0px; margin-bottom: 24px; white-space: normal; background-color: rgb(255, 255, 255); color: rgb(14, 14, 14); font-family: Arial, &amp;quot;Hiragino Sans GB&amp;quot;, 冬青黑, &amp;quot;Microsoft YaHei&amp;quot;, 微软雅黑, SimSun, 宋体, Helvetica, Tahoma, &amp;quot;Arial sans-serif&amp;quot;; text-align: justify;&quot;&gt;&lt;span style=&quot;box-sizing: border-box; font-weight: 700;&quot;&gt;2.　页面的标题&lt;/span&gt;&lt;/p&gt;&lt;p style=&quot;box-sizing: border-box; margin-top: 0px; margin-bottom: 24px; white-space: normal; background-color: rgb(255, 255, 255); color: rgb(14, 14, 14); font-family: Arial, &amp;quot;Hiragino Sans GB&amp;quot;, 冬青黑, &amp;quot;Microsoft YaHei&amp;quot;, 微软雅黑, SimSun, 宋体, Helvetica, Tahoma, &amp;quot;Arial sans-serif&amp;quot;; text-align: justify;&quot;&gt;搜索引擎排名中最重要的因素之一是页面标题。不过，许多网站并没有改变他们的网页标题。在青柠建站平台中，你可以通过使用 SEO 标题标签插件，它很容易让你为你的文章和页面创建标题。&lt;/p&gt;&lt;p style=&quot;box-sizing: border-box; margin-top: 0px; margin-bottom: 24px; white-space: normal; background-color: rgb(255, 255, 255); color: rgb(14, 14, 14); font-family: Arial, &amp;quot;Hiragino Sans GB&amp;quot;, 冬青黑, &amp;quot;Microsoft YaHei&amp;quot;, 微软雅黑, SimSun, 宋体, Helvetica, Tahoma, &amp;quot;Arial sans-serif&amp;quot;; text-align: justify;&quot;&gt;&lt;span style=&quot;box-sizing: border-box; font-weight: 700;&quot;&gt;3.　重复的内容&lt;/span&gt;&lt;/p&gt;&lt;p style=&quot;box-sizing: border-box; margin-top: 0px; margin-bottom: 24px; white-space: normal; background-color: rgb(255, 255, 255); color: rgb(14, 14, 14); font-family: Arial, &amp;quot;Hiragino Sans GB&amp;quot;, 冬青黑, &amp;quot;Microsoft YaHei&amp;quot;, 微软雅黑, SimSun, 宋体, Helvetica, Tahoma, &amp;quot;Arial sans-serif&amp;quot;; text-align: justify;&quot;&gt;没有一个搜索引擎喜欢看到重复的内容。重复内容是一些网站的主要问题，因为类别页面和日历/日期页面经常会导致搜索引擎在多个页面上找到相同的内容。&lt;/p&gt;&lt;p style=&quot;box-sizing: border-box; margin-top: 0px; margin-bottom: 24px; white-space: normal; background-color: rgb(255, 255, 255); color: rgb(14, 14, 14); font-family: Arial, &amp;quot;Hiragino Sans GB&amp;quot;, 冬青黑, &amp;quot;Microsoft YaHei&amp;quot;, 微软雅黑, SimSun, 宋体, Helvetica, Tahoma, &amp;quot;Arial sans-serif&amp;quot;; text-align: justify;&quot;&gt;对于网站所有者来说，有几种方法可以克服重复的内容问题。其中一种方法是使用 robot.txt 文件，用来指导搜索引擎哪些页面应该被忽略，只留下要索引的主要页面。&lt;/p&gt;&lt;p style=&quot;box-sizing: border-box; margin-top: 0px; margin-bottom: 24px; white-space: normal; background-color: rgb(255, 255, 255); color: rgb(14, 14, 14); font-family: Arial, &amp;quot;Hiragino Sans GB&amp;quot;, 冬青黑, &amp;quot;Microsoft YaHei&amp;quot;, 微软雅黑, SimSun, 宋体, Helvetica, Tahoma, &amp;quot;Arial sans-serif&amp;quot;; text-align: justify;&quot;&gt;&lt;span style=&quot;box-sizing: border-box; font-weight: 700;&quot;&gt;4. &amp;nbsp;Meta 标签&lt;/span&gt;&lt;/p&gt;&lt;p style=&quot;box-sizing: border-box; margin-top: 0px; margin-bottom: 24px; white-space: normal; background-color: rgb(255, 255, 255); color: rgb(14, 14, 14); font-family: Arial, &amp;quot;Hiragino Sans GB&amp;quot;, 冬青黑, &amp;quot;Microsoft YaHei&amp;quot;, 微软雅黑, SimSun, 宋体, Helvetica, Tahoma, &amp;quot;Arial sans-serif&amp;quot;; text-align: justify;&quot;&gt;在设计一个传统的静态网站时，你可以为每个页面输入元标签（描述）。尽管这些标签在搜索引擎排名上的影响力没有以前那么大，但在你的页面上有这些标签并不会带来什么坏处。&lt;/p&gt;&lt;p style=&quot;box-sizing: border-box; margin-top: 0px; margin-bottom: 24px; white-space: normal; background-color: rgb(255, 255, 255); color: rgb(14, 14, 14); font-family: Arial, &amp;quot;Hiragino Sans GB&amp;quot;, 冬青黑, &amp;quot;Microsoft YaHei&amp;quot;, 微软雅黑, SimSun, 宋体, Helvetica, Tahoma, &amp;quot;Arial sans-serif&amp;quot;; text-align: justify;&quot;&gt;然而，大多数建站平台并没有给用户在写文章时添加元标签的选项。对于 青柠建站平台 用户来说，添加元标签插件将允许你为任何页面输入元标签。&lt;/p&gt;&lt;p style=&quot;box-sizing: border-box; margin-top: 0px; margin-bottom: 24px; white-space: normal; background-color: rgb(255, 255, 255); color: rgb(14, 14, 14); font-family: Arial, &amp;quot;Hiragino Sans GB&amp;quot;, 冬青黑, &amp;quot;Microsoft YaHei&amp;quot;, 微软雅黑, SimSun, 宋体, Helvetica, Tahoma, &amp;quot;Arial sans-serif&amp;quot;; text-align: justify;&quot;&gt;&lt;span style=&quot;box-sizing: border-box; font-weight: 700;&quot;&gt;四、网页设计师在 SEO 方面的职责是什么？&lt;/span&gt;&lt;/p&gt;&lt;p style=&quot;box-sizing: border-box; margin-top: 0px; margin-bottom: 24px; white-space: normal; background-color: rgb(255, 255, 255); color: rgb(14, 14, 14); font-family: Arial, &amp;quot;Hiragino Sans GB&amp;quot;, 冬青黑, &amp;quot;Microsoft YaHei&amp;quot;, 微软雅黑, SimSun, 宋体, Helvetica, Tahoma, &amp;quot;Arial sans-serif&amp;quot;; text-align: justify;&quot;&gt;搜索引擎优化是一个持续的过程，它不能通过以特定的方式设计一个网站来实现。当然，网页设计师应该付出相当大的努力来帮助客户构建一个优化的站点，但是网页设计师在 SEO 方面的职责是什么，以及客户的职责是什么？&lt;/p&gt;&lt;p style=&quot;box-sizing: border-box; margin-top: 0px; margin-bottom: 24px; white-space: normal; background-color: rgb(255, 255, 255); color: rgb(14, 14, 14); font-family: Arial, &amp;quot;Hiragino Sans GB&amp;quot;, 冬青黑, &amp;quot;Microsoft YaHei&amp;quot;, 微软雅黑, SimSun, 宋体, Helvetica, Tahoma, &amp;quot;Arial sans-serif&amp;quot;; text-align: justify;&quot;&gt;作为一个企业主，你的网站的优化对你来说比设计师更重要（这并不是说设计师不关心，但是设计师的注意力通常集中在网站的视觉和功能上）。你比设计师更了解你的客户 / 潜在客户，所以你应该对你的目标有更多的建设性意见。&lt;/p&gt;&lt;p style=&quot;box-sizing: border-box; margin-top: 0px; margin-bottom: 24px; white-space: normal; background-color: rgb(255, 255, 255); color: rgb(14, 14, 14); font-family: Arial, &amp;quot;Hiragino Sans GB&amp;quot;, 冬青黑, &amp;quot;Microsoft YaHei&amp;quot;, 微软雅黑, SimSun, 宋体, Helvetica, Tahoma, &amp;quot;Arial sans-serif&amp;quot;; text-align: justify;&quot;&gt;也许有些客户对 SEO 和目标关键词可能不太了解，那么理想的情况是让客户和你在这个问题上协同工作。&lt;/p&gt;&lt;p style=&quot;box-sizing: border-box; margin-top: 0px; margin-bottom: 24px; white-space: normal; background-color: rgb(255, 255, 255); color: rgb(14, 14, 14); font-family: Arial, &amp;quot;Hiragino Sans GB&amp;quot;, 冬青黑, &amp;quot;Microsoft YaHei&amp;quot;, 微软雅黑, SimSun, 宋体, Helvetica, Tahoma, &amp;quot;Arial sans-serif&amp;quot;; text-align: justify;&quot;&gt;根据我的经验，让客户参与其中的最简单方法之一就是简单地解释网站上使用的词语和短语（标题、文案等）会对网站排名有直接的影响。&lt;/p&gt;&lt;p style=&quot;box-sizing: border-box; margin-top: 0px; margin-bottom: 24px; white-space: normal; background-color: rgb(255, 255, 255); color: rgb(14, 14, 14); font-family: Arial, &amp;quot;Hiragino Sans GB&amp;quot;, 冬青黑, &amp;quot;Microsoft YaHei&amp;quot;, 微软雅黑, SimSun, 宋体, Helvetica, Tahoma, &amp;quot;Arial sans-serif&amp;quot;; text-align: justify;&quot;&gt;我通常会要求客户给我一份他们认为潜在访问者可能会在搜索中使用的词语和短语列表。在我不太熟悉的行业中设计网站时，这一点尤其重要。&lt;/p&gt;&lt;p style=&quot;box-sizing: border-box; margin-top: 0px; margin-bottom: 24px; white-space: normal; background-color: rgb(255, 255, 255); color: rgb(14, 14, 14); font-family: Arial, &amp;quot;Hiragino Sans GB&amp;quot;, 冬青黑, &amp;quot;Microsoft YaHei&amp;quot;, 微软雅黑, SimSun, 宋体, Helvetica, Tahoma, &amp;quot;Arial sans-serif&amp;quot;; text-align: justify;&quot;&gt;当然，可能需要做一些研究。客户应该承担起关键词研究的责任，还是应该由设计师来负责？&lt;/p&gt;&lt;p style=&quot;box-sizing: border-box; margin-top: 0px; margin-bottom: 24px; white-space: normal; background-color: rgb(255, 255, 255); color: rgb(14, 14, 14); font-family: Arial, &amp;quot;Hiragino Sans GB&amp;quot;, 冬青黑, &amp;quot;Microsoft YaHei&amp;quot;, 微软雅黑, SimSun, 宋体, Helvetica, Tahoma, &amp;quot;Arial sans-serif&amp;quot;; text-align: justify;&quot;&gt;我的经验是，如果客户参与进来，这项研究通常会更有效，但这并不总是可能的。设计师应该有足够的知识来为客户提供建议，并且应该愿意提供帮助，但是最终最好还是让客户尽可能地参与进来。事实上，如果客户关心 SEO，参与过程会达到一个更加合理的期望。&lt;/p&gt;&lt;p style=&quot;box-sizing: border-box; margin-top: 0px; margin-bottom: 24px; white-space: normal; background-color: rgb(255, 255, 255); color: rgb(14, 14, 14); font-family: Arial, &amp;quot;Hiragino Sans GB&amp;quot;, 冬青黑, &amp;quot;Microsoft YaHei&amp;quot;, 微软雅黑, SimSun, 宋体, Helvetica, Tahoma, &amp;quot;Arial sans-serif&amp;quot;; text-align: justify;&quot;&gt;设定现实的期望也可能是设计师的责任。&lt;/p&gt;&lt;p style=&quot;box-sizing: border-box; margin-top: 0px; margin-bottom: 24px; white-space: normal; background-color: rgb(255, 255, 255); color: rgb(14, 14, 14); font-family: Arial, &amp;quot;Hiragino Sans GB&amp;quot;, 冬青黑, &amp;quot;Microsoft YaHei&amp;quot;, 微软雅黑, SimSun, 宋体, Helvetica, Tahoma, &amp;quot;Arial sans-serif&amp;quot;; text-align: justify;&quot;&gt;我有一些潜在的客户来找我说：“我被 SEO 专家告知，只要在网站页面上插入竞争热门的关键词就可以让我的网站排名第一或第二”。&lt;/p&gt;&lt;p style=&quot;box-sizing: border-box; margin-top: 0px; margin-bottom: 24px; white-space: normal; background-color: rgb(255, 255, 255); color: rgb(14, 14, 14); font-family: Arial, &amp;quot;Hiragino Sans GB&amp;quot;, 冬青黑, &amp;quot;Microsoft YaHei&amp;quot;, 微软雅黑, SimSun, 宋体, Helvetica, Tahoma, &amp;quot;Arial sans-serif&amp;quot;; text-align: justify;&quot;&gt;在这种情况下，我会很明显地会指出，“搜索引擎优化需要持续的工作，而这种工作通常不能通过以某种方式创建网站来完成的。”&lt;/p&gt;&lt;p style=&quot;box-sizing: border-box; margin-top: 0px; margin-bottom: 24px; white-space: normal; background-color: rgb(255, 255, 255); color: rgb(14, 14, 14); font-family: Arial, &amp;quot;Hiragino Sans GB&amp;quot;, 冬青黑, &amp;quot;Microsoft YaHei&amp;quot;, 微软雅黑, SimSun, 宋体, Helvetica, Tahoma, &amp;quot;Arial sans-serif&amp;quot;; text-align: justify;&quot;&gt;我经常建议客户在他们的网站上添加一个博客，以获得更多的内容，并提高排名的机会。&lt;/p&gt;&lt;p style=&quot;box-sizing: border-box; margin-top: 0px; margin-bottom: 24px; white-space: normal; background-color: rgb(255, 255, 255); color: rgb(14, 14, 14); font-family: Arial, &amp;quot;Hiragino Sans GB&amp;quot;, 冬青黑, &amp;quot;Microsoft YaHei&amp;quot;, 微软雅黑, SimSun, 宋体, Helvetica, Tahoma, &amp;quot;Arial sans-serif&amp;quot;; text-align: justify;&quot;&gt;&lt;span style=&quot;box-sizing: border-box; font-weight: 700;&quot;&gt;结语&lt;/span&gt;&lt;/p&gt;&lt;p style=&quot;box-sizing: border-box; margin-top: 0px; margin-bottom: 24px; white-space: normal; background-color: rgb(255, 255, 255); color: rgb(14, 14, 14); font-family: Arial, &amp;quot;Hiragino Sans GB&amp;quot;, 冬青黑, &amp;quot;Microsoft YaHei&amp;quot;, 微软雅黑, SimSun, 宋体, Helvetica, Tahoma, &amp;quot;Arial sans-serif&amp;quot;; text-align: justify;&quot;&gt;虽然这只是一个简短的总结，但这些是网站所有者和设计师将面对的最重要的 SEO 话题。通过了解这些知识，你可以更好地创建出对用户和搜索引擎都友好的网站。&lt;/p&gt;&lt;p style=&quot;box-sizing: border-box; margin-top: 0px; margin-bottom: 24px; white-space: normal; background-color: rgb(255, 255, 255); color: rgb(14, 14, 14); font-family: Arial, &amp;quot;Hiragino Sans GB&amp;quot;, 冬青黑, &amp;quot;Microsoft YaHei&amp;quot;, 微软雅黑, SimSun, 宋体, Helvetica, Tahoma, &amp;quot;Arial sans-serif&amp;quot;; text-align: justify;&quot;&gt;本文由易优小编设计 原创授权发布易优网站，未经授权，转载必究。&lt;/p&gt;&lt;p&gt;&lt;br/&gt;&lt;/p&gt;', '1526611744', '1531709637');
INSERT INTO `ey_article_content` VALUES ('14', '38', '&lt;p style=&quot;box-sizing: border-box; margin-top: 0px; margin-bottom: 24px; white-space: normal; background-color: rgb(255, 255, 255); color: rgb(14, 14, 14); font-family: Arial, &amp;quot;Hiragino Sans GB&amp;quot;, 冬青黑, &amp;quot;Microsoft YaHei&amp;quot;, 微软雅黑, SimSun, 宋体, Helvetica, Tahoma, &amp;quot;Arial sans-serif&amp;quot;; text-align: justify;&quot;&gt;SEO很多伙伴都了解，就是搜索引擎排名优化，通过对网站内部和外部进行优化当用户搜索相应关键词时网站能够排名在搜索引擎前面，具体可以百度搜索“网络营销课程”查看商梦网校操作的案例！&lt;/p&gt;&lt;p style=&quot;box-sizing: border-box; margin-top: 0px; margin-bottom: 24px; white-space: normal; background-color: rgb(255, 255, 255); color: rgb(14, 14, 14); font-family: Arial, &amp;quot;Hiragino Sans GB&amp;quot;, 冬青黑, &amp;quot;Microsoft YaHei&amp;quot;, 微软雅黑, SimSun, 宋体, Helvetica, Tahoma, &amp;quot;Arial sans-serif&amp;quot;; text-align: justify;&quot;&gt;但单页SEO很多伙伴可能会有点陌生，单页SEO是将单页网站与内容内容结合为一体的SEO优化方案，主要是提升网站流量利用率让用户打开网站就能看到目标页面，转换更多订单，创造更多收益。单页SEO的操作理念也是由商梦网校提出，并一起推荐操作大家的模式。&lt;/p&gt;&lt;p style=&quot;box-sizing: border-box; margin-top: 0px; margin-bottom: 24px; white-space: normal; background-color: rgb(255, 255, 255); color: rgb(14, 14, 14); font-family: Arial, &amp;quot;Hiragino Sans GB&amp;quot;, 冬青黑, &amp;quot;Microsoft YaHei&amp;quot;, 微软雅黑, SimSun, 宋体, Helvetica, Tahoma, &amp;quot;Arial sans-serif&amp;quot;; text-align: justify;&quot;&gt;那什么又是单页SEO站群呢，因为操作SEO成功率并不是100%，也就是意味着你做了并不会绝对有排名。因为在任何时候搜索引擎，特别是百度的索引数据库里，只有60%的网页数量。也就是说，大量的网页它是没有收录进来，它本身的能力所限无法做到中文的所有几百亿个网页都收录进来。所以，对于大部分网站，都有被删除网页，没有排名，或被K的经历，或没有排名。处理办法：坦然面对这一切。一个网站的成本才多少钱？如果因此对SEO失去信心，那就是最大的失去了。&lt;/p&gt;&lt;p style=&quot;box-sizing: border-box; margin-top: 0px; margin-bottom: 24px; white-space: normal; background-color: rgb(255, 255, 255); color: rgb(14, 14, 14); font-family: Arial, &amp;quot;Hiragino Sans GB&amp;quot;, 冬青黑, &amp;quot;Microsoft YaHei&amp;quot;, 微软雅黑, SimSun, 宋体, Helvetica, Tahoma, &amp;quot;Arial sans-serif&amp;quot;; text-align: justify;&quot;&gt;不过我们也想到了一个更好的解决方案，这个方案在最早期我们开始操作，并且取得了非常不错的成绩就是“站群”，我们可以假设一个网站排名的机会为1，如果我们用 10 个网站来进行优化排名机会可以提升 10 倍， 10 个网站我们也不要求都获得排名只需要有1- 3 个网站获得排名这个操作就是成功的，因为对于我们做站群来说投入 10 个网站的成本也就 1000 块左右；这个投资也是非常划算的，这个思路其实有点像竞价，不像传统的SEO，因为传统的SEO我们投资一个网站成本一两百，就想获得排名，然后给我们几百上千倍的回报。结果就相当于我们把希望寄托在一颗树上，结果这颗树没有开花结果，我们就饿死了。&lt;/p&gt;&lt;p style=&quot;box-sizing: border-box; margin-top: 0px; margin-bottom: 24px; white-space: normal; background-color: rgb(255, 255, 255); color: rgb(14, 14, 14); font-family: Arial, &amp;quot;Hiragino Sans GB&amp;quot;, 冬青黑, &amp;quot;Microsoft YaHei&amp;quot;, 微软雅黑, SimSun, 宋体, Helvetica, Tahoma, &amp;quot;Arial sans-serif&amp;quot;; text-align: justify;&quot;&gt;想给一个项目建立数十个网站也是需要掌握很多技术的，特别是批量建站方面，以及后期的维护。这次商梦网校升级加入的单页SEO站群操作方法，没有长篇大论直接给你演示怎么干，你只需要复制我们提供的方法就可以了。当然这里面也有很多核心的技术，比如域名注册和空间购买技巧虽然非常简单，但是直接会影响我们后期操作结果，我们给提供的技巧也会将你的成本降到低，如果投资建立 10 个网站域名与空间的成本不到 1000 元。相当于 1000 你就可以启动一个站群项目。核心的还是文章的采集，我们的原理是利用火车头采集原创文章然后实现挂机自动发布，只需要设置好每天几点运行软件就会自动更新网站文章，还会自动网站自动瞄文本，自动加入关键词。这些很多同学可能会问会不会太复杂，可以这样告诉你复杂的工作我们已经帮你搞定，到你使用的时候已经是打包好的解决方案。&lt;/p&gt;&lt;p style=&quot;box-sizing: border-box; margin-top: 0px; margin-bottom: 24px; white-space: normal; background-color: rgb(255, 255, 255); color: rgb(14, 14, 14); font-family: Arial, &amp;quot;Hiragino Sans GB&amp;quot;, 冬青黑, &amp;quot;Microsoft YaHei&amp;quot;, 微软雅黑, SimSun, 宋体, Helvetica, Tahoma, &amp;quot;Arial sans-serif&amp;quot;; text-align: justify;&quot;&gt;网站前期整体搭建只要花时间就能搞定，但真正考验人的基实还是在于后期优化，对于网站后期优化特别是外链增加收录和权重这一块，我们还是没有长篇大论会直接给你演示实用、高效的方法让你的站群快速的获得收录，增加权重，获得排名，你需要做的就拷贝我们商梦网校的方法和模式；这些经验都是我们长期操作整理下来的，并非几天修炼的结果。&lt;/p&gt;&lt;p&gt;&lt;br/&gt;&lt;/p&gt;', '1527555069', '1531709578');

-- ----------------------------
-- Table structure for ey_auth_role
-- ----------------------------
DROP TABLE IF EXISTS `ey_auth_role`;
CREATE TABLE `ey_auth_role` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT '' COMMENT '角色名',
  `pid` int(10) DEFAULT '0' COMMENT '父角色ID',
  `remark` text COMMENT '备注信息',
  `grade` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT '级别',
  `language` text COMMENT '多语言权限',
  `online_update` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '在线升级',
  `only_oneself` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '只看自己发布',
  `cud` varchar(255) DEFAULT '' COMMENT '增改删',
  `permission` text COMMENT '已允许的权限',
  `built_in` tinyint(1) DEFAULT '0' COMMENT '内置用户组，1表示内置',
  `sort_order` int(10) DEFAULT '0' COMMENT '排序号',
  `status` tinyint(1) DEFAULT '1' COMMENT '状态(1=正常，0=屏蔽)',
  `admin_id` int(10) DEFAULT '0' COMMENT '操作管理员ID',
  `add_time` int(11) DEFAULT '0' COMMENT '新增时间',
  `update_time` int(11) DEFAULT '0' COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COMMENT='管理员角色表';

-- ----------------------------
-- Records of ey_auth_role
-- ----------------------------
INSERT INTO `ey_auth_role` VALUES ('1', '优化推广员', '0', '', '0', 'a:1:{i:0;s:2:\"cn\";}', '0', '1', 'a:3:{i:0;s:3:\"add\";i:1;s:4:\"edit\";i:2;s:3:\"del\";}', 'a:2:{s:5:\"rules\";a:8:{i:0;s:1:\"1\";i:1;s:1:\"3\";i:2;s:1:\"4\";i:3;s:1:\"8\";i:4;s:1:\"9\";i:5;s:2:\"10\";i:6;s:2:\"14\";i:7;i:2;}s:7:\"arctype\";a:63:{i:0;s:1:\"1\";i:1;s:1:\"2\";i:2;s:1:\"3\";i:3;s:1:\"4\";i:4;s:1:\"5\";i:5;s:1:\"6\";i:6;s:2:\"33\";i:7;s:2:\"34\";i:8;s:2:\"35\";i:9;s:2:\"36\";i:10;s:2:\"37\";i:11;s:2:\"38\";i:12;s:2:\"39\";i:13;s:2:\"40\";i:14;s:2:\"41\";i:15;s:2:\"42\";i:16;s:2:\"43\";i:17;s:2:\"44\";i:18;s:2:\"45\";i:19;s:2:\"46\";i:20;s:2:\"47\";i:21;s:2:\"48\";i:22;s:1:\"8\";i:23;s:2:\"32\";i:24;s:1:\"9\";i:25;s:2:\"30\";i:26;s:2:\"31\";i:27;s:2:\"11\";i:28;s:2:\"12\";i:29;s:2:\"13\";i:30;s:2:\"23\";i:31;s:2:\"20\";i:32;s:2:\"24\";i:33;s:2:\"25\";i:34;s:2:\"21\";i:35;s:2:\"26\";i:36;s:2:\"22\";i:37;s:2:\"27\";i:38;s:2:\"28\";i:39;s:2:\"29\";i:40;s:2:\"31\";i:41;s:2:\"32\";i:42;s:2:\"33\";i:43;s:2:\"34\";i:44;s:2:\"35\";i:45;s:2:\"36\";i:46;s:2:\"37\";i:47;s:2:\"38\";i:48;s:2:\"39\";i:49;s:2:\"40\";i:50;s:2:\"41\";i:51;s:2:\"42\";i:52;s:2:\"43\";i:53;s:2:\"44\";i:54;s:2:\"45\";i:55;s:2:\"46\";i:56;s:2:\"47\";i:57;s:2:\"48\";i:58;s:2:\"49\";i:59;s:2:\"50\";i:60;s:2:\"51\";i:61;s:2:\"52\";i:62;s:2:\"53\";}}', '1', '100', '1', '0', '1541207843', '0');
INSERT INTO `ey_auth_role` VALUES ('2', '内容管理员', '0', '', '0', 'a:1:{i:0;s:2:\"cn\";}', '0', '1', 'a:3:{i:0;s:3:\"add\";i:1;s:4:\"edit\";i:2;s:3:\"del\";}', 'a:2:{s:5:\"rules\";a:4:{i:0;s:1:\"1\";i:1;s:2:\"10\";i:2;s:2:\"14\";i:3;i:2;}s:7:\"arctype\";a:63:{i:0;s:1:\"1\";i:1;s:1:\"2\";i:2;s:1:\"3\";i:3;s:1:\"4\";i:4;s:1:\"5\";i:5;s:1:\"6\";i:6;s:2:\"33\";i:7;s:2:\"34\";i:8;s:2:\"35\";i:9;s:2:\"36\";i:10;s:2:\"37\";i:11;s:2:\"38\";i:12;s:2:\"39\";i:13;s:2:\"40\";i:14;s:2:\"41\";i:15;s:2:\"42\";i:16;s:2:\"43\";i:17;s:2:\"44\";i:18;s:2:\"45\";i:19;s:2:\"46\";i:20;s:2:\"47\";i:21;s:2:\"48\";i:22;s:1:\"8\";i:23;s:2:\"32\";i:24;s:1:\"9\";i:25;s:2:\"30\";i:26;s:2:\"31\";i:27;s:2:\"11\";i:28;s:2:\"12\";i:29;s:2:\"13\";i:30;s:2:\"23\";i:31;s:2:\"20\";i:32;s:2:\"24\";i:33;s:2:\"25\";i:34;s:2:\"21\";i:35;s:2:\"26\";i:36;s:2:\"22\";i:37;s:2:\"27\";i:38;s:2:\"28\";i:39;s:2:\"29\";i:40;s:2:\"31\";i:41;s:2:\"32\";i:42;s:2:\"33\";i:43;s:2:\"34\";i:44;s:2:\"35\";i:45;s:2:\"36\";i:46;s:2:\"37\";i:47;s:2:\"38\";i:48;s:2:\"39\";i:49;s:2:\"40\";i:50;s:2:\"41\";i:51;s:2:\"42\";i:52;s:2:\"43\";i:53;s:2:\"44\";i:54;s:2:\"45\";i:55;s:2:\"46\";i:56;s:2:\"47\";i:57;s:2:\"48\";i:58;s:2:\"49\";i:59;s:2:\"50\";i:60;s:2:\"51\";i:61;s:2:\"52\";i:62;s:2:\"53\";}}', '1', '100', '1', '0', '1541207846', '0');

-- ----------------------------
-- Table structure for ey_channelfield
-- ----------------------------
DROP TABLE IF EXISTS `ey_channelfield`;
CREATE TABLE `ey_channelfield` (
  `id` int(10) NOT NULL AUTO_INCREMENT COMMENT '自增ID',
  `name` varchar(32) NOT NULL DEFAULT '' COMMENT '字段名称',
  `channel_id` int(10) NOT NULL DEFAULT '0' COMMENT '所属文档模型id',
  `title` varchar(32) NOT NULL DEFAULT '' COMMENT '字段标题',
  `dtype` varchar(32) NOT NULL DEFAULT '' COMMENT '字段类型',
  `define` varchar(128) NOT NULL DEFAULT '' COMMENT '字段定义',
  `maxlength` int(10) NOT NULL DEFAULT '0' COMMENT '最大长度，文本数据必须填写，大于255为text类型',
  `dfvalue` varchar(1000) NOT NULL DEFAULT '' COMMENT '默认值',
  `dfvalue_unit` varchar(50) NOT NULL DEFAULT '' COMMENT '数值单位',
  `remark` varchar(256) NOT NULL DEFAULT '' COMMENT '提示说明',
  `ifeditable` tinyint(1) NOT NULL DEFAULT '1' COMMENT '是否在编辑页显示',
  `ifrequire` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否必填',
  `ifsystem` tinyint(1) NOT NULL DEFAULT '0' COMMENT '字段分类，1=系统(不可修改)，0=自定义',
  `ifmain` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否主表字段',
  `sort_order` int(5) NOT NULL DEFAULT '100' COMMENT '排序',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '状态',
  `add_time` int(11) NOT NULL DEFAULT '0' COMMENT '创建时间',
  `update_time` int(11) NOT NULL DEFAULT '0' COMMENT '更新时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`,`channel_id`)
) ENGINE=MyISAM AUTO_INCREMENT=52 DEFAULT CHARSET=utf8 COMMENT='自定义字段表';

-- ----------------------------
-- Records of ey_channelfield
-- ----------------------------
INSERT INTO `ey_channelfield` VALUES ('1', 'add_time', '0', '新增时间', 'datetime', 'int(11)', '250', '', '', '', '1', '0', '1', '1', '100', '1', '1533091575', '1533091575');
INSERT INTO `ey_channelfield` VALUES ('2', 'update_time', '0', '更新时间', 'datetime', 'int(11)', '250', '', '', '', '1', '0', '1', '1', '100', '1', '1533091601', '1533091601');
INSERT INTO `ey_channelfield` VALUES ('3', 'aid', '0', '文档ID', 'int', 'int(11)', '250', '', '', '', '1', '0', '1', '1', '100', '1', '1533091624', '1533091624');
INSERT INTO `ey_channelfield` VALUES ('4', 'typeid', '0', '当前栏目ID', 'int', 'int(11)', '250', '', '', '', '1', '0', '1', '1', '100', '1', '1533091930', '1533091930');
INSERT INTO `ey_channelfield` VALUES ('5', 'channel', '0', '模型ID', 'int', 'int(11)', '250', '', '', '', '1', '0', '1', '1', '100', '1', '1533092214', '1533092214');
INSERT INTO `ey_channelfield` VALUES ('6', 'is_b', '0', '是否加粗', 'switch', 'tinyint(1)', '250', '', '', '', '1', '0', '1', '1', '100', '1', '1533092246', '1533092246');
INSERT INTO `ey_channelfield` VALUES ('7', 'title', '0', '文档标题', 'text', 'varchar(250)', '250', '', '', '', '1', '0', '1', '1', '100', '1', '1533092381', '1533092381');
INSERT INTO `ey_channelfield` VALUES ('8', 'litpic', '0', '封面图', 'img', 'varchar(250)', '250', '', '', '', '1', '0', '1', '1', '100', '1', '1533092398', '1533092398');
INSERT INTO `ey_channelfield` VALUES ('9', 'is_head', '0', '是否头条', 'switch', 'tinyint(1)', '250', '', '', '', '1', '0', '1', '1', '100', '1', '1533092420', '1533092420');
INSERT INTO `ey_channelfield` VALUES ('10', 'is_special', '0', '是否特荐', 'switch', 'tinyint(1)', '250', '', '', '', '1', '0', '1', '1', '100', '1', '1533092439', '1533092439');
INSERT INTO `ey_channelfield` VALUES ('11', 'is_top', '0', '是否置顶', 'switch', 'tinyint(1)', '250', '', '', '', '1', '0', '1', '1', '100', '1', '1533092454', '1533092454');
INSERT INTO `ey_channelfield` VALUES ('12', 'is_recom', '0', '是否推荐', 'switch', 'tinyint(1)', '250', '', '', '', '1', '0', '1', '1', '100', '1', '1533092468', '1533092468');
INSERT INTO `ey_channelfield` VALUES ('13', 'is_jump', '0', '是否跳转', 'switch', 'tinyint(1)', '250', '', '', '', '1', '0', '1', '1', '100', '1', '1533092484', '1533092484');
INSERT INTO `ey_channelfield` VALUES ('14', 'author', '0', '编辑者', 'text', 'varchar(250)', '250', '', '', '', '1', '0', '1', '1', '100', '1', '1533092498', '1533092498');
INSERT INTO `ey_channelfield` VALUES ('15', 'click', '0', '浏览量', 'int', 'int(11)', '250', '', '', '', '1', '0', '1', '1', '100', '1', '1533092512', '1533092512');
INSERT INTO `ey_channelfield` VALUES ('16', 'arcrank', '0', '阅读权限', 'select', 'tinyint(1)', '250', '', '', '', '1', '0', '1', '1', '100', '1', '1533092534', '1533092534');
INSERT INTO `ey_channelfield` VALUES ('17', 'jumplinks', '0', '跳转链接', 'text', 'varchar(250)', '250', '', '', '', '1', '0', '1', '1', '100', '1', '1533092553', '1533092553');
INSERT INTO `ey_channelfield` VALUES ('18', 'ismake', '0', '是否静态页面', 'switch', 'tinyint(1)', '250', '', '', '', '1', '0', '1', '1', '100', '1', '1533092698', '1533092698');
INSERT INTO `ey_channelfield` VALUES ('19', 'seo_title', '0', 'SEO标题', 'text', 'varchar(250)', '250', '', '', '', '1', '0', '1', '1', '100', '1', '1533092713', '1533092713');
INSERT INTO `ey_channelfield` VALUES ('20', 'seo_keywords', '0', 'SEO关键词', 'text', 'varchar(250)', '250', '', '', '', '1', '0', '1', '1', '100', '1', '1533092725', '1533092725');
INSERT INTO `ey_channelfield` VALUES ('21', 'seo_description', '0', 'SEO描述', 'text', 'varchar(250)', '250', '', '', '', '1', '0', '1', '1', '100', '1', '1533092739', '1533092739');
INSERT INTO `ey_channelfield` VALUES ('22', 'status', '0', '状态', 'switch', 'tinyint(1)', '250', '', '', '', '1', '0', '1', '1', '100', '1', '1533092753', '1533092753');
INSERT INTO `ey_channelfield` VALUES ('23', 'sort_order', '0', '排序号', 'int', 'int(11)', '250', '', '', '', '1', '0', '1', '1', '100', '1', '1533092766', '1533092766');
INSERT INTO `ey_channelfield` VALUES ('24', 'content', '2', '内容', 'htmltext', 'longtext', '250', '', '', '', '1', '0', '1', '0', '100', '1', '1533359739', '1533359739');
INSERT INTO `ey_channelfield` VALUES ('25', 'content', '3', '内容详情', 'htmltext', 'longtext', '250', '', '', '', '1', '0', '1', '0', '100', '1', '1533359588', '1533359588');
INSERT INTO `ey_channelfield` VALUES ('26', 'content', '4', '内容详情', 'htmltext', 'longtext', '250', '', '', '', '1', '0', '1', '0', '100', '1', '1533359752', '1533359752');
INSERT INTO `ey_channelfield` VALUES ('27', 'content', '6', '内容详情', 'htmltext', 'longtext', '250', '', '', '', '1', '0', '1', '0', '100', '1', '1533464715', '1533464715');
INSERT INTO `ey_channelfield` VALUES ('29', 'content', '1', '内容详情', 'htmltext', 'longtext', '250', '', '', '', '1', '0', '1', '0', '100', '1', '1533464713', '1533464713');
INSERT INTO `ey_channelfield` VALUES ('30', 'update_time', '-99', '更新时间', 'datetime', 'int(11)', '11', '0', '', '', '1', '0', '1', '1', '100', '1', '1533524780', '1533524780');
INSERT INTO `ey_channelfield` VALUES ('31', 'add_time', '-99', '新增时间', 'datetime', 'int(11)', '11', '0', '', '', '1', '0', '1', '1', '100', '1', '1533524780', '1533524780');
INSERT INTO `ey_channelfield` VALUES ('32', 'status', '-99', '启用 (1=正常，0=屏蔽)', 'switch', 'tinyint(1)', '1', '1', '', '', '1', '0', '1', '1', '100', '1', '1533524780', '1533524780');
INSERT INTO `ey_channelfield` VALUES ('33', 'is_part', '-99', '栏目属性：0=内容栏目，1=外部链接', 'switch', 'tinyint(1)', '1', '0', '', '', '1', '0', '1', '1', '100', '1', '1533524780', '1533524780');
INSERT INTO `ey_channelfield` VALUES ('34', 'is_hidden', '-99', '是否隐藏栏目：0=显示，1=隐藏', 'switch', 'tinyint(1)', '1', '0', '', '', '1', '0', '1', '1', '100', '1', '1533524780', '1533524780');
INSERT INTO `ey_channelfield` VALUES ('35', 'sort_order', '-99', '排序号', 'int', 'int(10)', '10', '0', '', '', '1', '0', '1', '1', '100', '1', '1533524780', '1533524780');
INSERT INTO `ey_channelfield` VALUES ('36', 'seo_description', '-99', 'seo描述', 'multitext', 'text', '0', '', '', '', '1', '0', '1', '1', '100', '1', '1533524780', '1533524780');
INSERT INTO `ey_channelfield` VALUES ('37', 'seo_keywords', '-99', 'seo关键字', 'text', 'varchar(200)', '200', '', '', '', '1', '0', '1', '1', '100', '1', '1533524780', '1533524780');
INSERT INTO `ey_channelfield` VALUES ('38', 'seo_title', '-99', 'SEO标题', 'text', 'varchar(200)', '200', '', '', '', '1', '0', '1', '1', '100', '1', '1533524780', '1533524780');
INSERT INTO `ey_channelfield` VALUES ('39', 'tempview', '-99', '文档模板文件名', 'text', 'varchar(200)', '200', '', '', '', '1', '0', '1', '1', '100', '1', '1533524780', '1533524780');
INSERT INTO `ey_channelfield` VALUES ('40', 'templist', '-99', '列表模板文件名', 'text', 'varchar(200)', '200', '', '', '', '1', '0', '1', '1', '100', '1', '1533524780', '1533524780');
INSERT INTO `ey_channelfield` VALUES ('41', 'litpic', '-99', '栏目图片', 'img', 'varchar(250)', '250', '', '', '', '1', '0', '1', '1', '100', '1', '1533524780', '1533524780');
INSERT INTO `ey_channelfield` VALUES ('42', 'typelink', '-99', '栏目链接', 'text', 'varchar(200)', '200', '', '', '', '1', '0', '1', '1', '100', '1', '1533524780', '1533524780');
INSERT INTO `ey_channelfield` VALUES ('43', 'grade', '-99', '栏目等级', 'switch', 'tinyint(1)', '1', '0', '', '', '1', '0', '1', '1', '100', '1', '1533524780', '1533524780');
INSERT INTO `ey_channelfield` VALUES ('44', 'englist_name', '-99', '栏目英文名', 'text', 'varchar(200)', '200', '', '', '', '1', '0', '1', '1', '100', '1', '1533524780', '1533524780');
INSERT INTO `ey_channelfield` VALUES ('45', 'dirpath', '-99', '目录存放HTML路径', 'text', 'varchar(200)', '200', '', '', '', '1', '0', '1', '1', '100', '1', '1533524780', '1533524780');
INSERT INTO `ey_channelfield` VALUES ('46', 'dirname', '-99', '目录英文名', 'text', 'varchar(200)', '200', '', '', '', '1', '0', '1', '1', '100', '1', '1533524780', '1533524780');
INSERT INTO `ey_channelfield` VALUES ('47', 'typename', '-99', '栏目名称', 'text', 'varchar(200)', '200', '', '', '', '1', '0', '1', '1', '100', '1', '1533524780', '1533524780');
INSERT INTO `ey_channelfield` VALUES ('48', 'parent_id', '-99', '栏目上级ID', 'int', 'int(10)', '10', '0', '', '', '1', '0', '1', '1', '100', '1', '1533524780', '1533524780');
INSERT INTO `ey_channelfield` VALUES ('49', 'current_channel', '-99', '栏目当前模型ID', 'int', 'int(10)', '10', '0', '', '', '1', '0', '1', '1', '100', '1', '1533524780', '1533524780');
INSERT INTO `ey_channelfield` VALUES ('50', 'channeltype', '-99', '栏目顶级模型ID', 'int', 'int(10)', '10', '0', '', '', '1', '0', '1', '1', '100', '1', '1533524780', '1533524780');
INSERT INTO `ey_channelfield` VALUES ('51', 'id', '-99', '栏目ID', 'int', 'int(10)', '10', '', '', '', '1', '0', '1', '1', '100', '1', '1533524780', '1533524780');

-- ----------------------------
-- Table structure for ey_channeltype
-- ----------------------------
DROP TABLE IF EXISTS `ey_channeltype`;
CREATE TABLE `ey_channeltype` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nid` varchar(50) NOT NULL DEFAULT '' COMMENT '识别id',
  `title` varchar(30) DEFAULT '' COMMENT '名称',
  `ntitle` varchar(30) DEFAULT '' COMMENT '左侧菜单名称',
  `table` varchar(50) DEFAULT '' COMMENT '表名',
  `ctl_name` varchar(50) DEFAULT '' COMMENT '控制器名称（区分大小写）',
  `status` tinyint(1) DEFAULT '1' COMMENT '状态(1=启用，0=屏蔽)',
  `sort_order` smallint(6) DEFAULT '50' COMMENT '排序',
  `add_time` int(11) DEFAULT '0' COMMENT '新增时间',
  `update_time` int(11) DEFAULT '0' COMMENT '更新时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idention` (`nid`) USING BTREE,
  UNIQUE KEY `ctl_name` (`ctl_name`) USING BTREE
) ENGINE=MyISAM AUTO_INCREMENT=9 DEFAULT CHARSET=utf8 COMMENT='系统模型表';

-- ----------------------------
-- Records of ey_channeltype
-- ----------------------------
INSERT INTO `ey_channeltype` VALUES ('1', 'article', '文章模型', '文章', 'article', 'Article', '1', '1', '0', '1543802839');
INSERT INTO `ey_channeltype` VALUES ('4', 'download', '下载模型', '下载', 'download', 'Download', '1', '4', '0', '1543802839');
INSERT INTO `ey_channeltype` VALUES ('2', 'product', '产品模型', '产品', 'product', 'Product', '1', '2', '0', '1543802839');
INSERT INTO `ey_channeltype` VALUES ('8', 'guestbook', '留言模型', '留言', 'guestbook', 'Guestbook', '1', '8', '1509197711', '1543802839');
INSERT INTO `ey_channeltype` VALUES ('6', 'single', '单页模型', '单页', 'single', 'Single', '1', '6', '1523091961', '1543802839');
INSERT INTO `ey_channeltype` VALUES ('3', 'images', '图集模型', '图集', 'images', 'Images', '1', '3', '1523929121', '1543802839');

-- ----------------------------
-- Table structure for ey_config
-- ----------------------------
DROP TABLE IF EXISTS `ey_config`;
CREATE TABLE `ey_config` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) DEFAULT '' COMMENT '配置的key键名',
  `value` text,
  `inc_type` varchar(64) DEFAULT '' COMMENT '配置分组',
  `desc` varchar(50) DEFAULT '' COMMENT '描述',
  `lang` varchar(50) DEFAULT 'cn' COMMENT '语言标识',
  `is_del` tinyint(1) DEFAULT '0' COMMENT '是否已删除，0=否，1=是',
  `update_time` int(11) DEFAULT '0' COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=166 DEFAULT CHARSET=utf8 COMMENT='系统配置表';

-- ----------------------------
-- Records of ey_config
-- ----------------------------
INSERT INTO `ey_config` VALUES ('1', 'is_mark', '0', 'water', '', 'cn', '0', '0');
INSERT INTO `ey_config` VALUES ('2', 'mark_txt', '易优Cms', 'water', '', 'cn', '0', '0');
INSERT INTO `ey_config` VALUES ('3', 'mark_img', '/public/upload/water/2018/05/08/93806077e5a4c4e12ceed30df5cde761.png', 'water', '', 'cn', '0', '0');
INSERT INTO `ey_config` VALUES ('4', 'mark_width', '200', 'water', '', 'cn', '0', '0');
INSERT INTO `ey_config` VALUES ('5', 'mark_height', '50', 'water', '', 'cn', '0', '0');
INSERT INTO `ey_config` VALUES ('6', 'mark_degree', '54', 'water', '', 'cn', '0', '0');
INSERT INTO `ey_config` VALUES ('7', 'mark_quality', '56', 'water', '', 'cn', '0', '0');
INSERT INTO `ey_config` VALUES ('8', 'mark_sel', '9', 'water', '', 'cn', '0', '0');
INSERT INTO `ey_config` VALUES ('9', 'sms_time_out', '120', 'sms', '', 'cn', '0', '0');
INSERT INTO `ey_config` VALUES ('10', 'theme_style', '1', 'basic', '', 'cn', '0', '0');
INSERT INTO `ey_config` VALUES ('11', 'file_size', '500', 'basic', '', 'cn', '0', '0');
INSERT INTO `ey_config` VALUES ('12', 'image_type', 'jpg|gif|png|bmp|jpeg|ico', 'basic', '', 'cn', '0', '0');
INSERT INTO `ey_config` VALUES ('13', 'file_type', 'zip|gz|rar|iso|doc|xsl|ppt|wps', 'basic', '', 'cn', '0', '0');
INSERT INTO `ey_config` VALUES ('14', 'media_type', 'swf|mpg|mp3|rm|rmvb|wmv|wma|wav|mid|mov|mp4', 'basic', '', 'cn', '0', '0');
INSERT INTO `ey_config` VALUES ('15', 'web_keywords', '', 'web', '', 'cn', '0', '0');
INSERT INTO `ey_config` VALUES ('17', 'sms_platform', '1', 'sms', '', 'cn', '0', '0');
INSERT INTO `ey_config` VALUES ('18', 'seo_viewtitle_format', '2', 'seo', '', 'cn', '0', '0');
INSERT INTO `ey_config` VALUES ('19', 'smtp_server', 'smtp.qq.com', 'smtp', '', 'cn', '0', '0');
INSERT INTO `ey_config` VALUES ('20', 'smtp_port', '465', 'smtp', '', 'cn', '0', '0');
INSERT INTO `ey_config` VALUES ('21', 'smtp_user', 'xxxxxxxxx@qq.com', 'smtp', '', 'cn', '0', '0');
INSERT INTO `ey_config` VALUES ('22', 'smtp_pwd', 'xxxxxxxxxxx', 'smtp', '', 'cn', '0', '0');
INSERT INTO `ey_config` VALUES ('23', 'inc_type', 'smtp', 'smtp', '', 'cn', '0', '0');
INSERT INTO `ey_config` VALUES ('24', 'mark_type', 'img', 'water', '', 'cn', '0', '0');
INSERT INTO `ey_config` VALUES ('25', 'mark_txt_size', '30', 'water', '', 'cn', '0', '0');
INSERT INTO `ey_config` VALUES ('26', 'mark_txt_color', '#000000', 'water', '', 'cn', '0', '0');
INSERT INTO `ey_config` VALUES ('27', 'oss_switch', '0', 'oss', '', 'cn', '0', '0');
INSERT INTO `ey_config` VALUES ('28', 'web_name', '易优Cms-演示站', 'web', '', 'cn', '0', '0');
INSERT INTO `ey_config` VALUES ('29', 'web_logo', '/public/upload/system/2018/05/24/8c675d3dae162ebc1936f3ab43d58960.png', 'web', '', 'cn', '0', '0');
INSERT INTO `ey_config` VALUES ('30', 'web_ico', '/favicon.ico', 'web', '', 'cn', '0', '0');
INSERT INTO `ey_config` VALUES ('31', 'web_basehost', 'http://127.0.0.4', 'web', '', 'cn', '0', '0');
INSERT INTO `ey_config` VALUES ('32', 'web_description', '', 'web', '', 'cn', '0', '0');
INSERT INTO `ey_config` VALUES ('79', 'web_recordnum', '琼ICP备xxxxxxxx号', 'web', '', 'cn', '0', '0');
INSERT INTO `ey_config` VALUES ('33', 'web_copyright', 'Copyright © 2012-2018 EYOUCMS. 易优CMS 版权所有', 'web', '', 'cn', '0', '0');
INSERT INTO `ey_config` VALUES ('34', 'web_thirdcode_pc', '', 'web', '', 'cn', '0', '0');
INSERT INTO `ey_config` VALUES ('35', 'web_thirdcode_wap', '', 'web', '', 'cn', '0', '0');
INSERT INTO `ey_config` VALUES ('39', 'seo_arcdir', '/html', 'seo', '', 'cn', '0', '0');
INSERT INTO `ey_config` VALUES ('40', 'seo_pseudo', '1', 'seo', '', 'cn', '0', '0');
INSERT INTO `ey_config` VALUES ('41', 'list_symbol', '&gt;', 'basic', '', 'cn', '0', '0');
INSERT INTO `ey_config` VALUES ('42', 'sitemap_auto', '1', 'sitemap', '', 'cn', '0', '0');
INSERT INTO `ey_config` VALUES ('43', 'sitemap_not1', '0', 'sitemap', '', 'cn', '0', '0');
INSERT INTO `ey_config` VALUES ('44', 'sitemap_not2', '1', 'sitemap', '', 'cn', '0', '0');
INSERT INTO `ey_config` VALUES ('45', 'sitemap_xml', '1', 'sitemap', '', 'cn', '0', '0');
INSERT INTO `ey_config` VALUES ('46', 'sitemap_txt', '0', 'sitemap', '', 'cn', '0', '0');
INSERT INTO `ey_config` VALUES ('47', 'sitemap_zzbaidutoken', '', 'sitemap', '', 'cn', '0', '0');
INSERT INTO `ey_config` VALUES ('48', 'seo_expires_in', '7200', 'seo', '', 'cn', '0', '0');
INSERT INTO `ey_config` VALUES ('55', 'web_title', '易优CMS -  Powered by Eyoucms.com', 'web', '', 'cn', '0', '0');
INSERT INTO `ey_config` VALUES ('56', 'smtp_test_eamil', 'xxxxxxxx@qq.com', 'smtp', '', 'cn', '0', '0');
INSERT INTO `ey_config` VALUES ('57', 'web_authortoken', 'bbe78c0c1afa6adfa4f01d85196e08e4', 'web', '', 'cn', '0', '1543801473');
INSERT INTO `ey_config` VALUES ('58', 'web_attr_3', '123456789', 'web', '', 'cn', '0', '0');
INSERT INTO `ey_config` VALUES ('59', 'web_attr_2', '8888-88888888', 'web', '', 'cn', '0', '0');
INSERT INTO `ey_config` VALUES ('60', 'web_attr_1', 'http://www.weibo.com', 'web', '', 'cn', '0', '0');
INSERT INTO `ey_config` VALUES ('61', 'web_attr_4', '/public/upload/system/2018/05/18/dfda33373cf1ba7baa39423036a5678a.jpg', 'web', '', 'cn', '0', '0');
INSERT INTO `ey_config` VALUES ('62', 'seo_inlet', '1', 'seo', '', 'cn', '0', '0');
INSERT INTO `ey_config` VALUES ('63', 'web_cmspath', '', 'web', '', 'cn', '0', '0');
INSERT INTO `ey_config` VALUES ('64', 'web_sqldatapath', '/data/sqldata', 'web', '', 'cn', '0', '0');
INSERT INTO `ey_config` VALUES ('65', 'web_cmsurl', '', 'web', '', 'cn', '0', '0');
INSERT INTO `ey_config` VALUES ('66', 'web_templets_dir', '/template', 'web', '', 'cn', '0', '0');
INSERT INTO `ey_config` VALUES ('67', 'web_templeturl', '/template', 'web', '', 'cn', '0', '0');
INSERT INTO `ey_config` VALUES ('68', 'web_templets_pc', '/template/pc', 'web', '', 'cn', '0', '0');
INSERT INTO `ey_config` VALUES ('69', 'web_templets_m', '/template/mobile', 'web', '', 'cn', '0', '0');
INSERT INTO `ey_config` VALUES ('70', 'web_eyoucms', 'http://www.eyoucms.com', 'web', '', 'cn', '0', '0');
INSERT INTO `ey_config` VALUES ('78', '_cmscopyright', 'nb7hx1rPHHjaq5qHcwSmu8B7', 'php', '', 'cn', '0', '1543802824');
INSERT INTO `ey_config` VALUES ('76', 'seo_liststitle_format', '2', 'seo', '', 'cn', '0', '0');
INSERT INTO `ey_config` VALUES ('77', 'web_status', '0', 'web', '', 'cn', '0', '0');
INSERT INTO `ey_config` VALUES ('80', 'web_is_authortoken', '0', 'web', '', 'cn', '0', '1543801504');
INSERT INTO `ey_config` VALUES ('81', 'web_adminbasefile', '/login.php', 'web', '', 'cn', '0', '0');
INSERT INTO `ey_config` VALUES ('82', 'seo_rewrite_format', '1', 'seo', '', 'cn', '0', '0');
INSERT INTO `ey_config` VALUES ('83', 'web_cmsmode', '2', 'web', '', 'cn', '0', '0');
INSERT INTO `ey_config` VALUES ('84', 'web_htmlcache_expires_in', '7200', 'web', '', 'cn', '0', '0');
INSERT INTO `ey_config` VALUES ('85', 'web_show_popup_upgrade', '1', 'web', '', 'cn', '0', '0');
INSERT INTO `ey_config` VALUES ('86', 'web_weapp_switch', '-1', 'web', '', 'cn', '0', '0');
INSERT INTO `ey_config` VALUES ('88', 'seo_dynamic_format', '1', 'seo', '', 'cn', '0', '0');
INSERT INTO `ey_config` VALUES ('89', 'system_sql_mode', 'NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION', 'system', '', 'cn', '0', '0');
INSERT INTO `ey_config` VALUES ('90', 'system_langnum', '1', 'system', '', 'cn', '0', '1543805286');
INSERT INTO `ey_config` VALUES ('165', 'system_home_default_lang', 'cn', 'system', '', 'cn', '0', '0');

-- ----------------------------
-- Table structure for ey_config_attribute
-- ----------------------------
DROP TABLE IF EXISTS `ey_config_attribute`;
CREATE TABLE `ey_config_attribute` (
  `attr_id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '表单id',
  `inc_type` varchar(20) DEFAULT '' COMMENT '变量分组',
  `attr_name` varchar(60) DEFAULT '' COMMENT '变量标题',
  `attr_var_name` varchar(50) DEFAULT '' COMMENT '变量名',
  `attr_input_type` tinyint(1) unsigned DEFAULT '0' COMMENT ' 0=文本框，1=下拉框，2=多行文本框，3=上传图片',
  `lang` varchar(50) DEFAULT 'cn' COMMENT '语言标识',
  `add_time` int(11) DEFAULT '0' COMMENT '新增时间',
  `update_time` int(11) DEFAULT '0' COMMENT '更新时间',
  PRIMARY KEY (`attr_id`)
) ENGINE=MyISAM AUTO_INCREMENT=9 DEFAULT CHARSET=utf8 COMMENT='自定义变量表';

-- ----------------------------
-- Records of ey_config_attribute
-- ----------------------------
INSERT INTO `ey_config_attribute` VALUES ('1', 'web', '微博地址', 'web_attr_1', '0', 'cn', '1525962574', '1526008818');
INSERT INTO `ey_config_attribute` VALUES ('2', 'web', '手机/固话', 'web_attr_2', '0', 'cn', '1525962600', '1525962600');
INSERT INTO `ey_config_attribute` VALUES ('3', 'web', 'QQ号码', 'web_attr_3', '0', 'cn', '1525962624', '1525962624');
INSERT INTO `ey_config_attribute` VALUES ('4', 'web', '微信二维码', 'web_attr_4', '3', 'cn', '1525999090', '1526008783');

-- ----------------------------
-- Table structure for ey_download_content
-- ----------------------------
DROP TABLE IF EXISTS `ey_download_content`;
CREATE TABLE `ey_download_content` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `aid` int(10) DEFAULT '0' COMMENT '文档ID',
  `content` longtext COMMENT '内容详情',
  `add_time` int(11) DEFAULT '0' COMMENT '新增时间',
  `update_time` int(11) DEFAULT '0' COMMENT '更新时间',
  PRIMARY KEY (`id`),
  KEY `news_id` (`aid`) USING BTREE
) ENGINE=MyISAM AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COMMENT='下载附加表';

-- ----------------------------
-- Records of ey_download_content
-- ----------------------------
INSERT INTO `ey_download_content` VALUES ('1', '30', '&lt;p&gt;工程机械推土挖掘机类网站模板，下载地址：&lt;a href=&quot;http://www.eyoucms.com/moban/16/668.html&quot; target=&quot;_self&quot;&gt;http://www.eyoucms.com/moban/16/668.html&lt;/a&gt;&lt;/p&gt;&lt;p&gt;&lt;br/&gt;&lt;/p&gt;&lt;p&gt;&lt;img src=&quot;/public/upload/download/2018/07/16/cb1af02c061429dd8a99c69df4f07838.jpg&quot;/&gt;&lt;/p&gt;', '1526614069', '1531888267');
INSERT INTO `ey_download_content` VALUES ('2', '31', '&lt;p&gt;职业教育培训机构网站模板，下载地址：&lt;a href=&quot;http://www.eyoucms.com/moban/10/673.html&quot; target=&quot;_self&quot;&gt;http://www.eyoucms.com/moban/10/673.html&lt;/a&gt;&lt;/p&gt;', '1526614168', '1531888375');

-- ----------------------------
-- Table structure for ey_download_file
-- ----------------------------
DROP TABLE IF EXISTS `ey_download_file`;
CREATE TABLE `ey_download_file` (
  `file_id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增ID',
  `aid` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT '产品ID',
  `title` varchar(200) DEFAULT '' COMMENT '产品标题',
  `file_url` varchar(255) DEFAULT '' COMMENT '文件存储路径',
  `file_size` varchar(255) DEFAULT '' COMMENT '文件大小',
  `file_ext` varchar(50) DEFAULT '' COMMENT '文件后缀名',
  `file_name` varchar(200) DEFAULT '' COMMENT '文件名',
  `file_mime` varchar(200) DEFAULT '' COMMENT '文件类型',
  `uhash` varchar(200) DEFAULT '' COMMENT '自定义的一种加密方式，用于文件下载权限验证',
  `md5file` varchar(200) DEFAULT '' COMMENT 'md5_file加密，可以检测上传/下载的文件包是否损坏',
  `sort_order` smallint(5) DEFAULT '0' COMMENT '排序',
  `add_time` int(10) unsigned DEFAULT '0' COMMENT '上传时间',
  PRIMARY KEY (`file_id`),
  KEY `arcid` (`aid`) USING BTREE
) ENGINE=MyISAM AUTO_INCREMENT=10 DEFAULT CHARSET=utf8 COMMENT='下载附件表';

-- ----------------------------
-- Records of ey_download_file
-- ----------------------------
INSERT INTO `ey_download_file` VALUES ('7', '30', '宅男女神一号种子', '/public/upload/download/2018/07/16/4b0f01441b5a246badf158fa99c140ac.zip', '9268', 'zip', '4b0f01441b5a246badf158fa99c140ac.zip', 'application/x-zip-compressed', '1837c4067aa99f7005e62b20bdb1a67f', '1837c4067aa99f7005e62b20bdb1a67f', '1', '1531710714');
INSERT INTO `ey_download_file` VALUES ('9', '31', '宅男女神二号种子', '/public/upload/download/2018/07/16/3b3f753af0f13e6e0237b9577e0bcd17.zip', '9268', 'zip', '3b3f753af0f13e6e0237b9577e0bcd17.zip', 'application/x-zip-compressed', '1837c4067aa99f7005e62b20bdb1a67f', '1837c4067aa99f7005e62b20bdb1a67f', '2', '1531710766');
INSERT INTO `ey_download_file` VALUES ('8', '31', '宅男女神二号种子', '/public/upload/download/2018/07/16/44bbd259222c81bd3c41112a73c904a0.zip', '9268', 'zip', '44bbd259222c81bd3c41112a73c904a0.zip', 'application/x-zip-compressed', '1837c4067aa99f7005e62b20bdb1a67f', '1837c4067aa99f7005e62b20bdb1a67f', '1', '1531710766');

-- ----------------------------
-- Table structure for ey_field_type
-- ----------------------------
DROP TABLE IF EXISTS `ey_field_type`;
CREATE TABLE `ey_field_type` (
  `name` varchar(32) NOT NULL DEFAULT '' COMMENT '字段类型',
  `title` varchar(64) NOT NULL DEFAULT '' COMMENT '中文类型名',
  `ifoption` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否需要设置选项',
  `sort_order` int(10) NOT NULL DEFAULT '0' COMMENT '排序',
  `add_time` int(11) NOT NULL DEFAULT '0' COMMENT '新增时间',
  `update_time` int(11) NOT NULL DEFAULT '0' COMMENT '更新时间',
  PRIMARY KEY (`name`),
  UNIQUE KEY `name` (`name`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='字段类型表';

-- ----------------------------
-- Records of ey_field_type
-- ----------------------------
INSERT INTO `ey_field_type` VALUES ('text', '单行文本', '0', '1', '1532485708', '1532485708');
INSERT INTO `ey_field_type` VALUES ('checkbox', '多选项', '1', '5', '1532485708', '1532485708');
INSERT INTO `ey_field_type` VALUES ('multitext', '多行文本', '0', '2', '1532485708', '1532485708');
INSERT INTO `ey_field_type` VALUES ('radio', '单选项', '1', '4', '1532485708', '1532485708');
INSERT INTO `ey_field_type` VALUES ('switch', '开关', '0', '13', '1532485708', '1532485708');
INSERT INTO `ey_field_type` VALUES ('select', '下拉框', '1', '6', '1532485708', '1532485708');
INSERT INTO `ey_field_type` VALUES ('img', '单张图', '0', '10', '1532485708', '1532485708');
INSERT INTO `ey_field_type` VALUES ('int', '整数类型', '0', '7', '1532485708', '1532485708');
INSERT INTO `ey_field_type` VALUES ('datetime', '日期和时间', '0', '12', '1532485708', '1532485708');
INSERT INTO `ey_field_type` VALUES ('htmltext', 'HTML文本', '0', '3', '1532485708', '1532485708');
INSERT INTO `ey_field_type` VALUES ('imgs', '多张图', '0', '11', '1532485708', '1532485708');
INSERT INTO `ey_field_type` VALUES ('decimal', '金额类型', '0', '9', '1532485708', '1532485708');
INSERT INTO `ey_field_type` VALUES ('float', '小数类型', '0', '8', '1532485708', '1532485708');

-- ----------------------------
-- Table structure for ey_guestbook
-- ----------------------------
DROP TABLE IF EXISTS `ey_guestbook`;
CREATE TABLE `ey_guestbook` (
  `aid` int(11) NOT NULL AUTO_INCREMENT,
  `typeid` int(11) DEFAULT '0' COMMENT '栏目ID',
  `channel` smallint(5) DEFAULT '0' COMMENT '模型ID',
  `ip` varchar(255) DEFAULT '' COMMENT 'ip地址',
  `lang` varchar(50) DEFAULT 'cn' COMMENT '语言标识',
  `add_time` int(11) DEFAULT '0' COMMENT '新增时间',
  `update_time` int(11) DEFAULT '0' COMMENT '更新时间',
  PRIMARY KEY (`aid`)
) ENGINE=MyISAM AUTO_INCREMENT=35 DEFAULT CHARSET=utf8 COMMENT='留言主表';

-- ----------------------------
-- Records of ey_guestbook
-- ----------------------------
INSERT INTO `ey_guestbook` VALUES ('15', '30', '8', '127.0.0.1', 'cn', '1526616554', '1526616554');
INSERT INTO `ey_guestbook` VALUES ('16', '30', '8', '127.0.0.1', 'cn', '1526616615', '1526616615');
INSERT INTO `ey_guestbook` VALUES ('17', '6', '8', '127.0.0.1', 'cn', '1526872813', '1526872813');
INSERT INTO `ey_guestbook` VALUES ('18', '6', '8', '127.0.0.1', 'cn', '1526873194', '1526873194');
INSERT INTO `ey_guestbook` VALUES ('19', '6', '8', '127.0.0.1', 'cn', '1526873250', '1526873250');
INSERT INTO `ey_guestbook` VALUES ('20', '6', '8', '127.0.0.1', 'cn', '1526873289', '1526873289');
INSERT INTO `ey_guestbook` VALUES ('21', '6', '8', '127.0.0.1', 'cn', '1526873428', '1526873428');
INSERT INTO `ey_guestbook` VALUES ('22', '6', '8', '127.0.0.1', 'cn', '1526873526', '1526873526');
INSERT INTO `ey_guestbook` VALUES ('23', '6', '8', '127.0.0.1', 'cn', '1526873538', '1526873538');
INSERT INTO `ey_guestbook` VALUES ('24', '6', '8', '127.0.0.1', 'cn', '1526873590', '1526873590');
INSERT INTO `ey_guestbook` VALUES ('25', '6', '8', '127.0.0.1', 'cn', '1526873598', '1526873598');
INSERT INTO `ey_guestbook` VALUES ('26', '6', '8', '127.0.0.1', 'cn', '1526873599', '1526873599');
INSERT INTO `ey_guestbook` VALUES ('27', '6', '8', '127.0.0.1', 'cn', '1526874038', '1526874038');
INSERT INTO `ey_guestbook` VALUES ('28', '6', '8', '127.0.0.1', 'cn', '1526874117', '1526874117');
INSERT INTO `ey_guestbook` VALUES ('29', '6', '8', '127.0.0.1', 'cn', '1526874555', '1526874555');
INSERT INTO `ey_guestbook` VALUES ('30', '6', '8', '127.0.0.1', 'cn', '1526876081', '1526876081');
INSERT INTO `ey_guestbook` VALUES ('31', '6', '8', '127.0.0.1', 'cn', '1526876214', '1526876214');
INSERT INTO `ey_guestbook` VALUES ('32', '6', '8', '127.0.0.1', 'cn', '1527060356', '1527060356');
INSERT INTO `ey_guestbook` VALUES ('33', '6', '8', '127.0.0.1', 'cn', '1527060517', '1527060517');
INSERT INTO `ey_guestbook` VALUES ('34', '6', '8', '127.0.0.1', 'cn', '1527156154', '1527156154');

-- ----------------------------
-- Table structure for ey_guestbook_attr
-- ----------------------------
DROP TABLE IF EXISTS `ey_guestbook_attr`;
CREATE TABLE `ey_guestbook_attr` (
  `guest_attr_id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '留言表单id自增',
  `aid` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT '留言id',
  `attr_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '表单id',
  `attr_value` text COMMENT '表单值',
  `lang` varchar(50) DEFAULT 'cn' COMMENT '语言标识',
  `add_time` int(11) DEFAULT '0' COMMENT '新增时间',
  `update_time` int(11) DEFAULT '0' COMMENT '更新时间',
  PRIMARY KEY (`guest_attr_id`),
  KEY `attr_id` (`attr_id`) USING BTREE,
  KEY `guest_id` (`aid`) USING BTREE
) ENGINE=MyISAM AUTO_INCREMENT=59 DEFAULT CHARSET=utf8 COMMENT='留言表单属性值';

-- ----------------------------
-- Records of ey_guestbook_attr
-- ----------------------------
INSERT INTO `ey_guestbook_attr` VALUES ('1', '15', '1', '蓉蓉', 'cn', '1526616554', '1526616554');
INSERT INTO `ey_guestbook_attr` VALUES ('2', '15', '2', '18800000000', 'cn', '1526616554', '1526616554');
INSERT INTO `ey_guestbook_attr` VALUES ('3', '15', '3', '隔壁老王', 'cn', '1526616554', '1526616554');
INSERT INTO `ey_guestbook_attr` VALUES ('4', '16', '1', '隔壁老王', 'cn', '1526616615', '1526616615');
INSERT INTO `ey_guestbook_attr` VALUES ('5', '16', '2', '18800000000', 'cn', '1526616615', '1526616615');
INSERT INTO `ey_guestbook_attr` VALUES ('6', '16', '3', '扫地阿姨', 'cn', '1526616615', '1526616615');
INSERT INTO `ey_guestbook_attr` VALUES ('7', '17', '4', '姓名啊', 'cn', '1526872813', '1526872813');
INSERT INTO `ey_guestbook_attr` VALUES ('8', '17', '5', '手机号啊', 'cn', '1526872813', '1526872813');
INSERT INTO `ey_guestbook_attr` VALUES ('9', '17', '6', '备注啊', 'cn', '1526872813', '1526872813');
INSERT INTO `ey_guestbook_attr` VALUES ('10', '20', '4', '77u', 'cn', '1526873289', '1526873289');
INSERT INTO `ey_guestbook_attr` VALUES ('11', '20', '5', '润体乳', 'cn', '1526873290', '1526873290');
INSERT INTO `ey_guestbook_attr` VALUES ('12', '20', '6', '投入人员让他', 'cn', '1526873290', '1526873290');
INSERT INTO `ey_guestbook_attr` VALUES ('13', '21', '4', '大声说地方', 'cn', '1526873428', '1526873428');
INSERT INTO `ey_guestbook_attr` VALUES ('14', '21', '5', '多个梵蒂冈', 'cn', '1526873428', '1526873428');
INSERT INTO `ey_guestbook_attr` VALUES ('15', '21', '6', '士大夫士大夫', 'cn', '1526873428', '1526873428');
INSERT INTO `ey_guestbook_attr` VALUES ('16', '22', '4', '第三方', 'cn', '1526873526', '1526873526');
INSERT INTO `ey_guestbook_attr` VALUES ('17', '22', '5', '非官方个', 'cn', '1526873526', '1526873526');
INSERT INTO `ey_guestbook_attr` VALUES ('18', '22', '6', '阿大丰收', 'cn', '1526873526', '1526873526');
INSERT INTO `ey_guestbook_attr` VALUES ('19', '23', '4', '打发斯蒂芬', 'cn', '1526873538', '1526873538');
INSERT INTO `ey_guestbook_attr` VALUES ('20', '23', '6', '房东是个负担', 'cn', '1526873538', '1526873538');
INSERT INTO `ey_guestbook_attr` VALUES ('21', '24', '4', '爱的色放的', 'cn', '1526873590', '1526873590');
INSERT INTO `ey_guestbook_attr` VALUES ('22', '24', '5', '第三方', 'cn', '1526873590', '1526873590');
INSERT INTO `ey_guestbook_attr` VALUES ('23', '24', '6', '第三方', 'cn', '1526873590', '1526873590');
INSERT INTO `ey_guestbook_attr` VALUES ('24', '25', '4', '3423', 'cn', '1526873598', '1526873598');
INSERT INTO `ey_guestbook_attr` VALUES ('25', '25', '5', '', 'cn', '1526873598', '1526873598');
INSERT INTO `ey_guestbook_attr` VALUES ('26', '25', '6', '', 'cn', '1526873598', '1526873598');
INSERT INTO `ey_guestbook_attr` VALUES ('27', '26', '4', '3423', 'cn', '1526873599', '1526873599');
INSERT INTO `ey_guestbook_attr` VALUES ('28', '26', '5', '', 'cn', '1526873599', '1526873599');
INSERT INTO `ey_guestbook_attr` VALUES ('29', '26', '6', '', 'cn', '1526873599', '1526873599');
INSERT INTO `ey_guestbook_attr` VALUES ('30', '27', '4', 'ad', 'cn', '1526874038', '1526874038');
INSERT INTO `ey_guestbook_attr` VALUES ('31', '27', '5', '辅导费', 'cn', '1526874038', '1526874038');
INSERT INTO `ey_guestbook_attr` VALUES ('32', '27', '6', '第三方官方的', 'cn', '1526874038', '1526874038');
INSERT INTO `ey_guestbook_attr` VALUES ('33', '28', '4', 'u7uym', 'cn', '1526874117', '1526874117');
INSERT INTO `ey_guestbook_attr` VALUES ('34', '28', '5', '一颗', 'cn', '1526874117', '1526874117');
INSERT INTO `ey_guestbook_attr` VALUES ('35', '28', '6', '个梵蒂冈', 'cn', '1526874117', '1526874117');
INSERT INTO `ey_guestbook_attr` VALUES ('36', '29', '4', '突然有人头', 'cn', '1526874555', '1526874555');
INSERT INTO `ey_guestbook_attr` VALUES ('37', '29', '5', '扔他', 'cn', '1526874555', '1526874555');
INSERT INTO `ey_guestbook_attr` VALUES ('38', '29', '6', '儿童', 'cn', '1526874555', '1526874555');
INSERT INTO `ey_guestbook_attr` VALUES ('39', '30', '4', '545', 'cn', '1526876081', '1526876081');
INSERT INTO `ey_guestbook_attr` VALUES ('40', '30', '5', '天通苑', 'cn', '1526876081', '1526876081');
INSERT INTO `ey_guestbook_attr` VALUES ('41', '30', '6', '个体户发过火', 'cn', '1526876081', '1526876081');
INSERT INTO `ey_guestbook_attr` VALUES ('42', '30', '7', '个人', 'cn', '1526876081', '1526876081');
INSERT INTO `ey_guestbook_attr` VALUES ('43', '31', '4', '234', 'cn', '1526876214', '1526876214');
INSERT INTO `ey_guestbook_attr` VALUES ('44', '31', '5', '43534', 'cn', '1526876214', '1526876214');
INSERT INTO `ey_guestbook_attr` VALUES ('45', '31', '6', '546546', 'cn', '1526876214', '1526876214');
INSERT INTO `ey_guestbook_attr` VALUES ('46', '31', '7', '团队', 'cn', '1526876214', '1526876214');
INSERT INTO `ey_guestbook_attr` VALUES ('47', '32', '4', '姓名', 'cn', '1527060356', '1527060356');
INSERT INTO `ey_guestbook_attr` VALUES ('48', '32', '5', '联系方式', 'cn', '1527060356', '1527060356');
INSERT INTO `ey_guestbook_attr` VALUES ('49', '32', '7', '无', 'cn', '1527060356', '1527060356');
INSERT INTO `ey_guestbook_attr` VALUES ('50', '32', '6', '备注', 'cn', '1527060356', '1527060356');
INSERT INTO `ey_guestbook_attr` VALUES ('51', '33', '4', '姓名', 'cn', '1527060517', '1527060517');
INSERT INTO `ey_guestbook_attr` VALUES ('52', '33', '7', '个人', 'cn', '1527060517', '1527060517');
INSERT INTO `ey_guestbook_attr` VALUES ('53', '33', '6', '备注', 'cn', '1527060517', '1527060517');
INSERT INTO `ey_guestbook_attr` VALUES ('54', '33', '5', '联系方式', 'cn', '1527060517', '1527060517');
INSERT INTO `ey_guestbook_attr` VALUES ('55', '34', '4', '343', 'cn', '1527156154', '1527156154');
INSERT INTO `ey_guestbook_attr` VALUES ('56', '34', '5', '435435', 'cn', '1527156154', '1527156154');
INSERT INTO `ey_guestbook_attr` VALUES ('57', '34', '6', '435345', 'cn', '1527156154', '1527156154');
INSERT INTO `ey_guestbook_attr` VALUES ('58', '34', '7', '无', 'cn', '1527156154', '1527156154');

-- ----------------------------
-- Table structure for ey_guestbook_attribute
-- ----------------------------
DROP TABLE IF EXISTS `ey_guestbook_attribute`;
CREATE TABLE `ey_guestbook_attribute` (
  `attr_id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '表单id',
  `attr_name` varchar(60) DEFAULT '' COMMENT '表单名称',
  `typeid` int(11) unsigned DEFAULT '0' COMMENT '栏目ID',
  `attr_input_type` tinyint(1) unsigned DEFAULT '0' COMMENT ' 0=文本框，1=下拉框，2=多行文本框',
  `attr_values` text COMMENT '可选值列表',
  `sort_order` int(11) unsigned DEFAULT '0' COMMENT '表单排序',
  `lang` varchar(50) DEFAULT 'cn' COMMENT '语言标识',
  `is_del` tinyint(1) DEFAULT '0' COMMENT '是否已删除，0=否，1=是',
  `add_time` int(11) DEFAULT '0' COMMENT '新增时间',
  `update_time` int(11) DEFAULT '0' COMMENT '更新时间',
  PRIMARY KEY (`attr_id`),
  KEY `guest_id` (`typeid`) USING BTREE
) ENGINE=MyISAM AUTO_INCREMENT=16 DEFAULT CHARSET=utf8 COMMENT='留言表单属性';

-- ----------------------------
-- Records of ey_guestbook_attribute
-- ----------------------------
INSERT INTO `ey_guestbook_attribute` VALUES ('1', '姓名', '30', '0', '', '100', 'cn', '0', '1526616441', '1526616441');
INSERT INTO `ey_guestbook_attribute` VALUES ('2', '手机号码', '30', '0', '', '100', 'cn', '0', '1526616453', '1526616453');
INSERT INTO `ey_guestbook_attribute` VALUES ('3', '约谈对象', '30', '1', '隔壁老王\r\n前台美女\r\n扫地阿姨', '100', 'cn', '0', '1526616497', '1526616812');
INSERT INTO `ey_guestbook_attribute` VALUES ('4', '姓名', '6', '0', '', '100', 'cn', '0', '1526634369', '1526874914');
INSERT INTO `ey_guestbook_attribute` VALUES ('5', '联系方式', '6', '0', '', '100', 'cn', '0', '1526634383', '1526634383');
INSERT INTO `ey_guestbook_attribute` VALUES ('6', '备注信息', '6', '2', '', '100', 'cn', '0', '1526634393', '1526875056');
INSERT INTO `ey_guestbook_attribute` VALUES ('7', '模式', '6', '1', '个人\r\n团队', '100', 'cn', '0', '1526875483', '1526876172');

-- ----------------------------
-- Table structure for ey_hooks
-- ----------------------------
DROP TABLE IF EXISTS `ey_hooks`;
CREATE TABLE `ey_hooks` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `name` varchar(50) NOT NULL DEFAULT '' COMMENT '钩子名称',
  `description` text COMMENT '描述',
  `module` varchar(50) DEFAULT '' COMMENT '钩子挂载的插件',
  `status` tinyint(1) unsigned DEFAULT '1' COMMENT '状态：0=无效，1=有效',
  `add_time` int(10) DEFAULT NULL,
  `update_time` int(10) unsigned DEFAULT '0' COMMENT '更新时间',
  PRIMARY KEY (`id`),
  KEY `name` (`name`) USING BTREE
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='插件钩子表';

-- ----------------------------
-- Records of ey_hooks
-- ----------------------------

-- ----------------------------
-- Table structure for ey_images_content
-- ----------------------------
DROP TABLE IF EXISTS `ey_images_content`;
CREATE TABLE `ey_images_content` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `aid` int(10) DEFAULT '0' COMMENT '文档ID',
  `content` longtext COMMENT '内容详情',
  `add_time` int(11) DEFAULT '0' COMMENT '新增时间',
  `update_time` int(11) DEFAULT '0' COMMENT '更新时间',
  PRIMARY KEY (`id`),
  KEY `news_id` (`aid`) USING BTREE
) ENGINE=MyISAM AUTO_INCREMENT=10 DEFAULT CHARSET=utf8 COMMENT='图集附加表';

-- ----------------------------
-- Records of ey_images_content
-- ----------------------------
INSERT INTO `ey_images_content` VALUES ('5', '22', '&lt;p&gt;新闻模型下的图集新闻模型下的图集新闻模型下的图集新闻模型下的图集新闻模型下的图集新闻模型下的图集新闻模型下的图集新闻模型下的图集新闻模型下的图集新闻模型下的图集新闻模型下的图集新闻模型下的图集新闻模型下的图集新闻模型下的图集新闻模型下的图集新闻模型下的图集新闻模型下的图集新闻模型下的图集新闻模型下的图集新闻模型下的图集新闻模型下的图集新闻模型下的图集新闻模型下的图集新闻模型下的图集新闻模型下的图集新闻模型下的图集新闻模型下的图集新闻模型下的图集新闻模型下的图集新闻模型下的图集新闻模型下的图集新闻模型下的图集新闻模型下的图集新闻模型下的图集新闻模型下的图集新闻模型下的图集新闻模型下的图集新闻模型下的图集新闻模型下的图集新闻模型下的图集新闻模型下的图集新闻模型下的图集新闻模型下的图集新闻模型下的图集新闻模型下的图集新闻模型下的图集新闻模型下的图集新闻模型下的图集新闻模型下的图集新闻模型下的图集新闻模型下的图集新闻模型下的图集新闻模型下的图集新闻模型下的图集新闻模型下的图集新闻模型下的图集新闻模型下的图集新闻模型下的图集&lt;/p&gt;', '1526612277', '1531877783');
INSERT INTO `ey_images_content` VALUES ('6', '23', '&lt;p&gt;新闻模型下的图集二新闻模型下的图集二新闻模型下的图集二新闻模型下的图集二新闻模型下的图集二新闻模型下的图集二新闻模型下的图集二新闻模型下的图集二新闻模型下的图集二新闻模型下的图集二新闻模型下的图集二新闻模型下的图集二新闻模型下的图集二新闻模型下的图集二新闻模型下的图集二新闻模型下的图集二新闻模型下的图集二新闻模型下的图集二新闻模型下的图集二新闻模型下的图集二新闻模型下的图集二新闻模型下的图集二新闻模型下的图集二新闻模型下的图集二新闻模型下的图集二新闻模型下的图集二新闻模型下的图集二新闻模型下的图集二新闻模型下的图集二新闻模型下的图集二新闻模型下的图集二新闻模型下的图集二新闻模型下的图集二新闻模型下的图集二新闻模型下的图集二新闻模型下的图集二新闻模型下的图集二&lt;/p&gt;', '1526612316', '1531877859');
INSERT INTO `ey_images_content` VALUES ('7', '42', '', '1531731387', '1531732448');
INSERT INTO `ey_images_content` VALUES ('8', '43', '', '1531732591', '1531732691');
INSERT INTO `ey_images_content` VALUES ('9', '44', '', '1543798501', '1543798501');

-- ----------------------------
-- Table structure for ey_images_upload
-- ----------------------------
DROP TABLE IF EXISTS `ey_images_upload`;
CREATE TABLE `ey_images_upload` (
  `img_id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增ID',
  `aid` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT '图集ID',
  `title` varchar(200) DEFAULT '' COMMENT '产品标题',
  `image_url` varchar(255) DEFAULT '' COMMENT '文件存储路径',
  `width` int(11) DEFAULT '0' COMMENT '图片宽度',
  `height` int(11) DEFAULT '0' COMMENT '图片高度',
  `filesize` mediumint(8) unsigned DEFAULT '0' COMMENT '文件大小',
  `mime` varchar(50) DEFAULT '' COMMENT '图片类型',
  `sort_order` smallint(5) DEFAULT '0' COMMENT '排序',
  `add_time` int(10) unsigned DEFAULT '0' COMMENT '上传时间',
  PRIMARY KEY (`img_id`),
  KEY `arcid` (`aid`) USING BTREE
) ENGINE=MyISAM AUTO_INCREMENT=27 DEFAULT CHARSET=utf8 COMMENT='图集图片表';

-- ----------------------------
-- Records of ey_images_upload
-- ----------------------------
INSERT INTO `ey_images_upload` VALUES ('22', '22', '新闻模型下的图集', '/public/upload/images/2018/07/18/1b42b138151ecee5b9abde4831b66add.jpg', '400', '400', '0', 'image/jpeg', '2', '1531877784');
INSERT INTO `ey_images_upload` VALUES ('21', '22', '新闻模型下的图集', '/public/upload/images/2018/07/18/60a1a6f1760e1f8c22ca02980fd8374e.jpg', '560', '560', '0', 'image/jpeg', '1', '1531877784');
INSERT INTO `ey_images_upload` VALUES ('23', '23', '新闻模型下的图集二', '/public/upload/images/2018/07/18/aec51022b7fc0ae3ce67279161c6a0c2.jpg', '560', '560', '0', 'image/jpeg', '1', '1531877860');
INSERT INTO `ey_images_upload` VALUES ('14', '42', '客户案例一', '/public/upload/images/2018/07/16/a6633714552fcccee2f49f2131f9d131.jpg', '1000', '782', '0', 'image/jpeg', '1', '1531732449');
INSERT INTO `ey_images_upload` VALUES ('15', '43', '客户案例二', '/public/upload/images/2018/07/16/2a97ea57a860f5ca2bfb007d06f0e47c.jpg', '1000', '782', '0', 'image/jpeg', '1', '1531732691');
INSERT INTO `ey_images_upload` VALUES ('16', '43', '客户案例二', '/public/upload/images/2018/07/16/91fac63ec3cea10d9b98ae8aba61cac0.jpg', '1000', '782', '0', 'image/jpeg', '2', '1531732691');
INSERT INTO `ey_images_upload` VALUES ('26', '44', '客户案例三', '/public/upload/images/2018/07/16/924131b50a74c8aeed880b92c4bf2242.jpg', '1000', '782', '0', 'image/jpeg', '3', '1543798501');
INSERT INTO `ey_images_upload` VALUES ('25', '44', '客户案例三', '/public/upload/images/2018/07/16/5f61e07e41840a8f171c47d003088380.jpg', '1000', '782', '0', 'image/jpeg', '2', '1543798501');
INSERT INTO `ey_images_upload` VALUES ('24', '44', '客户案例三', '/public/upload/images/2018/07/16/c8053c217ad5d3e0b77108f54ed1db52.jpg', '1000', '782', '0', 'image/jpeg', '1', '1543798501');

-- ----------------------------
-- Table structure for ey_language
-- ----------------------------
DROP TABLE IF EXISTS `ey_language`;
CREATE TABLE `ey_language` (
  `id` int(10) NOT NULL AUTO_INCREMENT COMMENT '信息ID，自增',
  `title` varchar(100) NOT NULL DEFAULT '' COMMENT '语言名称',
  `mark` varchar(50) NOT NULL DEFAULT '' COMMENT '语言标识（唯一）',
  `url` varchar(200) NOT NULL DEFAULT '' COMMENT '单独域名(外部链接)',
  `target` tinyint(1) NOT NULL DEFAULT '0' COMMENT '新窗口打开，0=否，1=是',
  `is_home_default` tinyint(1) DEFAULT '0' COMMENT '默认前台语言，1=是，0=否',
  `is_admin_default` tinyint(1) DEFAULT '0' COMMENT '默认后台语言，1=是，0=否',
  `syn_pack_id` int(10) DEFAULT '0' COMMENT '最后一次同步官方语言包ID',
  `status` tinyint(1) NOT NULL DEFAULT '0' COMMENT '语言状态，0=关闭，1=开启',
  `sort_order` int(10) DEFAULT '0' COMMENT '排序号',
  `add_time` int(11) DEFAULT '0' COMMENT '新增时间',
  `update_time` int(11) DEFAULT '0' COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='多语言主表';

-- ----------------------------
-- Records of ey_language
-- ----------------------------
INSERT INTO `ey_language` VALUES ('1', '简体中文', 'cn', '', '0', '1', '1', '0', '1', '100', '1541583096', '1543890743');

-- ----------------------------
-- Table structure for ey_language_attr
-- ----------------------------
DROP TABLE IF EXISTS `ey_language_attr`;
CREATE TABLE `ey_language_attr` (
  `id` int(10) NOT NULL AUTO_INCREMENT COMMENT '信息ID，自增',
  `attr_name` varchar(200) NOT NULL DEFAULT '' COMMENT '来自ey_weapp_language_attr表的attr_name',
  `attr_value` text NOT NULL COMMENT '变量值',
  `attr_group` varchar(50) DEFAULT '' COMMENT '分组，以表名划分（不含表前缀）',
  `lang` varchar(50) NOT NULL DEFAULT '' COMMENT '所属语言',
  `add_time` int(11) DEFAULT '0' COMMENT '新增时间',
  `update_time` int(11) DEFAULT '0' COMMENT '更新时间',
  PRIMARY KEY (`id`),
  KEY `attr_value` (`attr_name`,`lang`)
) ENGINE=MyISAM AUTO_INCREMENT=77 DEFAULT CHARSET=utf8 COMMENT='多语言模板变量关联绑定表';

-- ----------------------------
-- Records of ey_language_attr
-- ----------------------------
INSERT INTO `ey_language_attr` VALUES ('1', 'tid1', '1', 'arctype', 'cn', '1543801511', '1543801511');
INSERT INTO `ey_language_attr` VALUES ('2', 'tid2', '2', 'arctype', 'cn', '1543801511', '1543801511');
INSERT INTO `ey_language_attr` VALUES ('3', 'tid3', '3', 'arctype', 'cn', '1543801511', '1543801511');
INSERT INTO `ey_language_attr` VALUES ('4', 'tid4', '4', 'arctype', 'cn', '1543801511', '1543801511');
INSERT INTO `ey_language_attr` VALUES ('5', 'tid5', '5', 'arctype', 'cn', '1543801511', '1543801511');
INSERT INTO `ey_language_attr` VALUES ('6', 'tid6', '6', 'arctype', 'cn', '1543801511', '1543801511');
INSERT INTO `ey_language_attr` VALUES ('7', 'tid8', '8', 'arctype', 'cn', '1543801511', '1543801511');
INSERT INTO `ey_language_attr` VALUES ('8', 'tid9', '9', 'arctype', 'cn', '1543801511', '1543801511');
INSERT INTO `ey_language_attr` VALUES ('9', 'tid10', '10', 'arctype', 'cn', '1543801511', '1543801511');
INSERT INTO `ey_language_attr` VALUES ('10', 'tid11', '11', 'arctype', 'cn', '1543801511', '1543801511');
INSERT INTO `ey_language_attr` VALUES ('11', 'tid12', '12', 'arctype', 'cn', '1543801511', '1543801511');
INSERT INTO `ey_language_attr` VALUES ('12', 'tid13', '13', 'arctype', 'cn', '1543801511', '1543801511');
INSERT INTO `ey_language_attr` VALUES ('13', 'tid20', '20', 'arctype', 'cn', '1543801511', '1543801511');
INSERT INTO `ey_language_attr` VALUES ('14', 'tid21', '21', 'arctype', 'cn', '1543801511', '1543801511');
INSERT INTO `ey_language_attr` VALUES ('15', 'tid22', '22', 'arctype', 'cn', '1543801511', '1543801511');
INSERT INTO `ey_language_attr` VALUES ('16', 'tid23', '23', 'arctype', 'cn', '1543801511', '1543801511');
INSERT INTO `ey_language_attr` VALUES ('17', 'tid24', '24', 'arctype', 'cn', '1543801511', '1543801511');
INSERT INTO `ey_language_attr` VALUES ('18', 'tid25', '25', 'arctype', 'cn', '1543801511', '1543801511');
INSERT INTO `ey_language_attr` VALUES ('19', 'tid26', '26', 'arctype', 'cn', '1543801511', '1543801511');
INSERT INTO `ey_language_attr` VALUES ('20', 'tid27', '27', 'arctype', 'cn', '1543801511', '1543801511');
INSERT INTO `ey_language_attr` VALUES ('21', 'tid28', '28', 'arctype', 'cn', '1543801511', '1543801511');
INSERT INTO `ey_language_attr` VALUES ('22', 'tid29', '29', 'arctype', 'cn', '1543801511', '1543801511');
INSERT INTO `ey_language_attr` VALUES ('23', 'tid30', '30', 'arctype', 'cn', '1543801511', '1543801511');
INSERT INTO `ey_language_attr` VALUES ('24', 'attr_1', '1', 'guestbook_attribute', 'cn', '1543801511', '1543801511');
INSERT INTO `ey_language_attr` VALUES ('25', 'attr_2', '2', 'guestbook_attribute', 'cn', '1543801511', '1543801511');
INSERT INTO `ey_language_attr` VALUES ('26', 'attr_3', '3', 'guestbook_attribute', 'cn', '1543801511', '1543801511');
INSERT INTO `ey_language_attr` VALUES ('27', 'attr_4', '4', 'guestbook_attribute', 'cn', '1543801511', '1543801511');
INSERT INTO `ey_language_attr` VALUES ('28', 'attr_5', '5', 'guestbook_attribute', 'cn', '1543801511', '1543801511');
INSERT INTO `ey_language_attr` VALUES ('29', 'attr_6', '6', 'guestbook_attribute', 'cn', '1543801511', '1543801511');
INSERT INTO `ey_language_attr` VALUES ('30', 'attr_7', '7', 'guestbook_attribute', 'cn', '1543801511', '1543801511');
INSERT INTO `ey_language_attr` VALUES ('31', 'attr_1', '1', 'product_attribute', 'cn', '1543801511', '1543801511');
INSERT INTO `ey_language_attr` VALUES ('32', 'attr_2', '2', 'product_attribute', 'cn', '1543801511', '1543801511');
INSERT INTO `ey_language_attr` VALUES ('33', 'attr_3', '3', 'product_attribute', 'cn', '1543801511', '1543801511');
INSERT INTO `ey_language_attr` VALUES ('34', 'attr_4', '4', 'product_attribute', 'cn', '1543801511', '1543801511');
INSERT INTO `ey_language_attr` VALUES ('35', 'attr_5', '5', 'product_attribute', 'cn', '1543801511', '1543801511');
INSERT INTO `ey_language_attr` VALUES ('36', 'attr_6', '6', 'product_attribute', 'cn', '1543801511', '1543801511');
INSERT INTO `ey_language_attr` VALUES ('37', 'attr_7', '7', 'product_attribute', 'cn', '1543801511', '1543801511');
INSERT INTO `ey_language_attr` VALUES ('38', 'attr_8', '8', 'product_attribute', 'cn', '1543801511', '1543801511');

-- ----------------------------
-- Table structure for ey_language_attribute
-- ----------------------------
DROP TABLE IF EXISTS `ey_language_attribute`;
CREATE TABLE `ey_language_attribute` (
  `attr_id` int(10) NOT NULL AUTO_INCREMENT COMMENT '信息ID，自增',
  `attr_title` varchar(200) NOT NULL DEFAULT '' COMMENT '变量标题',
  `attr_name` varchar(200) NOT NULL DEFAULT '' COMMENT '变量名称',
  `attr_group` varchar(50) DEFAULT '' COMMENT '分组，以表名划分（不含表前缀）',
  `is_del` tinyint(1) DEFAULT '0' COMMENT '伪删除，0=否，1=是',
  `add_time` int(11) DEFAULT '0' COMMENT '新增时间',
  `update_time` int(11) DEFAULT '0' COMMENT '更新时间',
  PRIMARY KEY (`attr_id`)
) ENGINE=MyISAM AUTO_INCREMENT=39 DEFAULT CHARSET=utf8 COMMENT='多语言模板变量表';

-- ----------------------------
-- Records of ey_language_attribute
-- ----------------------------
INSERT INTO `ey_language_attribute` VALUES ('1', '关于我们', 'tid1', 'arctype', '0', '1543801511', '1543801511');
INSERT INTO `ey_language_attribute` VALUES ('2', '新闻动态', 'tid2', 'arctype', '0', '1543801511', '1543801511');
INSERT INTO `ey_language_attribute` VALUES ('3', '产品展示', 'tid3', 'arctype', '0', '1543801511', '1543801511');
INSERT INTO `ey_language_attribute` VALUES ('4', '客户案例', 'tid4', 'arctype', '0', '1543801511', '1543801511');
INSERT INTO `ey_language_attribute` VALUES ('5', '资料下载', 'tid5', 'arctype', '0', '1543801511', '1543801511');
INSERT INTO `ey_language_attribute` VALUES ('6', '报名入口', 'tid6', 'arctype', '0', '1543801511', '1543801511');
INSERT INTO `ey_language_attribute` VALUES ('7', '公司简介', 'tid8', 'arctype', '0', '1543801511', '1543801511');
INSERT INTO `ey_language_attribute` VALUES ('8', '公司荣誉', 'tid9', 'arctype', '0', '1543801511', '1543801511');
INSERT INTO `ey_language_attribute` VALUES ('9', '媒体报道', 'tid10', 'arctype', '0', '1543801511', '1543801511');
INSERT INTO `ey_language_attribute` VALUES ('10', 'SEO优化', 'tid11', 'arctype', '0', '1543801511', '1543801511');
INSERT INTO `ey_language_attribute` VALUES ('11', '企业运营', 'tid12', 'arctype', '0', '1543801511', '1543801511');
INSERT INTO `ey_language_attribute` VALUES ('12', '单页面', 'tid13', 'arctype', '0', '1543801511', '1543801511');
INSERT INTO `ey_language_attribute` VALUES ('13', '手机', 'tid20', 'arctype', '0', '1543801511', '1543801511');
INSERT INTO `ey_language_attribute` VALUES ('14', '电脑', 'tid21', 'arctype', '0', '1543801511', '1543801511');
INSERT INTO `ey_language_attribute` VALUES ('15', '通用配件', 'tid22', 'arctype', '0', '1543801511', '1543801511');
INSERT INTO `ey_language_attribute` VALUES ('16', '风景图集', 'tid23', 'arctype', '0', '1543801511', '1543801511');
INSERT INTO `ey_language_attribute` VALUES ('17', '智能手机', 'tid24', 'arctype', '0', '1543801511', '1543801511');
INSERT INTO `ey_language_attribute` VALUES ('18', '畅玩手机', 'tid25', 'arctype', '0', '1543801511', '1543801511');
INSERT INTO `ey_language_attribute` VALUES ('19', '笔记本电脑', 'tid26', 'arctype', '0', '1543801511', '1543801511');
INSERT INTO `ey_language_attribute` VALUES ('20', '耳机', 'tid27', 'arctype', '0', '1543801511', '1543801511');
INSERT INTO `ey_language_attribute` VALUES ('21', '音箱', 'tid28', 'arctype', '0', '1543801511', '1543801511');
INSERT INTO `ey_language_attribute` VALUES ('22', '充电宝', 'tid29', 'arctype', '0', '1543801511', '1543801511');
INSERT INTO `ey_language_attribute` VALUES ('23', '预约面试', 'tid30', 'arctype', '0', '1543801511', '1543801511');
INSERT INTO `ey_language_attribute` VALUES ('24', '姓名', 'attr_1', 'guestbook_attribute', '0', '1543801511', '1543801511');
INSERT INTO `ey_language_attribute` VALUES ('25', '手机号码', 'attr_2', 'guestbook_attribute', '0', '1543801511', '1543801511');
INSERT INTO `ey_language_attribute` VALUES ('26', '约谈对象', 'attr_3', 'guestbook_attribute', '0', '1543801511', '1543801511');
INSERT INTO `ey_language_attribute` VALUES ('27', '姓名', 'attr_4', 'guestbook_attribute', '0', '1543801511', '1543801511');
INSERT INTO `ey_language_attribute` VALUES ('28', '联系方式', 'attr_5', 'guestbook_attribute', '0', '1543801511', '1543801511');
INSERT INTO `ey_language_attribute` VALUES ('29', '备注信息', 'attr_6', 'guestbook_attribute', '0', '1543801511', '1543801511');
INSERT INTO `ey_language_attribute` VALUES ('30', '模式', 'attr_7', 'guestbook_attribute', '0', '1543801511', '1543801511');
INSERT INTO `ey_language_attribute` VALUES ('31', '用户界面', 'attr_1', 'product_attribute', '0', '1543801511', '1543801511');
INSERT INTO `ey_language_attribute` VALUES ('32', '操作系统', 'attr_2', 'product_attribute', '0', '1543801511', '1543801511');
INSERT INTO `ey_language_attribute` VALUES ('33', '键盘类型', 'attr_3', 'product_attribute', '0', '1543801511', '1543801511');
INSERT INTO `ey_language_attribute` VALUES ('34', ' 型号', 'attr_4', 'product_attribute', '0', '1543801511', '1543801511');
INSERT INTO `ey_language_attribute` VALUES ('35', '屏幕大小', 'attr_5', 'product_attribute', '0', '1543801511', '1543801511');
INSERT INTO `ey_language_attribute` VALUES ('36', '重量', 'attr_6', 'product_attribute', '0', '1543801511', '1543801511');
INSERT INTO `ey_language_attribute` VALUES ('37', '型号', 'attr_7', 'product_attribute', '0', '1543801511', '1543801511');
INSERT INTO `ey_language_attribute` VALUES ('38', '支持蓝牙', 'attr_8', 'product_attribute', '0', '1543801511', '1543801511');

-- ----------------------------
-- Table structure for ey_language_mark
-- ----------------------------
DROP TABLE IF EXISTS `ey_language_mark`;
CREATE TABLE `ey_language_mark` (
  `id` int(10) NOT NULL AUTO_INCREMENT COMMENT '自增ID',
  `title` varchar(50) NOT NULL DEFAULT '' COMMENT '国家语言名称',
  `cn_title` varchar(50) NOT NULL DEFAULT '' COMMENT '中文名称',
  `mark` varchar(50) DEFAULT '' COMMENT '多语言标识',
  `pinyin` varchar(100) DEFAULT '' COMMENT '拼音',
  `sort_order` int(10) NOT NULL DEFAULT '0' COMMENT '排序号',
  `add_time` int(11) DEFAULT '0' COMMENT '新增时间',
  `update_time` int(11) DEFAULT '0' COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=57 DEFAULT CHARSET=utf8 COMMENT='国家语言表';

-- ----------------------------
-- Records of ey_language_mark
-- ----------------------------
INSERT INTO `ey_language_mark` VALUES ('1', '简体中文', '简体中文', 'cn', 'zhongwenjianti', '100', '0', '1541583096');
INSERT INTO `ey_language_mark` VALUES ('2', 'Vietnamese', '越南语', 'vi', 'yuenanyu', '100', '0', '1541583096');
INSERT INTO `ey_language_mark` VALUES ('3', '繁体中文', '繁体中文', 'zh', 'zhongwenfanti', '100', '0', '1541583096');
INSERT INTO `ey_language_mark` VALUES ('4', 'English', '英语', 'en', 'yingyu', '100', '0', '1541583096');
INSERT INTO `ey_language_mark` VALUES ('5', 'Indonesian', '印尼语', 'id', 'yinniyu', '100', '0', '1541583096');
INSERT INTO `ey_language_mark` VALUES ('6', 'Urdu', '乌尔都语', 'ur', 'wuerduyu', '100', '0', '1541583096');
INSERT INTO `ey_language_mark` VALUES ('7', 'Yiddish', '意第绪语', 'yi', 'yidixuyu', '100', '0', '1541583096');
INSERT INTO `ey_language_mark` VALUES ('8', 'Italian', '意大利语', 'it', 'yidaliyu', '100', '0', '1541583096');
INSERT INTO `ey_language_mark` VALUES ('9', 'Greek', '希腊语', 'el', 'xilayu', '100', '0', '1541583096');
INSERT INTO `ey_language_mark` VALUES ('10', 'Spanish Basque', '西班牙的巴斯克语', 'eu', 'xibanyadebasikeyu', '100', '0', '1541583096');
INSERT INTO `ey_language_mark` VALUES ('11', 'Spanish', '西班牙语', 'es', 'xibanyayu', '100', '0', '1541583096');
INSERT INTO `ey_language_mark` VALUES ('12', 'Hungarian', '匈牙利语', 'hu', 'xiongyaliyu', '100', '0', '1541583096');
INSERT INTO `ey_language_mark` VALUES ('13', 'Hebrew', '希伯来语', 'iw', 'xibolaiyu', '100', '0', '1541583096');
INSERT INTO `ey_language_mark` VALUES ('14', 'Ukrainian', '乌克兰语', 'uk', 'wukelanyu', '100', '0', '1541583096');
INSERT INTO `ey_language_mark` VALUES ('15', 'Welsh', '威尔士语', 'cy', 'weiershiyu', '100', '0', '1541583096');
INSERT INTO `ey_language_mark` VALUES ('16', 'Thai', '泰语', 'th', 'taiyu', '100', '0', '1541583096');
INSERT INTO `ey_language_mark` VALUES ('17', 'Turkish', '土耳其语', 'tr', 'tuerqiyu', '100', '0', '1541583096');
INSERT INTO `ey_language_mark` VALUES ('18', 'Swahili', '斯瓦希里语', 'sw', 'siwaxiliyu', '100', '0', '1541583096');
INSERT INTO `ey_language_mark` VALUES ('19', 'Japanese', '日语', 'ja', 'riyu', '100', '0', '1541583096');
INSERT INTO `ey_language_mark` VALUES ('20', 'Swedish', '瑞典语', 'sv', 'ruidianyu', '100', '0', '1541583096');
INSERT INTO `ey_language_mark` VALUES ('21', 'Serbian', '塞尔维亚语', 'sr', 'saierweiyayu', '100', '0', '1541583096');
INSERT INTO `ey_language_mark` VALUES ('22', 'Slovak', '斯洛伐克语', 'sk', 'siluofakeyu', '100', '0', '1541583096');
INSERT INTO `ey_language_mark` VALUES ('23', 'Slovenian', '斯洛文尼亚语', 'sl', 'siluowenniyayu', '100', '0', '1541583096');
INSERT INTO `ey_language_mark` VALUES ('24', 'Portuguese', '葡萄牙语', 'pt', 'putaoyayu', '100', '0', '1541583096');
INSERT INTO `ey_language_mark` VALUES ('25', 'Norwegian', '挪威语', 'no', 'nuoweiyu', '100', '0', '1541583096');
INSERT INTO `ey_language_mark` VALUES ('26', 'Macedonian', '马其顿语', 'mk', 'maqidunyu', '100', '0', '1541583096');
INSERT INTO `ey_language_mark` VALUES ('27', 'Malay', '马来语', 'ms', 'malaiyu', '100', '0', '1541583096');
INSERT INTO `ey_language_mark` VALUES ('28', 'Maltese', '马耳他语', 'mt', 'maertayu', '100', '0', '1541583096');
INSERT INTO `ey_language_mark` VALUES ('29', 'Romanian', '罗马尼亚语', 'ro', 'luomaniyayu', '100', '0', '1541583096');
INSERT INTO `ey_language_mark` VALUES ('30', 'Lithuanian', '立陶宛语', 'lt', 'litaowanyu', '100', '0', '1541583096');
INSERT INTO `ey_language_mark` VALUES ('31', 'Latvian', '拉脱维亚语', 'lv', 'latuoweiyayu', '100', '0', '1541583096');
INSERT INTO `ey_language_mark` VALUES ('32', 'Latin', '拉丁语', 'la', 'ladingyu', '100', '0', '1541583096');
INSERT INTO `ey_language_mark` VALUES ('33', 'Croatian', '克罗地亚语', 'hr', 'keluodiyayu', '100', '0', '1541583096');
INSERT INTO `ey_language_mark` VALUES ('34', 'Czech', '捷克语', 'cs', 'jiekeyu', '100', '0', '1541583096');
INSERT INTO `ey_language_mark` VALUES ('35', 'Catalan', '加泰罗尼亚语', 'ca', 'jiatailuoniyayu', '100', '0', '1541583096');
INSERT INTO `ey_language_mark` VALUES ('36', 'Galician', '加利西亚语', 'gl', 'jialixiyayu', '100', '0', '1541583096');
INSERT INTO `ey_language_mark` VALUES ('37', 'Dutch', '荷兰语', 'nl', 'helanyu', '100', '0', '1541583096');
INSERT INTO `ey_language_mark` VALUES ('38', 'Korean', '韩语', 'ko', 'hanyu', '100', '0', '1541583096');
INSERT INTO `ey_language_mark` VALUES ('39', 'Haitian Creole', '海地克里奥尔语', 'ht', 'haidikeliaoeryu', '100', '0', '1541583096');
INSERT INTO `ey_language_mark` VALUES ('40', 'Finnish', '芬兰语', 'fi', 'fenlanyu', '100', '0', '1541583096');
INSERT INTO `ey_language_mark` VALUES ('41', 'Filipino', '菲律宾语', 'tl', 'feilvbinyu', '100', '0', '1541583096');
INSERT INTO `ey_language_mark` VALUES ('42', 'Russian', '俄语', 'ru', 'eyu', '100', '0', '1541583096');
INSERT INTO `ey_language_mark` VALUES ('43', 'Boolean (Afrikaans)', '布尔语(南非荷兰语)', 'af', 'bueryunanfeihelanyu', '100', '0', '1541583096');
INSERT INTO `ey_language_mark` VALUES ('44', 'French', '法语', 'fr', 'fayu', '100', '0', '1541583096');
INSERT INTO `ey_language_mark` VALUES ('45', 'Danish', '丹麦语', 'da', 'danmaiyu', '100', '0', '1541583096');
INSERT INTO `ey_language_mark` VALUES ('46', 'German', '德语', 'de', 'deyu', '100', '0', '1541583096');
INSERT INTO `ey_language_mark` VALUES ('47', 'Azerbaijani', '阿塞拜疆语', 'az', 'asaibaijiangyu', '100', '0', '1541583096');
INSERT INTO `ey_language_mark` VALUES ('48', 'Irish', '爱尔兰语', 'ga', 'aierlanyu', '100', '0', '1541583096');
INSERT INTO `ey_language_mark` VALUES ('49', 'Estonian', '爱沙尼亚语', 'et', 'aishaniyayu', '100', '0', '1541583096');
INSERT INTO `ey_language_mark` VALUES ('50', 'Belarusian', '白俄罗斯语', 'be', 'baieluosiyu', '100', '0', '1541583096');
INSERT INTO `ey_language_mark` VALUES ('51', 'Bulgarian', '保加利亚语', 'bg', 'baojialiyayu', '100', '0', '1541583096');
INSERT INTO `ey_language_mark` VALUES ('52', 'Icelandic', '冰岛语', 'is', 'bingdaoyu', '100', '0', '1541583096');
INSERT INTO `ey_language_mark` VALUES ('53', 'Polish', '波兰语', 'pl', 'bolanyu', '100', '0', '1541583096');
INSERT INTO `ey_language_mark` VALUES ('54', 'Persian', '波斯语', 'fa', 'bosiyu', '100', '0', '1541583096');
INSERT INTO `ey_language_mark` VALUES ('55', 'Arabic', '阿拉伯语', 'ar', 'alaboyu', '100', '0', '1541583096');
INSERT INTO `ey_language_mark` VALUES ('56', 'Albanian', '阿尔巴尼亚语', 'sq', 'aerbaniyayu', '100', '0', '1541583096');

-- ----------------------------
-- Table structure for ey_language_pack
-- ----------------------------
DROP TABLE IF EXISTS `ey_language_pack`;
CREATE TABLE `ey_language_pack` (
  `id` int(10) NOT NULL AUTO_INCREMENT COMMENT '自增ID',
  `name` varchar(50) NOT NULL DEFAULT '' COMMENT '变量名',
  `value` text NOT NULL COMMENT '变量值',
  `is_syn` tinyint(1) DEFAULT '0' COMMENT '同步官方语言包：0=否，1=是',
  `lang` varchar(50) DEFAULT 'cn' COMMENT '语言标识',
  `sort_order` int(10) DEFAULT '0' COMMENT '排序号',
  `add_time` int(11) DEFAULT '0' COMMENT '新增时间',
  `update_time` int(11) DEFAULT '0' COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='模板语言包变量';

-- ----------------------------
-- Records of ey_language_pack
-- ----------------------------

-- ----------------------------
-- Table structure for ey_links
-- ----------------------------
DROP TABLE IF EXISTS `ey_links`;
CREATE TABLE `ey_links` (
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
  `lang` varchar(50) DEFAULT 'cn' COMMENT '语言标识',
  `delete_time` int(11) DEFAULT '0' COMMENT '软删除时间',
  `add_time` int(11) DEFAULT '0' COMMENT '新增时间',
  `update_time` int(11) DEFAULT '0' COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=11 DEFAULT CHARSET=utf8 COMMENT='友情链接表';

-- ----------------------------
-- Records of ey_links
-- ----------------------------
INSERT INTO `ey_links` VALUES ('1', '1', '百度', 'http://www.baidu.com', '', '100', '1', '', '', '1', 'cn', '0', '1524975826', '1537585074');
INSERT INTO `ey_links` VALUES ('2', '1', '腾讯', 'http://www.qq.com', '', '100', '1', '', '', '1', 'cn', '0', '1524976095', '1537585061');
INSERT INTO `ey_links` VALUES ('3', '1', '新浪', 'http://www.sina.com.cn', '', '100', '1', '', '', '1', 'cn', '0', '1532414285', '1537585047');
INSERT INTO `ey_links` VALUES ('4', '1', '小程序开发教程', 'http://www.yiyongtong.com', '', '100', '1', '', '', '1', 'cn', '0', '1532414529', '1537585013');
INSERT INTO `ey_links` VALUES ('5', '1', '素材58', 'http://www.sucai58.com', '', '100', '1', '', '', '1', 'cn', '0', '1532414726', '1537585146');

-- ----------------------------
-- Table structure for ey_product_attr
-- ----------------------------
DROP TABLE IF EXISTS `ey_product_attr`;
CREATE TABLE `ey_product_attr` (
  `product_attr_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '产品属性id自增',
  `aid` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT '产品id',
  `attr_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '属性id',
  `attr_value` text COMMENT '属性值',
  `attr_price` varchar(255) DEFAULT '' COMMENT '属性价格',
  `add_time` int(11) DEFAULT '0' COMMENT '新增时间',
  `update_time` int(11) DEFAULT '0' COMMENT '更新时间',
  PRIMARY KEY (`product_attr_id`),
  KEY `aid` (`aid`) USING BTREE,
  KEY `attr_id` (`attr_id`) USING BTREE
) ENGINE=MyISAM AUTO_INCREMENT=25 DEFAULT CHARSET=utf8 COMMENT='产品表单属性值';

-- ----------------------------
-- Records of ey_product_attr
-- ----------------------------
INSERT INTO `ey_product_attr` VALUES ('5', '28', '5', '13.3', '0', '1526613498', '1526613498');
INSERT INTO `ey_product_attr` VALUES ('6', '28', '6', '3KG', '0', '1526613498', '1526613498');
INSERT INTO `ey_product_attr` VALUES ('7', '29', '7', 'AKG&amp;HUAWEI', '0', '1526613820', '1526613820');
INSERT INTO `ey_product_attr` VALUES ('8', '29', '8', '支持', '0', '1526613820', '1526613820');
INSERT INTO `ey_product_attr` VALUES ('17', '37', '2', '苹果', '', '1527507984', '1527507984');
INSERT INTO `ey_product_attr` VALUES ('18', '37', '1', '牛逼', '', '1527507984', '1527507984');
INSERT INTO `ey_product_attr` VALUES ('19', '37', '3', '触摸', '', '1527507984', '1527507984');
INSERT INTO `ey_product_attr` VALUES ('20', '37', '4', '234234', '', '1527507984', '1527507984');
INSERT INTO `ey_product_attr` VALUES ('21', '27', '2', 'EMUI 4.1 + Android 6.0', '', '1531726843', '1531726843');
INSERT INTO `ey_product_attr` VALUES ('22', '27', '1', 'EMUI 4.1', '', '1531726843', '1531726843');
INSERT INTO `ey_product_attr` VALUES ('23', '27', '3', '虚拟键盘', '', '1531726843', '1531726843');
INSERT INTO `ey_product_attr` VALUES ('24', '27', '4', 'EDI-AL10', '', '1531726843', '1531726843');

-- ----------------------------
-- Table structure for ey_product_attribute
-- ----------------------------
DROP TABLE IF EXISTS `ey_product_attribute`;
CREATE TABLE `ey_product_attribute` (
  `attr_id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '属性id',
  `attr_name` varchar(60) DEFAULT '' COMMENT '属性名称',
  `typeid` int(11) unsigned DEFAULT '0' COMMENT '栏目id',
  `attr_index` tinyint(1) unsigned DEFAULT '0' COMMENT '0不需要检索 1关键字检索 2范围检索',
  `attr_input_type` tinyint(1) unsigned DEFAULT '0' COMMENT ' 0=文本框，1=下拉框，2=多行文本框',
  `attr_values` text COMMENT '可选值列表',
  `sort_order` int(11) unsigned DEFAULT '0' COMMENT '属性排序',
  `lang` varchar(50) DEFAULT 'cn' COMMENT '语言标识',
  `is_del` tinyint(1) DEFAULT '0' COMMENT '是否已删除，0=否，1=是',
  `add_time` int(11) DEFAULT '0' COMMENT '新增时间',
  `update_time` int(11) DEFAULT '0' COMMENT '更新时间',
  PRIMARY KEY (`attr_id`),
  KEY `cat_id` (`typeid`) USING BTREE
) ENGINE=MyISAM AUTO_INCREMENT=19 DEFAULT CHARSET=utf8 COMMENT='产品表单属性表';

-- ----------------------------
-- Records of ey_product_attribute
-- ----------------------------
INSERT INTO `ey_product_attribute` VALUES ('1', '用户界面', '24', '0', '0', '', '100', 'cn', '0', '1526612774', '1526612774');
INSERT INTO `ey_product_attribute` VALUES ('2', '操作系统', '24', '0', '0', '', '10', 'cn', '0', '1526612785', '1526612785');
INSERT INTO `ey_product_attribute` VALUES ('3', '键盘类型', '24', '0', '0', '', '100', 'cn', '0', '1526613004', '1526613004');
INSERT INTO `ey_product_attribute` VALUES ('4', ' 型号', '24', '0', '0', '', '100', 'cn', '0', '1526613011', '1526613011');
INSERT INTO `ey_product_attribute` VALUES ('5', '屏幕大小', '26', '0', '0', '', '100', 'cn', '0', '1526613252', '1526613252');
INSERT INTO `ey_product_attribute` VALUES ('6', '重量', '26', '0', '0', '', '100', 'cn', '0', '1526613259', '1526613259');
INSERT INTO `ey_product_attribute` VALUES ('7', '型号', '27', '0', '0', '', '100', 'cn', '0', '1526613668', '1526613668');
INSERT INTO `ey_product_attribute` VALUES ('8', '支持蓝牙', '27', '0', '0', '', '100', 'cn', '0', '1526613732', '1526613732');

-- ----------------------------
-- Table structure for ey_product_content
-- ----------------------------
DROP TABLE IF EXISTS `ey_product_content`;
CREATE TABLE `ey_product_content` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `aid` int(10) DEFAULT '0' COMMENT '文档ID',
  `content` longtext COMMENT '内容详情',
  `add_time` int(11) DEFAULT '0' COMMENT '新增时间',
  `update_time` int(11) DEFAULT '0' COMMENT '更新时间',
  PRIMARY KEY (`id`),
  KEY `news_id` (`aid`) USING BTREE
) ENGINE=MyISAM AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COMMENT='产品附加表';

-- ----------------------------
-- Records of ey_product_content
-- ----------------------------
INSERT INTO `ey_product_content` VALUES ('2', '27', '&lt;p&gt;&lt;span style=&quot;color: rgb(94, 115, 135); font-family: &amp;quot;Segoe UI&amp;quot;, &amp;quot;Lucida Grande&amp;quot;, Helvetica, Arial, &amp;quot;Microsoft YaHei&amp;quot;, FreeSans, Arimo, &amp;quot;Droid Sans&amp;quot;, &amp;quot;wenquanyi micro hei&amp;quot;, &amp;quot;Hiragino Sans GB&amp;quot;, &amp;quot;Hiragino Sans GB W3&amp;quot;, Roboto, Arial, sans-serif; font-size: 14px; background-color: rgb(255, 255, 255);&quot;&gt;全向录音/指向回放、定向免提、指关节手势、分屏多窗口、语音控制、情景智能、单手操作、杂志锁屏、手机找回、无线WIFI打印、学生模式、多屏互动、运动健康&lt;/span&gt;&lt;span style=&quot;color: rgb(94, 115, 135); font-family: &amp;quot;Segoe UI&amp;quot;, &amp;quot;Lucida Grande&amp;quot;, Helvetica, Arial, &amp;quot;Microsoft YaHei&amp;quot;, FreeSans, Arimo, &amp;quot;Droid Sans&amp;quot;, &amp;quot;wenquanyi micro hei&amp;quot;, &amp;quot;Hiragino Sans GB&amp;quot;, &amp;quot;Hiragino Sans GB W3&amp;quot;, Roboto, Arial, sans-serif; font-size: 14px; background-color: rgb(255, 255, 255);&quot;&gt;全向录音/指向回放、定向免提、指关节手势、分屏多窗口、语音控制、情景智能、单手操作、杂志锁屏、手机找回、无线WIFI打印、学生模式、多屏互动、运动健康&lt;/span&gt;&lt;span style=&quot;color: rgb(94, 115, 135); font-family: &amp;quot;Segoe UI&amp;quot;, &amp;quot;Lucida Grande&amp;quot;, Helvetica, Arial, &amp;quot;Microsoft YaHei&amp;quot;, FreeSans, Arimo, &amp;quot;Droid Sans&amp;quot;, &amp;quot;wenquanyi micro hei&amp;quot;, &amp;quot;Hiragino Sans GB&amp;quot;, &amp;quot;Hiragino Sans GB W3&amp;quot;, Roboto, Arial, sans-serif; font-size: 14px; background-color: rgb(255, 255, 255);&quot;&gt;全向录音/指向回放、定向免提、指关节手势、分屏多窗口、语音控制、情景智能、单手操作、杂志锁屏、手机找回、无线WIFI打印、学生模式、多屏互动、运动健康的&lt;/span&gt;&lt;/p&gt;', '1526613043', '1531727096');
INSERT INTO `ey_product_content` VALUES ('3', '28', '&lt;p&gt;轻薄全金属机身 / 256GB SSD / 第八代 Intel 酷睿i5 处理器 / FHD 全贴合屏幕 / 指纹解锁 / office激活不支持7天无理由退货&lt;/p&gt;&lt;p&gt;&lt;img src=&quot;/public/upload/product/2018/05/18/4e5a31ff6bb3f88e03ae2d80353cdc67.jpg&quot; title=&quot;4e5a31ff6bb3f88e03ae2d80353cdc67.jpg&quot; alt=&quot;4e5a31ff6bb3f88e03ae2d80353cdc67.jpg&quot;/&gt;&lt;/p&gt;', '1526613271', '1531730814');
INSERT INTO `ey_product_content` VALUES ('4', '29', '&lt;p&gt;&lt;span style=&quot;color: rgb(94, 115, 135); font-family: &amp;quot;Segoe UI&amp;quot;, &amp;quot;Lucida Grande&amp;quot;, Helvetica, Arial, &amp;quot;Microsoft YaHei&amp;quot;, FreeSans, Arimo, &amp;quot;Droid Sans&amp;quot;, &amp;quot;wenquanyi micro hei&amp;quot;, &amp;quot;Hiragino Sans GB&amp;quot;, &amp;quot;Hiragino Sans GB W3&amp;quot;, Roboto, Arial, sans-serif; font-size: 14px; background-color: rgb(255, 255, 255);&quot;&gt;特性	M3平板定制AKG品牌高保真耳机，配合M3平板享受HiFi音质&lt;/span&gt;&lt;/p&gt;', '1526613739', '1526613820');
INSERT INTO `ey_product_content` VALUES ('5', '37', '&lt;p&gt;&lt;img src=&quot;/public/upload/product/2018/05/28/bbc3b215d0c76afa21a52358f59f8bed.jpg&quot; title=&quot;000000000134003091_3_800x800.jpg&quot; width=&quot;800&quot; height=&quot;800&quot; border=&quot;0&quot; vspace=&quot;0&quot; alt=&quot;000000000134003091_3_800x800.jpg&quot; style=&quot;width: 800px; height: 800px;&quot;/&gt;&lt;/p&gt;', '1527507844', '1531726969');

-- ----------------------------
-- Table structure for ey_product_img
-- ----------------------------
DROP TABLE IF EXISTS `ey_product_img`;
CREATE TABLE `ey_product_img` (
  `img_id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增ID',
  `aid` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT '产品ID',
  `title` varchar(200) DEFAULT '' COMMENT '产品标题',
  `image_url` varchar(255) DEFAULT '' COMMENT '文件存储路径',
  `width` int(11) DEFAULT '0' COMMENT '图片宽度',
  `height` int(11) DEFAULT '0' COMMENT '图片高度',
  `filesize` varchar(255) DEFAULT '' COMMENT '文件大小',
  `mime` varchar(50) DEFAULT '' COMMENT '图片类型',
  `sort_order` smallint(5) DEFAULT '0' COMMENT '排序',
  `add_time` int(10) unsigned DEFAULT '0' COMMENT '上传时间',
  PRIMARY KEY (`img_id`),
  KEY `arcid` (`aid`) USING BTREE
) ENGINE=MyISAM AUTO_INCREMENT=43 DEFAULT CHARSET=utf8 COMMENT='产品图片表';

-- ----------------------------
-- Records of ey_product_img
-- ----------------------------
INSERT INTO `ey_product_img` VALUES ('40', '27', '华为HUAWEI NOTE 8', '/public/upload/product/2018/05/18/2b6cf3e6fdb8573d99024567c834d42c.jpg', '400', '400', '0', 'image/jpeg', '1', '1531727097');
INSERT INTO `ey_product_img` VALUES ('42', '28', '小米笔记本Air 13.3', '/public/upload/product/2018/05/18/078891e9b7151559c35b9c77a522ff23.jpg', '400', '400', '0', 'image/jpeg', '2', '1531730815');
INSERT INTO `ey_product_img` VALUES ('41', '28', '小米笔记本Air 13.3', '/public/upload/product/2018/05/18/7e04484a0e74d6dbbe24ba9cf81b62fd.jpg', '560', '560', '0', 'image/jpeg', '1', '1531730815');
INSERT INTO `ey_product_img` VALUES ('8', '29', ' 小米蓝牙项圈耳机', '/public/upload/product/2018/05/18/97714e2c8a418a4282063d9019134a86.jpg', '400', '400', '0', 'image/jpeg', '1', '1526613820');
INSERT INTO `ey_product_img` VALUES ('9', '29', ' 小米蓝牙项圈耳机', '/public/upload/product/2018/05/18/48e701b08f5c10d1946300bc057374af.jpg', '400', '400', '0', 'image/jpeg', '2', '1526613820');
INSERT INTO `ey_product_img` VALUES ('10', '29', ' 小米蓝牙项圈耳机', '/public/upload/product/2018/05/18/3ce361b95074e5b35c7ea7ac11b98e53.jpg', '400', '400', '0', 'image/jpeg', '3', '1526613820');
INSERT INTO `ey_product_img` VALUES ('38', '37', 'Apple iPhone 6s 16GB 玫瑰金色 移动联通电信4G手机', '/public/upload/product/2018/05/28/0e2452c3fb90e308157c22781efdfcfa.jpg', '800', '800', '0', 'image/jpeg', '3', '1531726970');
INSERT INTO `ey_product_img` VALUES ('39', '37', 'Apple iPhone 6s 16GB 玫瑰金色 移动联通电信4G手机', '/public/upload/product/2018/05/28/bbc3b215d0c76afa21a52358f59f8bed.jpg', '800', '800', '0', 'image/jpeg', '4', '1531726970');
INSERT INTO `ey_product_img` VALUES ('37', '37', 'Apple iPhone 6s 16GB 玫瑰金色 移动联通电信4G手机', '/public/upload/product/2018/05/28/1ac58d20256c11ec9849eed616bbc42b.jpg', '800', '800', '0', 'image/jpeg', '2', '1531726970');
INSERT INTO `ey_product_img` VALUES ('36', '37', 'Apple iPhone 6s 16GB 玫瑰金色 移动联通电信4G手机', '/public/upload/product/2018/05/28/22b1d3ab98046b377e795e70450a602f.jpg', '800', '800', '0', 'image/jpeg', '1', '1531726970');

-- ----------------------------
-- Table structure for ey_single_content
-- ----------------------------
DROP TABLE IF EXISTS `ey_single_content`;
CREATE TABLE `ey_single_content` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `aid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '文档ID',
  `typeid` int(10) DEFAULT '0' COMMENT '栏目ID',
  `content` longtext COMMENT '内容详情',
  `add_time` int(11) DEFAULT '0' COMMENT '新增时间',
  `update_time` int(11) DEFAULT '0' COMMENT '更新时间',
  PRIMARY KEY (`id`),
  KEY `aid` (`aid`) USING BTREE
) ENGINE=MyISAM AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 COMMENT='单页附加表';

-- ----------------------------
-- Records of ey_single_content
-- ----------------------------
INSERT INTO `ey_single_content` VALUES ('1', '1', '1', '', '0', '1527836335');
INSERT INTO `ey_single_content` VALUES ('2', '2', '8', '&lt;p style=&quot;white-space: normal; text-indent: 2em;&quot;&gt;易优内容管理系统(&lt;a href=&quot;http://www.eyoucms.com/&quot; target=&quot;_blank&quot;&gt;EyouCms&lt;/a&gt;) 以模板多、易优化、开源而闻名，是国内新锐的PHP开源网站管理系统，也是最受用户好评的PHP类CMS系统，在经历多年的发展，目前的版本无论在功能，还是在后台易用性方面，都有了长足的发展和进步，eyoucms免费版的主要目标用户锁定在有企业建站需求的群体，当然也不乏有个人用户和学校等在使用该系统。&lt;/p&gt;&lt;p style=&quot;white-space: normal; text-indent: 2em;&quot;&gt;企业网站，无论大型还是中小型企业，利用网络传递信息在一定程度上提高了办事的效率，提高企业的竞争力。&lt;a href=&quot;http://www.eyoucms.com/&quot; target=&quot;_blank&quot;&gt;EyouCms&lt;/a&gt;网站建设系统做各种网站，&lt;a href=&quot;http://www.eyoucms.com/&quot; target=&quot;_blank&quot;&gt;EyouCms&lt;/a&gt;是什么，&lt;a href=&quot;http://www.eyoucms.com/&quot; target=&quot;_blank&quot;&gt;EyouCms&lt;/a&gt;是一个自由和开放源码的内容管理系统，它是一个可以独立使用的内容发布系统（CMS）。在中国，&lt;a href=&quot;http://www.eyoucms.com/&quot; target=&quot;_blank&quot;&gt;EyouCms&lt;/a&gt;属于最受人们喜爱的CMS系统。&lt;/p&gt;&lt;p style=&quot;white-space: normal; text-indent: 2em;&quot;&gt;政府机关，通过建立政府门户，有利于各种信息和资源的整合，为政府和社会公众之间加强联系和沟通，从而使政府可以更快、更便捷、更有效开展工作。&lt;/p&gt;&lt;p style=&quot;white-space: normal; text-indent: 2em;&quot;&gt;教育机构，通过网络信息的引入，使得教育机构之间及教育机构内部和教育者之间进行信息传递，全面提升教育类网站的层面。&lt;/p&gt;&lt;h3 style=&quot;white-space: normal;&quot;&gt;优点&lt;/h3&gt;&lt;ol class=&quot; list-paddingleft-2&quot;&gt;&lt;li&gt;&lt;p&gt;易用：使用易优你可以用它十分钟搭建一个企业网站，后台简单易用。&lt;/p&gt;&lt;/li&gt;&lt;li&gt;&lt;p&gt;完善：易优基本包含了一个常规企业网站需要的一切功能。&lt;/p&gt;&lt;/li&gt;&lt;li&gt;&lt;p&gt;扩展性：易优亦可通过插件库支持更多功能，如阿里短信或小程序等第三方扩展。&lt;br/&gt;&lt;/p&gt;&lt;/li&gt;&lt;li&gt;&lt;p&gt;丰富的资料：作为一个国内cms，易优拥有完善的帮助文档及标签手册。&lt;/p&gt;&lt;/li&gt;&lt;li&gt;&lt;p&gt;丰富的模版：易优拥有大量免费的漂亮模版，涵盖各行各业，任用户自由选择。&lt;/p&gt;&lt;/li&gt;&lt;/ol&gt;&lt;h3 style=&quot;white-space: normal;&quot;&gt;缺点&lt;/h3&gt;&lt;ol class=&quot; list-paddingleft-2&quot;&gt;&lt;li&gt;&lt;p&gt;创新性：易优是一个基于用户需求开发的系统，用户需求不断改变，我们竭力跟着并改变。&lt;/p&gt;&lt;/li&gt;&lt;li&gt;&lt;p&gt;社区：目前专注模板建设，这对于一个开源项目来说社区互动并没有真正建立起来。&lt;/p&gt;&lt;p&gt;&lt;br/&gt;&lt;/p&gt;&lt;/li&gt;&lt;/ol&gt;&lt;p style=&quot;white-space: normal; text-indent: 2em;&quot;&gt;未来，期待与用户携手缔造一个更好的易而优CMS...2018.6.1&lt;/p&gt;&lt;p&gt;&lt;br/&gt;&lt;/p&gt;', '0', '1527836706');
INSERT INTO `ey_single_content` VALUES ('3', '3', '13', '&lt;div yne-bulb-block=&quot;paragraph&quot; style=&quot;box-sizing: border-box; color: rgb(34, 34, 34); font-family: &amp;quot;Segoe UI&amp;quot;, &amp;quot;Lucida Grande&amp;quot;, Helvetica, Arial, &amp;quot;Microsoft YaHei&amp;quot;, FreeSans, Arimo, &amp;quot;Droid Sans&amp;quot;, &amp;quot;wenquanyi micro hei&amp;quot;, &amp;quot;Hiragino Sans GB&amp;quot;, &amp;quot;Hiragino Sans GB W3&amp;quot;, Roboto, Arial, sans-serif; font-size: 18px; white-space: normal;&quot;&gt;针对不同服务器、虚拟空间，运行PHP的环境也有所不同，目前主要分为：Nginx、apache、IIS以及其他服务器。下面分享如何去掉URL上的index.php字符，&lt;span style=&quot;box-sizing: border-box; color: rgb(255, 0, 0);&quot;&gt;记得最后要重启服务器，在管理后台清除缓存哦！&lt;/span&gt;&lt;/div&gt;&lt;div yne-bulb-block=&quot;paragraph&quot; style=&quot;box-sizing: border-box; color: rgb(34, 34, 34); font-family: &amp;quot;Segoe UI&amp;quot;, &amp;quot;Lucida Grande&amp;quot;, Helvetica, Arial, &amp;quot;Microsoft YaHei&amp;quot;, FreeSans, Arimo, &amp;quot;Droid Sans&amp;quot;, &amp;quot;wenquanyi micro hei&amp;quot;, &amp;quot;Hiragino Sans GB&amp;quot;, &amp;quot;Hiragino Sans GB W3&amp;quot;, Roboto, Arial, sans-serif; font-size: 18px; white-space: normal;&quot;&gt;&amp;nbsp;&lt;/div&gt;&lt;div yne-bulb-block=&quot;paragraph&quot; style=&quot;box-sizing: border-box; color: rgb(34, 34, 34); font-family: &amp;quot;Segoe UI&amp;quot;, &amp;quot;Lucida Grande&amp;quot;, Helvetica, Arial, &amp;quot;Microsoft YaHei&amp;quot;, FreeSans, Arimo, &amp;quot;Droid Sans&amp;quot;, &amp;quot;wenquanyi micro hei&amp;quot;, &amp;quot;Hiragino Sans GB&amp;quot;, &amp;quot;Hiragino Sans GB W3&amp;quot;, Roboto, Arial, sans-serif; font-size: 18px; white-space: normal;&quot;&gt;【IIS服务器】&lt;/div&gt;&lt;div yne-bulb-block=&quot;paragraph&quot; style=&quot;box-sizing: border-box; color: rgb(34, 34, 34); font-family: &amp;quot;Segoe UI&amp;quot;, &amp;quot;Lucida Grande&amp;quot;, Helvetica, Arial, &amp;quot;Microsoft YaHei&amp;quot;, FreeSans, Arimo, &amp;quot;Droid Sans&amp;quot;, &amp;quot;wenquanyi micro hei&amp;quot;, &amp;quot;Hiragino Sans GB&amp;quot;, &amp;quot;Hiragino Sans GB W3&amp;quot;, Roboto, Arial, sans-serif; font-size: 18px; white-space: normal;&quot;&gt;在网站根目录下有个 web.config 文件，这个文件的作用是重写URL，让URL变得简短，易于SEO优化，以及用户的记忆。打开 web.config 文件，在原有的基础上加以下代码片段即可。&lt;/div&gt;&lt;div yne-bulb-block=&quot;paragraph&quot; style=&quot;box-sizing: border-box; color: rgb(34, 34, 34); font-family: &amp;quot;Segoe UI&amp;quot;, &amp;quot;Lucida Grande&amp;quot;, Helvetica, Arial, &amp;quot;Microsoft YaHei&amp;quot;, FreeSans, Arimo, &amp;quot;Droid Sans&amp;quot;, &amp;quot;wenquanyi micro hei&amp;quot;, &amp;quot;Hiragino Sans GB&amp;quot;, &amp;quot;Hiragino Sans GB W3&amp;quot;, Roboto, Arial, sans-serif; font-size: 18px; white-space: normal;&quot;&gt;&lt;span style=&quot;box-sizing: border-box; color: rgb(255, 0, 0);&quot;&gt;&amp;lt;rewrite&amp;gt;&lt;/span&gt;&lt;/div&gt;&lt;div yne-bulb-block=&quot;paragraph&quot; style=&quot;box-sizing: border-box; color: rgb(34, 34, 34); font-family: &amp;quot;Segoe UI&amp;quot;, &amp;quot;Lucida Grande&amp;quot;, Helvetica, Arial, &amp;quot;Microsoft YaHei&amp;quot;, FreeSans, Arimo, &amp;quot;Droid Sans&amp;quot;, &amp;quot;wenquanyi micro hei&amp;quot;, &amp;quot;Hiragino Sans GB&amp;quot;, &amp;quot;Hiragino Sans GB W3&amp;quot;, Roboto, Arial, sans-serif; font-size: 18px; white-space: normal;&quot;&gt;&lt;span style=&quot;box-sizing: border-box; color: rgb(255, 0, 0);&quot;&gt;&amp;lt;rules&amp;gt;&lt;/span&gt;&lt;/div&gt;&lt;div yne-bulb-block=&quot;paragraph&quot; style=&quot;box-sizing: border-box; color: rgb(34, 34, 34); font-family: &amp;quot;Segoe UI&amp;quot;, &amp;quot;Lucida Grande&amp;quot;, Helvetica, Arial, &amp;quot;Microsoft YaHei&amp;quot;, FreeSans, Arimo, &amp;quot;Droid Sans&amp;quot;, &amp;quot;wenquanyi micro hei&amp;quot;, &amp;quot;Hiragino Sans GB&amp;quot;, &amp;quot;Hiragino Sans GB W3&amp;quot;, Roboto, Arial, sans-serif; font-size: 18px; white-space: normal;&quot;&gt;&lt;span style=&quot;box-sizing: border-box; color: rgb(255, 0, 0);&quot;&gt;&amp;lt;rule name=&amp;quot;Imported Rule 1&amp;quot; enabled=&amp;quot;true&amp;quot; stopProcessing=&amp;quot;true&amp;quot;&amp;gt;&lt;/span&gt;&lt;/div&gt;&lt;div yne-bulb-block=&quot;paragraph&quot; style=&quot;box-sizing: border-box; color: rgb(34, 34, 34); font-family: &amp;quot;Segoe UI&amp;quot;, &amp;quot;Lucida Grande&amp;quot;, Helvetica, Arial, &amp;quot;Microsoft YaHei&amp;quot;, FreeSans, Arimo, &amp;quot;Droid Sans&amp;quot;, &amp;quot;wenquanyi micro hei&amp;quot;, &amp;quot;Hiragino Sans GB&amp;quot;, &amp;quot;Hiragino Sans GB W3&amp;quot;, Roboto, Arial, sans-serif; font-size: 18px; white-space: normal;&quot;&gt;&lt;span style=&quot;box-sizing: border-box; color: rgb(255, 0, 0);&quot;&gt;&amp;lt;match url=&amp;quot;^(.*)$&amp;quot; /&amp;gt;&lt;/span&gt;&lt;/div&gt;&lt;div yne-bulb-block=&quot;paragraph&quot; style=&quot;box-sizing: border-box; color: rgb(34, 34, 34); font-family: &amp;quot;Segoe UI&amp;quot;, &amp;quot;Lucida Grande&amp;quot;, Helvetica, Arial, &amp;quot;Microsoft YaHei&amp;quot;, FreeSans, Arimo, &amp;quot;Droid Sans&amp;quot;, &amp;quot;wenquanyi micro hei&amp;quot;, &amp;quot;Hiragino Sans GB&amp;quot;, &amp;quot;Hiragino Sans GB W3&amp;quot;, Roboto, Arial, sans-serif; font-size: 18px; white-space: normal;&quot;&gt;&lt;span style=&quot;box-sizing: border-box; color: rgb(255, 0, 0);&quot;&gt;&amp;lt;conditions logicalGrouping=&amp;quot;MatchAll&amp;quot;&amp;gt;&lt;/span&gt;&lt;/div&gt;&lt;div yne-bulb-block=&quot;paragraph&quot; style=&quot;box-sizing: border-box; color: rgb(34, 34, 34); font-family: &amp;quot;Segoe UI&amp;quot;, &amp;quot;Lucida Grande&amp;quot;, Helvetica, Arial, &amp;quot;Microsoft YaHei&amp;quot;, FreeSans, Arimo, &amp;quot;Droid Sans&amp;quot;, &amp;quot;wenquanyi micro hei&amp;quot;, &amp;quot;Hiragino Sans GB&amp;quot;, &amp;quot;Hiragino Sans GB W3&amp;quot;, Roboto, Arial, sans-serif; font-size: 18px; white-space: normal;&quot;&gt;&lt;span style=&quot;box-sizing: border-box; color: rgb(255, 0, 0);&quot;&gt;&amp;lt;add input=&amp;quot;{HTTP_HOST}&amp;quot; pattern=&amp;quot;^(.*)$&amp;quot; /&amp;gt;&lt;/span&gt;&lt;/div&gt;&lt;div yne-bulb-block=&quot;paragraph&quot; style=&quot;box-sizing: border-box; color: rgb(34, 34, 34); font-family: &amp;quot;Segoe UI&amp;quot;, &amp;quot;Lucida Grande&amp;quot;, Helvetica, Arial, &amp;quot;Microsoft YaHei&amp;quot;, FreeSans, Arimo, &amp;quot;Droid Sans&amp;quot;, &amp;quot;wenquanyi micro hei&amp;quot;, &amp;quot;Hiragino Sans GB&amp;quot;, &amp;quot;Hiragino Sans GB W3&amp;quot;, Roboto, Arial, sans-serif; font-size: 18px; white-space: normal;&quot;&gt;&lt;span style=&quot;box-sizing: border-box; color: rgb(255, 0, 0);&quot;&gt;&amp;lt;add input=&amp;quot;{REQUEST_FILENAME}&amp;quot; matchType=&amp;quot;IsFile&amp;quot; negate=&amp;quot;true&amp;quot; /&amp;gt;&lt;/span&gt;&lt;/div&gt;&lt;div yne-bulb-block=&quot;paragraph&quot; style=&quot;box-sizing: border-box; color: rgb(34, 34, 34); font-family: &amp;quot;Segoe UI&amp;quot;, &amp;quot;Lucida Grande&amp;quot;, Helvetica, Arial, &amp;quot;Microsoft YaHei&amp;quot;, FreeSans, Arimo, &amp;quot;Droid Sans&amp;quot;, &amp;quot;wenquanyi micro hei&amp;quot;, &amp;quot;Hiragino Sans GB&amp;quot;, &amp;quot;Hiragino Sans GB W3&amp;quot;, Roboto, Arial, sans-serif; font-size: 18px; white-space: normal;&quot;&gt;&lt;span style=&quot;box-sizing: border-box; color: rgb(255, 0, 0);&quot;&gt;&amp;lt;add input=&amp;quot;{REQUEST_FILENAME}&amp;quot; matchType=&amp;quot;IsDirectory&amp;quot; negate=&amp;quot;true&amp;quot; /&amp;gt;&lt;/span&gt;&lt;/div&gt;&lt;div yne-bulb-block=&quot;paragraph&quot; style=&quot;box-sizing: border-box; color: rgb(34, 34, 34); font-family: &amp;quot;Segoe UI&amp;quot;, &amp;quot;Lucida Grande&amp;quot;, Helvetica, Arial, &amp;quot;Microsoft YaHei&amp;quot;, FreeSans, Arimo, &amp;quot;Droid Sans&amp;quot;, &amp;quot;wenquanyi micro hei&amp;quot;, &amp;quot;Hiragino Sans GB&amp;quot;, &amp;quot;Hiragino Sans GB W3&amp;quot;, Roboto, Arial, sans-serif; font-size: 18px; white-space: normal;&quot;&gt;&lt;span style=&quot;box-sizing: border-box; color: rgb(255, 0, 0);&quot;&gt;&amp;lt;/conditions&amp;gt;&lt;/span&gt;&lt;/div&gt;&lt;div yne-bulb-block=&quot;paragraph&quot; style=&quot;box-sizing: border-box; color: rgb(34, 34, 34); font-family: &amp;quot;Segoe UI&amp;quot;, &amp;quot;Lucida Grande&amp;quot;, Helvetica, Arial, &amp;quot;Microsoft YaHei&amp;quot;, FreeSans, Arimo, &amp;quot;Droid Sans&amp;quot;, &amp;quot;wenquanyi micro hei&amp;quot;, &amp;quot;Hiragino Sans GB&amp;quot;, &amp;quot;Hiragino Sans GB W3&amp;quot;, Roboto, Arial, sans-serif; font-size: 18px; white-space: normal;&quot;&gt;&lt;span style=&quot;box-sizing: border-box; color: rgb(255, 0, 0);&quot;&gt;&amp;lt;action type=&amp;quot;Rewrite&amp;quot; url=&amp;quot;index.php/{R:1}&amp;quot; /&amp;gt;&lt;/span&gt;&lt;/div&gt;&lt;div yne-bulb-block=&quot;paragraph&quot; style=&quot;box-sizing: border-box; color: rgb(34, 34, 34); font-family: &amp;quot;Segoe UI&amp;quot;, &amp;quot;Lucida Grande&amp;quot;, Helvetica, Arial, &amp;quot;Microsoft YaHei&amp;quot;, FreeSans, Arimo, &amp;quot;Droid Sans&amp;quot;, &amp;quot;wenquanyi micro hei&amp;quot;, &amp;quot;Hiragino Sans GB&amp;quot;, &amp;quot;Hiragino Sans GB W3&amp;quot;, Roboto, Arial, sans-serif; font-size: 18px; white-space: normal;&quot;&gt;&lt;span style=&quot;box-sizing: border-box; color: rgb(255, 0, 0);&quot;&gt;&amp;lt;/rule&amp;gt;&lt;/span&gt;&lt;/div&gt;&lt;div yne-bulb-block=&quot;paragraph&quot; style=&quot;box-sizing: border-box; color: rgb(34, 34, 34); font-family: &amp;quot;Segoe UI&amp;quot;, &amp;quot;Lucida Grande&amp;quot;, Helvetica, Arial, &amp;quot;Microsoft YaHei&amp;quot;, FreeSans, Arimo, &amp;quot;Droid Sans&amp;quot;, &amp;quot;wenquanyi micro hei&amp;quot;, &amp;quot;Hiragino Sans GB&amp;quot;, &amp;quot;Hiragino Sans GB W3&amp;quot;, Roboto, Arial, sans-serif; font-size: 18px; white-space: normal;&quot;&gt;&lt;span style=&quot;box-sizing: border-box; color: rgb(255, 0, 0);&quot;&gt;&amp;lt;/rules&amp;gt;&lt;/span&gt;&lt;/div&gt;&lt;div yne-bulb-block=&quot;paragraph&quot; style=&quot;box-sizing: border-box; color: rgb(34, 34, 34); font-family: &amp;quot;Segoe UI&amp;quot;, &amp;quot;Lucida Grande&amp;quot;, Helvetica, Arial, &amp;quot;Microsoft YaHei&amp;quot;, FreeSans, Arimo, &amp;quot;Droid Sans&amp;quot;, &amp;quot;wenquanyi micro hei&amp;quot;, &amp;quot;Hiragino Sans GB&amp;quot;, &amp;quot;Hiragino Sans GB W3&amp;quot;, Roboto, Arial, sans-serif; font-size: 18px; white-space: normal;&quot;&gt;&lt;span style=&quot;box-sizing: border-box; color: rgb(255, 0, 0);&quot;&gt;&amp;lt;/rewrite&amp;gt;&lt;/span&gt;&lt;/div&gt;&lt;div yne-bulb-block=&quot;paragraph&quot; style=&quot;box-sizing: border-box; color: rgb(34, 34, 34); font-family: &amp;quot;Segoe UI&amp;quot;, &amp;quot;Lucida Grande&amp;quot;, Helvetica, Arial, &amp;quot;Microsoft YaHei&amp;quot;, FreeSans, Arimo, &amp;quot;Droid Sans&amp;quot;, &amp;quot;wenquanyi micro hei&amp;quot;, &amp;quot;Hiragino Sans GB&amp;quot;, &amp;quot;Hiragino Sans GB W3&amp;quot;, Roboto, Arial, sans-serif; font-size: 18px; white-space: normal;&quot;&gt;&amp;nbsp;&lt;/div&gt;&lt;div yne-bulb-block=&quot;paragraph&quot; style=&quot;box-sizing: border-box; color: rgb(34, 34, 34); font-family: &amp;quot;Segoe UI&amp;quot;, &amp;quot;Lucida Grande&amp;quot;, Helvetica, Arial, &amp;quot;Microsoft YaHei&amp;quot;, FreeSans, Arimo, &amp;quot;Droid Sans&amp;quot;, &amp;quot;wenquanyi micro hei&amp;quot;, &amp;quot;Hiragino Sans GB&amp;quot;, &amp;quot;Hiragino Sans GB W3&amp;quot;, Roboto, Arial, sans-serif; font-size: 18px; white-space: normal;&quot;&gt;以下是某个香港虚拟空间的效果：&lt;/div&gt;&lt;div yne-bulb-block=&quot;paragraph&quot; style=&quot;box-sizing: border-box; color: rgb(34, 34, 34); font-family: &amp;quot;Segoe UI&amp;quot;, &amp;quot;Lucida Grande&amp;quot;, Helvetica, Arial, &amp;quot;Microsoft YaHei&amp;quot;, FreeSans, Arimo, &amp;quot;Droid Sans&amp;quot;, &amp;quot;wenquanyi micro hei&amp;quot;, &amp;quot;Hiragino Sans GB&amp;quot;, &amp;quot;Hiragino Sans GB W3&amp;quot;, Roboto, Arial, sans-serif; font-size: 18px; white-space: normal;&quot;&gt;&amp;lt;?xml version=&amp;quot;1.0&amp;quot; encoding=&amp;quot;UTF-8&amp;quot;?&amp;gt;&lt;/div&gt;&lt;div yne-bulb-block=&quot;paragraph&quot; style=&quot;box-sizing: border-box; color: rgb(34, 34, 34); font-family: &amp;quot;Segoe UI&amp;quot;, &amp;quot;Lucida Grande&amp;quot;, Helvetica, Arial, &amp;quot;Microsoft YaHei&amp;quot;, FreeSans, Arimo, &amp;quot;Droid Sans&amp;quot;, &amp;quot;wenquanyi micro hei&amp;quot;, &amp;quot;Hiragino Sans GB&amp;quot;, &amp;quot;Hiragino Sans GB W3&amp;quot;, Roboto, Arial, sans-serif; font-size: 18px; white-space: normal;&quot;&gt;&amp;lt;configuration&amp;gt;&lt;/div&gt;&lt;div yne-bulb-block=&quot;paragraph&quot; style=&quot;box-sizing: border-box; color: rgb(34, 34, 34); font-family: &amp;quot;Segoe UI&amp;quot;, &amp;quot;Lucida Grande&amp;quot;, Helvetica, Arial, &amp;quot;Microsoft YaHei&amp;quot;, FreeSans, Arimo, &amp;quot;Droid Sans&amp;quot;, &amp;quot;wenquanyi micro hei&amp;quot;, &amp;quot;Hiragino Sans GB&amp;quot;, &amp;quot;Hiragino Sans GB W3&amp;quot;, Roboto, Arial, sans-serif; font-size: 18px; white-space: normal;&quot;&gt;&amp;lt;system.webServer&amp;gt;&lt;/div&gt;&lt;div yne-bulb-block=&quot;paragraph&quot; style=&quot;box-sizing: border-box; color: rgb(34, 34, 34); font-family: &amp;quot;Segoe UI&amp;quot;, &amp;quot;Lucida Grande&amp;quot;, Helvetica, Arial, &amp;quot;Microsoft YaHei&amp;quot;, FreeSans, Arimo, &amp;quot;Droid Sans&amp;quot;, &amp;quot;wenquanyi micro hei&amp;quot;, &amp;quot;Hiragino Sans GB&amp;quot;, &amp;quot;Hiragino Sans GB W3&amp;quot;, Roboto, Arial, sans-serif; font-size: 18px; white-space: normal;&quot;&gt;&amp;lt;handlers&amp;gt;&lt;/div&gt;&lt;div yne-bulb-block=&quot;paragraph&quot; style=&quot;box-sizing: border-box; color: rgb(34, 34, 34); font-family: &amp;quot;Segoe UI&amp;quot;, &amp;quot;Lucida Grande&amp;quot;, Helvetica, Arial, &amp;quot;Microsoft YaHei&amp;quot;, FreeSans, Arimo, &amp;quot;Droid Sans&amp;quot;, &amp;quot;wenquanyi micro hei&amp;quot;, &amp;quot;Hiragino Sans GB&amp;quot;, &amp;quot;Hiragino Sans GB W3&amp;quot;, Roboto, Arial, sans-serif; font-size: 18px; white-space: normal;&quot;&gt;&amp;lt;remove name=&amp;quot;PHP-7.0-7i24.com&amp;quot; /&amp;gt;&lt;/div&gt;&lt;div yne-bulb-block=&quot;paragraph&quot; style=&quot;box-sizing: border-box; color: rgb(34, 34, 34); font-family: &amp;quot;Segoe UI&amp;quot;, &amp;quot;Lucida Grande&amp;quot;, Helvetica, Arial, &amp;quot;Microsoft YaHei&amp;quot;, FreeSans, Arimo, &amp;quot;Droid Sans&amp;quot;, &amp;quot;wenquanyi micro hei&amp;quot;, &amp;quot;Hiragino Sans GB&amp;quot;, &amp;quot;Hiragino Sans GB W3&amp;quot;, Roboto, Arial, sans-serif; font-size: 18px; white-space: normal;&quot;&gt;&amp;lt;remove name=&amp;quot;PHP-5.6-7i24.com&amp;quot; /&amp;gt;&lt;/div&gt;&lt;div yne-bulb-block=&quot;paragraph&quot; style=&quot;box-sizing: border-box; color: rgb(34, 34, 34); font-family: &amp;quot;Segoe UI&amp;quot;, &amp;quot;Lucida Grande&amp;quot;, Helvetica, Arial, &amp;quot;Microsoft YaHei&amp;quot;, FreeSans, Arimo, &amp;quot;Droid Sans&amp;quot;, &amp;quot;wenquanyi micro hei&amp;quot;, &amp;quot;Hiragino Sans GB&amp;quot;, &amp;quot;Hiragino Sans GB W3&amp;quot;, Roboto, Arial, sans-serif; font-size: 18px; white-space: normal;&quot;&gt;&amp;lt;remove name=&amp;quot;PHP-5.5-7i24.com&amp;quot; /&amp;gt;&lt;/div&gt;&lt;div yne-bulb-block=&quot;paragraph&quot; style=&quot;box-sizing: border-box; color: rgb(34, 34, 34); font-family: &amp;quot;Segoe UI&amp;quot;, &amp;quot;Lucida Grande&amp;quot;, Helvetica, Arial, &amp;quot;Microsoft YaHei&amp;quot;, FreeSans, Arimo, &amp;quot;Droid Sans&amp;quot;, &amp;quot;wenquanyi micro hei&amp;quot;, &amp;quot;Hiragino Sans GB&amp;quot;, &amp;quot;Hiragino Sans GB W3&amp;quot;, Roboto, Arial, sans-serif; font-size: 18px; white-space: normal;&quot;&gt;&amp;lt;remove name=&amp;quot;PHP-5.4-7i24.com&amp;quot; /&amp;gt;&lt;/div&gt;&lt;div yne-bulb-block=&quot;paragraph&quot; style=&quot;box-sizing: border-box; color: rgb(34, 34, 34); font-family: &amp;quot;Segoe UI&amp;quot;, &amp;quot;Lucida Grande&amp;quot;, Helvetica, Arial, &amp;quot;Microsoft YaHei&amp;quot;, FreeSans, Arimo, &amp;quot;Droid Sans&amp;quot;, &amp;quot;wenquanyi micro hei&amp;quot;, &amp;quot;Hiragino Sans GB&amp;quot;, &amp;quot;Hiragino Sans GB W3&amp;quot;, Roboto, Arial, sans-serif; font-size: 18px; white-space: normal;&quot;&gt;&amp;lt;remove name=&amp;quot;PHP-5.3-7i24.com&amp;quot; /&amp;gt;&lt;/div&gt;&lt;div yne-bulb-block=&quot;paragraph&quot; style=&quot;box-sizing: border-box; color: rgb(34, 34, 34); font-family: &amp;quot;Segoe UI&amp;quot;, &amp;quot;Lucida Grande&amp;quot;, Helvetica, Arial, &amp;quot;Microsoft YaHei&amp;quot;, FreeSans, Arimo, &amp;quot;Droid Sans&amp;quot;, &amp;quot;wenquanyi micro hei&amp;quot;, &amp;quot;Hiragino Sans GB&amp;quot;, &amp;quot;Hiragino Sans GB W3&amp;quot;, Roboto, Arial, sans-serif; font-size: 18px; white-space: normal;&quot;&gt;&amp;lt;remove name=&amp;quot;PHP-5.2-7i24.com&amp;quot; /&amp;gt;&lt;/div&gt;&lt;div yne-bulb-block=&quot;paragraph&quot; style=&quot;box-sizing: border-box; color: rgb(34, 34, 34); font-family: &amp;quot;Segoe UI&amp;quot;, &amp;quot;Lucida Grande&amp;quot;, Helvetica, Arial, &amp;quot;Microsoft YaHei&amp;quot;, FreeSans, Arimo, &amp;quot;Droid Sans&amp;quot;, &amp;quot;wenquanyi micro hei&amp;quot;, &amp;quot;Hiragino Sans GB&amp;quot;, &amp;quot;Hiragino Sans GB W3&amp;quot;, Roboto, Arial, sans-serif; font-size: 18px; white-space: normal;&quot;&gt;&amp;lt;add name=&amp;quot;PHP-5.4-7i24.com&amp;quot; path=&amp;quot;*.php&amp;quot; verb=&amp;quot;*&amp;quot; modules=&amp;quot;FastCgiModule&amp;quot; scriptProcessor=&amp;quot;c:php.4php-cgi.exe&amp;quot; resourceType=&amp;quot;Either&amp;quot; /&amp;gt;&lt;/div&gt;&lt;div yne-bulb-block=&quot;paragraph&quot; style=&quot;box-sizing: border-box; color: rgb(34, 34, 34); font-family: &amp;quot;Segoe UI&amp;quot;, &amp;quot;Lucida Grande&amp;quot;, Helvetica, Arial, &amp;quot;Microsoft YaHei&amp;quot;, FreeSans, Arimo, &amp;quot;Droid Sans&amp;quot;, &amp;quot;wenquanyi micro hei&amp;quot;, &amp;quot;Hiragino Sans GB&amp;quot;, &amp;quot;Hiragino Sans GB W3&amp;quot;, Roboto, Arial, sans-serif; font-size: 18px; white-space: normal;&quot;&gt;&amp;lt;/handlers&amp;gt;&lt;/div&gt;&lt;div yne-bulb-block=&quot;paragraph&quot; style=&quot;box-sizing: border-box; color: rgb(34, 34, 34); font-family: &amp;quot;Segoe UI&amp;quot;, &amp;quot;Lucida Grande&amp;quot;, Helvetica, Arial, &amp;quot;Microsoft YaHei&amp;quot;, FreeSans, Arimo, &amp;quot;Droid Sans&amp;quot;, &amp;quot;wenquanyi micro hei&amp;quot;, &amp;quot;Hiragino Sans GB&amp;quot;, &amp;quot;Hiragino Sans GB W3&amp;quot;, Roboto, Arial, sans-serif; font-size: 18px; white-space: normal;&quot;&gt;&lt;span style=&quot;box-sizing: border-box; color: rgb(255, 0, 0);&quot;&gt;&amp;lt;rewrite&amp;gt;&lt;/span&gt;&lt;/div&gt;&lt;div yne-bulb-block=&quot;paragraph&quot; style=&quot;box-sizing: border-box; color: rgb(34, 34, 34); font-family: &amp;quot;Segoe UI&amp;quot;, &amp;quot;Lucida Grande&amp;quot;, Helvetica, Arial, &amp;quot;Microsoft YaHei&amp;quot;, FreeSans, Arimo, &amp;quot;Droid Sans&amp;quot;, &amp;quot;wenquanyi micro hei&amp;quot;, &amp;quot;Hiragino Sans GB&amp;quot;, &amp;quot;Hiragino Sans GB W3&amp;quot;, Roboto, Arial, sans-serif; font-size: 18px; white-space: normal;&quot;&gt;&lt;span style=&quot;box-sizing: border-box; color: rgb(255, 0, 0);&quot;&gt;&amp;lt;rules&amp;gt;&lt;/span&gt;&lt;/div&gt;&lt;div yne-bulb-block=&quot;paragraph&quot; style=&quot;box-sizing: border-box; color: rgb(34, 34, 34); font-family: &amp;quot;Segoe UI&amp;quot;, &amp;quot;Lucida Grande&amp;quot;, Helvetica, Arial, &amp;quot;Microsoft YaHei&amp;quot;, FreeSans, Arimo, &amp;quot;Droid Sans&amp;quot;, &amp;quot;wenquanyi micro hei&amp;quot;, &amp;quot;Hiragino Sans GB&amp;quot;, &amp;quot;Hiragino Sans GB W3&amp;quot;, Roboto, Arial, sans-serif; font-size: 18px; white-space: normal;&quot;&gt;&lt;span style=&quot;box-sizing: border-box; color: rgb(255, 0, 0);&quot;&gt;&amp;lt;rule name=&amp;quot;Imported Rule 1&amp;quot; enabled=&amp;quot;true&amp;quot; stopProcessing=&amp;quot;true&amp;quot;&amp;gt;&lt;/span&gt;&lt;/div&gt;&lt;div yne-bulb-block=&quot;paragraph&quot; style=&quot;box-sizing: border-box; color: rgb(34, 34, 34); font-family: &amp;quot;Segoe UI&amp;quot;, &amp;quot;Lucida Grande&amp;quot;, Helvetica, Arial, &amp;quot;Microsoft YaHei&amp;quot;, FreeSans, Arimo, &amp;quot;Droid Sans&amp;quot;, &amp;quot;wenquanyi micro hei&amp;quot;, &amp;quot;Hiragino Sans GB&amp;quot;, &amp;quot;Hiragino Sans GB W3&amp;quot;, Roboto, Arial, sans-serif; font-size: 18px; white-space: normal;&quot;&gt;&lt;span style=&quot;box-sizing: border-box; color: rgb(255, 0, 0);&quot;&gt;&amp;lt;match url=&amp;quot;^(.*)$&amp;quot; /&amp;gt;&lt;/span&gt;&lt;/div&gt;&lt;div yne-bulb-block=&quot;paragraph&quot; style=&quot;box-sizing: border-box; color: rgb(34, 34, 34); font-family: &amp;quot;Segoe UI&amp;quot;, &amp;quot;Lucida Grande&amp;quot;, Helvetica, Arial, &amp;quot;Microsoft YaHei&amp;quot;, FreeSans, Arimo, &amp;quot;Droid Sans&amp;quot;, &amp;quot;wenquanyi micro hei&amp;quot;, &amp;quot;Hiragino Sans GB&amp;quot;, &amp;quot;Hiragino Sans GB W3&amp;quot;, Roboto, Arial, sans-serif; font-size: 18px; white-space: normal;&quot;&gt;&lt;span style=&quot;box-sizing: border-box; color: rgb(255, 0, 0);&quot;&gt;&amp;lt;conditions logicalGrouping=&amp;quot;MatchAll&amp;quot;&amp;gt;&lt;/span&gt;&lt;/div&gt;&lt;div yne-bulb-block=&quot;paragraph&quot; style=&quot;box-sizing: border-box; color: rgb(34, 34, 34); font-family: &amp;quot;Segoe UI&amp;quot;, &amp;quot;Lucida Grande&amp;quot;, Helvetica, Arial, &amp;quot;Microsoft YaHei&amp;quot;, FreeSans, Arimo, &amp;quot;Droid Sans&amp;quot;, &amp;quot;wenquanyi micro hei&amp;quot;, &amp;quot;Hiragino Sans GB&amp;quot;, &amp;quot;Hiragino Sans GB W3&amp;quot;, Roboto, Arial, sans-serif; font-size: 18px; white-space: normal;&quot;&gt;&lt;span style=&quot;box-sizing: border-box; color: rgb(255, 0, 0);&quot;&gt;&amp;lt;add input=&amp;quot;{HTTP_HOST}&amp;quot; pattern=&amp;quot;^(.*)$&amp;quot; /&amp;gt;&lt;/span&gt;&lt;/div&gt;&lt;div yne-bulb-block=&quot;paragraph&quot; style=&quot;box-sizing: border-box; color: rgb(34, 34, 34); font-family: &amp;quot;Segoe UI&amp;quot;, &amp;quot;Lucida Grande&amp;quot;, Helvetica, Arial, &amp;quot;Microsoft YaHei&amp;quot;, FreeSans, Arimo, &amp;quot;Droid Sans&amp;quot;, &amp;quot;wenquanyi micro hei&amp;quot;, &amp;quot;Hiragino Sans GB&amp;quot;, &amp;quot;Hiragino Sans GB W3&amp;quot;, Roboto, Arial, sans-serif; font-size: 18px; white-space: normal;&quot;&gt;&lt;span style=&quot;box-sizing: border-box; color: rgb(255, 0, 0);&quot;&gt;&amp;lt;add input=&amp;quot;{REQUEST_FILENAME}&amp;quot; matchType=&amp;quot;IsFile&amp;quot; negate=&amp;quot;true&amp;quot; /&amp;gt;&lt;/span&gt;&lt;/div&gt;&lt;div yne-bulb-block=&quot;paragraph&quot; style=&quot;box-sizing: border-box; color: rgb(34, 34, 34); font-family: &amp;quot;Segoe UI&amp;quot;, &amp;quot;Lucida Grande&amp;quot;, Helvetica, Arial, &amp;quot;Microsoft YaHei&amp;quot;, FreeSans, Arimo, &amp;quot;Droid Sans&amp;quot;, &amp;quot;wenquanyi micro hei&amp;quot;, &amp;quot;Hiragino Sans GB&amp;quot;, &amp;quot;Hiragino Sans GB W3&amp;quot;, Roboto, Arial, sans-serif; font-size: 18px; white-space: normal;&quot;&gt;&lt;span style=&quot;box-sizing: border-box; color: rgb(255, 0, 0);&quot;&gt;&amp;lt;add input=&amp;quot;{REQUEST_FILENAME}&amp;quot; matchType=&amp;quot;IsDirectory&amp;quot; negate=&amp;quot;true&amp;quot; /&amp;gt;&lt;/span&gt;&lt;/div&gt;&lt;div yne-bulb-block=&quot;paragraph&quot; style=&quot;box-sizing: border-box; color: rgb(34, 34, 34); font-family: &amp;quot;Segoe UI&amp;quot;, &amp;quot;Lucida Grande&amp;quot;, Helvetica, Arial, &amp;quot;Microsoft YaHei&amp;quot;, FreeSans, Arimo, &amp;quot;Droid Sans&amp;quot;, &amp;quot;wenquanyi micro hei&amp;quot;, &amp;quot;Hiragino Sans GB&amp;quot;, &amp;quot;Hiragino Sans GB W3&amp;quot;, Roboto, Arial, sans-serif; font-size: 18px; white-space: normal;&quot;&gt;&lt;span style=&quot;box-sizing: border-box; color: rgb(255, 0, 0);&quot;&gt;&amp;lt;/conditions&amp;gt;&lt;/span&gt;&lt;/div&gt;&lt;div yne-bulb-block=&quot;paragraph&quot; style=&quot;box-sizing: border-box; color: rgb(34, 34, 34); font-family: &amp;quot;Segoe UI&amp;quot;, &amp;quot;Lucida Grande&amp;quot;, Helvetica, Arial, &amp;quot;Microsoft YaHei&amp;quot;, FreeSans, Arimo, &amp;quot;Droid Sans&amp;quot;, &amp;quot;wenquanyi micro hei&amp;quot;, &amp;quot;Hiragino Sans GB&amp;quot;, &amp;quot;Hiragino Sans GB W3&amp;quot;, Roboto, Arial, sans-serif; font-size: 18px; white-space: normal;&quot;&gt;&lt;span style=&quot;box-sizing: border-box; color: rgb(255, 0, 0);&quot;&gt;&amp;lt;action type=&amp;quot;Rewrite&amp;quot; url=&amp;quot;index.php/{R:1}&amp;quot; /&amp;gt;&lt;/span&gt;&lt;/div&gt;&lt;div yne-bulb-block=&quot;paragraph&quot; style=&quot;box-sizing: border-box; color: rgb(34, 34, 34); font-family: &amp;quot;Segoe UI&amp;quot;, &amp;quot;Lucida Grande&amp;quot;, Helvetica, Arial, &amp;quot;Microsoft YaHei&amp;quot;, FreeSans, Arimo, &amp;quot;Droid Sans&amp;quot;, &amp;quot;wenquanyi micro hei&amp;quot;, &amp;quot;Hiragino Sans GB&amp;quot;, &amp;quot;Hiragino Sans GB W3&amp;quot;, Roboto, Arial, sans-serif; font-size: 18px; white-space: normal;&quot;&gt;&lt;span style=&quot;box-sizing: border-box; color: rgb(255, 0, 0);&quot;&gt;&amp;lt;/rule&amp;gt;&lt;/span&gt;&lt;/div&gt;&lt;div yne-bulb-block=&quot;paragraph&quot; style=&quot;box-sizing: border-box; color: rgb(34, 34, 34); font-family: &amp;quot;Segoe UI&amp;quot;, &amp;quot;Lucida Grande&amp;quot;, Helvetica, Arial, &amp;quot;Microsoft YaHei&amp;quot;, FreeSans, Arimo, &amp;quot;Droid Sans&amp;quot;, &amp;quot;wenquanyi micro hei&amp;quot;, &amp;quot;Hiragino Sans GB&amp;quot;, &amp;quot;Hiragino Sans GB W3&amp;quot;, Roboto, Arial, sans-serif; font-size: 18px; white-space: normal;&quot;&gt;&lt;span style=&quot;box-sizing: border-box; color: rgb(255, 0, 0);&quot;&gt;&amp;lt;/rules&amp;gt;&lt;/span&gt;&lt;/div&gt;&lt;div yne-bulb-block=&quot;paragraph&quot; style=&quot;box-sizing: border-box; color: rgb(34, 34, 34); font-family: &amp;quot;Segoe UI&amp;quot;, &amp;quot;Lucida Grande&amp;quot;, Helvetica, Arial, &amp;quot;Microsoft YaHei&amp;quot;, FreeSans, Arimo, &amp;quot;Droid Sans&amp;quot;, &amp;quot;wenquanyi micro hei&amp;quot;, &amp;quot;Hiragino Sans GB&amp;quot;, &amp;quot;Hiragino Sans GB W3&amp;quot;, Roboto, Arial, sans-serif; font-size: 18px; white-space: normal;&quot;&gt;&lt;span style=&quot;box-sizing: border-box; color: rgb(255, 0, 0);&quot;&gt;&amp;lt;/rewrite&amp;gt;&lt;/span&gt;&lt;/div&gt;&lt;div yne-bulb-block=&quot;paragraph&quot; style=&quot;box-sizing: border-box; color: rgb(34, 34, 34); font-family: &amp;quot;Segoe UI&amp;quot;, &amp;quot;Lucida Grande&amp;quot;, Helvetica, Arial, &amp;quot;Microsoft YaHei&amp;quot;, FreeSans, Arimo, &amp;quot;Droid Sans&amp;quot;, &amp;quot;wenquanyi micro hei&amp;quot;, &amp;quot;Hiragino Sans GB&amp;quot;, &amp;quot;Hiragino Sans GB W3&amp;quot;, Roboto, Arial, sans-serif; font-size: 18px; white-space: normal;&quot;&gt;&amp;lt;/system.webServer&amp;gt;&lt;/div&gt;&lt;div yne-bulb-block=&quot;paragraph&quot; style=&quot;box-sizing: border-box; color: rgb(34, 34, 34); font-family: &amp;quot;Segoe UI&amp;quot;, &amp;quot;Lucida Grande&amp;quot;, Helvetica, Arial, &amp;quot;Microsoft YaHei&amp;quot;, FreeSans, Arimo, &amp;quot;Droid Sans&amp;quot;, &amp;quot;wenquanyi micro hei&amp;quot;, &amp;quot;Hiragino Sans GB&amp;quot;, &amp;quot;Hiragino Sans GB W3&amp;quot;, Roboto, Arial, sans-serif; font-size: 18px; white-space: normal;&quot;&gt;&amp;lt;/configuration&amp;gt;&lt;/div&gt;&lt;div yne-bulb-block=&quot;paragraph&quot; style=&quot;box-sizing: border-box; color: rgb(34, 34, 34); font-family: &amp;quot;Segoe UI&amp;quot;, &amp;quot;Lucida Grande&amp;quot;, Helvetica, Arial, &amp;quot;Microsoft YaHei&amp;quot;, FreeSans, Arimo, &amp;quot;Droid Sans&amp;quot;, &amp;quot;wenquanyi micro hei&amp;quot;, &amp;quot;Hiragino Sans GB&amp;quot;, &amp;quot;Hiragino Sans GB W3&amp;quot;, Roboto, Arial, sans-serif; font-size: 18px; white-space: normal;&quot;&gt;&amp;nbsp;&lt;/div&gt;&lt;div yne-bulb-block=&quot;paragraph&quot; style=&quot;box-sizing: border-box; color: rgb(34, 34, 34); font-family: &amp;quot;Segoe UI&amp;quot;, &amp;quot;Lucida Grande&amp;quot;, Helvetica, Arial, &amp;quot;Microsoft YaHei&amp;quot;, FreeSans, Arimo, &amp;quot;Droid Sans&amp;quot;, &amp;quot;wenquanyi micro hei&amp;quot;, &amp;quot;Hiragino Sans GB&amp;quot;, &amp;quot;Hiragino Sans GB W3&amp;quot;, Roboto, Arial, sans-serif; font-size: 18px; white-space: normal;&quot;&gt;【Nginx服务器】&lt;/div&gt;&lt;div yne-bulb-block=&quot;paragraph&quot; style=&quot;box-sizing: border-box; color: rgb(34, 34, 34); font-family: &amp;quot;Segoe UI&amp;quot;, &amp;quot;Lucida Grande&amp;quot;, Helvetica, Arial, &amp;quot;Microsoft YaHei&amp;quot;, FreeSans, Arimo, &amp;quot;Droid Sans&amp;quot;, &amp;quot;wenquanyi micro hei&amp;quot;, &amp;quot;Hiragino Sans GB&amp;quot;, &amp;quot;Hiragino Sans GB W3&amp;quot;, Roboto, Arial, sans-serif; font-size: 18px; white-space: normal;&quot;&gt;在原有的nginx重写文件里新增以下代码片段：&lt;/div&gt;&lt;div yne-bulb-block=&quot;paragraph&quot; style=&quot;box-sizing: border-box; color: rgb(34, 34, 34); font-family: &amp;quot;Segoe UI&amp;quot;, &amp;quot;Lucida Grande&amp;quot;, Helvetica, Arial, &amp;quot;Microsoft YaHei&amp;quot;, FreeSans, Arimo, &amp;quot;Droid Sans&amp;quot;, &amp;quot;wenquanyi micro hei&amp;quot;, &amp;quot;Hiragino Sans GB&amp;quot;, &amp;quot;Hiragino Sans GB W3&amp;quot;, Roboto, Arial, sans-serif; font-size: 18px; white-space: normal;&quot;&gt;&lt;span style=&quot;box-sizing: border-box; color: rgb(255, 0, 0);&quot;&gt;location / {&lt;/span&gt;&lt;/div&gt;&lt;div yne-bulb-block=&quot;paragraph&quot; style=&quot;box-sizing: border-box; color: rgb(34, 34, 34); font-family: &amp;quot;Segoe UI&amp;quot;, &amp;quot;Lucida Grande&amp;quot;, Helvetica, Arial, &amp;quot;Microsoft YaHei&amp;quot;, FreeSans, Arimo, &amp;quot;Droid Sans&amp;quot;, &amp;quot;wenquanyi micro hei&amp;quot;, &amp;quot;Hiragino Sans GB&amp;quot;, &amp;quot;Hiragino Sans GB W3&amp;quot;, Roboto, Arial, sans-serif; font-size: 18px; white-space: normal;&quot;&gt;&lt;span style=&quot;box-sizing: border-box; color: rgb(255, 0, 0);&quot;&gt;if (!-e $request_filename) {&lt;/span&gt;&lt;/div&gt;&lt;div yne-bulb-block=&quot;paragraph&quot; style=&quot;box-sizing: border-box; color: rgb(34, 34, 34); font-family: &amp;quot;Segoe UI&amp;quot;, &amp;quot;Lucida Grande&amp;quot;, Helvetica, Arial, &amp;quot;Microsoft YaHei&amp;quot;, FreeSans, Arimo, &amp;quot;Droid Sans&amp;quot;, &amp;quot;wenquanyi micro hei&amp;quot;, &amp;quot;Hiragino Sans GB&amp;quot;, &amp;quot;Hiragino Sans GB W3&amp;quot;, Roboto, Arial, sans-serif; font-size: 18px; white-space: normal;&quot;&gt;&lt;span style=&quot;box-sizing: border-box; color: rgb(255, 0, 0);&quot;&gt;rewrite ^(.*)$ /index.php?s=/$1 last;&lt;/span&gt;&lt;/div&gt;&lt;div yne-bulb-block=&quot;paragraph&quot; style=&quot;box-sizing: border-box; color: rgb(34, 34, 34); font-family: &amp;quot;Segoe UI&amp;quot;, &amp;quot;Lucida Grande&amp;quot;, Helvetica, Arial, &amp;quot;Microsoft YaHei&amp;quot;, FreeSans, Arimo, &amp;quot;Droid Sans&amp;quot;, &amp;quot;wenquanyi micro hei&amp;quot;, &amp;quot;Hiragino Sans GB&amp;quot;, &amp;quot;Hiragino Sans GB W3&amp;quot;, Roboto, Arial, sans-serif; font-size: 18px; white-space: normal;&quot;&gt;&lt;span style=&quot;box-sizing: border-box; color: rgb(255, 0, 0);&quot;&gt;break;&lt;/span&gt;&lt;/div&gt;&lt;div yne-bulb-block=&quot;paragraph&quot; style=&quot;box-sizing: border-box; color: rgb(34, 34, 34); font-family: &amp;quot;Segoe UI&amp;quot;, &amp;quot;Lucida Grande&amp;quot;, Helvetica, Arial, &amp;quot;Microsoft YaHei&amp;quot;, FreeSans, Arimo, &amp;quot;Droid Sans&amp;quot;, &amp;quot;wenquanyi micro hei&amp;quot;, &amp;quot;Hiragino Sans GB&amp;quot;, &amp;quot;Hiragino Sans GB W3&amp;quot;, Roboto, Arial, sans-serif; font-size: 18px; white-space: normal;&quot;&gt;&lt;span style=&quot;box-sizing: border-box; color: rgb(255, 0, 0);&quot;&gt;}&lt;/span&gt;&lt;/div&gt;&lt;div yne-bulb-block=&quot;paragraph&quot; style=&quot;box-sizing: border-box; color: rgb(34, 34, 34); font-family: &amp;quot;Segoe UI&amp;quot;, &amp;quot;Lucida Grande&amp;quot;, Helvetica, Arial, &amp;quot;Microsoft YaHei&amp;quot;, FreeSans, Arimo, &amp;quot;Droid Sans&amp;quot;, &amp;quot;wenquanyi micro hei&amp;quot;, &amp;quot;Hiragino Sans GB&amp;quot;, &amp;quot;Hiragino Sans GB W3&amp;quot;, Roboto, Arial, sans-serif; font-size: 18px; white-space: normal;&quot;&gt;&lt;span style=&quot;box-sizing: border-box; color: rgb(255, 0, 0);&quot;&gt;}&lt;/span&gt;&lt;/div&gt;&lt;div yne-bulb-block=&quot;paragraph&quot; style=&quot;box-sizing: border-box; color: rgb(34, 34, 34); font-family: &amp;quot;Segoe UI&amp;quot;, &amp;quot;Lucida Grande&amp;quot;, Helvetica, Arial, &amp;quot;Microsoft YaHei&amp;quot;, FreeSans, Arimo, &amp;quot;Droid Sans&amp;quot;, &amp;quot;wenquanyi micro hei&amp;quot;, &amp;quot;Hiragino Sans GB&amp;quot;, &amp;quot;Hiragino Sans GB W3&amp;quot;, Roboto, Arial, sans-serif; font-size: 18px; white-space: normal;&quot;&gt;&amp;nbsp;&lt;/div&gt;&lt;div yne-bulb-block=&quot;paragraph&quot; style=&quot;box-sizing: border-box; color: rgb(34, 34, 34); font-family: &amp;quot;Segoe UI&amp;quot;, &amp;quot;Lucida Grande&amp;quot;, Helvetica, Arial, &amp;quot;Microsoft YaHei&amp;quot;, FreeSans, Arimo, &amp;quot;Droid Sans&amp;quot;, &amp;quot;wenquanyi micro hei&amp;quot;, &amp;quot;Hiragino Sans GB&amp;quot;, &amp;quot;Hiragino Sans GB W3&amp;quot;, Roboto, Arial, sans-serif; font-size: 18px; white-space: normal;&quot;&gt;【apache服务器】&lt;br style=&quot;box-sizing: border-box;&quot;/&gt;易优CMS在apache服务器环境默认自动隐藏index.php入口。&lt;br style=&quot;box-sizing: border-box;&quot;/&gt;如果发现没隐藏，可以检查根目录.htaccess是否含有以下代码段：&lt;/div&gt;&lt;div yne-bulb-block=&quot;paragraph&quot; style=&quot;box-sizing: border-box; color: rgb(34, 34, 34); font-family: &amp;quot;Segoe UI&amp;quot;, &amp;quot;Lucida Grande&amp;quot;, Helvetica, Arial, &amp;quot;Microsoft YaHei&amp;quot;, FreeSans, Arimo, &amp;quot;Droid Sans&amp;quot;, &amp;quot;wenquanyi micro hei&amp;quot;, &amp;quot;Hiragino Sans GB&amp;quot;, &amp;quot;Hiragino Sans GB W3&amp;quot;, Roboto, Arial, sans-serif; font-size: 18px; white-space: normal;&quot;&gt;&amp;lt;IfModule mod_rewrite.c&amp;gt;&lt;/div&gt;&lt;div yne-bulb-block=&quot;paragraph&quot; style=&quot;box-sizing: border-box; color: rgb(34, 34, 34); font-family: &amp;quot;Segoe UI&amp;quot;, &amp;quot;Lucida Grande&amp;quot;, Helvetica, Arial, &amp;quot;Microsoft YaHei&amp;quot;, FreeSans, Arimo, &amp;quot;Droid Sans&amp;quot;, &amp;quot;wenquanyi micro hei&amp;quot;, &amp;quot;Hiragino Sans GB&amp;quot;, &amp;quot;Hiragino Sans GB W3&amp;quot;, Roboto, Arial, sans-serif; font-size: 18px; white-space: normal;&quot;&gt;&lt;div style=&quot;box-sizing: border-box;&quot;&gt;Options +FollowSymlinks -Multiviews&lt;/div&gt;&lt;div style=&quot;box-sizing: border-box;&quot;&gt;&lt;span style=&quot;box-sizing: border-box; color: rgb(255, 0, 0);&quot;&gt;RewriteEngine on&lt;/span&gt;&lt;/div&gt;&lt;div style=&quot;box-sizing: border-box;&quot;&gt;&lt;span style=&quot;box-sizing: border-box; color: rgb(255, 0, 0);&quot;&gt;RewriteCond %{REQUEST_FILENAME} !-d&lt;/span&gt;&lt;/div&gt;&lt;div style=&quot;box-sizing: border-box;&quot;&gt;&lt;span style=&quot;box-sizing: border-box; color: rgb(255, 0, 0);&quot;&gt;RewriteCond %{REQUEST_FILENAME} !-f&lt;/span&gt;&lt;/div&gt;&lt;div style=&quot;box-sizing: border-box;&quot;&gt;&lt;span style=&quot;box-sizing: border-box; color: rgb(255, 0, 0);&quot;&gt;RewriteRule ^(.*)$ index.php/$1 [QSA,PT,L]&lt;/span&gt;&lt;/div&gt;&lt;/div&gt;&lt;div yne-bulb-block=&quot;paragraph&quot; style=&quot;box-sizing: border-box; color: rgb(34, 34, 34); font-family: &amp;quot;Segoe UI&amp;quot;, &amp;quot;Lucida Grande&amp;quot;, Helvetica, Arial, &amp;quot;Microsoft YaHei&amp;quot;, FreeSans, Arimo, &amp;quot;Droid Sans&amp;quot;, &amp;quot;wenquanyi micro hei&amp;quot;, &amp;quot;Hiragino Sans GB&amp;quot;, &amp;quot;Hiragino Sans GB W3&amp;quot;, Roboto, Arial, sans-serif; font-size: 18px; white-space: normal;&quot;&gt;&amp;lt;/IfModule&amp;gt;&lt;br style=&quot;box-sizing: border-box;&quot;/&gt;&lt;br style=&quot;box-sizing: border-box;&quot;/&gt;如果存在，继续查看apache是否开启了URL重写模块 rewrite_module ， 然后重启服务就行了。&lt;/div&gt;&lt;p&gt;&lt;br/&gt;&lt;/p&gt;', '0', '1531710225');

-- ----------------------------
-- Table structure for ey_tagindex
-- ----------------------------
DROP TABLE IF EXISTS `ey_tagindex`;
CREATE TABLE `ey_tagindex` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'tagid',
  `tag` varchar(50) NOT NULL DEFAULT '' COMMENT 'tag内容',
  `typeid` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT '栏目ID',
  `count` int(10) unsigned DEFAULT '0' COMMENT '点击',
  `total` int(10) unsigned DEFAULT '0' COMMENT '文档数',
  `weekcc` int(10) unsigned DEFAULT '0' COMMENT '周统计',
  `monthcc` int(10) unsigned DEFAULT '0' COMMENT '月统计',
  `weekup` int(10) unsigned DEFAULT '0' COMMENT '每周更新',
  `monthup` int(10) unsigned DEFAULT '0' COMMENT '每月更新',
  `lang` varchar(50) DEFAULT 'cn' COMMENT '语言标识',
  `add_time` int(10) unsigned DEFAULT '0' COMMENT '添加时间',
  PRIMARY KEY (`id`),
  KEY `typeid` (`typeid`) USING BTREE,
  KEY `count` (`count`,`total`,`weekcc`,`monthcc`,`weekup`,`monthup`,`add_time`) USING BTREE,
  KEY `tag` (`tag`) USING BTREE
) ENGINE=MyISAM AUTO_INCREMENT=38 DEFAULT CHARSET=utf8 COMMENT='标签索引表';

-- ----------------------------
-- Records of ey_tagindex
-- ----------------------------
INSERT INTO `ey_tagindex` VALUES ('24', 'TAG标签', '10', '0', '0', '0', '0', '0', '0', 'cn', '1526544706');
INSERT INTO `ey_tagindex` VALUES ('25', '对的', '10', '0', '0', '0', '0', '0', '0', 'cn', '1526544706');
INSERT INTO `ey_tagindex` VALUES ('26', '替换稿件', '10', '0', '0', '0', '0', '0', '0', 'cn', '1526544706');
INSERT INTO `ey_tagindex` VALUES ('27', '杨靖宇', '10', '0', '0', '0', '0', '0', '0', 'cn', '1526544706');
INSERT INTO `ey_tagindex` VALUES ('28', '网站', '12', '0', '0', '0', '0', '0', '0', 'cn', '1526608291');
INSERT INTO `ey_tagindex` VALUES ('29', '建设', '12', '0', '0', '0', '0', '0', '0', 'cn', '1526608291');
INSERT INTO `ey_tagindex` VALUES ('30', '五大核心', '12', '0', '0', '0', '0', '0', '0', 'cn', '1526608291');
INSERT INTO `ey_tagindex` VALUES ('31', '要素', '12', '0', '0', '0', '0', '0', '0', 'cn', '1526608291');
INSERT INTO `ey_tagindex` VALUES ('32', '华为', '24', '0', '0', '0', '0', '0', '0', 'cn', '1526613161');
INSERT INTO `ey_tagindex` VALUES ('33', 'HUAWEI', '24', '0', '0', '0', '0', '0', '0', 'cn', '1526613161');
INSERT INTO `ey_tagindex` VALUES ('34', 'NOTE 8', '24', '0', '0', '0', '0', '0', '0', 'cn', '1526613161');
INSERT INTO `ey_tagindex` VALUES ('35', '宅男', '5', '0', '0', '0', '0', '0', '0', 'cn', '1526614158');
INSERT INTO `ey_tagindex` VALUES ('36', '女神', '5', '0', '0', '0', '0', '0', '0', 'cn', '1526614158');
INSERT INTO `ey_tagindex` VALUES ('37', '一号', '5', '0', '0', '0', '0', '0', '0', 'cn', '1526614158');

-- ----------------------------
-- Table structure for ey_taglist
-- ----------------------------
DROP TABLE IF EXISTS `ey_taglist`;
CREATE TABLE `ey_taglist` (
  `tid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'tagid',
  `aid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '文档ID',
  `typeid` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT '栏目ID',
  `tag` varchar(50) DEFAULT '' COMMENT 'tag内容',
  `arcrank` tinyint(1) DEFAULT '0' COMMENT '阅读权限',
  `lang` varchar(50) DEFAULT 'cn' COMMENT '语言标识',
  `add_time` int(11) DEFAULT '0' COMMENT '新增时间',
  `update_time` int(11) DEFAULT '0' COMMENT '更新时间',
  PRIMARY KEY (`tid`,`aid`),
  KEY `aid` (`aid`,`typeid`) USING BTREE
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='文章标签表';

-- ----------------------------
-- Records of ey_taglist
-- ----------------------------
INSERT INTO `ey_taglist` VALUES ('28', '13', '12', '网站', '0', 'cn', '1531709955', '0');
INSERT INTO `ey_taglist` VALUES ('29', '13', '12', '建设', '0', 'cn', '1531709955', '0');
INSERT INTO `ey_taglist` VALUES ('30', '13', '12', '五大核心', '0', 'cn', '1531709955', '0');
INSERT INTO `ey_taglist` VALUES ('32', '27', '24', '华为', '0', 'cn', '1531727097', '0');
INSERT INTO `ey_taglist` VALUES ('33', '27', '24', 'HUAWEI', '0', 'cn', '1531727097', '0');
INSERT INTO `ey_taglist` VALUES ('34', '27', '24', 'NOTE 8', '0', 'cn', '1531727097', '0');
INSERT INTO `ey_taglist` VALUES ('37', '30', '5', '一号', '0', 'cn', '1531888268', '0');
INSERT INTO `ey_taglist` VALUES ('36', '30', '5', '女神', '0', 'cn', '1531888268', '0');
INSERT INTO `ey_taglist` VALUES ('35', '30', '5', '宅男', '0', 'cn', '1531888268', '0');
INSERT INTO `ey_taglist` VALUES ('31', '13', '12', '要素', '0', 'cn', '1531709955', '0');

-- ----------------------------
-- Table structure for ey_ui_config
-- ----------------------------
DROP TABLE IF EXISTS `ey_ui_config`;
CREATE TABLE `ey_ui_config` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '表id',
  `md5key` varchar(100) NOT NULL DEFAULT '' COMMENT '唯一键值（由 theme_style、page、name）组成',
  `theme_style` varchar(20) DEFAULT 'pc' COMMENT '模板风格',
  `page` varchar(64) DEFAULT '' COMMENT '页面分组',
  `type` varchar(50) DEFAULT '' COMMENT '编辑类型',
  `name` varchar(50) DEFAULT '' COMMENT '与页面的e-id对应',
  `value` text COMMENT '页面美化的val值',
  `lang` varchar(50) DEFAULT 'cn' COMMENT '语言标识',
  `add_time` int(11) DEFAULT '0' COMMENT '新增时间',
  `update_time` int(11) DEFAULT '0' COMMENT '更新时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `md5key` (`md5key`) USING BTREE
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='可视化参数设置';

-- ----------------------------
-- Records of ey_ui_config
-- ----------------------------

-- ----------------------------
-- Table structure for ey_weapp
-- ----------------------------
DROP TABLE IF EXISTS `ey_weapp`;
CREATE TABLE `ey_weapp` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `code` varchar(50) DEFAULT '' COMMENT '插件标识',
  `name` varchar(55) DEFAULT '' COMMENT '中文名字',
  `config` text COMMENT '配置信息',
  `data` text COMMENT '额外序列化存储数据，简单插件可以不创建表，存储这里即可',
  `status` tinyint(1) DEFAULT '0' COMMENT '状态：0=未安装，1=启用，-1=禁用',
  `tag_weapp` tinyint(1) DEFAULT '1' COMMENT '1=自动绑定，2=手工调用。关联模板标签weapp，自动调用内置的show钩子方法',
  `thorough` tinyint(1) DEFAULT '0' COMMENT '彻底卸载：0=是，1=否',
  `add_time` int(11) DEFAULT '0' COMMENT '新增时间',
  `update_time` int(11) DEFAULT '0' COMMENT '更新时间',
  PRIMARY KEY (`id`),
  KEY `code` (`code`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='插件应用表';

-- ----------------------------
-- Records of ey_weapp
-- ----------------------------
