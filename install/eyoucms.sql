-- ----------------------------------------
-- EyouCms MySQL Data Transfer 
-- 
-- Server         : 127.0.0.1_3306
-- Server Version : 5.5.53
-- Host           : 127.0.0.1:3306
-- Database       : e6
-- 
-- Part : #1
-- Version : #v1.2.6
-- Date : 2019-01-14 21:45:07
-- -----------------------------------------

SET FOREIGN_KEY_CHECKS = 0;


-- -----------------------------
-- Table structure for `ey_ad`
-- -----------------------------
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

-- -----------------------------
-- Records of `ey_ad`
-- -----------------------------
INSERT INTO `ey_ad` VALUES ('1', '1', '1', '共展蓝图', 'http://www.eyoucms.com', '/uploads/allimg/20190114/120a22b23302608afa29126f281f610a.jpg', '1524215594', '0', '&lt;p&gt;填写广告的备注信息，方便于后期的跟进&lt;/p&gt;', '', '', '', '0', '', '1', '100', '0', '0', 'cn', '1524215652', '1547460894');
INSERT INTO `ey_ad` VALUES ('2', '1', '1', '易优模板库', 'http://www.eyoucms.com', '/uploads/allimg/20190114/97574b57b85d37b6b2cb5734c8f305c3.jpg', '0', '0', '&lt;p&gt;填写广告的备注信息，方便于后期的跟进&lt;/p&gt;', '', '', '', '0', '', '1', '100', '0', '0', 'cn', '1524214017', '1547460879');
INSERT INTO `ey_ad` VALUES ('3', '2', '1', 'en共展蓝图', 'http://www.eyoucms.com', '/uploads/allimg/20190114/120a22b23302608afa29126f281f610a.jpg', '1524215594', '0', '&lt;p&gt;填写广告的备注信息，方便于后期的跟进&lt;/p&gt;', '', '', '', '0', '', '1', '100', '0', '0', 'en', '1524215652', '1527824535');
INSERT INTO `ey_ad` VALUES ('4', '2', '1', 'en易优模板库', 'http://www.eyoucms.com', '/uploads/allimg/20190114/97574b57b85d37b6b2cb5734c8f305c3.jpg', '0', '0', '&lt;p&gt;填写广告的备注信息，方便于后期的跟进&lt;/p&gt;', '', '', '', '0', '', '1', '100', '0', '0', 'en', '1524214017', '1531724625');

-- -----------------------------
-- Table structure for `ey_ad_position`
-- -----------------------------
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
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COMMENT='广告位置表';

-- -----------------------------
-- Records of `ey_ad_position`
-- -----------------------------
INSERT INTO `ey_ad_position` VALUES ('1', '首页-大幻灯片', '1920', '550', '广告图片的宽高度随着浏览器大小而改变', '1', 'cn', '0', '1524209276', '1524209365');
INSERT INTO `ey_ad_position` VALUES ('2', 'en首页-大幻灯片', '1920', '550', '广告图片的宽高度随着浏览器大小而改变', '1', 'en', '0', '1524209276', '1524209365');

-- -----------------------------
-- Table structure for `ey_admin`
-- -----------------------------
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

-- -----------------------------
-- Records of `ey_admin`
-- -----------------------------
INSERT INTO `ey_admin` VALUES ('1', 'admin', '', 'admin', '', '', '7959ec68e999edd0380ff0809f76fa42', '1547473292', '127.0.0.1', '2', '8rukejsuhfd5jmvv4b1n0usn55', '0', '-1', 'cn', '1', '1547473274', '1547473464');

-- -----------------------------
-- Table structure for `ey_admin_log`
-- -----------------------------
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
) ENGINE=MyISAM AUTO_INCREMENT=257 DEFAULT CHARSET=utf8 COMMENT='管理员操作日志表';

-- -----------------------------
-- Records of `ey_admin_log`
-- -----------------------------
INSERT INTO `ey_admin_log` VALUES ('118', '1', '后台登录', '127.0.0.1', '/login.php', '1540962138');
INSERT INTO `ey_admin_log` VALUES ('119', '1', '安全退出', '127.0.0.1', '/login.php', '1540968879');
INSERT INTO `ey_admin_log` VALUES ('120', '1', '后台登录', '127.0.0.1', '/login.php', '1540968885');
INSERT INTO `ey_admin_log` VALUES ('121', '1', '安全退出', '127.0.0.1', '/login.php', '1540970909');
INSERT INTO `ey_admin_log` VALUES ('122', '1', '后台登录', '127.0.0.1', '/login.php', '1540970915');
INSERT INTO `ey_admin_log` VALUES ('123', '1', '后台登录', '127.0.0.1', '/login.php', '1545267359');
INSERT INTO `ey_admin_log` VALUES ('124', '1', '新增多语言：English', '127.0.0.1', '/login.php', '1545267532');
INSERT INTO `ey_admin_log` VALUES ('125', '1', '编辑留言表单：Name', '127.0.0.1', '/login.php', '1545267932');
INSERT INTO `ey_admin_log` VALUES ('126', '1', '编辑留言表单：Tel', '127.0.0.1', '/login.php', '1545267998');
INSERT INTO `ey_admin_log` VALUES ('127', '1', '编辑留言表单：Remarks', '127.0.0.1', '/login.php', '1545268014');
INSERT INTO `ey_admin_log` VALUES ('128', '1', '编辑留言表单：Pattern', '127.0.0.1', '/login.php', '1545268028');
INSERT INTO `ey_admin_log` VALUES ('129', '1', '编辑栏目：Entry entry', '127.0.0.1', '/login.php', '1545268049');
INSERT INTO `ey_admin_log` VALUES ('130', '1', '新增下载：工程机械推土挖掘机类网站模板', '127.0.0.1', '/login.php', '1545268125');
INSERT INTO `ey_admin_log` VALUES ('131', '1', '编辑下载：工程机械推土挖掘机类网站模板', '127.0.0.1', '/login.php', '1545268147');
INSERT INTO `ey_admin_log` VALUES ('132', '1', '新增下载：Website Template of Vocational Education and Training Institutions', '127.0.0.1', '/login.php', '1545268233');
INSERT INTO `ey_admin_log` VALUES ('133', '1', '编辑下载：Construction machinery bulldozer website template', '127.0.0.1', '/login.php', '1545268293');
INSERT INTO `ey_admin_log` VALUES ('134', '1', '编辑下载：Website Template of Vocational Education and Training Institutions', '127.0.0.1', '/login.php', '1545268305');
INSERT INTO `ey_admin_log` VALUES ('135', '1', '编辑栏目：Data download', '127.0.0.1', '/login.php', '1545268321');
INSERT INTO `ey_admin_log` VALUES ('136', '1', '新增图集：Customer Case I', '127.0.0.1', '/login.php', '1545268371');
INSERT INTO `ey_admin_log` VALUES ('137', '1', '编辑图集：Customer Case I', '127.0.0.1', '/login.php', '1545268402');
INSERT INTO `ey_admin_log` VALUES ('138', '1', '编辑图集：Customer Case I', '127.0.0.1', '/login.php', '1545268427');
INSERT INTO `ey_admin_log` VALUES ('139', '1', '编辑图集：Customer Case I', '127.0.0.1', '/login.php', '1545268466');
INSERT INTO `ey_admin_log` VALUES ('140', '1', '新增图集：Customer Case II', '127.0.0.1', '/login.php', '1545268514');
INSERT INTO `ey_admin_log` VALUES ('141', '1', '新增图集：Customer Case III', '127.0.0.1', '/login.php', '1545268563');
INSERT INTO `ey_admin_log` VALUES ('142', '1', '编辑栏目：Case', '127.0.0.1', '/login.php', '1545268599');
INSERT INTO `ey_admin_log` VALUES ('143', '1', '新增产品：Millet Bluetooth Necklace Headset', '127.0.0.1', '/login.php', '1545268778');
INSERT INTO `ey_admin_log` VALUES ('144', '1', '编辑产品参数：Model', '127.0.0.1', '/login.php', '1545268934');
INSERT INTO `ey_admin_log` VALUES ('145', '1', '编辑产品参数：Support Bluetooth', '127.0.0.1', '/login.php', '1545268951');
INSERT INTO `ey_admin_log` VALUES ('146', '1', '移动文档-id：Array', '127.0.0.1', '/login.php', '1545268967');
INSERT INTO `ey_admin_log` VALUES ('147', '1', '编辑产品：Millet Bluetooth Necklace Headset', '127.0.0.1', '/login.php', '1545268991');
INSERT INTO `ey_admin_log` VALUES ('148', '1', '编辑栏目：Portable battery', '127.0.0.1', '/login.php', '1545269115');
INSERT INTO `ey_admin_log` VALUES ('149', '1', '编辑栏目：Loudspeaker box', '127.0.0.1', '/login.php', '1545269134');
INSERT INTO `ey_admin_log` VALUES ('150', '1', '编辑栏目：Headset', '127.0.0.1', '/login.php', '1545269149');
INSERT INTO `ey_admin_log` VALUES ('151', '1', '编辑栏目：General accessories', '127.0.0.1', '/login.php', '1545269166');
INSERT INTO `ey_admin_log` VALUES ('152', '1', '编辑产品：Millet Bluetooth Necklace Headset', '127.0.0.1', '/login.php', '1545269236');
INSERT INTO `ey_admin_log` VALUES ('153', '1', '编辑产品：Millet Bluetooth Necklace Headset', '127.0.0.1', '/login.php', '1545269540');
INSERT INTO `ey_admin_log` VALUES ('154', '1', '编辑产品：Millet Bluetooth Necklace Headset', '127.0.0.1', '/login.php', '1545269805');
INSERT INTO `ey_admin_log` VALUES ('155', '1', '编辑产品：Millet Bluetooth Necklace Headset', '127.0.0.1', '/login.php', '1545270012');
INSERT INTO `ey_admin_log` VALUES ('156', '1', '新增产品：Millet notebook Air 13.3', '127.0.0.1', '/login.php', '1545270139');
INSERT INTO `ey_admin_log` VALUES ('157', '1', '编辑产品参数：Screen size', '127.0.0.1', '/login.php', '1545270158');
INSERT INTO `ey_admin_log` VALUES ('158', '1', '编辑产品参数：Weight', '127.0.0.1', '/login.php', '1545270171');
INSERT INTO `ey_admin_log` VALUES ('159', '1', '编辑栏目：Notebook computer', '127.0.0.1', '/login.php', '1545270191');
INSERT INTO `ey_admin_log` VALUES ('160', '1', '编辑栏目：Computer', '127.0.0.1', '/login.php', '1545270214');
INSERT INTO `ey_admin_log` VALUES ('161', '1', '新增产品：HUAWEI NOTE 8', '127.0.0.1', '/login.php', '1545270361');
INSERT INTO `ey_admin_log` VALUES ('162', '1', '新增产品：Apple iPhone 6s 16GB  Rose Gold Mobile Unicom 4G Mobile Phone', '127.0.0.1', '/login.php', '1545270634');
INSERT INTO `ey_admin_log` VALUES ('163', '1', '编辑产品：Apple iPhone 6s 16GB ', '127.0.0.1', '/login.php', '1545270643');
INSERT INTO `ey_admin_log` VALUES ('164', '1', '编辑栏目：Play your mobile phone', '127.0.0.1', '/login.php', '1545270668');
INSERT INTO `ey_admin_log` VALUES ('165', '1', '编辑栏目：Smartphone', '127.0.0.1', '/login.php', '1545270702');
INSERT INTO `ey_admin_log` VALUES ('166', '1', '编辑栏目：Phone', '127.0.0.1', '/login.php', '1545270715');
INSERT INTO `ey_admin_log` VALUES ('167', '1', '编辑栏目： Product', '127.0.0.1', '/login.php', '1545270730');
INSERT INTO `ey_admin_log` VALUES ('168', '1', '新增图集：Atlas under News Model', '127.0.0.1', '/login.php', '1545270783');
INSERT INTO `ey_admin_log` VALUES ('169', '1', '新增图集：Atlas II under News Model', '127.0.0.1', '/login.php', '1545270816');
INSERT INTO `ey_admin_log` VALUES ('170', '1', '编辑栏目：Landscape Atlas', '127.0.0.1', '/login.php', '1545270830');
INSERT INTO `ey_admin_log` VALUES ('171', '1', '编辑栏目：en单页面', '127.0.0.1', '/login.php', '1545270865');
INSERT INTO `ey_admin_log` VALUES ('172', '1', '编辑栏目：Single page', '127.0.0.1', '/login.php', '1545270877');
INSERT INTO `ey_admin_log` VALUES ('173', '1', '新增文章：Five Core Elements of Website Construction', '127.0.0.1', '/login.php', '1545270962');
INSERT INTO `ey_admin_log` VALUES ('174', '1', '新增文章：Experience the Core Value of Enterprise Website Perfectly from Three Aspects', '127.0.0.1', '/login.php', '1545271034');
INSERT INTO `ey_admin_log` VALUES ('175', '1', '新增文章：Looking back on the 40-year history of beverages in China, there is always a taste of your childhood', '127.0.0.1', '/login.php', '1545271068');
INSERT INTO `ey_admin_log` VALUES ('176', '1', '新增文章：How to value fans in the age of social media?', '127.0.0.1', '/login.php', '1545271106');
INSERT INTO `ey_admin_log` VALUES ('177', '1', '新增文章：&quot;Subversive Marketing: Business Revolution in the Big Data Age&quot;: Big Data &quot;More Is Less, Less Is Mor', '127.0.0.1', '/login.php', '1545271237');
INSERT INTO `ey_admin_log` VALUES ('178', '1', '编辑栏目：Enterprise operation', '127.0.0.1', '/login.php', '1545271263');
INSERT INTO `ey_admin_log` VALUES ('179', '1', '新增文章：What is seo?', '127.0.0.1', '/login.php', '1545271307');
INSERT INTO `ey_admin_log` VALUES ('180', '1', '新增文章：How did CMS come into being?', '127.0.0.1', '/login.php', '1545272018');
INSERT INTO `ey_admin_log` VALUES ('181', '1', '新增文章：The relationship between website design and SEO, the master is analyzed from these four dimensions!', '127.0.0.1', '/login.php', '1545272054');
INSERT INTO `ey_admin_log` VALUES ('182', '1', '新增文章：Shangmeng.com: Single-page SEO station group technology, with 10 websites to optimize the ranking!', '127.0.0.1', '/login.php', '1545272097');
INSERT INTO `ey_admin_log` VALUES ('183', '1', '编辑栏目：SEO optimization', '127.0.0.1', '/login.php', '1545272114');
INSERT INTO `ey_admin_log` VALUES ('184', '1', '编辑栏目：Media coverage', '127.0.0.1', '/login.php', '1545272127');
INSERT INTO `ey_admin_log` VALUES ('185', '1', '新增文章：Differences in user interface design and experience design', '127.0.0.1', '/login.php', '1545272159');
INSERT INTO `ey_admin_log` VALUES ('186', '1', '新增文章：Novice science! What is the user interface and experience design?', '127.0.0.1', '/login.php', '1545272218');
INSERT INTO `ey_admin_log` VALUES ('187', '1', '新增文章：Read the Internet Queen and her report: Investment in the Internet, Bible, stock selection guide', '127.0.0.1', '/login.php', '1545272280');
INSERT INTO `ey_admin_log` VALUES ('188', '1', '新增文章：Website construction, static pages and dynamic pages how to choose', '127.0.0.1', '/login.php', '1545272334');
INSERT INTO `ey_admin_log` VALUES ('189', '1', '编辑栏目：News', '127.0.0.1', '/login.php', '1545272354');
INSERT INTO `ey_admin_log` VALUES ('190', '1', '编辑留言表单：Name', '127.0.0.1', '/login.php', '1545272376');
INSERT INTO `ey_admin_log` VALUES ('191', '1', '编辑留言表单：Telephone', '127.0.0.1', '/login.php', '1545272410');
INSERT INTO `ey_admin_log` VALUES ('192', '1', '编辑留言表单：Object of negotiation', '127.0.0.1', '/login.php', '1545272446');
INSERT INTO `ey_admin_log` VALUES ('193', '1', '编辑留言表单：Pattern', '127.0.0.1', '/login.php', '1545272477');
INSERT INTO `ey_admin_log` VALUES ('194', '1', '编辑栏目：Appointment interview', '127.0.0.1', '/login.php', '1545272506');
INSERT INTO `ey_admin_log` VALUES ('195', '1', '编辑栏目：en公司简介', '127.0.0.1', '/login.php', '1545272535');
INSERT INTO `ey_admin_log` VALUES ('196', '1', '编辑栏目：Honor', '127.0.0.1', '/login.php', '1545272547');
INSERT INTO `ey_admin_log` VALUES ('197', '1', '编辑栏目：Company Profile', '127.0.0.1', '/login.php', '1545272565');
INSERT INTO `ey_admin_log` VALUES ('198', '1', '编辑栏目：About Us', '127.0.0.1', '/login.php', '1545272580');
INSERT INTO `ey_admin_log` VALUES ('199', '1', '编辑友情链接：百度', '127.0.0.1', '/login.php', '1545272660');
INSERT INTO `ey_admin_log` VALUES ('200', '1', '编辑友情链接：腾讯', '127.0.0.1', '/login.php', '1545272665');
INSERT INTO `ey_admin_log` VALUES ('201', '1', '编辑友情链接：新浪', '127.0.0.1', '/login.php', '1545272669');
INSERT INTO `ey_admin_log` VALUES ('202', '1', '编辑友情链接：小程序开发教程', '127.0.0.1', '/login.php', '1545272673');
INSERT INTO `ey_admin_log` VALUES ('203', '1', '编辑友情链接：素材58', '127.0.0.1', '/login.php', '1545272677');
INSERT INTO `ey_admin_log` VALUES ('204', '1', '新增模板语言变量：yybl1', '127.0.0.1', '/login.php', '1545272835');
INSERT INTO `ey_admin_log` VALUES ('205', '1', '新增模板语言变量：yybl2', '127.0.0.1', '/login.php', '1545272897');
INSERT INTO `ey_admin_log` VALUES ('206', '1', '新增模板语言变量：yybl3', '127.0.0.1', '/login.php', '1545272961');
INSERT INTO `ey_admin_log` VALUES ('207', '1', '新增模板语言变量：yybl4', '127.0.0.1', '/login.php', '1545273023');
INSERT INTO `ey_admin_log` VALUES ('208', '1', '新增模板语言变量：yybl5', '127.0.0.1', '/login.php', '1545273158');
INSERT INTO `ey_admin_log` VALUES ('209', '1', '新增模板语言变量：yybl6', '127.0.0.1', '/login.php', '1545273239');
INSERT INTO `ey_admin_log` VALUES ('210', '1', '新增模板语言变量：yybl7', '127.0.0.1', '/login.php', '1545273292');
INSERT INTO `ey_admin_log` VALUES ('211', '1', '新增模板语言变量：yybl8', '127.0.0.1', '/login.php', '1545273376');
INSERT INTO `ey_admin_log` VALUES ('212', '1', '新增模板语言变量：yybl9', '127.0.0.1', '/login.php', '1545273418');
INSERT INTO `ey_admin_log` VALUES ('213', '1', '编辑下载：Construction machinery bulldozer website template', '127.0.0.1', '/login.php', '1545273531');
INSERT INTO `ey_admin_log` VALUES ('214', '1', '新增模板语言变量：yybl10', '127.0.0.1', '/login.php', '1545273596');
INSERT INTO `ey_admin_log` VALUES ('215', '1', '新增模板语言变量：yybl11', '127.0.0.1', '/login.php', '1545273655');
INSERT INTO `ey_admin_log` VALUES ('216', '1', '编辑产品参数：operating system', '127.0.0.1', '/login.php', '1545273990');
INSERT INTO `ey_admin_log` VALUES ('217', '1', '编辑产品参数：User Interface', '127.0.0.1', '/login.php', '1545274001');
INSERT INTO `ey_admin_log` VALUES ('218', '1', '编辑产品参数：Keyboard type', '127.0.0.1', '/login.php', '1545274014');
INSERT INTO `ey_admin_log` VALUES ('219', '1', '编辑产品参数：model', '127.0.0.1', '/login.php', '1545274025');
INSERT INTO `ey_admin_log` VALUES ('220', '1', '新增模板语言变量：yybl12', '127.0.0.1', '/login.php', '1545274437');
INSERT INTO `ey_admin_log` VALUES ('221', '1', '新增模板语言变量：yybl13', '127.0.0.1', '/login.php', '1545274472');
INSERT INTO `ey_admin_log` VALUES ('222', '1', '后台登录', '127.0.0.1', '/login.php', '1545354383');
INSERT INTO `ey_admin_log` VALUES ('223', '1', '后台登录', '127.0.0.1', '/login.php', '1545357676');
INSERT INTO `ey_admin_log` VALUES ('224', '1', '后台登录', '127.0.0.1', '/login.php', '1546477007');
INSERT INTO `ey_admin_log` VALUES ('225', '1', '安全退出', '127.0.0.1', '/login.php', '1546477294');
INSERT INTO `ey_admin_log` VALUES ('226', '1', '后台登录', '127.0.0.1', '/login.php', '1546477299');
INSERT INTO `ey_admin_log` VALUES ('227', '1', '编辑模板语言变量：yybl13', '127.0.0.1', '/login.php', '1546477350');
INSERT INTO `ey_admin_log` VALUES ('228', '1', '后台登录', '127.0.0.1', '/login.php', '1547460414');
INSERT INTO `ey_admin_log` VALUES ('229', '1', '编辑广告', '127.0.0.1', '/login.php', '1547460879');
INSERT INTO `ey_admin_log` VALUES ('230', '1', '编辑广告', '127.0.0.1', '/login.php', '1547460894');
INSERT INTO `ey_admin_log` VALUES ('231', '1', '编辑产品：Apple iPhone 6s 16GB 玫瑰金色 移动联通电信4G手机', '127.0.0.1', '/login.php', '1547461970');
INSERT INTO `ey_admin_log` VALUES ('232', '1', '编辑产品： 小米蓝牙项圈耳机', '127.0.0.1', '/login.php', '1547462018');
INSERT INTO `ey_admin_log` VALUES ('233', '1', '编辑产品：小米笔记本Air 13.3', '127.0.0.1', '/login.php', '1547462162');
INSERT INTO `ey_admin_log` VALUES ('234', '1', '编辑产品：华为HUAWEI NOTE 8', '127.0.0.1', '/login.php', '1547462188');
INSERT INTO `ey_admin_log` VALUES ('235', '1', '编辑文章：网站建设，静态页面和动态页面如何选择', '127.0.0.1', '/login.php', '1547462449');
INSERT INTO `ey_admin_log` VALUES ('236', '1', '编辑文章：一文读懂互联网女皇和她的报告：互联网领域的投资圣经、选股指南', '127.0.0.1', '/login.php', '1547462473');
INSERT INTO `ey_admin_log` VALUES ('237', '1', '编辑文章：seo是什么？', '127.0.0.1', '/login.php', '1547462542');
INSERT INTO `ey_admin_log` VALUES ('238', '1', '编辑文章：社交媒体时代，如何对粉丝估值？', '127.0.0.1', '/login.php', '1547462596');
INSERT INTO `ey_admin_log` VALUES ('239', '1', '编辑文章：网站建设的五大核心要素', '127.0.0.1', '/login.php', '1547462639');
INSERT INTO `ey_admin_log` VALUES ('240', '1', '编辑图集：新闻模型下的图集二', '127.0.0.1', '/login.php', '1547462702');
INSERT INTO `ey_admin_log` VALUES ('241', '1', '编辑图集：新闻模型下的图集', '127.0.0.1', '/login.php', '1547462752');
INSERT INTO `ey_admin_log` VALUES ('242', '1', '编辑图集：客户案例三', '127.0.0.1', '/login.php', '1547462806');
INSERT INTO `ey_admin_log` VALUES ('243', '1', '编辑图集：客户案例二', '127.0.0.1', '/login.php', '1547462830');
INSERT INTO `ey_admin_log` VALUES ('244', '1', '编辑图集：客户案例一', '127.0.0.1', '/login.php', '1547462847');
INSERT INTO `ey_admin_log` VALUES ('245', '1', '编辑下载：职业教育培训机构网站模板', '127.0.0.1', '/login.php', '1547463404');
INSERT INTO `ey_admin_log` VALUES ('246', '1', '编辑下载：工程机械推土挖掘机类网站模板', '127.0.0.1', '/login.php', '1547463434');
INSERT INTO `ey_admin_log` VALUES ('247', '1', '编辑文章：Website construction, static pages and dynamic pages how to choose', '127.0.0.1', '/login.php', '1547463681');
INSERT INTO `ey_admin_log` VALUES ('248', '1', '编辑文章：Five Core Elements of Website Construction', '127.0.0.1', '/login.php', '1547463745');
INSERT INTO `ey_admin_log` VALUES ('249', '1', '编辑下载：Construction machinery bulldozer website template', '127.0.0.1', '/login.php', '1547463855');
INSERT INTO `ey_admin_log` VALUES ('250', '1', '编辑下载：工程机械推土挖掘机类网站模板', '127.0.0.1', '/login.php', '1547463959');

-- -----------------------------
-- Table structure for `ey_archives`
-- -----------------------------
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
) ENGINE=MyISAM AUTO_INCREMENT=72 DEFAULT CHARSET=utf8 COMMENT='文档主表';

-- -----------------------------
-- Records of `ey_archives`
-- -----------------------------
INSERT INTO `ey_archives` VALUES ('1', '1', '6', '0', '关于我们', '', '0', '0', '0', '0', '0', '', '0', '0', '', '0', '', '', '', '1', '100', 'cn', '0', '1526539465', '1527836335');
INSERT INTO `ey_archives` VALUES ('2', '8', '6', '0', '公司简介', '', '0', '0', '0', '0', '0', '', '0', '0', '', '0', '', '', '', '1', '100', 'cn', '0', '1526540452', '1527836706');
INSERT INTO `ey_archives` VALUES ('3', '13', '6', '0', '单页面', '', '0', '0', '0', '0', '0', '', '4', '0', '', '0', '', '', '', '1', '100', 'cn', '0', '1526540573', '1531710225');
INSERT INTO `ey_archives` VALUES ('4', '11', '1', '1', 'seo是什么？', '/uploads/allimg/20190114/716fd8917b02cf71176639d7ad69da9c.png', '0', '0', '0', '0', '0', '', '131', '0', '', '0', '', '', '在了解seo是什么意思之后，才能学习seo。什么是seo，从官方解释来看，seo=Search（搜索）Engine（引擎）Optimization（优化），即搜索引擎优化。使用过百度或其他搜索引擎，在', '1', '100', 'cn', '0', '1526545072', '1547462541');
INSERT INTO `ey_archives` VALUES ('39', '12', '1', '0', '回顾中国饮料40年发展史，总有一款是你儿时记忆的味道', '', '0', '0', '0', '0', '0', '', '178', '0', '', '0', '', '', '对于记忆来说，味道往往是最美的，儿时喝过的饮料，至今回想起来依然觉得津津有味。今天是六一儿童节，青山资本梳理了中国40年来饮料发展的简史，权当节日的小消遣，顺便看看能否找到你记忆深处的那个味道？第一阶段：国人味蕾的开启时代百事可乐在华第一家工厂开业1981年，可口可乐在中国第一条生产线正式投产，主要供应旅游饭店，卖给外国人收取外汇，百事可乐也在深圳建立了第一家罐装厂。1982年，国家把饮料纳入“国家计划管理产品”，可口可乐开始在北京市场进行内销。', '1', '100', 'cn', '0', '1527824652', '1531709817');
INSERT INTO `ey_archives` VALUES ('9', '10', '1', '0', '用户界面设计和体验设计的差别', '', '0', '0', '0', '0', '0', '', '169', '0', '', '0', '', '', '有时候我们需要获取图集中的第一张图片，下面给出解决办法： 第一步：修改include/extend.func.php 添加  // 提取图集第一张大图', '1', '100', 'cn', '0', '1526552582', '1531711820');
INSERT INTO `ey_archives` VALUES ('10', '10', '1', '0', '新手科普文！什么是用户界面和体验设计？', '', '0', '0', '0', '0', '0', '', '130', '0', '', '0', '', '', '在仿站时，我们常常会自定义很多字段，那么如何在首页调用呢，下面给出方法：一、指定channelid属性（channelid=\'17\' 17是指内容模型里面指定的模型ID) 二、指定要调用出来的字段ad', '1', '100', 'cn', '0', '1526552685', '1531711845');
INSERT INTO `ey_archives` VALUES ('12', '10', '1', '1', '一文读懂互联网女皇和她的报告：互联网领域的投资圣经、选股指南', '/uploads/allimg/20190114/c0ee7f49917d9e1a8f834b625970a9d0.png', '0', '0', '0', '0', '0', '', '267', '0', '', '0', '', '', '北京时间 5 月 31 日凌晨，有“互联网女皇”之称的玛丽·米克尔发布了 2018 年的互联网趋势报告，这也是她第 23 年公布互联网报告。\r\n每年的互联网女皇报告几乎都会成为每个互联网创业者的必读报告。那么，互联网女皇是谁?为什么她的报告会如此受关注呢?', '1', '100', 'cn', '0', '1526552714', '1547462473');
INSERT INTO `ey_archives` VALUES ('13', '12', '1', '0', '网站建设的五大核心要素', '/uploads/allimg/20190114/d09702880ccf6d5ab5893c3116f1a5f0.jpg', '0', '0', '0', '0', '0', '', '159', '0', '', '0', 'SEO标', 'O关键', 'SEO描述', '1', '100', 'cn', '0', '1526608216', '1547462639');
INSERT INTO `ey_archives` VALUES ('14', '10', '1', '0', '网站建设，静态页面和动态页面如何选择', '/uploads/allimg/20190114/1621fb9e84a97e78b1c1cac6ec6b37bd.png', '0', '0', '0', '0', '0', '', '149', '0', '', '0', '', '', '网站建设，静态页面和动态页面如何选择　　电商网站建设为什么要使用静态页面制作。我们都知道，网站制作有分为静态页面制作和动态网页制作，那么建设电商网站采用哪种网站设计技术更好呢?　　我们建设网站最终目的', '1', '100', 'cn', '0', '1526609496', '1547462449');
INSERT INTO `ey_archives` VALUES ('19', '12', '1', '0', '从三方面完美的体验企业网站的核心价值', 'http://www.eyoucms.com/uploads/allimg/180426/150RQ155-0.jpg', '0', '0', '0', '0', '0', '', '145', '0', '', '0', '', '', '从三方面完美的体验企业网站的核心价值　　随着互联网的迅猛发展，一个企业的发展离不开互联网的发展，企业注重企业网站建设，那么必然会给其带来不错的效果。企业网站建设其核心价值直接体现在网站对于用户和商家而', '1', '100', 'cn', '0', '1526610848', '1526610848');
INSERT INTO `ey_archives` VALUES ('20', '11', '1', '0', 'CMS是如何应运而生的？', '', '0', '0', '0', '0', '0', '', '176', '0', '', '0', '', '', '随着网络应用的丰富和发展，很多网站往往不能迅速跟进大量信息衍生及业务模式变革的脚步，常常需要花费许多时间、人力和物力来处理信息更新和维护工作；遇到网站扩充的时候，整合内外网及分支网站的工作就变得更加复', '1', '100', 'cn', '0', '1526611606', '1527557542');
INSERT INTO `ey_archives` VALUES ('21', '11', '1', '0', '网站设计与SEO的关系，高手是从这4个维度分析的！', '', '0', '0', '0', '0', '0', '', '287', '0', '', '0', '', '', 'SEO（搜索引擎优化）和有效的网站设计是齐头并进的。好的网站设计是关于创建一个吸引目标受众的网站，并让他们采取某种行动。但是，如果该网站不遵循目前的SEO最佳做法，它的排名将会受到影响，从而会导致真正', '1', '100', 'cn', '0', '1526611744', '1531709637');
INSERT INTO `ey_archives` VALUES ('22', '23', '3', '0', '新闻模型下的图集', '/uploads/allimg/20190114/e00be6cd175d973a064bbd42f76bd7cf.jpg', '0', '0', '0', '0', '0', '', '192', '0', '', '0', '', '', '新闻模型下的图集新闻模型下的图集新闻模型下的图集新闻模型下的图集新闻模型下的图集新闻模型下的图集新闻模型下的图集新闻模型下的图集新闻模型下的图集新闻模型下的图集新闻模型下的图集新闻模型下的图集新闻模型', '1', '100', 'cn', '0', '1526612277', '1547462752');
INSERT INTO `ey_archives` VALUES ('23', '23', '3', '0', '新闻模型下的图集二', '/uploads/allimg/20190114/5c9151abf9ab18003f8cc47887bc2b5c.jpg', '0', '0', '0', '0', '0', '', '287', '0', '', '0', '', '', '新闻模型下的图集二新闻模型下的图集二新闻模型下的图集二新闻模型下的图集二新闻模型下的图集二新闻模型下的图集二新闻模型下的图集二新闻模型下的图集二新闻模型下的图集二新闻模型下的图集二新闻模型下的图集二新', '1', '100', 'cn', '0', '1526612316', '1547462702');
INSERT INTO `ey_archives` VALUES ('27', '24', '2', '0', '华为HUAWEI NOTE 8', '/uploads/allimg/20190114/c5cabfe225aa42a62fc5a8aa7a66855a.jpg', '0', '0', '0', '0', '0', '', '289', '0', '', '0', '', '', '全向录音/指向回放、定向免提、指关节手势、分屏多窗口、语音控制、情景智能、单手操作、杂志锁屏、手机找回、无线WIFI打印、学生模式、多屏互动、运动健康全向录音/指向回放、定向免提、指关节手势、分屏多窗', '1', '100', 'cn', '0', '1526613043', '1547462188');
INSERT INTO `ey_archives` VALUES ('28', '26', '2', '0', '小米笔记本Air 13.3', '/uploads/allimg/20190114/66109e989148356eadb4ff1eee285826.jpg', '0', '0', '0', '0', '0', '', '149', '0', '', '0', '', '', '轻薄全金属机身/256GBSSD/第八代Intel酷睿i5处理器/FHD全贴合屏幕/指纹解锁/office激活不支持7天无理由退货...', '1', '100', 'cn', '0', '1526613271', '1547462162');
INSERT INTO `ey_archives` VALUES ('29', '27', '2', '0', ' 小米蓝牙项圈耳机', '/uploads/allimg/20190114/73b342f8127066fc4f891a1afd6c9751.jpg', '0', '0', '0', '0', '0', '', '211', '0', '', '0', '', '', '特性M3平板定制AKG品牌高保真耳机，配合M3平板享受HiFi音质...', '1', '100', 'cn', '0', '1526613739', '1547462018');
INSERT INTO `ey_archives` VALUES ('30', '5', '4', '0', '工程机械推土挖掘机类网站模板', '/uploads/allimg/20190114/4873105f54a14f3785047bd8ecc8b5ac.jpg', '0', '0', '0', '0', '0', '', '243', '0', '', '0', '', '', '宅男女神一号，多懂得...', '1', '100', 'cn', '0', '1526614069', '1547463959');
INSERT INTO `ey_archives` VALUES ('31', '5', '4', '0', '职业教育培训机构网站模板', '', '0', '0', '0', '0', '0', '', '168', '0', '', '0', '', '', '宅男女神二号种子，高手多是不懂的...', '1', '100', 'cn', '0', '1526614168', '1547463404');
INSERT INTO `ey_archives` VALUES ('40', '12', '1', '0', '社交媒体时代，如何对粉丝估值？', '/uploads/allimg/20190114/0e4da9d3f8f983a36b7357b97ef4adad.jpg', '0', '0', '0', '0', '0', '', '174', '0', '', '0', '', '', '约翰·奎尔奇说，社交媒体有很多营销挑战，如何为粉丝来估值是一个大问题。从营销角度来思考，要关注强纽带和弱纽带。你可能以为，强纽带的密友产生最大的营销影响，研究发现不是这样的，产生更大的影响反而是跟你更疏远的人。演讲者｜约翰·奎尔奇（哈佛商学院教授，曾任伦敦商学院院长、中欧国际工商学院副院长）非常感谢大家在周日早上回来听我讲课。对于你们这些创业者，或者希望成为创业者的人，我今天准备了一个特别的讲座。很多创业者没有把最终愿景很好界定，所以每天都忙于灭火，忙于生存。创业营销，你必须做好规划今天将从创业营销这个话题开始，包括你如何生存和成功。创业营销包括四个关键领域，你必须很好地去规划：要有正确的目标客户和最终用户；要有正确的产品和服务要有一个非常好的人才团队，使得商业创意能够实现；要有好的合作伙伴，不是分销商，而是会计、律师等服务伙伴。那么，何为创业营销？？第一，这是从愿景到行动的逆向工程设计当星巴克只有5家店时，创始人就有一个愿景，让星巴克成为你生活中的第三空间。对创业者要从愿景开始，向后进行逆向工程的设计：看一下需要有什么样的行动，才能实现愿景。很多创业者没有把最终愿景很好界定，所以每天', '1', '100', 'cn', '0', '1527824837', '1547462596');
INSERT INTO `ey_archives` VALUES ('37', '24', '2', '0', 'Apple iPhone 6s 16GB 玫瑰金色 移动联通电信4G手机', '/uploads/allimg/20190114/02d7e067ba09df1e19892d6fbd0dbae3.jpg', '0', '0', '0', '0', '0', '', '300', '0', '', '0', '', '', '', '1', '100', 'cn', '0', '1527507844', '1547461970');
INSERT INTO `ey_archives` VALUES ('38', '11', '1', '0', '商梦网校：单页SEO站群技术，用10个网站优化排名！', 'http://www.eyoucms.com/uploads/allimg/180505/3-1P505101H3447.png', '0', '0', '0', '0', '0', '', '113', '0', '', '0', '', '', 'SEO很多伙伴都了解，就是搜索引擎排名优化，通过对网站内部和外部进行优化当用户搜索相应关键词时网站能够排名在搜索引擎前面，具体可以百度搜索“网络营销课程”查看商梦网校操作的案例！但单页SEO很多伙伴可能会有点陌生，单页SEO是将单页网站与内容内容结合为一体的SEO优化方案，主要是提升网站流量利用率让用户打开网站就能看到目标页面，转换更多订单，创造更多收益。单页SEO的操作理念也是由商梦网校提出，并一起推荐操作大家的模式。那什么又是单页SEO站群呢，因为操作SEO成功率并不是100%，也就是意味着你做了并不会绝对有排名。因为在任何时候搜索引擎，特别是百度的索引数据库里，只有60%的网页数量。也就是说，大量的网页它是没有收录进来，它本身的能力所限无法做到中文的所有几百亿个网页都收录进来。所以，对于大部分网站，都有被删除网页，没有排名，或被K的经历，或没有排名。处理办法：坦然面对这一切。一个网站的成本才多少钱？如果因此对SEO失去信心，那就是最大的失去了。不过我们也想到了一个更好的解决方案，这个方案在最早期我们开始操作，并且取得了非常不错的成绩就是“站群”，我们可以假设一个网站排名的机会为1', '1', '100', 'cn', '0', '1527555069', '1531709578');
INSERT INTO `ey_archives` VALUES ('41', '12', '1', '0', '《颠覆营销:大数据时代的商业革命》：大数据“多即少，少即多”', '', '0', '0', '0', '0', '0', '', '162', '0', '', '0', '', '', '各种行销手段早已令人眼花缭乱，但究其本质都是在研究客户（消费者），研究客户的所想、所需，使产品或服务有的放矢。大数据时代又给它赋予了新名词：精准营销。大数据最先应用的领域多为面对客户的行业，最先应用的情景也多为精准营销。“酒好也怕巷子深”，产品或服务的信息要送达客户才可能促成交易。一般认为，向客户传达产品或服务信息要靠广告。广告古已有之，“三碗不过岗”的酒幌子就是广告。没有互联网的时代，我们熟悉的是电视广告、广播广告、印刷品平面广告、户外广告牌等，当然，也包括吆喝叫卖。但过去的广告是千人一面、不区分受众的。后来商家对客户的信息有所采集就有了CRM，经过客户分类，可以更好地服务于不同的客户群体。互联网+大数据时代让CRM有了新的发展机遇，管理客户不再是简单的数字统计和没有个性的（或简单聚类的）直邮、定投。随着商家对客户知道更多、了解更深，便有机会为客户提供个性化的营销方案，进一步改善客户体验，成为了个性化营销或叫精准营销。大数据时代，让很多过去的不可能变为可能，营销活动也赢来了新的发展机遇。时代不同，商业经营的形式会变化，但本质就是两件事：开源，节流。开源是开拓新客户，发现新商机；节流是', '1', '100', 'cn', '0', '1527825125', '1527825125');
INSERT INTO `ey_archives` VALUES ('42', '4', '3', '0', '客户案例一', '/uploads/allimg/20190114/ada4963a2dba414c6a5d2f4d983d5cfb.jpg', '0', '0', '0', '0', '0', '', '253', '0', '', '0', '', '', '', '1', '100', 'cn', '0', '1531731387', '1547462847');
INSERT INTO `ey_archives` VALUES ('43', '4', '3', '0', '客户案例二', '/uploads/allimg/20190114/a5552ebb7d08351c8ab5a39596c34db1.jpg', '0', '0', '0', '0', '0', '', '267', '0', '', '0', '', '', '', '1', '100', 'cn', '0', '1531732591', '1547462829');
INSERT INTO `ey_archives` VALUES ('44', '4', '3', '0', '客户案例三', '/uploads/allimg/20190114/5e82997411262b71dc9b34bf2ce96dff.jpg', '0', '0', '0', '0', '0', '', '282', '0', '', '0', '', '', '', '1', '100', 'cn', '0', '1531732811', '1547462806');
INSERT INTO `ey_archives` VALUES ('45', '31', '6', '0', 'About Us', '', '0', '0', '0', '0', '0', '', '0', '0', '', '0', '', '', '', '1', '100', 'en', '0', '1545267531', '1545272580');
INSERT INTO `ey_archives` VALUES ('46', '32', '6', '0', 'Company Profile', '', '0', '0', '0', '0', '0', '', '0', '0', '', '0', '', '', '', '1', '100', 'en', '0', '1545267531', '1545272565');
INSERT INTO `ey_archives` VALUES ('47', '39', '6', '0', 'Single page', '', '0', '0', '0', '0', '0', '', '0', '0', '', '0', '', '', '', '1', '100', 'en', '0', '1545267531', '1545270877');
INSERT INTO `ey_archives` VALUES ('48', '52', '4', '0', 'Construction machinery bulldozer website template', 'http://www.eyoucms.com/uploads/allimg/180426/150RQ155-0.jpg', '0', '0', '0', '0', '0', '', '163', '0', '', '0', '', '', 'Construction machinery bulldozer website template, download address：http://www.eyoucms.com/moban/16/668.html', '1', '100', 'en', '1', '1545268101', '1547463855');
INSERT INTO `ey_archives` VALUES ('49', '52', '4', '0', 'Website Template of Vocational Education and Training Institutions', '', '0', '0', '0', '0', '0', '', '135', '0', '', '0', '', '', 'Web template for vocational education and training institutions, download address: http://www.eyoucms.com/moban/10/673.html', '1', '100', 'en', '1', '1545268178', '1545268305');
INSERT INTO `ey_archives` VALUES ('50', '51', '3', '0', 'Customer Case I', '/uploads/allimg/20181220/a0efe0c4c085eb9d900d580a2fc8b60d.jpg', '0', '0', '0', '0', '0', '', '181', '0', '', '0', '', '', '', '1', '100', 'en', '1', '1545268344', '1545268466');
INSERT INTO `ey_archives` VALUES ('51', '51', '3', '0', 'Customer Case II', '/uploads/allimg/20181220/d7a2dfa72e8fad4b8c05ec5a2fb299b5.jpg', '0', '0', '0', '0', '0', '', '220', '0', '', '0', '', '', '', '1', '100', 'en', '1', '1545268484', '1545268514');
INSERT INTO `ey_archives` VALUES ('52', '51', '3', '0', 'Customer Case III', '/uploads/allimg/20181220/3139826d5d18b0143de1f0888fcc12dc.jpg', '0', '0', '0', '0', '0', '', '197', '0', '', '0', '', '', '', '1', '100', 'en', '1', '1545268516', '1545268563');
INSERT INTO `ey_archives` VALUES ('53', '48', '2', '0', 'Millet Bluetooth Necklace Headset', '/uploads/allimg/20181220/ed065072e34504da0ff9eb9c104f2d07.jpg', '0', '0', '0', '0', '0', '', '201', '0', '', '0', '', '', 'Feature M3 Tablet Customized AKG Brand High Fidelity Headphones, with M3 Tablet Enjoy HiFi Sound Quality...', '1', '100', 'en', '1', '1545268730', '1545270011');
INSERT INTO `ey_archives` VALUES ('54', '46', '2', '0', 'Millet notebook Air 13.3', '/uploads/allimg/20181220/bb7a7206605841a2db4af30ba3585506.jpg', '0', '0', '0', '0', '0', '', '295', '0', '', '0', '', '', 'Light and thin all-metal fuselage / 256GBSSD / 8th generation Intel Core i5 processor / FHD full-fit screen / fingerprint unlock / Office activation does not support 7 days without reason to return goods...', '1', '100', 'en', '1', '1545270060', '1545270139');
INSERT INTO `ey_archives` VALUES ('55', '43', '2', '0', 'HUAWEI NOTE 8', '/uploads/allimg/20181220/c63c2b41520e21784fdb272abfc77453.jpg', '0', '0', '0', '0', '0', '', '278', '0', '', '0', '', '', 'Omnidirectional recording/pointing playback, directional hands-free, finger joint gesture, split screen multi-window, voice control, situational intelligence, single-handed operation, magazine lock screen, mobile phone retrieval, wireless WIFI printing, student mode, multi-screen interaction, sports health omnidirectional recording/pointing playback, directional hands-free, finger joint gesture, split screen multi-window', '1', '100', 'en', '1', '1545270266', '1545270361');
INSERT INTO `ey_archives` VALUES ('56', '43', '2', '0', 'Apple iPhone 6s 16GB ', '/uploads/allimg/20181220/ebbf9bd058529bfd47d2830835427e57.jpg', '0', '0', '0', '0', '0', '', '175', '0', '', '0', '', '', '', '1', '100', 'en', '1', '1545270365', '1545270643');
INSERT INTO `ey_archives` VALUES ('57', '40', '3', '0', 'Atlas under News Model', '/uploads/allimg/20181220/d543bd229a479794186ec78b42753d6e.jpg', '0', '0', '0', '0', '0', '', '228', '0', '', '0', '', '', '', '1', '100', 'en', '1', '1545270757', '1545270783');
INSERT INTO `ey_archives` VALUES ('58', '40', '3', '0', 'Atlas II under News Model', '/uploads/allimg/20181220/3dd707090ed329fb39e75c48292b7923.jpg', '0', '0', '0', '0', '0', '', '276', '0', '', '0', '', '', '', '1', '100', 'en', '1', '1545270788', '1545270816');
INSERT INTO `ey_archives` VALUES ('59', '38', '1', '0', 'Five Core Elements of Website Construction', '/uploads/allimg/20181220/39229581e20d2e22e750df528a43fe71.jpg', '0', '0', '0', '0', '0', '', '245', '0', '', '0', '', '', 'Five Core Elements of Website Construction　　In order to implement network marketing, enterprises need to make websites first. Website is composed of many Web pages, and the design of these pages directly affects whether the website can be welcomed by users. To judge the design of a homepage, we should consider it comprehensively from many aspects, not only whether it is vividly and beautifully designed, but also whether the website can be considered for users to the greatest extent.　　3. Product ', '1', '100', 'en', '1', '1545270896', '1547463745');
INSERT INTO `ey_archives` VALUES ('60', '38', '1', '0', 'Experience the Core Value of Enterprise Website Perfectly from Three Aspects', '/uploads/allimg/20181220/4d466f39dde9e64d762cd50b51566286.jpg', '0', '0', '0', '0', '0', '', '226', '0', '', '0', '', '', 'Experience the Core Value of Enterprise Website Perfectly from Three Aspects　　With the rapid development of the Internet, the development of an enterprise can not be separated from the development of the Internet. Enterprises pay attention to the construction of enterprise websites, then it will inevitably bring good results. The core value of enterprise website construction is directly reflected in whether the website can satisfy the interests and needs of users and businessmen, improve the dev', '1', '100', 'en', '1', '1545270965', '1545270965');
INSERT INTO `ey_archives` VALUES ('61', '38', '1', '0', 'Looking back on the 40-year history of beverages in China, there is always a taste of your childhood', '', '0', '0', '0', '0', '0', '', '244', '0', '', '0', '', '', 'Looking back on the 40-year history of Chinese beverage development, there is always a taste of your childhood memory. For memory, the taste is often the most beautiful. The beverage you drank in childhood is still enjoyable in retrospect.Today is the June 1 children&#39;s day. Qingshan capital has compiled a brief history of China&#39;s beverage development in the past 40 years, and it can be a holiday pastime. By the way, can you find the smell in your memory?The First Stage: The Opening Age o', '1', '100', 'en', '1', '1545271038', '1545271038');
INSERT INTO `ey_archives` VALUES ('62', '38', '1', '0', 'How to value fans in the age of social media?', '/uploads/allimg/20181220/040eb84875a8067b81c27177cd7ec95b.jpg', '0', '0', '0', '0', '0', '', '215', '0', '', '0', '', '', 'John Quilch says that social media has many marketing challenges, and how to value fans is a big problem. From the marketing point of view, we should pay attention to strong ties and weak ties. You may think that strong bonds have the greatest marketing impact. Research has found that it&#39;s not like this, but people who are more distant from you.Speaker John Quilch(Professor of Harvard Business School, former Dean of London Business School and Vice Dean of CEIBS)Thank you very much for coming', '1', '100', 'en', '1', '1545271071', '1545271071');
INSERT INTO `ey_archives` VALUES ('63', '38', '1', '0', '&quot;Subversive Marketing: Business Revolution in the Big Data Age&quot;: Big Data &quot;More Is Less, Less Is Mor', '', '0', '0', '0', '0', '0', '', '227', '0', '', '0', '', '', 'Various marketing methods have long been dazzling, but the essence is to study customers (consumers), research the needs and needs of customers, and make products or services targeted. The era of big data has given it a new term: precision marketing. The first areas where big data is applied are mostly for the customer-facing industry. The first application scenarios are mostly precision marketing.“Wine is good, and the alley is deep.” Information about products or services should be delivered t', '1', '100', 'en', '1', '1545271135', '1545271135');
INSERT INTO `ey_archives` VALUES ('64', '37', '1', '0', 'What is seo?', '/uploads/allimg/20181220/381e3fccc694fff578a861c93628ce15.jpg', '0', '0', '0', '0', '0', '', '126', '0', '', '0', '', '', 'After learning what seo means, you can learn seo.What is seo, from the official explanation, seo=Search Engine Optimization, which is search engine optimization.Use Baidu or other search engines, enter a certain keyword in the search box, such as the wrought iron gate, the top is with the ad typeface, the background is slightly different is the bidding position, which is commonly known as the sem position.Seo is an online marketing method based on search engine marketing. Through seo technology,', '1', '100', 'en', '1', '1545271278', '1545271278');
INSERT INTO `ey_archives` VALUES ('65', '37', '1', '0', 'How did CMS come into being?', '', '0', '0', '0', '0', '0', '', '106', '0', '', '0', '', '', 'With the enrichment and development of web applications, many websites often cannot quickly follow the footsteps of a large amount of information derivation and business model changes. It often takes a lot of time, manpower and material resources to handle information update and maintenance work. When encountering website expansion, The integration of internal and external networks and branch sites has become more complicated, and even the need to rebuild the website; so, users continue to upgra', '1', '100', 'en', '1', '1545271999', '1545271999');
INSERT INTO `ey_archives` VALUES ('66', '37', '1', '0', 'The relationship between website design and SEO, the master is analyzed from these four dimensions!', '', '0', '0', '0', '0', '0', '', '113', '0', '', '0', '', '', 'SEO (Search Engine Optimization) and effective website design go hand in hand. Good website design is about creating a website that appeals to your target audience and letting them take some action. However, if the site does not follow current SEO best practices, its ranking will be affected, resulting in fewer visitors actually participating in the site.Conversely, if you focus on search engine optimization and how to please search engine spiders, then the site may rank high and get a lot of se', '1', '100', 'en', '1', '1545272020', '1545272020');
INSERT INTO `ey_archives` VALUES ('67', '37', '1', '0', 'Shangmeng.com: Single-page SEO station group technology, with 10 websites to optimize the ranking!', '/uploads/allimg/20181220/b20b37ff3af3fad04716faa97b5bb584.png', '0', '0', '0', '0', '0', '', '167', '0', '', '0', '', '', 'Many SEO partners understand that search engine ranking optimization is optimized by internal and external websites. When users search for corresponding keywords, the website can be ranked in front of the search engine. Specifically, Baidu search &quot;network marketing course&quot; to view the operation of Shangmeng. Case!But a single page SEO many partners may be a bit strange, single-page SEO is a SEO optimization program that combines a single-page website with content content, mainly to imp', '1', '100', 'en', '1', '1545272059', '1545272059');
INSERT INTO `ey_archives` VALUES ('68', '36', '1', '0', 'Differences in user interface design and experience design', '', '0', '0', '0', '0', '0', '', '172', '0', '', '0', '', '', 'Note: The User Interface (UI) design is one of several interdisciplinary topics involved in designing software products. Whether it is user experience (UX, User Experience), interaction design (ID, Interaction Design), or visual / graphic design (Visual / Graphic Design), can involve user interface design.First, what is the user interface design?Broadly speaking, the user interface is the medium through which people interact with machines. The user issues an instruction to the machine, and the m', '1', '100', 'en', '1', '1545272146', '1545272146');
INSERT INTO `ey_archives` VALUES ('69', '36', '1', '0', 'Novice science! What is the user interface and experience design?', '', '0', '0', '0', '0', '0', '', '203', '0', '', '0', '', '', 'Z Yuhan: User Interface (UI) design is one of several interdisciplinary topics involved in designing software products. Whether it is user experience (UX, User Experience), interaction design (ID, Interaction Design), or visual / graphic design (Visual / Graphic Design), can involve user interface design.First, what is the user interface design?Broadly speaking, the user interface is the medium through which people interact with machines. The user issues an instruction to the machine, and the ma', '1', '100', 'en', '1', '1545272183', '1545272183');
INSERT INTO `ey_archives` VALUES ('70', '36', '1', '0', 'Read the Internet Queen and her report: Investment in the Internet, Bible, stock selection guide', '/uploads/allimg/20181220/bd62f1623a6a7b4b3a32e6045bff14a3.jpg', '0', '0', '0', '0', '0', '', '166', '0', '', '0', '', '', 'In the early morning of May 31st, Beijing time, Mary Mickel, who is known as the “Queen of the Internet”, published the Internet Trend Report for 2018, which is the 23rd year of her Internet report.The annual Internet Queen&#39;s report will almost always become a must-read report for every Internet entrepreneur. So, who is the Internet Queen? Why is her report so concerned?Internet Queen: The symbol of Wall Street in the 90sIn September 1958, Mary Meeker was born in Indiana, USA.In 1982, Mikel ', '1', '100', 'en', '1', '1545272227', '1545272227');
INSERT INTO `ey_archives` VALUES ('71', '36', '1', '0', 'Website construction, static pages and dynamic pages how to choose', '/uploads/allimg/20181220/4e7474448185b797c4c1d796b3e581fe.jpg', '0', '0', '0', '0', '0', '', '151', '0', '', '0', '', '', 'Website construction, static pages and dynamic pages how to chooseWhy should e-commerce website construction use static page production? We all know that website production is divided into static page production and dynamic web page production. So which website design technology is better for building e-commerce websites?The ultimate goal of our website is to provide users with a view, so it is most practical to think from the user\'s point of view. Although the dynamic webpage creation techn', '1', '100', 'en', '1', '1545272283', '1547463680');

-- -----------------------------
-- Table structure for `ey_arcrank`
-- -----------------------------
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

-- -----------------------------
-- Records of `ey_arcrank`
-- -----------------------------
INSERT INTO `ey_arcrank` VALUES ('1', '0', '开放浏览', 'cn', '0', '0');
INSERT INTO `ey_arcrank` VALUES ('2', '-1', '待审核稿件', 'cn', '0', '0');
INSERT INTO `ey_arcrank` VALUES ('3', '0', 'en开放浏览', 'en', '0', '0');
INSERT INTO `ey_arcrank` VALUES ('4', '-1', 'en待审核稿件', 'en', '0', '0');

-- -----------------------------
-- Table structure for `ey_arctype`
-- -----------------------------
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

-- -----------------------------
-- Records of `ey_arctype`
-- -----------------------------
INSERT INTO `ey_arctype` VALUES ('1', '6', '6', '0', '关于我们', 'guanyuwomen', '/html/guanyuwomen', '', '0', '', '', 'lists_single.htm', '', '', '', '', '100', '0', '0', '0', '0', '1', 'cn', '1526539465', '1545272580');
INSERT INTO `ey_arctype` VALUES ('2', '1', '1', '0', '新闻动态', 'xinwendongtai', '/html/xinwendongtai', '', '0', '', '', '', '', '', '', '', '100', '0', '0', '0', '0', '1', 'cn', '1526539487', '1545272354');
INSERT INTO `ey_arctype` VALUES ('3', '2', '2', '0', '产品展示', 'chanpinzhanshi', '/html/chanpinzhanshi', '', '0', '', '', '', '', '', '', '', '100', '0', '0', '0', '0', '1', 'cn', '1526539505', '1545270730');
INSERT INTO `ey_arctype` VALUES ('4', '3', '3', '0', '客户案例', 'kehuanli', '/html/kehuanli', '', '0', '', '', '', '', '', '', '', '100', '0', '0', '0', '0', '1', 'cn', '1526539517', '1545268599');
INSERT INTO `ey_arctype` VALUES ('5', '4', '4', '0', '资料下载', 'ziliaoxiazai', '/html/ziliaoxiazai', '', '0', '', '', '', '', '', '', '', '100', '0', '0', '0', '0', '1', 'cn', '1526539530', '1545268321');
INSERT INTO `ey_arctype` VALUES ('6', '8', '8', '0', '报名入口', 'baomingrukou', '/html/baomingrukou', '', '0', '', '', '', '', '', '', '', '100', '0', '0', '0', '0', '1', 'cn', '1526539546', '1545268049');
INSERT INTO `ey_arctype` VALUES ('8', '6', '6', '1', '公司简介', 'gongsijianjie', '/html/guanyuwomen/gongsijianjie', '', '1', '', '', 'lists_single.htm', '', '', '', '', '100', '0', '0', '0', '0', '1', 'cn', '1526540452', '1545272565');
INSERT INTO `ey_arctype` VALUES ('9', '6', '1', '1', '公司荣誉', 'gsry', '/html/guanyuwomen', '', '1', '', '', 'lists_article.htm', 'view_article.htm', '', '', '', '100', '0', '0', '0', '0', '1', 'cn', '1526540478', '1545272547');
INSERT INTO `ey_arctype` VALUES ('10', '1', '1', '2', '媒体报道', 'meitibaodao', '/html/xinwendongtai/meitibaodao', '', '1', '', '', '', '', '', '', '', '100', '0', '0', '0', '0', '1', 'cn', '1526540530', '1545272127');
INSERT INTO `ey_arctype` VALUES ('11', '1', '1', '2', 'SEO优化', 'xingyezixun', '/html/xinwendongtai/xingyezixun', '', '1', '', '', '', '', '', '', '', '100', '0', '0', '0', '0', '1', 'cn', '1526540543', '1545272114');
INSERT INTO `ey_arctype` VALUES ('12', '1', '1', '2', '企业运营', 'qiyexinwen', '/html/xinwendongtai/qiyexinwen', '', '1', '', '', '', '', '', '', '', '100', '0', '0', '0', '0', '1', 'cn', '1526540554', '1545271263');
INSERT INTO `ey_arctype` VALUES ('13', '1', '6', '2', '单页面', 'xinwendanye', '/html/xinwendongtai/xinwendanye', '', '1', '', '', 'lists_single.htm', '', '', '', '', '100', '0', '0', '0', '0', '1', 'cn', '1526540573', '1545270877');
INSERT INTO `ey_arctype` VALUES ('20', '2', '2', '3', '手机', 'shouji', '/html/chanpinzhanshi/shouji', '', '1', '', '', '', '', '', '', '', '100', '0', '0', '0', '0', '1', 'cn', '1526612114', '1545270715');
INSERT INTO `ey_arctype` VALUES ('21', '2', '2', '3', '电脑', 'diannao', '/html/chanpinzhanshi/diannao', '', '1', '', '', '', '', '', '', '', '100', '0', '0', '0', '0', '1', 'cn', '1526612188', '1545270214');
INSERT INTO `ey_arctype` VALUES ('22', '2', '2', '3', '通用配件', 'tongyongpeijian', '/html/chanpinzhanshi/tongyongpeijian', '', '1', '', '', '', '', '', '', '', '100', '0', '0', '0', '0', '1', 'cn', '1526612218', '1545269166');
INSERT INTO `ey_arctype` VALUES ('23', '1', '3', '2', '风景图集', 'fengjingtuji', '/html/xinwendongtai/fengjingtuji', '', '1', '', '', '', '', '', '', '', '100', '0', '0', '0', '0', '1', 'cn', '1526612255', '1545270830');
INSERT INTO `ey_arctype` VALUES ('24', '2', '2', '20', '智能手机', 'zhinenshouji', '/html/chanpinzhanshi/shouji/zhinenshouji', '', '2', '', '', '', '', '', '', '', '100', '0', '0', '0', '0', '1', 'cn', '1526612571', '1545270702');
INSERT INTO `ey_arctype` VALUES ('25', '2', '2', '20', '畅玩手机', 'changwanshouji', '/html/chanpinzhanshi/shouji/changwanshouji', '', '2', '', '', '', '', '', '', '', '100', '0', '0', '0', '0', '1', 'cn', '1526612606', '1545270668');
INSERT INTO `ey_arctype` VALUES ('26', '2', '2', '21', '笔记本电脑', 'bijibendiannao', '/html/chanpinzhanshi/diannao/bijibendiannao', '', '2', '', '', '', '', '', '', '', '100', '0', '0', '0', '0', '1', 'cn', '1526612635', '1545270191');
INSERT INTO `ey_arctype` VALUES ('27', '2', '2', '22', '耳机', 'erji', '/html/chanpinzhanshi/tongyongpeijian/erji', '', '2', '', '', '', '', '', '', '', '100', '0', '0', '0', '0', '1', 'cn', '1526612661', '1545269149');
INSERT INTO `ey_arctype` VALUES ('28', '2', '2', '22', '音箱', 'yinxiang', '/html/chanpinzhanshi/tongyongpeijian/yinxiang', '', '2', '', '', '', '', '', '', '', '100', '0', '0', '0', '0', '1', 'cn', '1526612678', '1545269134');
INSERT INTO `ey_arctype` VALUES ('29', '2', '2', '22', '充电宝', 'chongdianbao', '/html/chanpinzhanshi/tongyongpeijian/chongdianbao', '', '2', '', '', '', '', '', '', '', '100', '0', '0', '0', '0', '1', 'cn', '1526612691', '1545269115');
INSERT INTO `ey_arctype` VALUES ('30', '6', '8', '1', '预约面试', 'yuyuemianshi', '/html/guanyuwomen/yuyuemianshi', '', '1', '', '', 'lists_guestbook_30.htm', '', '', '', '', '100', '0', '0', '0', '0', '1', 'cn', '1526634493', '1545272506');
INSERT INTO `ey_arctype` VALUES ('31', '6', '6', '0', 'About Us', 'guanyuwomen', '/html/guanyuwomen', '', '0', '', '', 'lists_single.htm', '', '', '', '', '100', '0', '0', '0', '0', '1', 'en', '1526539465', '1545272580');
INSERT INTO `ey_arctype` VALUES ('32', '6', '6', '31', 'Company Profile', 'gongsijianjie', '/html/guanyuwomen/gongsijianjie', '', '1', '', '', 'lists_single.htm', '', '', '', '', '100', '0', '0', '0', '0', '1', 'en', '1526540452', '1545272580');
INSERT INTO `ey_arctype` VALUES ('33', '6', '1', '31', 'Honor', 'gsry', '/html/guanyuwomen', '', '1', '', '', 'lists_article.htm', 'view_article.htm', '', '', '', '100', '0', '0', '0', '0', '1', 'en', '1526540478', '1545272580');
INSERT INTO `ey_arctype` VALUES ('34', '6', '8', '31', 'Appointment interview', 'yuyuemianshi', '/html/guanyuwomen/yuyuemianshi', '', '1', '', '', 'lists_guestbook_30.htm', '', '', '', '', '100', '0', '0', '0', '0', '1', 'en', '1526634493', '1545272580');
INSERT INTO `ey_arctype` VALUES ('35', '1', '1', '0', 'News', 'xinwendongtai', '/html/xinwendongtai', '', '0', '', '', 'lists_article.htm', 'view_article.htm', '', '', '', '100', '0', '0', '0', '0', '1', 'en', '1526539487', '1545272354');
INSERT INTO `ey_arctype` VALUES ('36', '1', '1', '35', 'Media coverage', 'meitibaodao', '/html/xinwendongtai/meitibaodao', '', '1', '', '', 'lists_article.htm', 'view_article.htm', '', '', '', '100', '0', '0', '0', '0', '1', 'en', '1526540530', '1545272354');
INSERT INTO `ey_arctype` VALUES ('37', '1', '1', '35', 'SEO optimization', 'xingyezixun', '/html/xinwendongtai/xingyezixun', '', '1', '', '', 'lists_article.htm', 'view_article.htm', '', '', '', '100', '0', '0', '0', '0', '1', 'en', '1526540543', '1545272354');
INSERT INTO `ey_arctype` VALUES ('38', '1', '1', '35', 'Enterprise operation', 'qiyexinwen', '/html/xinwendongtai/qiyexinwen', '', '1', '', '', 'lists_article.htm', 'view_article.htm', '', '', '', '100', '0', '0', '0', '0', '1', 'en', '1526540554', '1545272354');
INSERT INTO `ey_arctype` VALUES ('39', '1', '6', '35', 'Single page', 'xinwendanye', '/html/xinwendongtai/xinwendanye', '', '1', '', '', 'lists_single.htm', '', '', '', '', '100', '0', '0', '0', '0', '1', 'en', '1526540573', '1545272354');
INSERT INTO `ey_arctype` VALUES ('40', '1', '3', '35', 'Landscape Atlas', 'fengjingtuji', '/html/xinwendongtai/fengjingtuji', '', '1', '', '', 'lists_images.htm', 'view_images.htm', '', '', '', '100', '0', '0', '0', '0', '1', 'en', '1526612255', '1545272354');
INSERT INTO `ey_arctype` VALUES ('41', '2', '2', '0', ' Product', 'chanpinzhanshi', '/html/chanpinzhanshi', '', '0', '', '', 'lists_product.htm', 'view_product.htm', '', '', '', '100', '0', '0', '0', '0', '1', 'en', '1526539505', '1545270730');
INSERT INTO `ey_arctype` VALUES ('42', '2', '2', '41', 'Phone', 'shouji', '/html/chanpinzhanshi/shouji', '', '1', '', '', 'lists_product.htm', 'view_product.htm', '', '', '', '100', '0', '0', '0', '0', '1', 'en', '1526612114', '1545270730');
INSERT INTO `ey_arctype` VALUES ('43', '2', '2', '42', 'Smartphone', 'zhinenshouji', '/html/chanpinzhanshi/shouji/zhinenshouji', '', '2', '', '', 'lists_product.htm', 'view_product.htm', '', '', '', '100', '0', '0', '0', '0', '1', 'en', '1526612571', '1545270730');
INSERT INTO `ey_arctype` VALUES ('44', '2', '2', '42', 'Play your mobile phone', 'changwanshouji', '/html/chanpinzhanshi/shouji/changwanshouji', '', '2', '', '', 'lists_product.htm', 'view_product.htm', '', '', '', '100', '0', '0', '0', '0', '1', 'en', '1526612606', '1545270730');
INSERT INTO `ey_arctype` VALUES ('45', '2', '2', '41', 'Computer', 'diannao', '/html/chanpinzhanshi/diannao', '', '1', '', '', 'lists_product.htm', 'view_product.htm', '', '', '', '100', '0', '0', '0', '0', '1', 'en', '1526612188', '1545270730');
INSERT INTO `ey_arctype` VALUES ('46', '2', '2', '45', 'Notebook computer', 'bijibendiannao', '/html/chanpinzhanshi/diannao/bijibendiannao', '', '2', '', '', 'lists_product.htm', 'view_product.htm', '', '', '', '100', '0', '0', '0', '0', '1', 'en', '1526612635', '1545270730');
INSERT INTO `ey_arctype` VALUES ('47', '2', '2', '41', 'General accessories', 'tongyongpeijian', '/html/chanpinzhanshi/tongyongpeijian', '', '1', '', '', 'lists_product.htm', 'view_product.htm', '', '', '', '100', '0', '0', '0', '0', '1', 'en', '1526612218', '1545270730');
INSERT INTO `ey_arctype` VALUES ('48', '2', '2', '47', 'Headset', 'erji', '/html/chanpinzhanshi/tongyongpeijian/erji', '', '2', '', '', 'lists_product.htm', 'view_product.htm', '', '', '', '100', '0', '0', '0', '0', '1', 'en', '1526612661', '1545270730');
INSERT INTO `ey_arctype` VALUES ('49', '2', '2', '47', 'Loudspeaker box', 'yinxiang', '/html/chanpinzhanshi/tongyongpeijian/yinxiang', '', '2', '', '', 'lists_product.htm', 'view_product.htm', '', '', '', '100', '0', '0', '0', '0', '1', 'en', '1526612678', '1545270730');
INSERT INTO `ey_arctype` VALUES ('50', '2', '2', '47', 'Portable battery', 'chongdianbao', '/html/chanpinzhanshi/tongyongpeijian/chongdianbao', '', '2', '', '', 'lists_product.htm', 'view_product.htm', '', '', '', '100', '0', '0', '0', '0', '1', 'en', '1526612691', '1545270730');
INSERT INTO `ey_arctype` VALUES ('51', '3', '3', '0', 'Case', 'kehuanli', '/html/kehuanli', '', '0', '', '', 'lists_images.htm', 'view_images.htm', '', '', '', '100', '0', '0', '0', '0', '1', 'en', '1526539517', '1545268599');
INSERT INTO `ey_arctype` VALUES ('52', '4', '4', '0', 'Data download', 'ziliaoxiazai', '/html/ziliaoxiazai', '', '0', '', '', 'lists_download.htm', 'view_download.htm', '', '', '', '100', '0', '0', '0', '0', '1', 'en', '1526539530', '1545268321');
INSERT INTO `ey_arctype` VALUES ('53', '8', '8', '0', 'Entry entry', 'baomingrukou', '/html/baomingrukou', '', '0', '', '', 'lists_guestbook.htm', '', '', '', '', '100', '0', '0', '0', '0', '1', 'en', '1526539546', '1545268049');

-- -----------------------------
-- Table structure for `ey_article_content`
-- -----------------------------
DROP TABLE IF EXISTS `ey_article_content`;
CREATE TABLE `ey_article_content` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `aid` int(10) DEFAULT '0' COMMENT '文档ID',
  `content` longtext COMMENT '内容详情',
  `add_time` int(11) DEFAULT '0' COMMENT '新增时间',
  `update_time` int(11) DEFAULT '0' COMMENT '更新时间',
  PRIMARY KEY (`id`),
  KEY `news_id` (`aid`) USING BTREE
) ENGINE=MyISAM AUTO_INCREMENT=31 DEFAULT CHARSET=utf8 COMMENT='文章附加表';

-- -----------------------------
-- Records of `ey_article_content`
-- -----------------------------
INSERT INTO `ey_article_content` VALUES ('1', '4', '&lt;p style=&quot;margin-top: 0px; margin-bottom: 15px; color: rgb(85, 85, 85); font-family: &amp;quot;Microsoft Yahei&amp;quot;, &amp;quot;Helvetica Neue&amp;quot;, Helvetica, Arial, sans-serif; font-size: 15px; text-indent: 30px; white-space: normal;&quot;&gt;在了解&lt;strong&gt;seo是什么意思&lt;/strong&gt;之后，才能学习seo。&lt;br/&gt;&lt;/p&gt;&lt;p style=&quot;margin-top: 0px; margin-bottom: 15px; color: rgb(85, 85, 85); font-family: &amp;quot;Microsoft Yahei&amp;quot;, &amp;quot;Helvetica Neue&amp;quot;, Helvetica, Arial, sans-serif; font-size: 15px; text-indent: 30px; white-space: normal;&quot;&gt;什么是seo，从官方解释来看，seo=Search（搜索） Engine（引擎） Optimization（优化），即搜索引擎优化。&lt;/p&gt;&lt;p style=&quot;margin-top: 0px; margin-bottom: 15px; color: rgb(85, 85, 85); font-family: &amp;quot;Microsoft Yahei&amp;quot;, &amp;quot;Helvetica Neue&amp;quot;, Helvetica, Arial, sans-serif; font-size: 15px; text-indent: 30px; white-space: normal;&quot;&gt;使用过百度或其他搜索引擎，在搜索框中输入某一个关键词，如铁艺大门，排名靠前带有广告字样，背景略不同的是竞价位置，为俗称的&lt;a href=&quot;http://www.xminseo.com/2376.html&quot; title=&quot;&quot; style=&quot;color: rgb(0, 166, 124); text-decoration: none;&quot;&gt;sem&lt;/a&gt;位置。&lt;/p&gt;&lt;p style=&quot;margin-top: 0px; margin-bottom: 15px; color: rgb(85, 85, 85); font-family: &amp;quot;Microsoft Yahei&amp;quot;, &amp;quot;Helvetica Neue&amp;quot;, Helvetica, Arial, sans-serif; font-size: 15px; text-indent: 30px; white-space: normal;&quot;&gt;seo是基于搜索引擎营销的一种网络营销方式，通过seo技术，提升网站关键词排名，获得展现，继而获得曝光，继而获得用户点击，继而获得转化。&lt;/p&gt;&lt;p style=&quot;margin-top: 0px; margin-bottom: 15px; color: rgb(85, 85, 85); font-family: &amp;quot;Microsoft Yahei&amp;quot;, &amp;quot;Helvetica Neue&amp;quot;, Helvetica, Arial, sans-serif; font-size: 15px; text-indent: 30px; white-space: normal;&quot;&gt;一：seo分类。&lt;/p&gt;&lt;p style=&quot;margin-top: 0px; margin-bottom: 15px; color: rgb(85, 85, 85); font-family: &amp;quot;Microsoft Yahei&amp;quot;, &amp;quot;Helvetica Neue&amp;quot;, Helvetica, Arial, sans-serif; font-size: 15px; text-indent: 30px; white-space: normal;&quot;&gt;细化来看，所有有利于网站关键词排名提升的点，都可以归纳于seo，为便于理解，我们将seo分为站内seo和站外seo。&lt;/p&gt;&lt;p style=&quot;margin-top: 0px; margin-bottom: 15px; color: rgb(85, 85, 85); font-family: &amp;quot;Microsoft Yahei&amp;quot;, &amp;quot;Helvetica Neue&amp;quot;, Helvetica, Arial, sans-serif; font-size: 15px; text-indent: 30px; white-space: normal;&quot;&gt;1：站内seo。&lt;/p&gt;&lt;p style=&quot;margin-top: 0px; margin-bottom: 15px; color: rgb(85, 85, 85); font-family: &amp;quot;Microsoft Yahei&amp;quot;, &amp;quot;Helvetica Neue&amp;quot;, Helvetica, Arial, sans-serif; font-size: 15px; text-indent: 30px; white-space: normal;&quot;&gt;什么是站内seo？通俗来讲，就是指网站内部优化，即网站本身内部的优化，包括代码标签优化、内容优化、安全建设、用户体验等。&lt;/p&gt;&lt;p style=&quot;margin-top: 0px; margin-bottom: 15px; color: rgb(85, 85, 85); font-family: &amp;quot;Microsoft Yahei&amp;quot;, &amp;quot;Helvetica Neue&amp;quot;, Helvetica, Arial, sans-serif; font-size: 15px; text-indent: 30px; white-space: normal;&quot;&gt;2：站外seo。&lt;/p&gt;&lt;p style=&quot;margin-top: 0px; margin-bottom: 15px; color: rgb(85, 85, 85); font-family: &amp;quot;Microsoft Yahei&amp;quot;, &amp;quot;Helvetica Neue&amp;quot;, Helvetica, Arial, sans-serif; font-size: 15px; text-indent: 30px; white-space: normal;&quot;&gt;什么是站外seo？通俗来讲，就是网站的外部优化，包括外链建设，品牌建设，速度优化，引流等。&lt;/p&gt;&lt;p style=&quot;margin-top: 0px; margin-bottom: 15px; color: rgb(85, 85, 85); font-family: &amp;quot;Microsoft Yahei&amp;quot;, &amp;quot;Helvetica Neue&amp;quot;, Helvetica, Arial, sans-serif; font-size: 15px; text-indent: 30px; white-space: normal;&quot;&gt;二：seo相关建议。&lt;/p&gt;&lt;p style=&quot;margin-top: 0px; margin-bottom: 15px; color: rgb(85, 85, 85); font-family: &amp;quot;Microsoft Yahei&amp;quot;, &amp;quot;Helvetica Neue&amp;quot;, Helvetica, Arial, sans-serif; font-size: 15px; text-indent: 30px; white-space: normal;&quot;&gt;1：建议把seo定位于一种网络营销方式，在学习，使用seo的过程中，将他作为一种获取流量的渠道。&lt;/p&gt;&lt;p style=&quot;margin-top: 0px; margin-bottom: 15px; color: rgb(85, 85, 85); font-family: &amp;quot;Microsoft Yahei&amp;quot;, &amp;quot;Helvetica Neue&amp;quot;, Helvetica, Arial, sans-serif; font-size: 15px; text-indent: 30px; white-space: normal;&quot;&gt;2：新手学习seo的理想平台是百度搜索资源平台而非其他；理论联系实际操作是更为有效的学习方式；有经验的seo高手教会更快的掌握好seo；多思考，多总结，才能领悟seo的精髓。&lt;/p&gt;&lt;p style=&quot;margin-top: 0px; margin-bottom: 15px; color: rgb(85, 85, 85); font-family: &amp;quot;Microsoft Yahei&amp;quot;, &amp;quot;Helvetica Neue&amp;quot;, Helvetica, Arial, sans-serif; font-size: 15px; text-indent: 30px; white-space: normal;&quot;&gt;3：学习seo之前，熟悉掌握相关seo术语很有必要。&lt;/p&gt;&lt;p style=&quot;margin-top: 0px; margin-bottom: 15px; color: rgb(85, 85, 85); font-family: &amp;quot;Microsoft Yahei&amp;quot;, &amp;quot;Helvetica Neue&amp;quot;, Helvetica, Arial, sans-serif; font-size: 15px; text-indent: 30px; white-space: normal;&quot;&gt;4：很多时候，seo的理论与现实是相违背的，也就是说seo的理论点不复杂，操作点却很难达到。&lt;/p&gt;&lt;p style=&quot;margin-top: 0px; margin-bottom: 15px; color: rgb(85, 85, 85); font-family: &amp;quot;Microsoft Yahei&amp;quot;, &amp;quot;Helvetica Neue&amp;quot;, Helvetica, Arial, sans-serif; font-size: 15px; text-indent: 30px; white-space: normal;&quot;&gt;新手接触seo，感觉无所适从，请熟读seo术语，后面会越来越轻松。&lt;/p&gt;&lt;p&gt;&lt;br/&gt;&lt;/p&gt;', '1547462542', '1547462542');
INSERT INTO `ey_article_content` VALUES ('5', '9', '&lt;p style=&quot;margin-top: 0px; margin-bottom: 24px; color: rgb(14, 14, 14); font-family: Arial, &amp;quot;Hiragino Sans GB&amp;quot;, 冬青黑, &amp;quot;Microsoft YaHei&amp;quot;, 微软雅黑, SimSun, 宋体, Helvetica, Tahoma, &amp;quot;Arial sans-serif&amp;quot;; text-align: justify; white-space: normal; background-color: rgb(255, 255, 255);&quot;&gt;&lt;span style=&quot;font-weight: 700;&quot;&gt;注：&lt;/span&gt;用户界面（UI，User Interface）设计是设计软件产品所涉及到的几个交叉学科之一。不论是用户体验（UX，User Experience）、交互设计（ID，Interaction Design），还是视觉/图形设计（Visual / Graphic Design），都能牵扯到用户界面设计。&lt;/p&gt;&lt;p style=&quot;margin-top: 0px; margin-bottom: 24px; color: rgb(14, 14, 14); font-family: Arial, &amp;quot;Hiragino Sans GB&amp;quot;, 冬青黑, &amp;quot;Microsoft YaHei&amp;quot;, 微软雅黑, SimSun, 宋体, Helvetica, Tahoma, &amp;quot;Arial sans-serif&amp;quot;; text-align: justify; white-space: normal; background-color: rgb(255, 255, 255);&quot;&gt;&lt;span style=&quot;color: rgb(54, 54, 54); font-family: Tahoma, Arial, &amp;quot;Hiragino Sans GB&amp;quot;, 冬青黑, &amp;quot;Microsoft YaHei&amp;quot;, 微软雅黑, SimSun, 宋体, Heiti, 黑体, sans-serif; font-size: 24px;&quot;&gt;一、什么是用户界面设计？&lt;/span&gt;&lt;/p&gt;&lt;p style=&quot;margin-top: 0px; margin-bottom: 24px; color: rgb(14, 14, 14); font-family: Arial, &amp;quot;Hiragino Sans GB&amp;quot;, 冬青黑, &amp;quot;Microsoft YaHei&amp;quot;, 微软雅黑, SimSun, 宋体, Helvetica, Tahoma, &amp;quot;Arial sans-serif&amp;quot;; text-align: justify; white-space: normal; background-color: rgb(255, 255, 255);&quot;&gt;广泛来讲，用户界面是人与机器交流的媒介。用户向机器发出指令，机器随即开始一段进程，回复信息，并给出反馈。用户可以根据用户反馈进行下一步操作的决策。&lt;/p&gt;&lt;p style=&quot;margin-top: 0px; margin-bottom: 24px; color: rgb(14, 14, 14); font-family: Arial, &amp;quot;Hiragino Sans GB&amp;quot;, 冬青黑, &amp;quot;Microsoft YaHei&amp;quot;, 微软雅黑, SimSun, 宋体, Helvetica, Tahoma, &amp;quot;Arial sans-serif&amp;quot;; text-align: justify; white-space: normal; background-color: rgb(255, 255, 255);&quot;&gt;人机交互（HCI，Human Computer Interaciton）所关注的主要是数字界面，即过去的打孔机、命令行，直至今天的图形界面（GUI，Graphic Design）。&lt;/p&gt;&lt;p style=&quot;margin-top: 0px; margin-bottom: 24px; color: rgb(14, 14, 14); font-family: Arial, &amp;quot;Hiragino Sans GB&amp;quot;, 冬青黑, &amp;quot;Microsoft YaHei&amp;quot;, 微软雅黑, SimSun, 宋体, Helvetica, Tahoma, &amp;quot;Arial sans-serif&amp;quot;; text-align: justify; white-space: normal; background-color: rgb(255, 255, 255);&quot;&gt;用户界面设计对于数码产品来说主要关注的是布局、信息结构，以及界面元素在显示屏和各种终端平台上的展示。电子游戏和电视界面也包括其中。&lt;/p&gt;&lt;p&gt;&lt;br/&gt;&lt;/p&gt;', '1526552582', '1531711820');
INSERT INTO `ey_article_content` VALUES ('15', '39', '&lt;p style=&quot;margin-top: 0px; margin-bottom: 32px; padding: 0px; text-align: justify; font-family: &amp;quot;Open Sans&amp;quot;, Arial, &amp;quot;Hiragino Sans GB&amp;quot;, &amp;quot;Microsoft YaHei&amp;quot;, 微软雅黑, STHeiti, &amp;quot;WenQuanYi Micro Hei&amp;quot;, SimSun, sans-serif, sans-serif; font-size: 18px; white-space: normal; background-color: rgb(255, 255, 255);&quot;&gt;对于记忆来说，味道往往是最美的，儿时喝过的饮料，至今回想起来依然觉得津津有味。&lt;br/&gt;&lt;/p&gt;&lt;p style=&quot;margin-top: 0px; margin-bottom: 32px; padding: 0px; text-align: justify; font-family: &amp;quot;Open Sans&amp;quot;, Arial, &amp;quot;Hiragino Sans GB&amp;quot;, &amp;quot;Microsoft YaHei&amp;quot;, 微软雅黑, STHeiti, &amp;quot;WenQuanYi Micro Hei&amp;quot;, SimSun, sans-serif, sans-serif; font-size: 18px; white-space: normal; background-color: rgb(255, 255, 255);&quot;&gt;今天是六一儿童节，青山资本梳理了中国40年来饮料发展的简史，权当节日的小消遣，顺便看看能否找到你记忆深处的那个味道？&lt;/p&gt;&lt;h2 style=&quot;margin: 0px; padding: 0px; font-size: 16px; font-family: &amp;quot;Open Sans&amp;quot;, Arial, &amp;quot;Hiragino Sans GB&amp;quot;, &amp;quot;Microsoft YaHei&amp;quot;, 微软雅黑, STHeiti, &amp;quot;WenQuanYi Micro Hei&amp;quot;, SimSun, sans-serif, sans-serif; white-space: normal; background-color: rgb(255, 255, 255);&quot;&gt;第一阶段：国人味蕾的开启时代&lt;/h2&gt;&lt;p style=&quot;margin-top: 0px; margin-bottom: 32px; padding: 0px; text-align: justify; font-family: &amp;quot;Open Sans&amp;quot;, Arial, &amp;quot;Hiragino Sans GB&amp;quot;, &amp;quot;Microsoft YaHei&amp;quot;, 微软雅黑, STHeiti, &amp;quot;WenQuanYi Micro Hei&amp;quot;, SimSun, sans-serif, sans-serif; font-size: 18px; white-space: normal; background-color: rgb(255, 255, 255);&quot;&gt;&lt;br/&gt;&lt;/p&gt;&lt;p style=&quot;margin-top: 0px; margin-bottom: 32px; padding: 0px; text-align: justify; font-family: &amp;quot;Open Sans&amp;quot;, Arial, &amp;quot;Hiragino Sans GB&amp;quot;, &amp;quot;Microsoft YaHei&amp;quot;, 微软雅黑, STHeiti, &amp;quot;WenQuanYi Micro Hei&amp;quot;, SimSun, sans-serif, sans-serif; font-size: 18px; white-space: normal; background-color: rgb(255, 255, 255);&quot;&gt;百事可乐在华第一家工厂开业&lt;/p&gt;&lt;p style=&quot;margin-top: 0px; margin-bottom: 32px; padding: 0px; text-align: justify; font-family: &amp;quot;Open Sans&amp;quot;, Arial, &amp;quot;Hiragino Sans GB&amp;quot;, &amp;quot;Microsoft YaHei&amp;quot;, 微软雅黑, STHeiti, &amp;quot;WenQuanYi Micro Hei&amp;quot;, SimSun, sans-serif, sans-serif; font-size: 18px; white-space: normal; background-color: rgb(255, 255, 255);&quot;&gt;1981年，可口可乐在中国第一条生产线正式投产，主要供应旅游饭店，卖给外国人收取外汇，百事可乐也在深圳建立了第一家罐装厂。&lt;/p&gt;&lt;p style=&quot;margin-top: 0px; margin-bottom: 32px; padding: 0px; text-align: justify; font-family: &amp;quot;Open Sans&amp;quot;, Arial, &amp;quot;Hiragino Sans GB&amp;quot;, &amp;quot;Microsoft YaHei&amp;quot;, 微软雅黑, STHeiti, &amp;quot;WenQuanYi Micro Hei&amp;quot;, SimSun, sans-serif, sans-serif; font-size: 18px; white-space: normal; background-color: rgb(255, 255, 255);&quot;&gt;1982年，国家把饮料纳入“国家计划管理产品”，可口可乐开始在北京市场进行内销。&lt;/p&gt;&lt;p&gt;&lt;br/&gt;&lt;/p&gt;', '1527824652', '1531709817');
INSERT INTO `ey_article_content` VALUES ('16', '40', '&lt;p style=&quot;margin-top: 0px; margin-bottom: 32px; padding: 0px; text-align: justify; font-family: &amp;quot;Open Sans&amp;quot;, Arial, &amp;quot;Hiragino Sans GB&amp;quot;, &amp;quot;Microsoft YaHei&amp;quot;, 微软雅黑, STHeiti, &amp;quot;WenQuanYi Micro Hei&amp;quot;, SimSun, sans-serif, sans-serif; font-size: 18px; white-space: normal; background-color: rgb(255, 255, 255);&quot;&gt;约翰·奎尔奇说， 社交媒体有很多营销挑战，如何为粉丝来估值是一个大问题。从营销角度来思考，要关注强纽带和弱纽带。你可能以为，强纽带的密友产生最大的营销影响，研究发现不是这样的，产生更大的影响反而是跟你更疏远的人。&lt;/p&gt;&lt;p&gt;&lt;span style=&quot;font-family: &amp;quot;Open Sans&amp;quot;, Arial, &amp;quot;Hiragino Sans GB&amp;quot;, &amp;quot;Microsoft YaHei&amp;quot;, 微软雅黑, STHeiti, &amp;quot;WenQuanYi Micro Hei&amp;quot;, SimSun, sans-serif, sans-serif; font-size: 18px; background-color: rgb(255, 255, 255);&quot;&gt;演讲者｜ 约翰·奎尔奇&lt;/span&gt;&lt;/p&gt;&lt;p style=&quot;margin-top: 0px; margin-bottom: 32px; padding: 0px; text-align: justify; font-family: &amp;quot;Open Sans&amp;quot;, Arial, &amp;quot;Hiragino Sans GB&amp;quot;, &amp;quot;Microsoft YaHei&amp;quot;, 微软雅黑, STHeiti, &amp;quot;WenQuanYi Micro Hei&amp;quot;, SimSun, sans-serif, sans-serif; font-size: 18px; white-space: normal; background-color: rgb(255, 255, 255);&quot;&gt;（ 哈佛商学院教授， 曾任伦敦商学院院长、中欧国际工商学院副院长）&lt;/p&gt;&lt;p style=&quot;margin-top: 0px; margin-bottom: 32px; padding: 0px; text-align: justify; font-family: &amp;quot;Open Sans&amp;quot;, Arial, &amp;quot;Hiragino Sans GB&amp;quot;, &amp;quot;Microsoft YaHei&amp;quot;, 微软雅黑, STHeiti, &amp;quot;WenQuanYi Micro Hei&amp;quot;, SimSun, sans-serif, sans-serif; font-size: 18px; white-space: normal; background-color: rgb(255, 255, 255);&quot;&gt;非常感谢大家在周日早上回来听我讲课。对于你们这些创业者，或者希望成为创业者的人，我今天准备了一个特别的讲座。&lt;/p&gt;&lt;p style=&quot;margin-top: 0px; margin-bottom: 32px; padding: 0px; text-align: justify; font-family: &amp;quot;Open Sans&amp;quot;, Arial, &amp;quot;Hiragino Sans GB&amp;quot;, &amp;quot;Microsoft YaHei&amp;quot;, 微软雅黑, STHeiti, &amp;quot;WenQuanYi Micro Hei&amp;quot;, SimSun, sans-serif, sans-serif; font-size: 18px; white-space: normal; background-color: rgb(255, 255, 255);&quot;&gt;很多创业者没有把最终愿景很好界定，所以每天都忙于灭火，忙于生存。&lt;/p&gt;&lt;p&gt;&lt;strong style=&quot;font-family: &amp;quot;Open Sans&amp;quot;, Arial, &amp;quot;Hiragino Sans GB&amp;quot;, &amp;quot;Microsoft YaHei&amp;quot;, 微软雅黑, STHeiti, &amp;quot;WenQuanYi Micro Hei&amp;quot;, SimSun, sans-serif, sans-serif; font-size: 18px; white-space: normal; background-color: rgb(255, 255, 255);&quot;&gt;创业营销，你必须做好规划&lt;/strong&gt;&lt;/p&gt;&lt;p style=&quot;margin-top: 0px; margin-bottom: 32px; padding: 0px; text-align: justify; font-family: &amp;quot;Open Sans&amp;quot;, Arial, &amp;quot;Hiragino Sans GB&amp;quot;, &amp;quot;Microsoft YaHei&amp;quot;, 微软雅黑, STHeiti, &amp;quot;WenQuanYi Micro Hei&amp;quot;, SimSun, sans-serif, sans-serif; font-size: 18px; white-space: normal; background-color: rgb(255, 255, 255);&quot;&gt;今天将从创业营销这个话题开始，包括你如何生存和成功。创业营销包括四个关键领域，你必须很好地去规划：&lt;/p&gt;&lt;ul style=&quot;list-style-type: inherit;&quot; class=&quot; list-paddingleft-2&quot;&gt;&lt;li&gt;&lt;p style=&quot;margin-top: 0px; margin-bottom: 0px; padding: 0px;&quot;&gt;要有正确的目标客户和最终用户；&lt;/p&gt;&lt;/li&gt;&lt;li&gt;&lt;p style=&quot;margin-top: 0px; margin-bottom: 0px; padding: 0px;&quot;&gt;要有正确的产品和服务&lt;/p&gt;&lt;/li&gt;&lt;li&gt;&lt;p style=&quot;margin-top: 0px; margin-bottom: 0px; padding: 0px;&quot;&gt;要有一个非常好的人才团队，使得商业创意能够实现；&lt;/p&gt;&lt;/li&gt;&lt;li&gt;&lt;p style=&quot;margin-top: 0px; margin-bottom: 0px; padding: 0px;&quot;&gt;要有好的合作伙伴，不是分销商，而是会计、律师等服务伙伴。&lt;/p&gt;&lt;/li&gt;&lt;/ul&gt;&lt;p style=&quot;margin-top: 0px; margin-bottom: 32px; padding: 0px; text-align: justify; font-family: &amp;quot;Open Sans&amp;quot;, Arial, &amp;quot;Hiragino Sans GB&amp;quot;, &amp;quot;Microsoft YaHei&amp;quot;, 微软雅黑, STHeiti, &amp;quot;WenQuanYi Micro Hei&amp;quot;, SimSun, sans-serif, sans-serif; font-size: 18px; white-space: normal; background-color: rgb(255, 255, 255);&quot;&gt;&lt;strong&gt;那么，何为创业营销？ ？&lt;/strong&gt;&lt;/p&gt;&lt;p style=&quot;margin-top: 0px; margin-bottom: 32px; padding: 0px; text-align: justify; font-family: &amp;quot;Open Sans&amp;quot;, Arial, &amp;quot;Hiragino Sans GB&amp;quot;, &amp;quot;Microsoft YaHei&amp;quot;, 微软雅黑, STHeiti, &amp;quot;WenQuanYi Micro Hei&amp;quot;, SimSun, sans-serif, sans-serif; font-size: 18px; white-space: normal; background-color: rgb(255, 255, 255);&quot;&gt;第一，这是从愿景到行动的逆向工程设计&lt;/p&gt;&lt;p style=&quot;margin-top: 0px; margin-bottom: 32px; padding: 0px; text-align: justify; font-family: &amp;quot;Open Sans&amp;quot;, Arial, &amp;quot;Hiragino Sans GB&amp;quot;, &amp;quot;Microsoft YaHei&amp;quot;, 微软雅黑, STHeiti, &amp;quot;WenQuanYi Micro Hei&amp;quot;, SimSun, sans-serif, sans-serif; font-size: 18px; white-space: normal; background-color: rgb(255, 255, 255);&quot;&gt;当星巴克只有 5 家店时，创始人就有一个愿景，让星巴克成为你生活中的第三空间。&lt;/p&gt;&lt;p style=&quot;margin-top: 0px; margin-bottom: 32px; padding: 0px; text-align: justify; font-family: &amp;quot;Open Sans&amp;quot;, Arial, &amp;quot;Hiragino Sans GB&amp;quot;, &amp;quot;Microsoft YaHei&amp;quot;, 微软雅黑, STHeiti, &amp;quot;WenQuanYi Micro Hei&amp;quot;, SimSun, sans-serif, sans-serif; font-size: 18px; white-space: normal; background-color: rgb(255, 255, 255);&quot;&gt;对创业者要从愿景开始，向后进行逆向工程的设计：看一下需要有什么样的行动，才能实现愿景。 很多创业者没有把最终愿景很好界定，所以每天都忙于灭火，忙于生存。&lt;/p&gt;&lt;p style=&quot;margin-top: 0px; margin-bottom: 32px; padding: 0px; text-align: justify; font-family: &amp;quot;Open Sans&amp;quot;, Arial, &amp;quot;Hiragino Sans GB&amp;quot;, &amp;quot;Microsoft YaHei&amp;quot;, 微软雅黑, STHeiti, &amp;quot;WenQuanYi Micro Hei&amp;quot;, SimSun, sans-serif, sans-serif; font-size: 18px; white-space: normal; background-color: rgb(255, 255, 255);&quot;&gt;第二，快速的周期，低成本进行试验，以提供证据&lt;/p&gt;&lt;p style=&quot;margin-top: 0px; margin-bottom: 32px; padding: 0px; text-align: justify; font-family: &amp;quot;Open Sans&amp;quot;, Arial, &amp;quot;Hiragino Sans GB&amp;quot;, &amp;quot;Microsoft YaHei&amp;quot;, 微软雅黑, STHeiti, &amp;quot;WenQuanYi Micro Hei&amp;quot;, SimSun, sans-serif, sans-serif; font-size: 18px; white-space: normal; background-color: rgb(255, 255, 255);&quot;&gt;有了愿景要去思考，怎样做一些快速的低成本实验测试创意，向合作伙伴、客户等证明，这是一个非常好的愿景。换句话说， 你需要短期的成就作为证据。&lt;/p&gt;&lt;p style=&quot;margin-top: 0px; margin-bottom: 32px; padding: 0px; text-align: justify; font-family: &amp;quot;Open Sans&amp;quot;, Arial, &amp;quot;Hiragino Sans GB&amp;quot;, &amp;quot;Microsoft YaHei&amp;quot;, 微软雅黑, STHeiti, &amp;quot;WenQuanYi Micro Hei&amp;quot;, SimSun, sans-serif, sans-serif; font-size: 18px; white-space: normal; background-color: rgb(255, 255, 255);&quot;&gt;第三，与高瞻远瞩的客户共同开发&lt;/p&gt;&lt;p style=&quot;margin-top: 0px; margin-bottom: 32px; padding: 0px; text-align: justify; font-family: &amp;quot;Open Sans&amp;quot;, Arial, &amp;quot;Hiragino Sans GB&amp;quot;, &amp;quot;Microsoft YaHei&amp;quot;, 微软雅黑, STHeiti, &amp;quot;WenQuanYi Micro Hei&amp;quot;, SimSun, sans-serif, sans-serif; font-size: 18px; white-space: normal; background-color: rgb(255, 255, 255);&quot;&gt;大多数的客户是保守的，不想浪费时间在新公司上。 你必须要找到有远见的客户，他们愿意在你身上冒风险。 他们可能是小的新兴客户，不是你想要进入的那个市场的好根基客户。&lt;/p&gt;&lt;p style=&quot;margin-top: 0px; margin-bottom: 32px; padding: 0px; text-align: justify; font-family: &amp;quot;Open Sans&amp;quot;, Arial, &amp;quot;Hiragino Sans GB&amp;quot;, &amp;quot;Microsoft YaHei&amp;quot;, 微软雅黑, STHeiti, &amp;quot;WenQuanYi Micro Hei&amp;quot;, SimSun, sans-serif, sans-serif; font-size: 18px; white-space: normal; background-color: rgb(255, 255, 255);&quot;&gt;第四：创建小步快跑的综合路线图&lt;/p&gt;&lt;p style=&quot;margin-top: 0px; margin-bottom: 32px; padding: 0px; text-align: justify; font-family: &amp;quot;Open Sans&amp;quot;, Arial, &amp;quot;Hiragino Sans GB&amp;quot;, &amp;quot;Microsoft YaHei&amp;quot;, 微软雅黑, STHeiti, &amp;quot;WenQuanYi Micro Hei&amp;quot;, SimSun, sans-serif, sans-serif; font-size: 18px; white-space: normal; background-color: rgb(255, 255, 255);&quot;&gt;包括创建产品路线图、客户图、合作伙伴路线图、人才路线图。 创业者应该有一个长达一年甚至三年的路线图，看下你希望这个公司在这四个维度上应该怎么样取得进步。&lt;/p&gt;&lt;p style=&quot;margin-top: 0px; margin-bottom: 32px; padding: 0px; text-align: justify; font-family: &amp;quot;Open Sans&amp;quot;, Arial, &amp;quot;Hiragino Sans GB&amp;quot;, &amp;quot;Microsoft YaHei&amp;quot;, 微软雅黑, STHeiti, &amp;quot;WenQuanYi Micro Hei&amp;quot;, SimSun, sans-serif, sans-serif; font-size: 18px; white-space: normal; background-color: rgb(255, 255, 255);&quot;&gt;&lt;strong&gt;举个例子&lt;/strong&gt;&lt;/p&gt;&lt;p style=&quot;margin-top: 0px; margin-bottom: 32px; padding: 0px; text-align: justify; font-family: &amp;quot;Open Sans&amp;quot;, Arial, &amp;quot;Hiragino Sans GB&amp;quot;, &amp;quot;Microsoft YaHei&amp;quot;, 微软雅黑, STHeiti, &amp;quot;WenQuanYi Micro Hei&amp;quot;, SimSun, sans-serif, sans-serif; font-size: 18px; white-space: normal; background-color: rgb(255, 255, 255);&quot;&gt;上世纪 90 年代末， John Osher 发明了 SpinBrush ，这是一个低成本的电动牙刷。因为 他洞察到市场上存在着一个很大的空白：普通手动牙刷每支两美元，电动牙刷要 50 美元。 但是这两者之间，没有任何中间产品。&lt;/p&gt;&lt;p style=&quot;margin-top: 0px; margin-bottom: 32px; padding: 0px; text-align: justify; font-family: &amp;quot;Open Sans&amp;quot;, Arial, &amp;quot;Hiragino Sans GB&amp;quot;, &amp;quot;Microsoft YaHei&amp;quot;, 微软雅黑, STHeiti, &amp;quot;WenQuanYi Micro Hei&amp;quot;, SimSun, sans-serif, sans-serif; font-size: 18px; white-space: normal; background-color: rgb(255, 255, 255);&quot;&gt;他想开发一个牙刷，价格介于两者之间。他思考了下新牙刷成功的性能标准：&lt;/p&gt;&lt;ul style=&quot;list-style-type: inherit;&quot; class=&quot; list-paddingleft-2&quot;&gt;&lt;li&gt;&lt;p style=&quot;margin-top: 0px; margin-bottom: 0px; padding: 0px;&quot;&gt;清洁上要优于手动牙刷，不然消费者不会付出更高的价格；&lt;/p&gt;&lt;/li&gt;&lt;li&gt;&lt;p style=&quot;margin-top: 0px; margin-bottom: 0px; padding: 0px;&quot;&gt;自带电池能用三个月，如果每周都要换电池太崩溃；&lt;/p&gt;&lt;/li&gt;&lt;li&gt;&lt;p style=&quot;margin-top: 0px; margin-bottom: 0px; padding: 0px;&quot;&gt;包装中有试用的特点，大家愿意看看牙刷启动后是怎么旋转的；&lt;/p&gt;&lt;/li&gt;&lt;li&gt;&lt;p style=&quot;margin-top: 0px; margin-bottom: 0px; padding: 0px;&quot;&gt;零售价不到 6 美元。&lt;/p&gt;&lt;/li&gt;&lt;/ul&gt;&lt;p style=&quot;margin-top: 0px; margin-bottom: 32px; padding: 0px; text-align: justify; font-family: &amp;quot;Open Sans&amp;quot;, Arial, &amp;quot;Hiragino Sans GB&amp;quot;, &amp;quot;Microsoft YaHei&amp;quot;, 微软雅黑, STHeiti, &amp;quot;WenQuanYi Micro Hei&amp;quot;, SimSun, sans-serif, sans-serif; font-size: 18px; white-space: normal; background-color: rgb(255, 255, 255);&quot;&gt;他对新牙刷的定位是：是更好的手动牙刷，而不是一个更便宜的电动牙刷。&lt;/p&gt;&lt;p style=&quot;margin-top: 0px; margin-bottom: 32px; padding: 0px; text-align: justify; font-family: &amp;quot;Open Sans&amp;quot;, Arial, &amp;quot;Hiragino Sans GB&amp;quot;, &amp;quot;Microsoft YaHei&amp;quot;, 微软雅黑, STHeiti, &amp;quot;WenQuanYi Micro Hei&amp;quot;, SimSun, sans-serif, sans-serif; font-size: 18px; white-space: normal; background-color: rgb(255, 255, 255);&quot;&gt;对于消费者，是从 2 美元增加到 6 美元，而不是从 50 美元降到 6 美元。因为如果是后者，零售商会觉得赔了：消费者只花了6美元，而以前是50美元。但是现在，消费者从花2块提高到了花6块。&lt;/p&gt;&lt;p style=&quot;margin-top: 0px; margin-bottom: 32px; padding: 0px; text-align: justify; font-family: &amp;quot;Open Sans&amp;quot;, Arial, &amp;quot;Hiragino Sans GB&amp;quot;, &amp;quot;Microsoft YaHei&amp;quot;, 微软雅黑, STHeiti, &amp;quot;WenQuanYi Micro Hei&amp;quot;, SimSun, sans-serif, sans-serif; font-size: 18px; white-space: normal; background-color: rgb(255, 255, 255);&quot;&gt;所以创业者不仅要考虑最终用户，还要思考如何让分销商多赚钱，因为你必须通过他们，产品才能到最终客户那里。 界定竞争的时候，好的定位声明非常重要。 最后，他把公司卖给了 宝洁，一共赚了4.8亿美元。&lt;/p&gt;&lt;p style=&quot;margin-top: 0px; margin-bottom: 32px; padding: 0px; text-align: justify; font-family: &amp;quot;Open Sans&amp;quot;, Arial, &amp;quot;Hiragino Sans GB&amp;quot;, &amp;quot;Microsoft YaHei&amp;quot;, 微软雅黑, STHeiti, &amp;quot;WenQuanYi Micro Hei&amp;quot;, SimSun, sans-serif, sans-serif; font-size: 18px; white-space: normal; background-color: rgb(255, 255, 255);&quot;&gt;大家看，其实非常简单，就是因为他有大量的消费者洞察，填补了没有任何人看见的市场空白。&lt;/p&gt;&lt;p style=&quot;margin-top: 0px; margin-bottom: 32px; padding: 0px; text-align: justify; font-family: &amp;quot;Open Sans&amp;quot;, Arial, &amp;quot;Hiragino Sans GB&amp;quot;, &amp;quot;Microsoft YaHei&amp;quot;, 微软雅黑, STHeiti, &amp;quot;WenQuanYi Micro Hei&amp;quot;, SimSun, sans-serif, sans-serif; font-size: 18px; white-space: normal; background-color: rgb(255, 255, 255);&quot;&gt;&lt;strong&gt;再举个例子&lt;/strong&gt;&lt;/p&gt;&lt;p style=&quot;margin-top: 0px; margin-bottom: 32px; padding: 0px; text-align: justify; font-family: &amp;quot;Open Sans&amp;quot;, Arial, &amp;quot;Hiragino Sans GB&amp;quot;, &amp;quot;Microsoft YaHei&amp;quot;, 微软雅黑, STHeiti, &amp;quot;WenQuanYi Micro Hei&amp;quot;, SimSun, sans-serif, sans-serif; font-size: 18px; white-space: normal; background-color: rgb(255, 255, 255);&quot;&gt;这家公司叫 Intuit ，创始人在20年前就发现，好多人在应对自己税务处理的时候，每年要填一个纳税申报单再交给政府，很麻烦。&lt;/p&gt;&lt;p style=&quot;margin-top: 0px; margin-bottom: 32px; padding: 0px; text-align: justify; font-family: &amp;quot;Open Sans&amp;quot;, Arial, &amp;quot;Hiragino Sans GB&amp;quot;, &amp;quot;Microsoft YaHei&amp;quot;, 微软雅黑, STHeiti, &amp;quot;WenQuanYi Micro Hei&amp;quot;, SimSun, sans-serif, sans-serif; font-size: 18px; white-space: normal; background-color: rgb(255, 255, 255);&quot;&gt;Intuit 是第一个开发个人理财软件的公司，尤其是做纳税管理方面的软件，不管是个人还是小企业都可以用。 但是这个好用的软件包，不知道卖向哪里，没人相信它能用。&lt;/p&gt;&lt;p style=&quot;margin-top: 0px; margin-bottom: 32px; padding: 0px; text-align: justify; font-family: &amp;quot;Open Sans&amp;quot;, Arial, &amp;quot;Hiragino Sans GB&amp;quot;, &amp;quot;Microsoft YaHei&amp;quot;, 微软雅黑, STHeiti, &amp;quot;WenQuanYi Micro Hei&amp;quot;, SimSun, sans-serif, sans-serif; font-size: 18px; white-space: normal; background-color: rgb(255, 255, 255);&quot;&gt;有时候你最大的问题就是，你的新产品如何把分销商搞定。他们分销很多东西，根本没时间花五小时检查你这个不知名的产品能不能用。&lt;/p&gt;&lt;p style=&quot;margin-top: 0px; margin-bottom: 32px; padding: 0px; text-align: justify; font-family: &amp;quot;Open Sans&amp;quot;, Arial, &amp;quot;Hiragino Sans GB&amp;quot;, &amp;quot;Microsoft YaHei&amp;quot;, 微软雅黑, STHeiti, &amp;quot;WenQuanYi Micro Hei&amp;quot;, SimSun, sans-serif, sans-serif; font-size: 18px; white-space: normal; background-color: rgb(255, 255, 255);&quot;&gt;最后他直接向消费者保证： 如果买了这个产品，六分钟内没学会怎么用，钱退给你，产品也送给你。&lt;/p&gt;&lt;p style=&quot;margin-top: 0px; margin-bottom: 32px; padding: 0px; text-align: justify; font-family: &amp;quot;Open Sans&amp;quot;, Arial, &amp;quot;Hiragino Sans GB&amp;quot;, &amp;quot;Microsoft YaHei&amp;quot;, 微软雅黑, STHeiti, &amp;quot;WenQuanYi Micro Hei&amp;quot;, SimSun, sans-serif, sans-serif; font-size: 18px; white-space: normal; background-color: rgb(255, 255, 255);&quot;&gt;除了退钱，他们还做了什么与众不同的事情呢？&lt;/p&gt;&lt;ul style=&quot;list-style-type: inherit;&quot; class=&quot; list-paddingleft-2&quot;&gt;&lt;li&gt;&lt;p style=&quot;margin-top: 0px; margin-bottom: 0px; padding: 0px;&quot;&gt;在买家允许下，跟着买家观察他的首次使用过程。&lt;/p&gt;&lt;/li&gt;&lt;li&gt;&lt;p style=&quot;margin-top: 0px; margin-bottom: 0px; padding: 0px;&quot;&gt;公司所有高管每个月必须花两小时做客户的技术支持，听客户遇到的问题；&lt;/p&gt;&lt;/li&gt;&lt;li&gt;&lt;p style=&quot;margin-top: 0px; margin-bottom: 0px; padding: 0px;&quot;&gt;做客户服务的技术支持，是公司里晋升的必经路径；&lt;/p&gt;&lt;/li&gt;&lt;li&gt;&lt;p style=&quot;margin-top: 0px; margin-bottom: 0px; padding: 0px;&quot;&gt;把客户的信当着所有高管的面大声朗读，不管是感谢还是指责。&lt;/p&gt;&lt;/li&gt;&lt;/ul&gt;&lt;p style=&quot;margin-top: 0px; margin-bottom: 32px; padding: 0px; text-align: justify; font-family: &amp;quot;Open Sans&amp;quot;, Arial, &amp;quot;Hiragino Sans GB&amp;quot;, &amp;quot;Microsoft YaHei&amp;quot;, 微软雅黑, STHeiti, &amp;quot;WenQuanYi Micro Hei&amp;quot;, SimSun, sans-serif, sans-serif; font-size: 18px; white-space: normal; background-color: rgb(255, 255, 255);&quot;&gt;这使得他们 50% 的销售是来自于口碑， 20% 的销售是来自于技术支持的推荐。&lt;/p&gt;&lt;p style=&quot;margin-top: 0px; margin-bottom: 32px; padding: 0px; text-align: justify; font-family: &amp;quot;Open Sans&amp;quot;, Arial, &amp;quot;Hiragino Sans GB&amp;quot;, &amp;quot;Microsoft YaHei&amp;quot;, 微软雅黑, STHeiti, &amp;quot;WenQuanYi Micro Hei&amp;quot;, SimSun, sans-serif, sans-serif; font-size: 18px; white-space: normal; background-color: rgb(255, 255, 255);&quot;&gt;&lt;em&gt;“ 客户真正想要的和技术真正能做好的交叉点 —— 在此处才能找到真正的伟大。 ”&lt;/em&gt;&lt;/p&gt;&lt;p style=&quot;margin-top: 0px; margin-bottom: 32px; padding: 0px; text-align: justify; font-family: &amp;quot;Open Sans&amp;quot;, Arial, &amp;quot;Hiragino Sans GB&amp;quot;, &amp;quot;Microsoft YaHei&amp;quot;, 微软雅黑, STHeiti, &amp;quot;WenQuanYi Micro Hei&amp;quot;, SimSun, sans-serif, sans-serif; font-size: 18px; white-space: normal; background-color: rgb(255, 255, 255);&quot;&gt;&lt;em&gt;“ 我们不管做什么，都是有客户存在的。 ”&lt;/em&gt;&lt;/p&gt;&lt;p style=&quot;margin-top: 0px; margin-bottom: 32px; padding: 0px; text-align: justify; font-family: &amp;quot;Open Sans&amp;quot;, Arial, &amp;quot;Hiragino Sans GB&amp;quot;, &amp;quot;Microsoft YaHei&amp;quot;, 微软雅黑, STHeiti, &amp;quot;WenQuanYi Micro Hei&amp;quot;, SimSun, sans-serif, sans-serif; font-size: 18px; white-space: normal; background-color: rgb(255, 255, 255);&quot;&gt;&lt;em&gt;——ScottCook（ Intuit创始人）&lt;/em&gt;&lt;/p&gt;&lt;p&gt;&lt;br/&gt;&lt;/p&gt;', '1547462596', '1547462596');
INSERT INTO `ey_article_content` VALUES ('17', '41', '&lt;p style=&quot;margin-top: 0px; margin-bottom: 32px; padding: 0px; text-align: justify; font-family: &amp;quot;Open Sans&amp;quot;, Arial, &amp;quot;Hiragino Sans GB&amp;quot;, &amp;quot;Microsoft YaHei&amp;quot;, 微软雅黑, STHeiti, &amp;quot;WenQuanYi Micro Hei&amp;quot;, SimSun, sans-serif, sans-serif; font-size: 18px; white-space: normal; background-color: rgb(255, 255, 255);&quot;&gt;各种行销手段早已令人眼花缭乱，但究其本质都是在研究客户（消费者），研究客户的所想、所需，使产品或服务有的放矢。大数据时代又给它赋予了新名词：精准营销。大数据最先应用的领域多为面对客户的行业，最先应用的情景也多为精准营销。&lt;/p&gt;&lt;p style=&quot;margin-top: 0px; margin-bottom: 32px; padding: 0px; text-align: justify; font-family: &amp;quot;Open Sans&amp;quot;, Arial, &amp;quot;Hiragino Sans GB&amp;quot;, &amp;quot;Microsoft YaHei&amp;quot;, 微软雅黑, STHeiti, &amp;quot;WenQuanYi Micro Hei&amp;quot;, SimSun, sans-serif, sans-serif; font-size: 18px; white-space: normal; background-color: rgb(255, 255, 255);&quot;&gt;“酒好也怕巷子深”，产品或服务的信息要送达客户才可能促成交易。一般认为，向客户传达产品或服务信息要靠广告。广告古已有之，“三碗不过岗”的酒幌子就是广告。没有互联网的时代，我们熟悉的是电视广告、广播广告、印刷品平面广告、户外广告牌等，当然，也包括吆喝叫卖。但过去的广告是千人一面、不区分受众的。后来商家对客户的信息有所采集就有了CRM，经过客户分类，可以更好地服务于不同的客户群体。互联网+大数据时代让CRM有了新的发展机遇，管理客户不再是简单的数字统计和没有个性的（或简单聚类的）直邮、定投。随着商家对客户知道更多、了解更深，便有机会为客户提供个性化的营销方案，进一步改善客户体验，成为了个性化营销或叫精准营销。大数据时代，让很多过去的不可能变为可能，营销活动也赢来了新的发展机遇。&lt;/p&gt;&lt;p style=&quot;margin-top: 0px; margin-bottom: 32px; padding: 0px; text-align: justify; font-family: &amp;quot;Open Sans&amp;quot;, Arial, &amp;quot;Hiragino Sans GB&amp;quot;, &amp;quot;Microsoft YaHei&amp;quot;, 微软雅黑, STHeiti, &amp;quot;WenQuanYi Micro Hei&amp;quot;, SimSun, sans-serif, sans-serif; font-size: 18px; white-space: normal; background-color: rgb(255, 255, 255);&quot;&gt;时代不同，商业经营的形式会变化，但本质就是两件事：开源，节流。开源是开拓新客户，发现新商机；节流是减少内部运营成本，提高资源利用效率。要实现这一切都需要以数据为依据的决策。过去，人们也在长期的经营活动中，采集和运用了与经营活动相关的很多强相关数据，也形成了选择客户的标准。鉴于当时的技术瓶颈，做大样本的数据采集及数据分析成本都过高，无法在更大范围推广运用。大数据时代，人们有了廉价采集数据和存储数据的可能，廉价的计算资源让数据分析成为了可能。&lt;/p&gt;&lt;p style=&quot;margin-top: 0px; margin-bottom: 32px; padding: 0px; text-align: justify; font-family: &amp;quot;Open Sans&amp;quot;, Arial, &amp;quot;Hiragino Sans GB&amp;quot;, &amp;quot;Microsoft YaHei&amp;quot;, 微软雅黑, STHeiti, &amp;quot;WenQuanYi Micro Hei&amp;quot;, SimSun, sans-serif, sans-serif; font-size: 18px; white-space: normal; background-color: rgb(255, 255, 255);&quot;&gt;大数据精准营销的背后，是用多维度的数据来观察客户，描述客户，就是说为客户画像。说“依托大数据，可以让营销人员比过去更了解客户，比客户自己更了解客户的需求”并不为过。营销人员无不想知道客户是谁、在哪里、消费习惯是什么、需要什么、什么时候需要、用什么方式向他们传递信息更为有效等等，通过数据采集和数据分析分析可以找到答案。精准营销不仅可以帮助商家开源---发现潜在客户，还可以帮助商家节流---发现潜在风险。当我们对客户了解更多，就会知道哪位客户可能在经营中存在风险。&lt;/p&gt;&lt;p style=&quot;margin-top: 0px; margin-bottom: 32px; padding: 0px; text-align: justify; font-family: &amp;quot;Open Sans&amp;quot;, Arial, &amp;quot;Hiragino Sans GB&amp;quot;, &amp;quot;Microsoft YaHei&amp;quot;, 微软雅黑, STHeiti, &amp;quot;WenQuanYi Micro Hei&amp;quot;, SimSun, sans-serif, sans-serif; font-size: 18px; white-space: normal; background-color: rgb(255, 255, 255);&quot;&gt;若问每个经营者是否会运用从业经验来进行营销，多数答案是肯定的。但若问经营者是否会利用数据进行营销，恐怕答案就是五花八门。一般认为，应用数据进行营销是大公司的事情，与小公司无缘。其实，大到跨国公司，小到街边小贩，运用数据进行营销，都会收到意想不到的结果。不相信吗？街边小贩留意一下天气预报（刮风，下雨，还是暴晒）就知道明天有哪些生意的机会，进而知道该如何备货。建议中小公司的人不要拒绝精准营销的理念，不妨学学精准营销的思想方法。即便是经营者有丰富的经验，把经验数据化对经营也会很有帮助。&lt;/p&gt;&lt;p style=&quot;margin-top: 0px; margin-bottom: 32px; padding: 0px; text-align: justify; font-family: &amp;quot;Open Sans&amp;quot;, Arial, &amp;quot;Hiragino Sans GB&amp;quot;, &amp;quot;Microsoft YaHei&amp;quot;, 微软雅黑, STHeiti, &amp;quot;WenQuanYi Micro Hei&amp;quot;, SimSun, sans-serif, sans-serif; font-size: 18px; white-space: normal; background-color: rgb(255, 255, 255);&quot;&gt;《颠覆营销》一书就是在教读者如何运用大数据来做营销。书中案例丰富、语言可读性强。值得关心大数据营销的各界朋友读一读。&lt;/p&gt;&lt;p style=&quot;margin-top: 0px; margin-bottom: 32px; padding: 0px; text-align: justify; font-family: &amp;quot;Open Sans&amp;quot;, Arial, &amp;quot;Hiragino Sans GB&amp;quot;, &amp;quot;Microsoft YaHei&amp;quot;, 微软雅黑, STHeiti, &amp;quot;WenQuanYi Micro Hei&amp;quot;, SimSun, sans-serif, sans-serif; font-size: 18px; white-space: normal; background-color: rgb(255, 255, 255);&quot;&gt;我认同书中的不少观点：“大数据重新定义产业竞争规则，比的不是数据规模大小，不是统计技术，也不是强大的计算能力，而是核心数据的解读能力”。在很多人纠结于大数据定义的今天，我们确实更应该关注数据的核心价值理解与应用。书中提出的“问对问题”也很重要。经营者平时的问题一定不少，但追问究竟时，就可能出现偏差，导致“失之毫厘谬以千里”。问对问题能力的提高涉及思想方法，需要在锻炼中提高。验证问题是否问对了，恰恰就是数据分析师可以做贡献的地方。&lt;/p&gt;&lt;p style=&quot;margin-top: 0px; margin-bottom: 32px; padding: 0px; text-align: justify; font-family: &amp;quot;Open Sans&amp;quot;, Arial, &amp;quot;Hiragino Sans GB&amp;quot;, &amp;quot;Microsoft YaHei&amp;quot;, 微软雅黑, STHeiti, &amp;quot;WenQuanYi Micro Hei&amp;quot;, SimSun, sans-serif, sans-serif; font-size: 18px; white-space: normal; background-color: rgb(255, 255, 255);&quot;&gt;本书还引起了二个值得更深入思考的问题：&lt;/p&gt;&lt;p style=&quot;margin-top: 0px; margin-bottom: 32px; padding: 0px; text-align: justify; font-family: &amp;quot;Open Sans&amp;quot;, Arial, &amp;quot;Hiragino Sans GB&amp;quot;, &amp;quot;Microsoft YaHei&amp;quot;, 微软雅黑, STHeiti, &amp;quot;WenQuanYi Micro Hei&amp;quot;, SimSun, sans-serif, sans-serif; font-size: 18px; white-space: normal; background-color: rgb(255, 255, 255);&quot;&gt;仅仅发现不同客户群体的消费习惯，适时提醒客户去消费，还远远不够。比如：某消费者一个月的正常理性消费在两千元的水平，一般在A，B两家商店消费。A商店运用了精准营销的理念会让消费者把这两千元都花在A商店，随着B商店的后来居上，消费者又可能重新回到B商店消费这两千元。在供给过剩需求不足的今天，既有的消费额在不同商家中进行分配或迁移都不能带来社会消费总量的增加。大数据营销的更高水平应用是提前知晓客户尚未被满足、甚至尚未被发现的需求。大数据的价值挖掘有机会把商家（含厂家）和客户连在一起，让商家提供更多的满足客户个性化需求的产品或服务，让客户的消费意愿提高。这是数据价值挖掘工作者面临的新挑战。&lt;/p&gt;&lt;p style=&quot;margin-top: 0px; margin-bottom: 32px; padding: 0px; text-align: justify; font-family: &amp;quot;Open Sans&amp;quot;, Arial, &amp;quot;Hiragino Sans GB&amp;quot;, &amp;quot;Microsoft YaHei&amp;quot;, 微软雅黑, STHeiti, &amp;quot;WenQuanYi Micro Hei&amp;quot;, SimSun, sans-serif, sans-serif; font-size: 18px; white-space: normal; background-color: rgb(255, 255, 255);&quot;&gt;数据真的越多越好吗？不少大数据公司热衷于用爬虫软件在网上“爬”各种数据。然而同一数据集在不同的应用场景价值密度是不一样的，针对特定应用场景也并非是数据维度越多就越好，一定要围绕应用目标来采集数据和使用数据。提升维度来采集更多数据一定是有助于更详尽地描述事物，但无疑也增加了处理数据的复杂性。每一次技术的进步，都给人类带来新的想象空间，难免欲望膨胀自信满满，对世界的认知也随之升维，甚至是无节制地升维。之后发现升维带来资源的占用，智慧跟不上，无节制地升维反而是解决方案复杂化，冷静下来会重新启动降维思考。也许人类的认知与智慧就是在升维、降维、再升维、再降维中交替前行的。本书的降维思考，必要时回归本元的思考给人们启示。&lt;/p&gt;&lt;p style=&quot;margin-top: 0px; margin-bottom: 32px; padding: 0px; text-align: justify; font-family: &amp;quot;Open Sans&amp;quot;, Arial, &amp;quot;Hiragino Sans GB&amp;quot;, &amp;quot;Microsoft YaHei&amp;quot;, 微软雅黑, STHeiti, &amp;quot;WenQuanYi Micro Hei&amp;quot;, SimSun, sans-serif, sans-serif; font-size: 18px; white-space: normal; background-color: rgb(255, 255, 255);&quot;&gt;大数据时代工具手段固然重要，思想方法更为重要。&lt;/p&gt;&lt;p&gt;&lt;br/&gt;&lt;/p&gt;', '1527825125', '1527825125');
INSERT INTO `ey_article_content` VALUES ('6', '10', '&lt;p style=&quot;margin-top: 0px; margin-bottom: 24px; color: rgb(14, 14, 14); font-family: Arial, &amp;quot;Hiragino Sans GB&amp;quot;, 冬青黑, &amp;quot;Microsoft YaHei&amp;quot;, 微软雅黑, SimSun, 宋体, Helvetica, Tahoma, &amp;quot;Arial sans-serif&amp;quot;; text-align: justify; white-space: normal; background-color: rgb(255, 255, 255);&quot;&gt;Z Yuhan：用户界面（UI，User Interface）设计是设计软件产品所涉及到的几个交叉学科之一。不论是用户体验（UX，User Experience）、交互设计（ID，Interaction Design），还是视觉/图形设计（Visual / Graphic Design），都能牵扯到用户界面设计。&lt;/p&gt;&lt;h4 style=&quot;margin: 28px 0px 14px; color: rgb(54, 54, 54); padding-left: 15px; border-left: 5px solid rgb(255, 200, 31); background-color: rgb(255, 255, 255); font-size: 24px; font-family: Tahoma, Arial, &amp;quot;Hiragino Sans GB&amp;quot;, 冬青黑, &amp;quot;Microsoft YaHei&amp;quot;, 微软雅黑, SimSun, 宋体, Heiti, 黑体, sans-serif; line-height: 32px; white-space: normal;&quot;&gt;一、什么是用户界面设计？&lt;/h4&gt;&lt;p style=&quot;margin-top: 0px; margin-bottom: 24px; color: rgb(14, 14, 14); font-family: Arial, &amp;quot;Hiragino Sans GB&amp;quot;, 冬青黑, &amp;quot;Microsoft YaHei&amp;quot;, 微软雅黑, SimSun, 宋体, Helvetica, Tahoma, &amp;quot;Arial sans-serif&amp;quot;; text-align: justify; white-space: normal; background-color: rgb(255, 255, 255);&quot;&gt;广泛来讲，用户界面是人与机器交流的媒介。用户向机器发出指令，机器随即开始一段进程，回复信息，并给出反馈。用户可以根据用户反馈进行下一步操作的决策。&lt;/p&gt;&lt;p style=&quot;margin-top: 0px; margin-bottom: 24px; color: rgb(14, 14, 14); font-family: Arial, &amp;quot;Hiragino Sans GB&amp;quot;, 冬青黑, &amp;quot;Microsoft YaHei&amp;quot;, 微软雅黑, SimSun, 宋体, Helvetica, Tahoma, &amp;quot;Arial sans-serif&amp;quot;; text-align: justify; white-space: normal; background-color: rgb(255, 255, 255);&quot;&gt;人机交互（HCI，Human Computer Interaciton）所关注的主要是数字界面，即过去的打孔机、命令行，直至今天的图形界面（GUI，Graphic Design）。&lt;/p&gt;&lt;p style=&quot;margin-top: 0px; margin-bottom: 24px; color: rgb(14, 14, 14); font-family: Arial, &amp;quot;Hiragino Sans GB&amp;quot;, 冬青黑, &amp;quot;Microsoft YaHei&amp;quot;, 微软雅黑, SimSun, 宋体, Helvetica, Tahoma, &amp;quot;Arial sans-serif&amp;quot;; text-align: justify; white-space: normal; background-color: rgb(255, 255, 255);&quot;&gt;用户界面设计对于数码产品来说主要关注的是布局、信息结构，以及界面元素在显示屏和各种终端平台上的展示。电子游戏和电视界面也包括其中。&lt;/p&gt;&lt;p&gt;&lt;br/&gt;&lt;/p&gt;', '1526552685', '1531711845');
INSERT INTO `ey_article_content` VALUES ('7', '12', '&lt;p&gt;北京时间 5 月 31 日凌晨，有“互联网女皇”之称的玛丽·米克尔发布了 2018 年的互联网趋势报告，这也是她第 23 年公布互联网报告。&lt;br/&gt;&lt;/p&gt;&lt;p&gt;每年的互联网女皇报告几乎都会成为每个互联网创业者的必读报告。那么，互联网女皇是谁?为什么她的报告会如此受关注呢?&lt;/p&gt;&lt;p&gt;&lt;strong&gt;互联网女皇： 90 年代华尔街的象征&lt;/strong&gt;&lt;/p&gt;&lt;p&gt;1958 年 9 月，玛丽·米克尔(Mary Meeker)出生于美国印第安纳州。&lt;/p&gt;&lt;p&gt;1982 年，米克尔加入了当时最负盛名的券商美林公司，担任股票经纪人。&lt;/p&gt;&lt;p&gt;米克尔的明星分析师之路开始于 1991 年，这年她加入了知名投行摩根士丹利，开始了自己辉煌的科技分析师生涯。&lt;/p&gt;&lt;p&gt;自 1995 年以来，米克尔的工作随着网络潮流变化而变化，她逐重于研究雅虎、美国在线及亚马孙等知名公司将如何调整结构并相互竞争。&lt;/p&gt;&lt;p&gt;1996 年，玛丽·米克尔如愿地成为摩根·斯坦利技术股票分析部的负责人，还创造出了华尔街闪耀的新职业——互联网分析师。就像垃圾债券代表了 80 年代华尔街一样，玛丽·米克尔成了 90 年代华尔街的象征。&lt;/p&gt;&lt;p&gt;2010 年底，米克尔辞去摩根士丹利董事总经理的职位，离开华尔街，去到加州成为知名风投KPCB的合伙人。KPCB公司(Kleiner\r\n Perkins Caufield &amp;amp; Byers)成立于 1972 年，是美国最大的风险基金，其最得意的杰作是网景公司的创立。&lt;/p&gt;&lt;p&gt;&lt;strong&gt;互联网女皇报告：互联网领域的投资圣经、选股指南&lt;/strong&gt;&lt;/p&gt;&lt;p&gt;1994 年，米克尔在《纽约时报》上偶然看到一篇讲述创业公司Mosaic研发网络浏览器的报道。米克尔立即意识到，这种网络浏览器可能会改变人们获取信息的方式。她随后就联系了Mosaic的两位创始人，并向华尔街投资者大力介绍这家公司。&lt;/p&gt;&lt;p&gt;Mosaic后来改名为网景，并在 1995 年在纽约上市。得益于米克尔与网景两位创始人的良好关系，摩根士丹利成为网景首次公开募股(IPO)的主承销商。&lt;/p&gt;&lt;p&gt;当年 8 月 9 日，网景上市首日收盘，股价从 14 美元的发行价暴增至 75 美元，创下了当时的上市公司首日涨幅记录。当年网景IPO也成为互联网时代到来的一大标志。&lt;/p&gt;&lt;p&gt;1995 年，除了负责网景的上市交易外，米克尔还与同事克里斯o德普开始发布《互联网报告》，并最早提出了“页面浏览量”等网络类股分析指标。这份报告被投资者视为互联网领域的投资圣经，并且成书公开发行，在整个科技行业引发了巨大反响。&lt;/p&gt;&lt;p&gt;1996- 1997 年，米克尔和摩根士丹利发布了《互联网广告报告》与《互联网零售业报告》，一举奠定了米克尔互联网领域第一分析师的地位。互联网女皇报告几乎成为当时每个互联网创业者的必读报告。&lt;/p&gt;&lt;p&gt;互联网女皇报告，无异于选股指南。她向投资者推荐的美国在线、戴尔、亚马逊、eBay等公司股票，都很快带来了超过十倍的投资回报。&lt;/p&gt;&lt;p&gt;&lt;strong&gt;互联网女皇报告中的“神预测”&lt;/strong&gt;&lt;/p&gt;&lt;p&gt;业界如此看重互联网女皇报告的最主要原因，在于米克尔的那些神预测。以下，我们简单罗列了几点互联网女皇报告中的神预测例子。&lt;/p&gt;', '1547462473', '1547462473');
INSERT INTO `ey_article_content` VALUES ('8', '13', '&lt;p style=&quot;box-sizing: border-box; margin-top: 0px; margin-bottom: 15px; white-space: normal; background-color: rgb(255, 255, 255); padding: 0px; line-height: 30px; color: rgb(51, 51, 51); font-family: 宋体; font-size: 14px;&quot;&gt;网站建设的五大核心要素&lt;/p&gt;&lt;p style=&quot;box-sizing: border-box; margin-top: 0px; margin-bottom: 15px; white-space: normal; background-color: rgb(255, 255, 255); padding: 0px; line-height: 30px; color: rgb(51, 51, 51); font-family: 宋体; font-size: 14px;&quot;&gt;&lt;img src=&quot;/uploads/ueditor/20190114/75c3c73acccc98cc5553d39eabf5fb38.jpg&quot; title=&quot;75c3c73acccc98cc5553d39eabf5fb38.jpg&quot; alt=&quot;75c3c73acccc98cc5553d39eabf5fb38.jpg&quot;/&gt;&lt;/p&gt;&lt;p style=&quot;box-sizing: border-box; margin-top: 0px; margin-bottom: 15px; white-space: normal; background-color: rgb(255, 255, 255); padding: 0px; line-height: 30px; color: rgb(51, 51, 51); font-family: 宋体; font-size: 14px;&quot;&gt;　　企业要实行网络营销，首先需要进行网站制作。网站是由众多的Web页面组成的，而这些页面设计的好坏，直接影响到这个网站能否得到用户的欢迎。判断一个主页设计的好坏，要从多方面综合考虑，不能仅仅看它设计得是否生动漂亮，而应该看这个网站能否最大限度地替用户考虑。&lt;/p&gt;&lt;p&gt;&lt;img alt=&quot;&quot; class=&quot;limg&quot; src=&quot;http://www.eyoucms.com/uploads/allimg/180426/1510032P3-1.jpg&quot;/&gt;&lt;/p&gt;&lt;p style=&quot;box-sizing: border-box; margin-top: 0px; margin-bottom: 15px; white-space: normal; background-color: rgb(255, 255, 255); padding: 0px; line-height: 30px; color: rgb(51, 51, 51); font-family: 宋体; font-size: 14px;&quot;&gt;　　3、以产品为核心原则&lt;/p&gt;&lt;p style=&quot;box-sizing: border-box; margin-top: 0px; margin-bottom: 15px; white-space: normal; background-color: rgb(255, 255, 255); padding: 0px; line-height: 30px; color: rgb(51, 51, 51); font-family: 宋体; font-size: 14px;&quot;&gt;　　网站制作最重要的目的及功能就是为产品展示。顾客访问网站的主要目的是为了对产品和服务进行深入的了解，网站的价值也就在于灵活地向用户展示产品说明及图片甚至多媒体信息，即使一个功能简单的网站至少也相当于一本可以随时更新的产品宣传资料。过时的产品信息或者产品信息不完善不仅无法促进销售，同时也影响顾客的信心。顾客在访问网站时，关心的不是个人的信息，而是能够提供什么样的产品、产品的优势是什么。所以，以产品为核心是网站成功的一首要前提。&lt;/p&gt;&lt;p style=&quot;box-sizing: border-box; margin-top: 0px; margin-bottom: 15px; white-space: normal; background-color: rgb(255, 255, 255); padding: 0px; line-height: 30px; color: rgb(51, 51, 51); font-family: 宋体; font-size: 14px;&quot;&gt;　　产品信息一般应该包括以下几方面内容：产品名称产品规格、产品用途、产品特性、产品认证情况及产品图片等。其次，产品规格、产品用途和产品特性等信息应尽可能详细地描述。&lt;/p&gt;&lt;p style=&quot;box-sizing: border-box; margin-top: 0px; margin-bottom: 15px; white-space: normal; background-color: rgb(255, 255, 255); padding: 0px; line-height: 30px; color: rgb(51, 51, 51); font-family: 宋体; font-size: 14px;&quot;&gt;　　4、以网站的信息交互能力强为原则&lt;/p&gt;&lt;p style=&quot;box-sizing: border-box; margin-top: 0px; margin-bottom: 15px; white-space: normal; background-color: rgb(255, 255, 255); padding: 0px; line-height: 30px; color: rgb(51, 51, 51); font-family: 宋体; font-size: 14px;&quot;&gt;　　如果一个网站只能提供浏览者浏览，而不能引导浏览者参与到网站内容的一部分建设中，那么它的吸引力是有限的。只有当浏览者能够很方便地和信息发布者交流信息时，该网站的魅力才能充分体现出来。虚拟论坛的设计在产品使用者之间、产品使用者与产品开发经理之间展开对产品的各种讨论。在线营销人员还可以借此收集市场信息，制定有效的营销计划。而网站消费者的反馈信息直接在网上公布，能够吸引消费者回访该网站，并由此可形成与顾客的固定关系。&lt;/p&gt;&lt;p style=&quot;box-sizing: border-box; margin-top: 0px; margin-bottom: 15px; white-space: normal; background-color: rgb(255, 255, 255); padding: 0px; line-height: 30px; color: rgb(51, 51, 51); font-family: 宋体; font-size: 14px;&quot;&gt;　　当顾客在网上找到感兴趣的产品时，如何针对该产品及时进行询价和反馈?这不仅仅是通过电子函件方式就能够实现的。网站上应该提供相应的信息反馈模块，使顾客能够针对某个或多个产品方便快捷地进行询价或反馈。同时，企业的业务员应该能够及时查到顾客的反馈信息并及时回复：每个业务部门或业务员应该能够针对其发布的产品，方便地管理顾客的信息和反馈信息。通过网站可以为顾客提供各种在线服务和帮助信息，比如常见问题解答(FAQ)、详尽的联系信息、在线填写寻求帮助的表单、通过聊天实时回答顾客的咨询等。同时，利用网站还可以实现增进顾客关系的目的，比如通过发行各种免费邮件列表、提供有奖竞猜等方式吸引用户的参与。通过网站上的在线调查表，可以获得用户的反馈信息，用于产品调查、消费者行为调查、品牌形象调查等，是获得第一手市场资料有效的调查工具。&lt;/p&gt;&lt;p style=&quot;box-sizing: border-box; margin-top: 0px; margin-bottom: 15px; white-space: normal; background-color: rgb(255, 255, 255); padding: 0px; line-height: 30px; color: rgb(51, 51, 51); font-family: 宋体; font-size: 14px;&quot;&gt;　　5、以完善的检索能力为原则&lt;/p&gt;&lt;p style=&quot;box-sizing: border-box; margin-top: 0px; margin-bottom: 15px; white-space: normal; background-color: rgb(255, 255, 255); padding: 0px; line-height: 30px; color: rgb(51, 51, 51); font-family: 宋体; font-size: 14px;&quot;&gt;　　对于一个网站来说，如何合理地组织自己要发布的信息内容，以便让浏览者能够快速、准确地找到要找的信息，这是一个网站内容组织是否成功的关键。如果网站的结构设计不能使顾客方便、快捷地找到所需的信息，再好的设计也不能吸引长久的客户。即使将他吸引到了网站主页，将来也会中断访问。为了达到上述设计目标，一些网站在网页上设计了信息索引和目录索引。使用者能很快地找到感兴趣的那部分信息。&lt;/p&gt;&lt;p style=&quot;box-sizing: border-box; margin-top: 0px; margin-bottom: 15px; white-space: normal; background-color: rgb(255, 255, 255); padding: 0px; line-height: 30px; color: rgb(51, 51, 51); font-family: 宋体; font-size: 14px;&quot;&gt;　　因此，为了网站内容的实用，有一定规模的网站一定要提供检索功能，以便于用户查找本网站的信息。为了给浏览者创造方便条件，网页设计者经常将网页内容设计成树形结构，方便纵向查询。访问者从主页开始就可以层层深入到所有“树权”和“树梢”的信息内容。另外，还可以设计一个搜索系统，让访问者很容易地就找到相关的内容。网址的搜索系统，设计应相当周全，允许访问者从任一页面进入。同时，在网站的任何一个页面都要设计有“返回主页”的链接，以方便访问者回到“树干”。&lt;/p&gt;&lt;p&gt;&lt;br/&gt;&lt;/p&gt;', '1547462639', '1547462639');
INSERT INTO `ey_article_content` VALUES ('9', '14', '&lt;p style=&quot;box-sizing: border-box; margin-top: 0px; margin-bottom: 15px; white-space: normal; background-color: rgb(255, 255, 255); padding: 0px; line-height: 30px; color: rgb(51, 51, 51); font-family: 宋体; font-size: 14px;&quot;&gt;网站建设，静态页面和动态页面如何选择&lt;/p&gt;&lt;p style=&quot;box-sizing: border-box; margin-top: 0px; margin-bottom: 15px; white-space: normal; background-color: rgb(255, 255, 255); padding: 0px; line-height: 30px; color: rgb(51, 51, 51); font-family: 宋体; font-size: 14px;&quot;&gt;　　电商网站建设为什么要使用静态页面制作。我们都知道，网站制作有分为静态页面制作和动态网页制作，那么建设电商网站采用哪种网站设计技术更好呢?&lt;/p&gt;&lt;p style=&quot;box-sizing: border-box; margin-top: 0px; margin-bottom: 15px; white-space: normal; background-color: rgb(255, 255, 255); padding: 0px; line-height: 30px; color: rgb(51, 51, 51); font-family: 宋体; font-size: 14px;&quot;&gt;　　我们建设网站最终目的是为了给用户浏览，所以从用户的角度出发进行思考才是最实际的，使用动态网页制作技术虽然网页美观度大大提升了，但是却不利于网站优化，今天小编重点和大家谈谈，网站建设为什么要使用静态页面制作。&lt;/p&gt;&lt;p&gt;&lt;img src=&quot;/uploads/ueditor/20190114/47caf8cc457ff50c8a66f4c4a23cfeb1.png&quot; title=&quot;47caf8cc457ff50c8a66f4c4a23cfeb1.png&quot; alt=&quot;47caf8cc457ff50c8a66f4c4a23cfeb1.png&quot;/&gt;&lt;/p&gt;&lt;p style=&quot;box-sizing: border-box; margin-top: 0px; margin-bottom: 15px; white-space: normal; background-color: rgb(255, 255, 255); padding: 0px; line-height: 30px; color: rgb(51, 51, 51); font-family: 宋体; font-size: 14px;&quot;&gt;　　做静态网站建设所采用的技术原理是一对一的形式，也就是说这样的网站上面，一个内容对应的就是一个页面，无论网站访问者如何操作都只是让服务器把固有的数据传送给请求者，没有脚本计算和后台数据库读取过程，大大降低了部分安全隐患。静态网站设计除了拥有上述的速度快，安全性高这两个特点之外还具有跨平台，跨服务器功能。&lt;/p&gt;&lt;p style=&quot;box-sizing: border-box; margin-top: 0px; margin-bottom: 15px; white-space: normal; background-color: rgb(255, 255, 255); padding: 0px; line-height: 30px; color: rgb(51, 51, 51); font-family: 宋体; font-size: 14px;&quot;&gt;　　现在熟悉搜索引擎原理工作原理的朋友应该都知道，它所提供给广大用户的信息是本身就存在于数据库当中的信息而不是实时的信息，固定的信息内容更容易接受和保存。我们可能常常会遇到这样的问题，当我们搜索自己所需要的信息时得出来的结果可能已经失效，这就是静态页面网站设计的不足之处，但又因为它的稳定，所以久久不会被删除。&lt;/p&gt;&lt;p style=&quot;box-sizing: border-box; margin-top: 0px; margin-bottom: 15px; white-space: normal; background-color: rgb(255, 255, 255); padding: 0px; line-height: 30px; color: rgb(51, 51, 51); font-family: 宋体; font-size: 14px;&quot;&gt;　　与静态页面网站设计不同，生成的动态页面信息不但不易被搜索引擎所检索，而且打开速度慢，再者也不稳定，这就是为什么这么多专业网站建设公司都一再建议客户使用静态形式的网站设计的原因，有些网站建设公司会考虑把页面进行伪静态处理，但不知道大家有没有注意过，伪静态处理的URL通常是不规则的。&lt;/p&gt;&lt;p&gt;&lt;br/&gt;&lt;/p&gt;', '1547462449', '1547462449');
INSERT INTO `ey_article_content` VALUES ('10', '19', '&lt;p style=&quot;box-sizing: border-box; margin-top: 0px; margin-bottom: 15px; white-space: normal; background-color: rgb(255, 255, 255); padding: 0px; line-height: 30px; color: rgb(51, 51, 51); font-family: 宋体; font-size: 14px;&quot;&gt;从三方面完美的体验企业网站的核心价值&lt;/p&gt;&lt;p style=&quot;box-sizing: border-box; margin-top: 0px; margin-bottom: 15px; white-space: normal; background-color: rgb(255, 255, 255); padding: 0px; line-height: 30px; color: rgb(51, 51, 51); font-family: 宋体; font-size: 14px;&quot;&gt;　　随着互联网的迅猛发展，一个企业的发展离不开互联网的发展，企业注重企业网站建设，那么必然会给其带来不错的效果。企业网站建设其核心价值直接体现在网站对于用户和商家而言，是否能够满足他们利益需求，能否提高企业发展，提高企业的发展渠道。&lt;/p&gt;&lt;p&gt;&lt;img class=&quot;rimg&quot; src=&quot;http://www.eyoucms.com/uploads/allimg/180426/150RQ155-0.jpg&quot;/&gt;&lt;/p&gt;&lt;p style=&quot;box-sizing: border-box; margin-top: 0px; margin-bottom: 15px; white-space: normal; background-color: rgb(255, 255, 255); padding: 0px; line-height: 30px; color: rgb(51, 51, 51); font-family: 宋体; font-size: 14px;&quot;&gt;　　一个好的导航系统就是一个好的导游，认为每一个网站设计方案都有权利与义务帮助客户及时准确的找到自己感兴趣的内容主体和需要的东西。&lt;/p&gt;&lt;p style=&quot;box-sizing: border-box; margin-top: 0px; margin-bottom: 15px; white-space: normal; background-color: rgb(255, 255, 255); padding: 0px; line-height: 30px; color: rgb(51, 51, 51); font-family: 宋体; font-size: 14px;&quot;&gt;　　另一方面体现在网站对商家现金利益需求的满足，而此却建立在网站对用户需求满足的基础之上。因为，如果网站不能够满足用户利益的需求，用户就不会为网站创造价值，不能吸引更多的用户参与到网站中来，不能实现网站价值循环式的增长，用户规模将会无法得到较大发展，很难实现对商家现金利益需求的满足，商家在网站投放广告是基于网站促进发生交易可能性的大小，交易可能性越大，商家才可以获得更大的现金利益，否则，将会白白浪费广告费。&lt;/p&gt;&lt;p style=&quot;box-sizing: border-box; margin-top: 0px; margin-bottom: 15px; white-space: normal; background-color: rgb(255, 255, 255); padding: 0px; line-height: 30px; color: rgb(51, 51, 51); font-family: 宋体; font-size: 14px;&quot;&gt;　　其次体现在对用户利益需求的满足，网站在发展初期更多的是要为用户提供他们需求的内容，积极的创造内容价值，满足用户各种基础性利益的需求，尤其是各类疑问的解答，相关兴趣或者专业资料的提供，各种资讯信息的发布。让用户能够基于某一种原因留下来，在基础性的工作做好的前提下，您可以着力于用户交易利益需求的满足，或者开始就将交易与用户的相关需求结合起来，打造一个个活跃度高的交易类版块，为用户提供此类交易最全面、最方便的资料和场所，积极促进用户活跃度的提高和迅速实现网站盈利。&lt;/p&gt;&lt;p style=&quot;box-sizing: border-box; margin-top: 0px; margin-bottom: 15px; white-space: normal; background-color: rgb(255, 255, 255); padding: 0px; line-height: 30px; color: rgb(51, 51, 51); font-family: 宋体; font-size: 14px;&quot;&gt;　　我们认为让客户在首页即可看到与自己寻找的讯息高度相关的行业信息是非常明智的抉择，一个没有大量行业专业信息体现的网站设计称不上合格的网站设计，也无法真正的为客户从根本上解决问题。&lt;/p&gt;&lt;p style=&quot;box-sizing: border-box; margin-top: 0px; margin-bottom: 15px; white-space: normal; background-color: rgb(255, 255, 255); padding: 0px; line-height: 30px; color: rgb(51, 51, 51); font-family: 宋体; font-size: 14px;&quot;&gt;　　我们只有尽量的在网站设计当中体现出如何才能在众多的行业竞争对手中脱颖而出，让客户可以信任我们呢?网站建设公司认为唯有尽量表现出自己的专业实力方可,当然除了这三点之外，网站设计仍旧有很多需要注意的地方，但不管怎么样，核心价值还是应该要重点体现，将重点放在核心内容上才是网站设计的真谛， 我们知道网站运营的核心理念是价值，站长们务必牢牢树立，一切从用户出发，积极满足用户需求，让用户发挥创造力，为网站创造价值，实现网站价值循环式增长，让站长运营变成用户运营是我们的终极目标，一劳永逸，盈利不断。&lt;/p&gt;&lt;p&gt;&lt;br/&gt;&lt;/p&gt;', '1526610848', '1526610848');
INSERT INTO `ey_article_content` VALUES ('11', '20', '&lt;p&gt;随着网络应用的丰富和发展，很多网站往往不能迅速跟进大量信息衍生及业务模式变革的脚步，常常需要花费许多时间、人力和物力来处理信息更新和维护工作；遇到网站扩充的时候，整合内外网及分支网站的工作就变得更加复杂，甚至还需重新建设网站；如此下去，用户始终在一个高成本、低效率的循环中升级、整合…&lt;/p&gt;&lt;p&gt;于是，我们听到许多用户这样的反馈：&lt;/p&gt;&lt;p&gt;页面制作无序，网站风格不统一，大量信息堆积，发布显得异常沉重；&lt;/p&gt;&lt;p&gt;内容繁杂，手工管理效率低下，手工链接视音频信息经常无法实现；&lt;/p&gt;&lt;p&gt;应用难度较高，许多工作需要技术人员配合才能完成，角色分工不明确；&lt;/p&gt;&lt;p&gt;改版工作量大，系统扩展能力差，集成其它应用时更是降低了灵活性；&lt;/p&gt;&lt;p&gt;对于网站建设和信息发布人员来说，他们最关注的系统的易用性和的功能的完善性，因此，这对网站建设和信息发布工具提出了一个很高的要求。&lt;/p&gt;&lt;p&gt;首先，角色定位明确，以充分保证工作人员的工作效率；其次，功能完整，满足各门道&amp;quot;把关人&amp;quot;应用所需，使信息发布准确无误。比如，为编辑、美工、主编及运维人员设置权限和实时管理功能。&lt;/p&gt;&lt;p&gt;此外，保障网站架构的安全性也是用户关注的焦点。能有效管理网站访问者的登陆权限，使内网数据库不受攻击，从而时刻保证网站的安全稳定，免于用户的后顾之忧。&lt;/p&gt;&lt;p&gt;根据以上需求，一套专业的内容管理系统CMS应运而生，来有效解决用户网站建设与信息发布中常见的问题和需求。对网站内容管理是该软件的最大优势，它流程完善、功能丰富，可把稿件分门别类并授权给合法用户编辑管理，而不需要用户去理会那些难懂的SQL语法。&lt;/p&gt;', '1526611606', '1527555060');
INSERT INTO `ey_article_content` VALUES ('12', '21', '&lt;p style=&quot;box-sizing: border-box; margin-top: 0px; margin-bottom: 24px; white-space: normal; background-color: rgb(255, 255, 255); color: rgb(14, 14, 14); font-family: Arial, &amp;quot;Hiragino Sans GB&amp;quot;, 冬青黑, &amp;quot;Microsoft YaHei&amp;quot;, 微软雅黑, SimSun, 宋体, Helvetica, Tahoma, &amp;quot;Arial sans-serif&amp;quot;; text-align: justify;&quot;&gt;SEO（搜索引擎优化）和有效的网站设计是齐头并进的。好的网站设计是关于创建一个吸引目标受众的网站，并让他们采取某种行动。但是，如果该网站不遵循目前的 SEO 最佳做法，它的排名将会受到影响，从而会导致真正参与该网站的访问者的数量的较少。&lt;/p&gt;&lt;p style=&quot;box-sizing: border-box; margin-top: 0px; margin-bottom: 24px; white-space: normal; background-color: rgb(255, 255, 255); color: rgb(14, 14, 14); font-family: Arial, &amp;quot;Hiragino Sans GB&amp;quot;, 冬青黑, &amp;quot;Microsoft YaHei&amp;quot;, 微软雅黑, SimSun, 宋体, Helvetica, Tahoma, &amp;quot;Arial sans-serif&amp;quot;; text-align: justify;&quot;&gt;相反地，如果将关注的焦点放在搜索引擎优化以及如何取悦搜索引擎蜘蛛上，那么网站可能会排名很高，并且会获得大量的搜索引擎流量，但是如果设计很不尽人意，那就不一样了。为了在当今的数字环境中取得成功，必须将重点放在网站设计和搜索引擎优化上。&lt;/p&gt;&lt;p style=&quot;box-sizing: border-box; margin-top: 0px; margin-bottom: 24px; white-space: normal; background-color: rgb(255, 255, 255); color: rgb(14, 14, 14); font-family: Arial, &amp;quot;Hiragino Sans GB&amp;quot;, 冬青黑, &amp;quot;Microsoft YaHei&amp;quot;, 微软雅黑, SimSun, 宋体, Helvetica, Tahoma, &amp;quot;Arial sans-serif&amp;quot;; text-align: justify;&quot;&gt;&lt;span style=&quot;box-sizing: border-box; font-weight: 700;&quot;&gt;一、但是，SEO 不会扼杀掉网页设计师的创造力吗？&lt;/span&gt;&lt;/p&gt;&lt;p style=&quot;box-sizing: border-box; margin-top: 0px; margin-bottom: 24px; white-space: normal; background-color: rgb(255, 255, 255); color: rgb(14, 14, 14); font-family: Arial, &amp;quot;Hiragino Sans GB&amp;quot;, 冬青黑, &amp;quot;Microsoft YaHei&amp;quot;, 微软雅黑, SimSun, 宋体, Helvetica, Tahoma, &amp;quot;Arial sans-serif&amp;quot;; text-align: justify;&quot;&gt;在过去的五年中，对“优化设计”的巨大需求已经被网页设计师所接受。在此之前，设计师们主要关注的是用户的体验，而不是“机器人”的体验。&lt;/p&gt;&lt;p style=&quot;box-sizing: border-box; margin-top: 0px; margin-bottom: 24px; white-space: normal; background-color: rgb(255, 255, 255); color: rgb(14, 14, 14); font-family: Arial, &amp;quot;Hiragino Sans GB&amp;quot;, 冬青黑, &amp;quot;Microsoft YaHei&amp;quot;, 微软雅黑, SimSun, 宋体, Helvetica, Tahoma, &amp;quot;Arial sans-serif&amp;quot;; text-align: justify;&quot;&gt;如今，设计师不仅要让网站看起来有吸引力，而且要确保行为召唤必须符合网站页面“折叠”的要求，网站的加载速度必须很快，必须使用面包屑路径，清晰明了的导航选择，必须使用&amp;nbsp;CSS，JavaScript 文件必须保持在最低限度…这是一项艰巨的任务。&lt;/p&gt;&lt;p style=&quot;box-sizing: border-box; margin-top: 0px; margin-bottom: 24px; white-space: normal; background-color: rgb(255, 255, 255); color: rgb(14, 14, 14); font-family: Arial, &amp;quot;Hiragino Sans GB&amp;quot;, 冬青黑, &amp;quot;Microsoft YaHei&amp;quot;, 微软雅黑, SimSun, 宋体, Helvetica, Tahoma, &amp;quot;Arial sans-serif&amp;quot;; text-align: justify;&quot;&gt;一些设计师可能想知道，所有这些新的 SEO 规则是否会损害创建网站的自由？&lt;/p&gt;&lt;p style=&quot;box-sizing: border-box; margin-top: 0px; margin-bottom: 24px; white-space: normal; background-color: rgb(255, 255, 255); color: rgb(14, 14, 14); font-family: Arial, &amp;quot;Hiragino Sans GB&amp;quot;, 冬青黑, &amp;quot;Microsoft YaHei&amp;quot;, 微软雅黑, SimSun, 宋体, Helvetica, Tahoma, &amp;quot;Arial sans-serif&amp;quot;; text-align: justify;&quot;&gt;对于“干净”的网站设计而言，它可以帮助一个网站快速加载，容易被搜索引擎蜘蛛抓取。因此，在现实中，创造力和最优化需要能够同时在一起“蓬勃发展”。&lt;/p&gt;&lt;p style=&quot;box-sizing: border-box; margin-top: 0px; margin-bottom: 24px; white-space: normal; background-color: rgb(255, 255, 255); color: rgb(14, 14, 14); font-family: Arial, &amp;quot;Hiragino Sans GB&amp;quot;, 冬青黑, &amp;quot;Microsoft YaHei&amp;quot;, 微软雅黑, SimSun, 宋体, Helvetica, Tahoma, &amp;quot;Arial sans-serif&amp;quot;; text-align: justify;&quot;&gt;&lt;span style=&quot;box-sizing: border-box; font-weight: 700;&quot;&gt;二、把它们结合在一起&lt;/span&gt;&lt;/p&gt;&lt;p style=&quot;box-sizing: border-box; margin-top: 0px; margin-bottom: 24px; white-space: normal; background-color: rgb(255, 255, 255); color: rgb(14, 14, 14); font-family: Arial, &amp;quot;Hiragino Sans GB&amp;quot;, 冬青黑, &amp;quot;Microsoft YaHei&amp;quot;, 微软雅黑, SimSun, 宋体, Helvetica, Tahoma, &amp;quot;Arial sans-serif&amp;quot;; text-align: justify;&quot;&gt;有一些核心元素支持每一个 SEO 策略和网站设计项目：&lt;/p&gt;&lt;p style=&quot;box-sizing: border-box; margin-top: 0px; margin-bottom: 24px; white-space: normal; background-color: rgb(255, 255, 255); color: rgb(14, 14, 14); font-family: Arial, &amp;quot;Hiragino Sans GB&amp;quot;, 冬青黑, &amp;quot;Microsoft YaHei&amp;quot;, 微软雅黑, SimSun, 宋体, Helvetica, Tahoma, &amp;quot;Arial sans-serif&amp;quot;; text-align: justify;&quot;&gt;&lt;span style=&quot;box-sizing: border-box; font-weight: 700;&quot;&gt;1.　关键词分析&lt;/span&gt;&lt;/p&gt;&lt;p style=&quot;box-sizing: border-box; margin-top: 0px; margin-bottom: 24px; white-space: normal; background-color: rgb(255, 255, 255); color: rgb(14, 14, 14); font-family: Arial, &amp;quot;Hiragino Sans GB&amp;quot;, 冬青黑, &amp;quot;Microsoft YaHei&amp;quot;, 微软雅黑, SimSun, 宋体, Helvetica, Tahoma, &amp;quot;Arial sans-serif&amp;quot;; text-align: justify;&quot;&gt;在启动一个商业网站项目时，必须进行彻底的关键词分析。为了做到这一点，网页设计师必须紧密深入地了解客户的目标受众，并定义受众中的人口结构是如何融入到企业正试图达到的更大的目标市场。然后，应该对网站进行适当的关键词/长尾关键词优化。&lt;/p&gt;&lt;p style=&quot;box-sizing: border-box; margin-top: 0px; margin-bottom: 24px; white-space: normal; background-color: rgb(255, 255, 255); color: rgb(14, 14, 14); font-family: Arial, &amp;quot;Hiragino Sans GB&amp;quot;, 冬青黑, &amp;quot;Microsoft YaHei&amp;quot;, 微软雅黑, SimSun, 宋体, Helvetica, Tahoma, &amp;quot;Arial sans-serif&amp;quot;; text-align: justify;&quot;&gt;&lt;span style=&quot;box-sizing: border-box; font-weight: 700;&quot;&gt;2.　内容层次结构&lt;/span&gt;&lt;/p&gt;&lt;p style=&quot;box-sizing: border-box; margin-top: 0px; margin-bottom: 24px; white-space: normal; background-color: rgb(255, 255, 255); color: rgb(14, 14, 14); font-family: Arial, &amp;quot;Hiragino Sans GB&amp;quot;, 冬青黑, &amp;quot;Microsoft YaHei&amp;quot;, 微软雅黑, SimSun, 宋体, Helvetica, Tahoma, &amp;quot;Arial sans-serif&amp;quot;; text-align: justify;&quot;&gt;对于一个企业来说，创建好的内容是不够的，他们还必须在战略上规划内容的位置。&lt;/p&gt;&lt;p style=&quot;box-sizing: border-box; margin-top: 0px; margin-bottom: 24px; white-space: normal; background-color: rgb(255, 255, 255); color: rgb(14, 14, 14); font-family: Arial, &amp;quot;Hiragino Sans GB&amp;quot;, 冬青黑, &amp;quot;Microsoft YaHei&amp;quot;, 微软雅黑, SimSun, 宋体, Helvetica, Tahoma, &amp;quot;Arial sans-serif&amp;quot;; text-align: justify;&quot;&gt;有效的计划意味着将相关的内容放到虚拟的容器中，通过创造性的设计和内部链接让内容层级结构一目了然。并且，一个经过优化的网站是对用户和搜索引擎蜘蛛都很友好的网站。&lt;/p&gt;&lt;p style=&quot;box-sizing: border-box; margin-top: 0px; margin-bottom: 24px; white-space: normal; background-color: rgb(255, 255, 255); color: rgb(14, 14, 14); font-family: Arial, &amp;quot;Hiragino Sans GB&amp;quot;, 冬青黑, &amp;quot;Microsoft YaHei&amp;quot;, 微软雅黑, SimSun, 宋体, Helvetica, Tahoma, &amp;quot;Arial sans-serif&amp;quot;; text-align: justify;&quot;&gt;&lt;span style=&quot;box-sizing: border-box; font-weight: 700;&quot;&gt;3.　从用户的角度思考&lt;/span&gt;&lt;/p&gt;&lt;p style=&quot;box-sizing: border-box; margin-top: 0px; margin-bottom: 24px; white-space: normal; background-color: rgb(255, 255, 255); color: rgb(14, 14, 14); font-family: Arial, &amp;quot;Hiragino Sans GB&amp;quot;, 冬青黑, &amp;quot;Microsoft YaHei&amp;quot;, 微软雅黑, SimSun, 宋体, Helvetica, Tahoma, &amp;quot;Arial sans-serif&amp;quot;; text-align: justify;&quot;&gt;通常情况下，你的网站有越多的页面或文章，目标用户找到你的机会就越多。当他们着陆这些特定的页面的时候，你需要确保你能帮助他们轻松的找到你。&lt;/p&gt;&lt;p style=&quot;box-sizing: border-box; margin-top: 0px; margin-bottom: 24px; white-space: normal; background-color: rgb(255, 255, 255); color: rgb(14, 14, 14); font-family: Arial, &amp;quot;Hiragino Sans GB&amp;quot;, 冬青黑, &amp;quot;Microsoft YaHei&amp;quot;, 微软雅黑, SimSun, 宋体, Helvetica, Tahoma, &amp;quot;Arial sans-serif&amp;quot;; text-align: justify;&quot;&gt;所以你必须从用户的角度进行思考，要让用户立即清楚地知道他们在进行访问的页面的当前位置，并帮助用户在尽可能少的点击下从页面转换到另一页面。&lt;/p&gt;&lt;p style=&quot;box-sizing: border-box; margin-top: 0px; margin-bottom: 24px; white-space: normal; background-color: rgb(255, 255, 255); color: rgb(14, 14, 14); font-family: Arial, &amp;quot;Hiragino Sans GB&amp;quot;, 冬青黑, &amp;quot;Microsoft YaHei&amp;quot;, 微软雅黑, SimSun, 宋体, Helvetica, Tahoma, &amp;quot;Arial sans-serif&amp;quot;; text-align: justify;&quot;&gt;&lt;span style=&quot;box-sizing: border-box; font-weight: 700;&quot;&gt;三、为什么&amp;nbsp;SEO 策略如此重要？&lt;/span&gt;&lt;/p&gt;&lt;p style=&quot;box-sizing: border-box; margin-top: 0px; margin-bottom: 24px; white-space: normal; background-color: rgb(255, 255, 255); color: rgb(14, 14, 14); font-family: Arial, &amp;quot;Hiragino Sans GB&amp;quot;, 冬青黑, &amp;quot;Microsoft YaHei&amp;quot;, 微软雅黑, SimSun, 宋体, Helvetica, Tahoma, &amp;quot;Arial sans-serif&amp;quot;; text-align: justify;&quot;&gt;拥有合适的网站结构和信息架构，最终将会帮助企业提供一种引人入胜的用户体验，同时减少对每一次新增长的需求。但是，除非你的品牌是众所周知的，否则通常是搜索引擎对网站所收到的大部分流量负责。SEO 策略有能力利用重要的客户数据，挖掘新的潜在收入流。&lt;/p&gt;&lt;p style=&quot;box-sizing: border-box; margin-top: 0px; margin-bottom: 24px; white-space: normal; background-color: rgb(255, 255, 255); color: rgb(14, 14, 14); font-family: Arial, &amp;quot;Hiragino Sans GB&amp;quot;, 冬青黑, &amp;quot;Microsoft YaHei&amp;quot;, 微软雅黑, SimSun, 宋体, Helvetica, Tahoma, &amp;quot;Arial sans-serif&amp;quot;; text-align: justify;&quot;&gt;对于那些试图进行搜索引擎优化的网站所有者来说，有一些地方经常是麻烦的。现在，我将为网站所有者提供搜索引擎优化建议，以获得更高排名的页面。&lt;/p&gt;&lt;p style=&quot;box-sizing: border-box; margin-top: 0px; margin-bottom: 24px; white-space: normal; background-color: rgb(255, 255, 255); color: rgb(14, 14, 14); font-family: Arial, &amp;quot;Hiragino Sans GB&amp;quot;, 冬青黑, &amp;quot;Microsoft YaHei&amp;quot;, 微软雅黑, SimSun, 宋体, Helvetica, Tahoma, &amp;quot;Arial sans-serif&amp;quot;; text-align: justify;&quot;&gt;&lt;span style=&quot;box-sizing: border-box; font-weight: 700;&quot;&gt;1. &amp;nbsp;URL 结构&lt;/span&gt;&lt;/p&gt;&lt;p style=&quot;box-sizing: border-box; margin-top: 0px; margin-bottom: 24px; white-space: normal; background-color: rgb(255, 255, 255); color: rgb(14, 14, 14); font-family: Arial, &amp;quot;Hiragino Sans GB&amp;quot;, 冬青黑, &amp;quot;Microsoft YaHei&amp;quot;, 微软雅黑, SimSun, 宋体, Helvetica, Tahoma, &amp;quot;Arial sans-serif&amp;quot;; text-align: justify;&quot;&gt;大多数网站创建的 URL 都包含很多随机字符，比如问号，没有关键词或任何有价值的内容。当搜索引擎的 URL 包含 SEO 的关键词或短语时，页面将会在搜索引擎中排名更高。因此，在 URL 中设置关键词非常重要。&lt;/p&gt;&lt;p style=&quot;box-sizing: border-box; margin-top: 0px; margin-bottom: 24px; white-space: normal; background-color: rgb(255, 255, 255); color: rgb(14, 14, 14); font-family: Arial, &amp;quot;Hiragino Sans GB&amp;quot;, 冬青黑, &amp;quot;Microsoft YaHei&amp;quot;, 微软雅黑, SimSun, 宋体, Helvetica, Tahoma, &amp;quot;Arial sans-serif&amp;quot;; text-align: justify;&quot;&gt;&lt;span style=&quot;box-sizing: border-box; font-weight: 700;&quot;&gt;2.　页面的标题&lt;/span&gt;&lt;/p&gt;&lt;p style=&quot;box-sizing: border-box; margin-top: 0px; margin-bottom: 24px; white-space: normal; background-color: rgb(255, 255, 255); color: rgb(14, 14, 14); font-family: Arial, &amp;quot;Hiragino Sans GB&amp;quot;, 冬青黑, &amp;quot;Microsoft YaHei&amp;quot;, 微软雅黑, SimSun, 宋体, Helvetica, Tahoma, &amp;quot;Arial sans-serif&amp;quot;; text-align: justify;&quot;&gt;搜索引擎排名中最重要的因素之一是页面标题。不过，许多网站并没有改变他们的网页标题。在青柠建站平台中，你可以通过使用 SEO 标题标签插件，它很容易让你为你的文章和页面创建标题。&lt;/p&gt;&lt;p style=&quot;box-sizing: border-box; margin-top: 0px; margin-bottom: 24px; white-space: normal; background-color: rgb(255, 255, 255); color: rgb(14, 14, 14); font-family: Arial, &amp;quot;Hiragino Sans GB&amp;quot;, 冬青黑, &amp;quot;Microsoft YaHei&amp;quot;, 微软雅黑, SimSun, 宋体, Helvetica, Tahoma, &amp;quot;Arial sans-serif&amp;quot;; text-align: justify;&quot;&gt;&lt;span style=&quot;box-sizing: border-box; font-weight: 700;&quot;&gt;3.　重复的内容&lt;/span&gt;&lt;/p&gt;&lt;p style=&quot;box-sizing: border-box; margin-top: 0px; margin-bottom: 24px; white-space: normal; background-color: rgb(255, 255, 255); color: rgb(14, 14, 14); font-family: Arial, &amp;quot;Hiragino Sans GB&amp;quot;, 冬青黑, &amp;quot;Microsoft YaHei&amp;quot;, 微软雅黑, SimSun, 宋体, Helvetica, Tahoma, &amp;quot;Arial sans-serif&amp;quot;; text-align: justify;&quot;&gt;没有一个搜索引擎喜欢看到重复的内容。重复内容是一些网站的主要问题，因为类别页面和日历/日期页面经常会导致搜索引擎在多个页面上找到相同的内容。&lt;/p&gt;&lt;p style=&quot;box-sizing: border-box; margin-top: 0px; margin-bottom: 24px; white-space: normal; background-color: rgb(255, 255, 255); color: rgb(14, 14, 14); font-family: Arial, &amp;quot;Hiragino Sans GB&amp;quot;, 冬青黑, &amp;quot;Microsoft YaHei&amp;quot;, 微软雅黑, SimSun, 宋体, Helvetica, Tahoma, &amp;quot;Arial sans-serif&amp;quot;; text-align: justify;&quot;&gt;对于网站所有者来说，有几种方法可以克服重复的内容问题。其中一种方法是使用 robot.txt 文件，用来指导搜索引擎哪些页面应该被忽略，只留下要索引的主要页面。&lt;/p&gt;&lt;p style=&quot;box-sizing: border-box; margin-top: 0px; margin-bottom: 24px; white-space: normal; background-color: rgb(255, 255, 255); color: rgb(14, 14, 14); font-family: Arial, &amp;quot;Hiragino Sans GB&amp;quot;, 冬青黑, &amp;quot;Microsoft YaHei&amp;quot;, 微软雅黑, SimSun, 宋体, Helvetica, Tahoma, &amp;quot;Arial sans-serif&amp;quot;; text-align: justify;&quot;&gt;&lt;span style=&quot;box-sizing: border-box; font-weight: 700;&quot;&gt;4. &amp;nbsp;Meta 标签&lt;/span&gt;&lt;/p&gt;&lt;p style=&quot;box-sizing: border-box; margin-top: 0px; margin-bottom: 24px; white-space: normal; background-color: rgb(255, 255, 255); color: rgb(14, 14, 14); font-family: Arial, &amp;quot;Hiragino Sans GB&amp;quot;, 冬青黑, &amp;quot;Microsoft YaHei&amp;quot;, 微软雅黑, SimSun, 宋体, Helvetica, Tahoma, &amp;quot;Arial sans-serif&amp;quot;; text-align: justify;&quot;&gt;在设计一个传统的静态网站时，你可以为每个页面输入元标签（描述）。尽管这些标签在搜索引擎排名上的影响力没有以前那么大，但在你的页面上有这些标签并不会带来什么坏处。&lt;/p&gt;&lt;p style=&quot;box-sizing: border-box; margin-top: 0px; margin-bottom: 24px; white-space: normal; background-color: rgb(255, 255, 255); color: rgb(14, 14, 14); font-family: Arial, &amp;quot;Hiragino Sans GB&amp;quot;, 冬青黑, &amp;quot;Microsoft YaHei&amp;quot;, 微软雅黑, SimSun, 宋体, Helvetica, Tahoma, &amp;quot;Arial sans-serif&amp;quot;; text-align: justify;&quot;&gt;然而，大多数建站平台并没有给用户在写文章时添加元标签的选项。对于 青柠建站平台 用户来说，添加元标签插件将允许你为任何页面输入元标签。&lt;/p&gt;&lt;p style=&quot;box-sizing: border-box; margin-top: 0px; margin-bottom: 24px; white-space: normal; background-color: rgb(255, 255, 255); color: rgb(14, 14, 14); font-family: Arial, &amp;quot;Hiragino Sans GB&amp;quot;, 冬青黑, &amp;quot;Microsoft YaHei&amp;quot;, 微软雅黑, SimSun, 宋体, Helvetica, Tahoma, &amp;quot;Arial sans-serif&amp;quot;; text-align: justify;&quot;&gt;&lt;span style=&quot;box-sizing: border-box; font-weight: 700;&quot;&gt;四、网页设计师在 SEO 方面的职责是什么？&lt;/span&gt;&lt;/p&gt;&lt;p style=&quot;box-sizing: border-box; margin-top: 0px; margin-bottom: 24px; white-space: normal; background-color: rgb(255, 255, 255); color: rgb(14, 14, 14); font-family: Arial, &amp;quot;Hiragino Sans GB&amp;quot;, 冬青黑, &amp;quot;Microsoft YaHei&amp;quot;, 微软雅黑, SimSun, 宋体, Helvetica, Tahoma, &amp;quot;Arial sans-serif&amp;quot;; text-align: justify;&quot;&gt;搜索引擎优化是一个持续的过程，它不能通过以特定的方式设计一个网站来实现。当然，网页设计师应该付出相当大的努力来帮助客户构建一个优化的站点，但是网页设计师在 SEO 方面的职责是什么，以及客户的职责是什么？&lt;/p&gt;&lt;p style=&quot;box-sizing: border-box; margin-top: 0px; margin-bottom: 24px; white-space: normal; background-color: rgb(255, 255, 255); color: rgb(14, 14, 14); font-family: Arial, &amp;quot;Hiragino Sans GB&amp;quot;, 冬青黑, &amp;quot;Microsoft YaHei&amp;quot;, 微软雅黑, SimSun, 宋体, Helvetica, Tahoma, &amp;quot;Arial sans-serif&amp;quot;; text-align: justify;&quot;&gt;作为一个企业主，你的网站的优化对你来说比设计师更重要（这并不是说设计师不关心，但是设计师的注意力通常集中在网站的视觉和功能上）。你比设计师更了解你的客户 / 潜在客户，所以你应该对你的目标有更多的建设性意见。&lt;/p&gt;&lt;p style=&quot;box-sizing: border-box; margin-top: 0px; margin-bottom: 24px; white-space: normal; background-color: rgb(255, 255, 255); color: rgb(14, 14, 14); font-family: Arial, &amp;quot;Hiragino Sans GB&amp;quot;, 冬青黑, &amp;quot;Microsoft YaHei&amp;quot;, 微软雅黑, SimSun, 宋体, Helvetica, Tahoma, &amp;quot;Arial sans-serif&amp;quot;; text-align: justify;&quot;&gt;也许有些客户对 SEO 和目标关键词可能不太了解，那么理想的情况是让客户和你在这个问题上协同工作。&lt;/p&gt;&lt;p style=&quot;box-sizing: border-box; margin-top: 0px; margin-bottom: 24px; white-space: normal; background-color: rgb(255, 255, 255); color: rgb(14, 14, 14); font-family: Arial, &amp;quot;Hiragino Sans GB&amp;quot;, 冬青黑, &amp;quot;Microsoft YaHei&amp;quot;, 微软雅黑, SimSun, 宋体, Helvetica, Tahoma, &amp;quot;Arial sans-serif&amp;quot;; text-align: justify;&quot;&gt;根据我的经验，让客户参与其中的最简单方法之一就是简单地解释网站上使用的词语和短语（标题、文案等）会对网站排名有直接的影响。&lt;/p&gt;&lt;p style=&quot;box-sizing: border-box; margin-top: 0px; margin-bottom: 24px; white-space: normal; background-color: rgb(255, 255, 255); color: rgb(14, 14, 14); font-family: Arial, &amp;quot;Hiragino Sans GB&amp;quot;, 冬青黑, &amp;quot;Microsoft YaHei&amp;quot;, 微软雅黑, SimSun, 宋体, Helvetica, Tahoma, &amp;quot;Arial sans-serif&amp;quot;; text-align: justify;&quot;&gt;我通常会要求客户给我一份他们认为潜在访问者可能会在搜索中使用的词语和短语列表。在我不太熟悉的行业中设计网站时，这一点尤其重要。&lt;/p&gt;&lt;p style=&quot;box-sizing: border-box; margin-top: 0px; margin-bottom: 24px; white-space: normal; background-color: rgb(255, 255, 255); color: rgb(14, 14, 14); font-family: Arial, &amp;quot;Hiragino Sans GB&amp;quot;, 冬青黑, &amp;quot;Microsoft YaHei&amp;quot;, 微软雅黑, SimSun, 宋体, Helvetica, Tahoma, &amp;quot;Arial sans-serif&amp;quot;; text-align: justify;&quot;&gt;当然，可能需要做一些研究。客户应该承担起关键词研究的责任，还是应该由设计师来负责？&lt;/p&gt;&lt;p style=&quot;box-sizing: border-box; margin-top: 0px; margin-bottom: 24px; white-space: normal; background-color: rgb(255, 255, 255); color: rgb(14, 14, 14); font-family: Arial, &amp;quot;Hiragino Sans GB&amp;quot;, 冬青黑, &amp;quot;Microsoft YaHei&amp;quot;, 微软雅黑, SimSun, 宋体, Helvetica, Tahoma, &amp;quot;Arial sans-serif&amp;quot;; text-align: justify;&quot;&gt;我的经验是，如果客户参与进来，这项研究通常会更有效，但这并不总是可能的。设计师应该有足够的知识来为客户提供建议，并且应该愿意提供帮助，但是最终最好还是让客户尽可能地参与进来。事实上，如果客户关心 SEO，参与过程会达到一个更加合理的期望。&lt;/p&gt;&lt;p style=&quot;box-sizing: border-box; margin-top: 0px; margin-bottom: 24px; white-space: normal; background-color: rgb(255, 255, 255); color: rgb(14, 14, 14); font-family: Arial, &amp;quot;Hiragino Sans GB&amp;quot;, 冬青黑, &amp;quot;Microsoft YaHei&amp;quot;, 微软雅黑, SimSun, 宋体, Helvetica, Tahoma, &amp;quot;Arial sans-serif&amp;quot;; text-align: justify;&quot;&gt;设定现实的期望也可能是设计师的责任。&lt;/p&gt;&lt;p style=&quot;box-sizing: border-box; margin-top: 0px; margin-bottom: 24px; white-space: normal; background-color: rgb(255, 255, 255); color: rgb(14, 14, 14); font-family: Arial, &amp;quot;Hiragino Sans GB&amp;quot;, 冬青黑, &amp;quot;Microsoft YaHei&amp;quot;, 微软雅黑, SimSun, 宋体, Helvetica, Tahoma, &amp;quot;Arial sans-serif&amp;quot;; text-align: justify;&quot;&gt;我有一些潜在的客户来找我说：“我被 SEO 专家告知，只要在网站页面上插入竞争热门的关键词就可以让我的网站排名第一或第二”。&lt;/p&gt;&lt;p style=&quot;box-sizing: border-box; margin-top: 0px; margin-bottom: 24px; white-space: normal; background-color: rgb(255, 255, 255); color: rgb(14, 14, 14); font-family: Arial, &amp;quot;Hiragino Sans GB&amp;quot;, 冬青黑, &amp;quot;Microsoft YaHei&amp;quot;, 微软雅黑, SimSun, 宋体, Helvetica, Tahoma, &amp;quot;Arial sans-serif&amp;quot;; text-align: justify;&quot;&gt;在这种情况下，我会很明显地会指出，“搜索引擎优化需要持续的工作，而这种工作通常不能通过以某种方式创建网站来完成的。”&lt;/p&gt;&lt;p style=&quot;box-sizing: border-box; margin-top: 0px; margin-bottom: 24px; white-space: normal; background-color: rgb(255, 255, 255); color: rgb(14, 14, 14); font-family: Arial, &amp;quot;Hiragino Sans GB&amp;quot;, 冬青黑, &amp;quot;Microsoft YaHei&amp;quot;, 微软雅黑, SimSun, 宋体, Helvetica, Tahoma, &amp;quot;Arial sans-serif&amp;quot;; text-align: justify;&quot;&gt;我经常建议客户在他们的网站上添加一个博客，以获得更多的内容，并提高排名的机会。&lt;/p&gt;&lt;p style=&quot;box-sizing: border-box; margin-top: 0px; margin-bottom: 24px; white-space: normal; background-color: rgb(255, 255, 255); color: rgb(14, 14, 14); font-family: Arial, &amp;quot;Hiragino Sans GB&amp;quot;, 冬青黑, &amp;quot;Microsoft YaHei&amp;quot;, 微软雅黑, SimSun, 宋体, Helvetica, Tahoma, &amp;quot;Arial sans-serif&amp;quot;; text-align: justify;&quot;&gt;&lt;span style=&quot;box-sizing: border-box; font-weight: 700;&quot;&gt;结语&lt;/span&gt;&lt;/p&gt;&lt;p style=&quot;box-sizing: border-box; margin-top: 0px; margin-bottom: 24px; white-space: normal; background-color: rgb(255, 255, 255); color: rgb(14, 14, 14); font-family: Arial, &amp;quot;Hiragino Sans GB&amp;quot;, 冬青黑, &amp;quot;Microsoft YaHei&amp;quot;, 微软雅黑, SimSun, 宋体, Helvetica, Tahoma, &amp;quot;Arial sans-serif&amp;quot;; text-align: justify;&quot;&gt;虽然这只是一个简短的总结，但这些是网站所有者和设计师将面对的最重要的 SEO 话题。通过了解这些知识，你可以更好地创建出对用户和搜索引擎都友好的网站。&lt;/p&gt;&lt;p style=&quot;box-sizing: border-box; margin-top: 0px; margin-bottom: 24px; white-space: normal; background-color: rgb(255, 255, 255); color: rgb(14, 14, 14); font-family: Arial, &amp;quot;Hiragino Sans GB&amp;quot;, 冬青黑, &amp;quot;Microsoft YaHei&amp;quot;, 微软雅黑, SimSun, 宋体, Helvetica, Tahoma, &amp;quot;Arial sans-serif&amp;quot;; text-align: justify;&quot;&gt;本文由易优小编设计 原创授权发布易优网站，未经授权，转载必究。&lt;/p&gt;&lt;p&gt;&lt;br/&gt;&lt;/p&gt;', '1526611744', '1531709637');
INSERT INTO `ey_article_content` VALUES ('14', '38', '&lt;p style=&quot;box-sizing: border-box; margin-top: 0px; margin-bottom: 24px; white-space: normal; background-color: rgb(255, 255, 255); color: rgb(14, 14, 14); font-family: Arial, &amp;quot;Hiragino Sans GB&amp;quot;, 冬青黑, &amp;quot;Microsoft YaHei&amp;quot;, 微软雅黑, SimSun, 宋体, Helvetica, Tahoma, &amp;quot;Arial sans-serif&amp;quot;; text-align: justify;&quot;&gt;SEO很多伙伴都了解，就是搜索引擎排名优化，通过对网站内部和外部进行优化当用户搜索相应关键词时网站能够排名在搜索引擎前面，具体可以百度搜索“网络营销课程”查看商梦网校操作的案例！&lt;/p&gt;&lt;p style=&quot;box-sizing: border-box; margin-top: 0px; margin-bottom: 24px; white-space: normal; background-color: rgb(255, 255, 255); color: rgb(14, 14, 14); font-family: Arial, &amp;quot;Hiragino Sans GB&amp;quot;, 冬青黑, &amp;quot;Microsoft YaHei&amp;quot;, 微软雅黑, SimSun, 宋体, Helvetica, Tahoma, &amp;quot;Arial sans-serif&amp;quot;; text-align: justify;&quot;&gt;但单页SEO很多伙伴可能会有点陌生，单页SEO是将单页网站与内容内容结合为一体的SEO优化方案，主要是提升网站流量利用率让用户打开网站就能看到目标页面，转换更多订单，创造更多收益。单页SEO的操作理念也是由商梦网校提出，并一起推荐操作大家的模式。&lt;/p&gt;&lt;p style=&quot;box-sizing: border-box; margin-top: 0px; margin-bottom: 24px; white-space: normal; background-color: rgb(255, 255, 255); color: rgb(14, 14, 14); font-family: Arial, &amp;quot;Hiragino Sans GB&amp;quot;, 冬青黑, &amp;quot;Microsoft YaHei&amp;quot;, 微软雅黑, SimSun, 宋体, Helvetica, Tahoma, &amp;quot;Arial sans-serif&amp;quot;; text-align: justify;&quot;&gt;那什么又是单页SEO站群呢，因为操作SEO成功率并不是100%，也就是意味着你做了并不会绝对有排名。因为在任何时候搜索引擎，特别是百度的索引数据库里，只有60%的网页数量。也就是说，大量的网页它是没有收录进来，它本身的能力所限无法做到中文的所有几百亿个网页都收录进来。所以，对于大部分网站，都有被删除网页，没有排名，或被K的经历，或没有排名。处理办法：坦然面对这一切。一个网站的成本才多少钱？如果因此对SEO失去信心，那就是最大的失去了。&lt;/p&gt;&lt;p style=&quot;box-sizing: border-box; margin-top: 0px; margin-bottom: 24px; white-space: normal; background-color: rgb(255, 255, 255); color: rgb(14, 14, 14); font-family: Arial, &amp;quot;Hiragino Sans GB&amp;quot;, 冬青黑, &amp;quot;Microsoft YaHei&amp;quot;, 微软雅黑, SimSun, 宋体, Helvetica, Tahoma, &amp;quot;Arial sans-serif&amp;quot;; text-align: justify;&quot;&gt;不过我们也想到了一个更好的解决方案，这个方案在最早期我们开始操作，并且取得了非常不错的成绩就是“站群”，我们可以假设一个网站排名的机会为1，如果我们用 10 个网站来进行优化排名机会可以提升 10 倍， 10 个网站我们也不要求都获得排名只需要有1- 3 个网站获得排名这个操作就是成功的，因为对于我们做站群来说投入 10 个网站的成本也就 1000 块左右；这个投资也是非常划算的，这个思路其实有点像竞价，不像传统的SEO，因为传统的SEO我们投资一个网站成本一两百，就想获得排名，然后给我们几百上千倍的回报。结果就相当于我们把希望寄托在一颗树上，结果这颗树没有开花结果，我们就饿死了。&lt;/p&gt;&lt;p style=&quot;box-sizing: border-box; margin-top: 0px; margin-bottom: 24px; white-space: normal; background-color: rgb(255, 255, 255); color: rgb(14, 14, 14); font-family: Arial, &amp;quot;Hiragino Sans GB&amp;quot;, 冬青黑, &amp;quot;Microsoft YaHei&amp;quot;, 微软雅黑, SimSun, 宋体, Helvetica, Tahoma, &amp;quot;Arial sans-serif&amp;quot;; text-align: justify;&quot;&gt;想给一个项目建立数十个网站也是需要掌握很多技术的，特别是批量建站方面，以及后期的维护。这次商梦网校升级加入的单页SEO站群操作方法，没有长篇大论直接给你演示怎么干，你只需要复制我们提供的方法就可以了。当然这里面也有很多核心的技术，比如域名注册和空间购买技巧虽然非常简单，但是直接会影响我们后期操作结果，我们给提供的技巧也会将你的成本降到低，如果投资建立 10 个网站域名与空间的成本不到 1000 元。相当于 1000 你就可以启动一个站群项目。核心的还是文章的采集，我们的原理是利用火车头采集原创文章然后实现挂机自动发布，只需要设置好每天几点运行软件就会自动更新网站文章，还会自动网站自动瞄文本，自动加入关键词。这些很多同学可能会问会不会太复杂，可以这样告诉你复杂的工作我们已经帮你搞定，到你使用的时候已经是打包好的解决方案。&lt;/p&gt;&lt;p style=&quot;box-sizing: border-box; margin-top: 0px; margin-bottom: 24px; white-space: normal; background-color: rgb(255, 255, 255); color: rgb(14, 14, 14); font-family: Arial, &amp;quot;Hiragino Sans GB&amp;quot;, 冬青黑, &amp;quot;Microsoft YaHei&amp;quot;, 微软雅黑, SimSun, 宋体, Helvetica, Tahoma, &amp;quot;Arial sans-serif&amp;quot;; text-align: justify;&quot;&gt;网站前期整体搭建只要花时间就能搞定，但真正考验人的基实还是在于后期优化，对于网站后期优化特别是外链增加收录和权重这一块，我们还是没有长篇大论会直接给你演示实用、高效的方法让你的站群快速的获得收录，增加权重，获得排名，你需要做的就拷贝我们商梦网校的方法和模式；这些经验都是我们长期操作整理下来的，并非几天修炼的结果。&lt;/p&gt;&lt;p&gt;&lt;br/&gt;&lt;/p&gt;', '1527555069', '1531709578');
INSERT INTO `ey_article_content` VALUES ('18', '59', '&lt;p&gt;Five Core Elements of Website Construction&lt;/p&gt;&lt;p style=&quot;text-align: center;&quot;&gt;&lt;img src=&quot;/uploads/allimg/20181220/39229581e20d2e22e750df528a43fe71.jpg&quot; style=&quot;box-sizing: inherit; border-style: none; vertical-align: top; max-width: 100%; height: auto !important;&quot;/&gt;&lt;/p&gt;&lt;p&gt;　　In order to implement network marketing, enterprises need to make websites first. Website is composed of many Web pages, and the design of these pages directly affects whether the website can be welcomed by users. To judge the design of a homepage, we should consider it comprehensively from many aspects, not only whether it is vividly and beautifully designed, but also whether the website can be considered for users to the greatest extent.&lt;/p&gt;&lt;p style=&quot;text-align: center;&quot;&gt;&lt;img alt=&quot;&quot; class=&quot;limg&quot; src=&quot;http://www.eyoucms.com/uploads/allimg/180426/1510032P3-1.jpg&quot; style=&quot;box-sizing: inherit; border-style: none; vertical-align: top; max-width: 100%; height: auto !important;&quot;/&gt;&lt;/p&gt;&lt;p&gt;　　&lt;/p&gt;&lt;p&gt;3. Product as the Core Principle&lt;/p&gt;&lt;p&gt;The most important purpose and function of website production is product display. The main purpose of customer visiting the website is to have a deep understanding of the products and services. The value of the website lies in flexibly displaying product instructions, pictures and even multimedia information to users. Even a simple website is at least equivalent to a product promotional material that can be updated at any time. Outdated product information ｏｒ imperfect product information can not only promote sales, but also affect customer confidence. When customers visit the website, they are not concerned about personal information, but about what kind of products they can provide and what advantages they have. Therefore, product as the core is a prerequisite for the success of the website.&lt;/p&gt;&lt;p&gt;Product information should generally include the following aspects: product name, product specifications, product use, product characteristics, product certification and product pictures. Secondly, product specifications, product uses and product characteristics should be described in as much detail as possible.&lt;/p&gt;&lt;p&gt;4. On the principle of strong information exchange ability of websites&lt;/p&gt;&lt;p&gt;If a website can only provide visitors to browse, but can not guide visitors to participate in part of the construction of website content, then its attraction is limited. Only when visitors can easily exchange information with information publishers can the charm of the website be fully embodied. Virtual forums are designed to discuss products among product users and between product users and product development managers. Online marketers can also use this to collect market information and formulate effective marketing plans. And the feedback information of website consumers is published directly on the Internet, which can attract consumers to visit the website and form a fixed relationship with customers.&lt;/p&gt;&lt;p&gt;When customers find products of interest on the Internet, how to make inquiries and feedback on the products in time? This is not only achieved by electronic mail. The website should provide corresponding information feedback module, so that customers can make inquiries ｏｒ feedback for one ｏｒ more products conveniently and quickly. At the same time, the salesman of the enterprise should be able to check the customer&amp;#39;s feedback information in time and reply in time: each business department ｏｒ salesman should be able to manage the customer&amp;#39;s information and feedback information conveniently according to the products they publish. Through the website, customers can provide a variety of online services and help information, such as FAQ, detailed contact information, online help forms, real-time chat to answer customer consultation and so on. At the same time, the use of the website can also achieve the purpose of improving customer relations, such as by issuing a variety of free mailing lists, providing prize guessing and other ways to attract users to participate. Through online questionnaires on the website, users&amp;#39;feedback information can be obtained, which can be used in product survey, consumer behavior survey, brand image survey and so on. It is an effective tool to obtain first-hand market information.&lt;/p&gt;&lt;p&gt;5. On the Principle of Perfect Retrieval Ability&lt;/p&gt;&lt;p&gt;For a website, how to organize reasonably the information content to be published so that the visitors can quickly and accurately find the information they are looking for is the key to the success of the website content organization. If the structure design of the website can not make the customers find the information they need conveniently and quickly, the best design can not attract long-term customers. Even if he is attracted to the home page of the website, his visits will be interrupted in the future. In order to achieve the above design goals, some websites have designed information index and directory index on the web page. Users can quickly find the part of information they are interested in.&lt;/p&gt;&lt;p&gt;Therefore, in order to make the content of the website practical, a certain scale of website must provide retrieval function, so as to facilitate users to find the information of this website. In order to create convenient conditions for visitors, web designers often design web content into tree structure to facilitate vertical query. Visitors can penetrate into all the information content of &amp;quot;tree rights&amp;quot; and &amp;quot;treetops&amp;quot; layer by layer from the home page. In addition, a search system can be designed to make it easy for visitors to find relevant content. Website search system should be well designed to allow visitors to enter from any page. At the same time, any page of the website should be designed with a &amp;quot;back home page&amp;quot; link to facilitate visitors to return to the &amp;quot;trunk&amp;quot;.&lt;/p&gt;&lt;p&gt;&lt;br/&gt;&lt;/p&gt;', '1547463745', '1547463745');
INSERT INTO `ey_article_content` VALUES ('19', '60', '&lt;p&gt;Experience the Core Value of Enterprise Website Perfectly from Three Aspects&lt;/p&gt;&lt;p&gt;　　With the rapid development of the Internet, the development of an enterprise can not be separated from the development of the Internet. Enterprises pay attention to the construction of enterprise websites, then it will inevitably bring good results. The core value of enterprise website construction is directly reflected in whether the website can satisfy the interests and needs of users and businessmen, improve the development of enterprises and improve the development channels of enterprises.&lt;/p&gt;&lt;p style=&quot;text-align: center;&quot;&gt;&lt;img class=&quot;rimg&quot; src=&quot;http://www.eyoucms.com/uploads/allimg/180426/150RQ155-0.jpg&quot; style=&quot;box-sizing: inherit; border-style: none; vertical-align: top; max-width: 100%; height: auto !important;&quot;/&gt;&lt;/p&gt;&lt;p&gt;　　&lt;/p&gt;&lt;p&gt;A good navigation system is a good tour guide. Every website design plan has the right and obligation to help customers find the subject of content and what they need in time and accurately.&lt;/p&gt;&lt;p&gt;On the other hand, it embodies the satisfaction of the website to the cash interests of the merchants, which is based on the satisfaction of the website to the users&amp;#39;needs. Because, if the website can not meet the needs of users&amp;#39;interests, users will not create value for the website, can not attract more users to participate in the website, can not achieve the cyclical growth of the value of the website, the scale of users will not be able to achieve greater development, it is difficult to meet the needs of cash interests of businesses. Businessmen put advertisements on the website is based on the website to promote transactions. The more likely it is and the more likely it is to be traded, the more cash profit the merchants can get. Otherwise, they will waste advertising money in vain.&lt;/p&gt;&lt;p&gt;Secondly, it is reflected in the satisfaction of users&amp;#39;interests and needs. In the initial stage of development, the website is more to provide users with the content they need, actively create content value, meet the needs of users&amp;#39; basic interests, especially the answers to various questions, the provision of relevant interest ｏｒ professional information, and the release of various information. Let users stay for a certain reason. On the premise of doing a good job in basic work, you can focus on meeting the interests of users&amp;#39;transactions, ｏｒ at the beginning, combine transactions with the relevant needs of users to create a highly active trading sector, providing users with the most comprehensive and convenient information and venues for such transactions, and actively promote users&amp;#39; activity. Improve the degree and quickly realize the profit of the website.&lt;/p&gt;&lt;p&gt;We think that it is a very wise choice for customers to see the industry information highly related to the information they are looking for on the home page. A website design without a lot of professional information is not qualified website design, nor can it really solve the problem fundamentally for customers.&lt;/p&gt;&lt;p&gt;We have to try our best to show how we can stand out among many competitors in the industry, so that customers can trust us? Website construction companies believe that only by showing their professional strength as far as possible, of course, in addition to these three points, website design still has many things to pay attention to, but no matter what, the core value should still be important. Points to reflect, focusing on the core content is the essence of website design, we know that the core concept of website operation is value, stationmasters must firmly establish, all from the user, actively meet user needs, let users play their creativity, create value for the website, realize the cyclical growth of website value, let the stationmaster operation become user operation is our ultimate goal. Once and for all, profits continue.&lt;/p&gt;&lt;p&gt;&lt;br/&gt;&lt;/p&gt;', '1545271034', '1545271034');
INSERT INTO `ey_article_content` VALUES ('20', '61', '&lt;p&gt;Looking back on the 40-year history of Chinese beverage development, there is always a taste of your childhood memory. For memory, the taste is often the most beautiful. The beverage you drank in childhood is still enjoyable in retrospect.&lt;/p&gt;&lt;p&gt;Today is the June 1 children&amp;#39;s day. Qingshan capital has compiled a brief history of China&amp;#39;s beverage development in the past 40 years, and it can be a holiday pastime. By the way, can you find the smell in your memory?&lt;/p&gt;&lt;p&gt;The First Stage: The Opening Age of Chinese Taste Bud&lt;/p&gt;&lt;p&gt;Pepsi Cola opened its first factory in China&lt;/p&gt;&lt;p&gt;In 1981, Coca-Cola officially launched its first production line in China, mainly supplying tourist hotels, selling to foreigners to collect foreign exchange, and Pepsi Cola established its first canning plant in Shenzhen.&lt;/p&gt;&lt;p&gt;In 1982, the state incorporated beverages into the &amp;quot;national plan management products&amp;quot;, and Coca-Cola began to sell in Beijing market.&lt;/p&gt;&lt;p&gt;&lt;br/&gt;&lt;/p&gt;', '1545271068', '1545271068');
INSERT INTO `ey_article_content` VALUES ('21', '62', '&lt;p&gt;John Quilch says that social media has many marketing challenges, and how to value fans is a big problem. From the marketing point of view, we should pay attention to strong ties and weak ties. You may think that strong bonds have the greatest marketing impact. Research has found that it&amp;#39;s not like this, but people who are more distant from you.&lt;/p&gt;&lt;p&gt;Speaker John Quilch&lt;/p&gt;&lt;p&gt;(Professor of Harvard Business School, former Dean of London Business School and Vice Dean of CEIBS)&lt;/p&gt;&lt;p&gt;Thank you very much for coming back to listen to my lecture on Sunday morning. For you entrepreneurs, ｏｒ those who want to be entrepreneurs, I have prepared a special lecture today.&lt;/p&gt;&lt;p&gt;Many entrepreneurs do not define their ultimate vision well, so they are busy putting out fires and surviving every day.&lt;/p&gt;&lt;p&gt;Start-up marketing, you must plan well&lt;/p&gt;&lt;p&gt;Today we will start with the topic of entrepreneurship marketing, including how you survive and succeed. Start-up marketing includes four key areas, which you must plan well:&lt;/p&gt;&lt;p&gt;Have the right target customers and end users;&lt;/p&gt;&lt;p&gt;Have the right products and services&lt;/p&gt;&lt;p&gt;We should have a very good talent team to make business ideas come true.&lt;/p&gt;&lt;p&gt;We should have good partners, not distributors, but accountants, lawyers and other service partners.&lt;/p&gt;&lt;p&gt;So, what is entrepreneurial marketing?&lt;/p&gt;&lt;p&gt;First, it is reverse engineering design from vision to action.&lt;/p&gt;&lt;p&gt;When Starbucks has only five stores, the founder has a vision to make Starbucks the third space in your life.&lt;/p&gt;&lt;p&gt;Starting with the vision, entrepreneurs need to design reverse engineering backwards: see what actions are needed to achieve the vision. Many entrepreneurs do not define their ultimate vision well, so they are busy putting out fires and surviving every day.&lt;/p&gt;&lt;p&gt;Second, fast cycle, low cost trials to provide evidence&lt;/p&gt;&lt;p&gt;With a vision to think about, how to do some fast and low-cost experiments to test creativity, to partners, customers and so on, this is a very good vision. In other words, you need short-term results as evidence.&lt;/p&gt;&lt;p&gt;Third, develop with forward-looking customers&lt;/p&gt;&lt;p&gt;Most customers are conservative and don&amp;#39;t want to waste time on new companies. You have to find visionary clients who are willing to take risks on you. They may be small, emerging customers, not good base customers in the market you want to enter.&lt;/p&gt;&lt;p&gt;Fourth: Create a comprehensive road map for trotting and fast running&lt;/p&gt;&lt;p&gt;It includes product roadmap, customer roadmap, partner roadmap and talent roadmap. An entrepreneur should have a road map for a year ｏｒ even three years to see how you want the company to make progress in these four dimensions.&lt;/p&gt;&lt;p&gt;For instance&lt;/p&gt;&lt;p&gt;In the late 1990s, John Osher invented SpinBrush, a low-cost electric toothbrush. Because he saw that there was a big gap in the market: ordinary manual toothbrushes cost two dollars each, and electric toothbrushes cost 50 dollars. But between the two, there is no intermediate product.&lt;/p&gt;&lt;p&gt;He wants to develop a toothbrush at a price somewhere between the two. He thought about the performance criteria for the success of the new toothbrush:&lt;/p&gt;&lt;p&gt;Cleaner than manual toothbrushes, ｏｒ consumers will not pay higher prices;&lt;/p&gt;&lt;p&gt;The self-contained batteries can last for three months, if the batteries need to be changed every week, they will collapse.&lt;/p&gt;&lt;p&gt;The packaging has the characteristics of trial use. We would like to see how the toothbrush rotates after starting.&lt;/p&gt;&lt;p&gt;The retail price is less than $6.&lt;/p&gt;&lt;p&gt;He positioned the new toothbrush as a better manual toothbrush rather than a cheaper electric toothbrush.&lt;/p&gt;&lt;p&gt;For consumers, it increased from $2 to $6, not from $50 to $6. Because if it&amp;#39;s the latter, retailers will feel compensated: consumers only spent $6, compared with $50 before. But now, consumers have gone from two to six.&lt;/p&gt;&lt;p&gt;So entrepreneurs need to think not only about end users, but also about how to make more money for distributors, because you have to go through them to get products to end customers. When defining competition, a good positioning statement is very important. Finally, he sold the company to P&amp;amp;amp;G, making a total of $480 million.&lt;/p&gt;&lt;p&gt;You see, it&amp;#39;s very simple, because he has a lot of consumer insights, filling the market gap that nobody sees.&lt;/p&gt;&lt;p&gt;Another example&lt;/p&gt;&lt;p&gt;Intuit, the company&amp;#39;s founder, discovered 20 years ago that many people have trouble filling out a tax return every year before handing it over to the government when they are dealing with their own taxes.&lt;/p&gt;&lt;p&gt;Intuit is the first company to develop personal finance software, especially tax management software, which can be used by both individuals and small businesses. But this useful package, no one knows where to sell it, no one believes it works.&lt;/p&gt;&lt;p&gt;Sometimes your biggest problem is how to get the distributor through your new product. They distribute a lot of things and don&amp;#39;t have time to spend five hours checking whether your unknown product works ｏｒ not.&lt;/p&gt;&lt;p&gt;Finally, he directly assured the consumer that if he bought the product, he would not learn how to use it in six minutes. The money would be refunded to you and the product would be given to you.&lt;/p&gt;&lt;p&gt;Besides refunding money, what else did they do differently?&lt;/p&gt;&lt;p&gt;With the buyer&amp;#39;s permission, follow the buyer to observe his first use.&lt;/p&gt;&lt;p&gt;All executives of the company have to spend two hours a month doing customer technical support and listening to customer problems.&lt;/p&gt;&lt;p&gt;Technical support for customer service is the only way for promotion in the company.&lt;/p&gt;&lt;p&gt;Read the customer&amp;#39;s letter aloud in front of all the executives, whether it&amp;#39;s thanks ｏｒ criticisms.&lt;/p&gt;&lt;p&gt;This makes 50% of their sales come from word of mouth.&lt;/p&gt;&lt;p&gt;&lt;br/&gt;&lt;/p&gt;', '1545271106', '1545271106');
INSERT INTO `ey_article_content` VALUES ('22', '63', '&lt;p&gt;Various marketing methods have long been dazzling, but the essence is to study customers (consumers), research the needs and needs of customers, and make products ｏｒ services targeted. The era of big data has given it a new term: precision marketing. The first areas where big data is applied are mostly for the customer-facing industry. The first application scenarios are mostly precision marketing.&lt;/p&gt;&lt;p&gt;&lt;br/&gt;&lt;/p&gt;&lt;p&gt;“Wine is good, and the alley is deep.” Information about products ｏｒ services should be delivered to customers before they can lead to transactions. It is generally believed that it is up to advertising to convey product ｏｒ service information to customers. Advertising has existed in the past, and the &amp;quot;three bowls are not on the job&amp;quot; wine cellar is advertising. In the era of no Internet, we are familiar with TV commercials, radio advertisements, print print advertisements, outdoor billboards, etc., of course, including sipping and selling. But the past advertisements are thousands of people and do not distinguish between audiences. Later, the merchants have collected CRM information from customers, and after customer classification, they can better serve different customer groups. The Internet + Big Data era has given CRM new opportunities for development. Managing customers is no longer a simple digital statistic and no personal (ｏｒ simple clustering) direct mail ｏｒ fixed investment. As merchants know more about customers and understand more deeply, they have the opportunity to provide customers with personalized marketing solutions to further improve the customer experience and become personalized marketing ｏｒ precision marketing. In the era of big data, many of the past impossibility has become possible, and marketing activities have also won new development opportunities.&lt;/p&gt;&lt;p&gt;&lt;br/&gt;&lt;/p&gt;&lt;p&gt;Different times, the form of business management will change, but the essence is two things: open source, throttling. Open source is to open up new customers and discover new business opportunities; throttling is to reduce internal operating costs and improve resource utilization efficiency. To achieve this requires data-driven decision making. In the past, people also collected and applied many strong related data related to business activities in long-term business activities, and also formed the criteria for selecting customers. In view of the technical bottleneck at that time, the cost of data collection and data analysis for large samples was too high to be widely used. In the era of big data, people have the possibility of collecting data and storing data cheaply. Cheap computing resources make data analysis possible.&lt;/p&gt;&lt;p&gt;&lt;br/&gt;&lt;/p&gt;&lt;p&gt;Behind the big data precision marketing is to use multi-dimensional data to observe customers, describe customers, that is, for customer portraits. It is no exaggeration to say that relying on big data can make marketers know customers better than in the past and understand customers&amp;#39; needs better than customers themselves. Marketers don&amp;#39;t want to know who the customer is, where they are, what the consumption habits are, what they need, when they need it, and how to pass them to them more effectively. The answer can be found through data collection and data analysis. Accurate marketing can not only help businesses open source -- discover potential customers, but also help merchants cut costs -- to identify potential risks. When we learn more about our customers, we know which customers may be at risk.&lt;/p&gt;&lt;p&gt;&lt;br/&gt;&lt;/p&gt;&lt;p&gt;If you ask each operator whether they will use their experience to market, most of the answers are yes. But if you ask the operators whether they will use the data for marketing, I am afraid the answer is very varied. It is generally believed that the application of data for marketing is a big company&amp;#39;s business, and it has no connection with small companies. In fact, as big as multinational companies, as small as street vendors, using data for marketing, they will receive unexpected results. Don&amp;#39;t believe it? Street vendors pay attention to the weather forecast (wind, rain, ｏｒ exposure) to know what business opportunities there are tomorrow, and then know how to stock up. It is recommended that people in small and medium-sized companies should not reject the idea of precision marketing, and may wish to learn the methods of precision marketing. Even if the operator has a wealth of experience, it will be helpful to digitize the experience to operate.&lt;/p&gt;&lt;p&gt;&lt;br/&gt;&lt;/p&gt;&lt;p&gt;The book &amp;quot;Subversion Marketing&amp;quot; is to teach readers how to use big data to do marketing. The book is rich in cases and the language is readable. It is worth reading about all the friends of big data marketing.&lt;/p&gt;&lt;p&gt;&lt;br/&gt;&lt;/p&gt;&lt;p&gt;I agree with many points in the book: &amp;quot;Big data redefines the rules of industrial competition, not the size of the data, not the statistical technology, nor the powerful computing power, but the ability to interpret the core data.&amp;quot; Today, many people are entangled in the definition of big data, we really should pay more attention to the core value understanding and application of data. The question asked in the book is also very important. The operators usually have a lot of problems, but when they ask the question, there may be deviations, which leads to &amp;quot;a thousand miles of lost.&amp;quot; Asking questions about the ability to improve involves thoughts and methods that need to be improved during exercise. Verifying that the question is right is exactly where the data analyst can contribute.&lt;/p&gt;&lt;p&gt;&lt;br/&gt;&lt;/p&gt;&lt;p&gt;The book also raises two questions that deserve more in-depth thinking:&lt;/p&gt;&lt;p&gt;&lt;br/&gt;&lt;/p&gt;&lt;p&gt;It is not enough to just find out the consumption habits of different customer groups and remind customers to spend at the right time. For example, a consumer&amp;#39;s normal rational consumption for one month is at the level of two thousand yuan, and is generally consumed in two stores, A and B. The A store uses the concept of precision marketing to allow consumers to spend both of these two thousand dollars in the A store. With the B store&amp;#39;s later, the consumer may return to the B store to spend two thousand dollars. Today, when the demand for excess supply is insufficient, the distribution ｏｒ migration of existing consumption among different businesses cannot bring about an increase in the total amount of social consumption. A higher level of application for big data marketing is to know in advance the needs of customers that have not been met ｏｒ even discovered. The value mining of big data has the opportunity to connect merchants (including manufacturers) with customers, so that merchants can provide more products ｏｒ services that meet the individual needs of customers, so that customers&amp;#39; willingness to consume will increase. This is a new challenge for data value mining workers.&lt;/p&gt;&lt;p&gt;&lt;br/&gt;&lt;/p&gt;&lt;p&gt;The more data, the better? Many big data companies are keen to use crawlers to &amp;quot;crawl&amp;quot; various data online. However, the same data set has different value density in different application scenarios. The specific application scenario is not the more data dimensions, the better. It is necessary to collect data and use data around the application target. Raising the dimension to collect more data must help to describe things in more detail, but undoubtedly increases the complexity of processing data. Every advancement in technology has brought new imagination to human beings. It is inevitable that desires will be inflated and confident, and the cognition of the world will be upgraded, even unrestrained. Later, it was discovered that the use of resources for the promotion of the dimension, the wisdom can not keep up, the unconstrained upgrade is the complexity of the solution, calm down will restart the thinking of dimensionality. Perhaps human cognition and wisdom are alternately moving forward in dimensioning, dimension reduction, re-elevation, and then dimension reduction. The book&amp;#39;s dimensionality thinking, if necessary, return to the element of thinking to give people a revelation.&lt;/p&gt;&lt;p&gt;&lt;br/&gt;&lt;/p&gt;&lt;p&gt;The tools of the big data era are of course important, and the way of thinking is more important.&lt;/p&gt;&lt;p&gt;&lt;br/&gt;&lt;/p&gt;', '1545271237', '1545271237');
INSERT INTO `ey_article_content` VALUES ('23', '64', '&lt;p&gt;After learning what seo means, you can learn seo.&lt;/p&gt;&lt;p&gt;&lt;br/&gt;&lt;/p&gt;&lt;p&gt;What is seo, from the official explanation, seo=Search Engine Optimization, which is search engine optimization.&lt;/p&gt;&lt;p&gt;&lt;br/&gt;&lt;/p&gt;&lt;p&gt;Use Baidu ｏｒ other search engines, enter a certain keyword in the search box, such as the wrought iron gate, the top is with the ad typeface, the background is slightly different is the bidding position, which is commonly known as the sem position.&lt;/p&gt;&lt;p&gt;&lt;br/&gt;&lt;/p&gt;&lt;p&gt;Seo is an online marketing method based on search engine marketing. Through seo technology, it can improve the keyword ranking of the website, get the display, and then get the exposure, and then get the user click, and then get the conversion.&lt;/p&gt;&lt;p&gt;&lt;br/&gt;&lt;/p&gt;&lt;p&gt;One: seo classification.&lt;/p&gt;&lt;p&gt;&lt;br/&gt;&lt;/p&gt;&lt;p&gt;In terms of refinement, all the points that are conducive to the promotion of the keyword ranking of the website can be summarized in the seo. For the sake of understanding, we divide the seo into the seo and the seo.&lt;/p&gt;&lt;p&gt;&lt;br/&gt;&lt;/p&gt;&lt;p&gt;1: SEO inside the station.&lt;/p&gt;&lt;p&gt;&lt;br/&gt;&lt;/p&gt;&lt;p&gt;What is a seo in the station? In general terms, it refers to the internal optimization of the website, that is, the internal optimization of the website itself, including code tag optimization, content optimization, security construction, user experience and so on.&lt;/p&gt;&lt;p&gt;&lt;br/&gt;&lt;/p&gt;&lt;p&gt;2: SEO outside the station.&lt;/p&gt;&lt;p&gt;&lt;br/&gt;&lt;/p&gt;&lt;p&gt;What is a stand outside seo? Generally speaking, it is the external optimization of the website, including external chain construction, brand building, speed optimization, and drainage.&lt;/p&gt;&lt;p&gt;&lt;br/&gt;&lt;/p&gt;&lt;p&gt;Two: seo related advice.&lt;/p&gt;&lt;p&gt;&lt;br/&gt;&lt;/p&gt;&lt;p&gt;1: It is recommended to position seo in an online marketing mode. In the process of learning and using seo, it is used as a channel for obtaining traffic.&lt;/p&gt;&lt;p&gt;&lt;br/&gt;&lt;/p&gt;&lt;p&gt;2: The ideal platform for novices to learn seo is Baidu search resource platform rather than others; theory and practical operation is a more effective way of learning; experienced seo masters can master seo faster; more thinking, more summaries, can comprehend The essence of seo.&lt;/p&gt;&lt;p&gt;&lt;br/&gt;&lt;/p&gt;&lt;p&gt;3: Before learning seo, it is necessary to be familiar with the relevant seo terms.&lt;/p&gt;&lt;p&gt;&lt;br/&gt;&lt;/p&gt;&lt;p&gt;4: Many times, the theory and reality of seo are contrary to each other. That is to say, the theoretical point of seo is not complicated, and the operating point is difficult to achieve.&lt;/p&gt;&lt;p&gt;&lt;br/&gt;&lt;/p&gt;&lt;p&gt;Novices are exposed to seo and feel at a loss. Please read the seo terminology and it will become easier later.&lt;/p&gt;&lt;p&gt;&lt;br/&gt;&lt;/p&gt;', '1545271307', '1545271307');
INSERT INTO `ey_article_content` VALUES ('24', '65', '&lt;p&gt;With the enrichment and development of web applications, many websites often cannot quickly follow the footsteps of a large amount of information derivation and business model changes. It often takes a lot of time, manpower and material resources to handle information ｕｐｄａｔｅ and maintenance work. When encountering website expansion, The integration of internal and external networks and branch sites has become more complicated, and even the need to rebuild the website; so, users continue to upgrade and integrate in a high-cost, low-efficiency cycle...&lt;/p&gt;&lt;p&gt;&lt;br/&gt;&lt;/p&gt;&lt;p&gt;So, we heard feedback from many users:&lt;/p&gt;&lt;p&gt;&lt;br/&gt;&lt;/p&gt;&lt;p&gt;The page is produced out of order, the style of the website is not uniform, and a large amount of information is accumulated, and the release is extremely heavy;&lt;/p&gt;&lt;p&gt;&lt;br/&gt;&lt;/p&gt;&lt;p&gt;The content is complicated, manual management is inefficient, and manual linking of video and audio information is often impossible;&lt;/p&gt;&lt;p&gt;&lt;br/&gt;&lt;/p&gt;&lt;p&gt;The application is difficult, and many jobs require the cooperation of technical personnel to complete, and the division of roles is not clear;&lt;/p&gt;&lt;p&gt;&lt;br/&gt;&lt;/p&gt;&lt;p&gt;The revision workload is large, the system expansion capability is poor, and the flexibility is reduced when integrating other applications;&lt;/p&gt;&lt;p&gt;&lt;br/&gt;&lt;/p&gt;&lt;p&gt;For website construction and information release personnel, they are most concerned about the ease of use and functionality of the system. Therefore, this puts a high demand on website construction and information publishing tools.&lt;/p&gt;&lt;p&gt;&lt;br/&gt;&lt;/p&gt;&lt;p&gt;First of all, the role is clearly defined to fully ensure the efficiency of the staff; secondly, the function is complete, to meet the needs of the doorkeeper &amp;quot;gatekeeper&amp;quot; application, so that the information is released accurately. For example, set permissions and real-time management functions for editors, artists, editors, and operations personnel.&lt;/p&gt;&lt;p&gt;&lt;br/&gt;&lt;/p&gt;&lt;p&gt;In addition, the security of the website architecture is also the focus of users. It can effectively manage the login rights of website visitors, so that the intranet database is not attacked, thus ensuring the security and stability of the website at all times and avoiding the worries of users.&lt;/p&gt;&lt;p&gt;&lt;br/&gt;&lt;/p&gt;&lt;p&gt;According to the above requirements, a professional content management system CMS came into being to effectively solve the common problems and needs in user website construction and information release. The management of website content is the biggest advantage of the software. It has complete processes and rich functions. It can classify manuscripts and authorize them to edit and manage them. It does not require users to pay attention to the incomprehensible SQL syntax.&lt;/p&gt;&lt;p&gt;&lt;br/&gt;&lt;/p&gt;', '1545272018', '1545272018');
INSERT INTO `ey_article_content` VALUES ('25', '66', '&lt;p&gt;SEO (Search Engine Optimization) and effective website design go hand in hand. Good website design is about creating a website that appeals to your target audience and letting them take some action. However, if the site does not follow current SEO best practices, its ranking will be affected, resulting in fewer visitors actually participating in the site.&lt;/p&gt;&lt;p&gt;&lt;br/&gt;&lt;/p&gt;&lt;p&gt;Conversely, if you focus on search engine optimization and how to please search engine spiders, then the site may rank high and get a lot of search engine traffic, but if the design is not satisfactory, it will be different. It is. In order to succeed in today&amp;#39;s digital environment, the focus must be on website design and search engine optimization.&lt;/p&gt;&lt;p&gt;&lt;br/&gt;&lt;/p&gt;&lt;p&gt;1. But, does SEO not kill the creativity of web designers?&lt;/p&gt;&lt;p&gt;&lt;br/&gt;&lt;/p&gt;&lt;p&gt;In the past five years, the huge demand for “optimized design” has been accepted by web designers. Prior to this, designers focused on the user experience rather than the &amp;quot;robot&amp;quot; experience.&lt;/p&gt;&lt;p&gt;&lt;br/&gt;&lt;/p&gt;&lt;p&gt;Today, designers not only want to make the site look attractive, but also to ensure that the ｃａｌｌ to action must meet the &amp;quot;folding&amp;quot; requirements of the site page, the site must be loaded quickly, must use the breadcrumb path, clear navigation options, must With CSS, JavaScript files must be kept to a minimum... this is a daunting task.&lt;/p&gt;&lt;p&gt;&lt;br/&gt;&lt;/p&gt;&lt;p&gt;Some designers may wonder if all these new SEO rules would undermine the freedom to create a website?&lt;/p&gt;&lt;p&gt;&lt;br/&gt;&lt;/p&gt;&lt;p&gt;For &amp;quot;clean&amp;quot; website design, it can help a website ｌｏａｄ quickly and be easily crawled by search engine spiders. Therefore, in reality, creativity and optimization need to be able to “prosper” together at the same time.&lt;/p&gt;&lt;p&gt;&lt;br/&gt;&lt;/p&gt;&lt;p&gt;Second, combine them together&lt;/p&gt;&lt;p&gt;&lt;br/&gt;&lt;/p&gt;&lt;p&gt;There are some core elements that support every SEO strategy and website design project:&lt;/p&gt;&lt;p&gt;&lt;br/&gt;&lt;/p&gt;&lt;p&gt;Keyword analysis&lt;/p&gt;&lt;p&gt;&lt;br/&gt;&lt;/p&gt;&lt;p&gt;A thorough keyword analysis is required when launching a commercial website project. In order to do this, web designers must understand the target audience of the customer closely and define how the demographic structure of the audience fits into the larger target market that the company is trying to achieve. Then, you should do the appropriate keyword/long tail keyword optimization for the website.&lt;/p&gt;&lt;p&gt;&lt;br/&gt;&lt;/p&gt;&lt;p&gt;2. Content hierarchy&lt;/p&gt;&lt;p&gt;&lt;br/&gt;&lt;/p&gt;&lt;p&gt;For a company, creating good content is not enough, they must also strategically plan where the content is.&lt;/p&gt;&lt;p&gt;&lt;br/&gt;&lt;/p&gt;&lt;p&gt;Effective planning means putting relevant content in a virtual container, with a creative design and internal links that make the content hierarchy visible at a glance. And, an optimized website is a website that is friendly to both users and search engine spiders.&lt;/p&gt;&lt;p&gt;&lt;br/&gt;&lt;/p&gt;&lt;p&gt;3. Think from the perspective of the user&lt;/p&gt;&lt;p&gt;&lt;br/&gt;&lt;/p&gt;&lt;p&gt;In general, the more pages ｏｒ articles you have on your site, the more opportunities your target users will find. When they land on these specific pages, you need to make sure that you can help them find you easily.&lt;/p&gt;&lt;p&gt;&lt;br/&gt;&lt;/p&gt;&lt;p&gt;So you have to think from the user&amp;#39;s point of view, let the user know immediately the current location of the page they are visiting, and help the user switch from page to page with as few clicks as possible.&lt;/p&gt;&lt;p&gt;&lt;br/&gt;&lt;/p&gt;&lt;p&gt;3. Why is the SEO strategy so important?&lt;/p&gt;&lt;p&gt;&lt;br/&gt;&lt;/p&gt;&lt;p&gt;Having the right site structure and information architecture will ultimately help companies deliver a compelling user experience while reducing the need for every new growth. However, unless your brand is well known, it is often the search engine that is responsible for most of the traffic received by the site. The SEO strategy has the ability to leverage key customer data to mine new potential revenue streams.&lt;/p&gt;&lt;p&gt;&lt;br/&gt;&lt;/p&gt;&lt;p&gt;For website owners who are trying to do SEO, there are some places that are often troublesome. Now, I will provide search engine optimization suggestions for website owners to get higher ranking pages.&lt;/p&gt;&lt;p&gt;&lt;br/&gt;&lt;/p&gt;&lt;p&gt;1. URL structure&lt;/p&gt;&lt;p&gt;&lt;br/&gt;&lt;/p&gt;&lt;p&gt;URLs created by most websites contain many random characters, such as question marks, no keywords, ｏｒ anything of value. When the search engine&amp;#39;s URL contains SEO keywords ｏｒ phrases, the page will rank higher in the search engine. Therefore, it is very important to set keywords in the URL.&lt;/p&gt;&lt;p&gt;&lt;br/&gt;&lt;/p&gt;&lt;p&gt;2. The title of the page&lt;/p&gt;&lt;p&gt;&lt;br/&gt;&lt;/p&gt;&lt;p&gt;One of the most important factors in search engine ranking is the page title. However, many websites have not changed their page titles. In the Lime website, you can use the SEO title tag plugin, which makes it easy for you to create titles for your articles and pages.&lt;/p&gt;&lt;p&gt;&lt;br/&gt;&lt;/p&gt;&lt;p&gt;3. Duplicate content&lt;/p&gt;&lt;p&gt;&lt;br/&gt;&lt;/p&gt;&lt;p&gt;No search engine likes to see duplicate content. Duplicate content is a major issue for some websites, as category pages and calendar/date pages often cause search engines to find the same content on multiple pages.&lt;/p&gt;&lt;p&gt;&lt;br/&gt;&lt;/p&gt;&lt;p&gt;There are several ways for website owners to overcome duplicate content issues. One way is to use a robot.txt file to guide the search engine which pages should be ignored, leaving only the main page to be indexed.&lt;/p&gt;&lt;p&gt;&lt;br/&gt;&lt;/p&gt;&lt;p&gt;4. Meta tags&lt;/p&gt;&lt;p&gt;&lt;br/&gt;&lt;/p&gt;&lt;p&gt;When designing a traditional static website, you can enter a meta tag (description) for each page. Although the impact of these tags on search engine rankings is not as great as it used to be, having these tags on your page doesn&amp;#39;t hurt.&lt;/p&gt;&lt;p&gt;&lt;br/&gt;&lt;/p&gt;&lt;p&gt;However, most site-building platforms do not give users the option to add meta tags when writing articles. For users of the Lime website, adding a meta tag plugin will allow you to enter a meta tag for any page.&lt;/p&gt;&lt;p&gt;&lt;br/&gt;&lt;/p&gt;&lt;p&gt;4. What is the role of web designers in SEO?&lt;/p&gt;&lt;p&gt;&lt;br/&gt;&lt;/p&gt;&lt;p&gt;Search engine optimization is an ongoing process that cannot be achieved by designing a website in a specific way. Of course, web designers should put a lot of effort into helping customers build an optimized site, but what are the responsibilities of web designers for SEO and what are their responsibilities?&lt;/p&gt;&lt;p&gt;&lt;br/&gt;&lt;/p&gt;&lt;p&gt;As a business owner, the optimization of your website is more important to you than the designer (this is not to say that the designer does not care, but the designer&amp;#39;s attention is usually focused on the visual and functional aspects of the website). You know your customers/leaders better than the designers, so you should have more constructive advice on your goals.&lt;/p&gt;&lt;p&gt;&lt;br/&gt;&lt;/p&gt;&lt;p&gt;Maybe some customers may not know much about SEO and target keywords, so the ideal situation is to let customers and you work together on this issue.&lt;/p&gt;&lt;p&gt;&lt;br/&gt;&lt;/p&gt;&lt;p&gt;In my experience, one of the easiest ways to get customers involved is to simply explain the words and phrases (titles, copywriting, etc.) used on the site that have a direct impact on the site&amp;#39;s ranking.&lt;/p&gt;&lt;p&gt;&lt;br/&gt;&lt;/p&gt;&lt;p&gt;I usually ask customers to give me a list of words and phrases that they think potential visitors might use in their searches. This is especially important when designing websites in industries that I am not familiar with.&lt;/p&gt;&lt;p&gt;&lt;br/&gt;&lt;/p&gt;&lt;p&gt;Of course, some research may be needed. Should the customer take responsibility for keyword research ｏｒ should it be the responsibility of the designer?&lt;/p&gt;&lt;p&gt;&lt;br/&gt;&lt;/p&gt;&lt;p&gt;My experience is that this research is usually more effective if the customer is involved, but this is not always possible. Designers should have enough knowledge to advise clients and should be willing to help, but in the end it is best to get the customer involved as much as possible. In fact, if the customer cares about SEO, the participation process will achieve a more reasonable expectation.&lt;/p&gt;&lt;p&gt;&lt;br/&gt;&lt;/p&gt;&lt;p&gt;Setting realistic expectations may also be the responsibility of the designer.&lt;/p&gt;&lt;p&gt;&lt;br/&gt;&lt;/p&gt;&lt;p&gt;I have some potential customers who come to me and say, “I was told by SEO experts that by inserting popular keywords on the website page, I can rank my website first ｏｒ second”.&lt;/p&gt;&lt;p&gt;&lt;br/&gt;&lt;/p&gt;&lt;p&gt;In this case, I will obviously point out that &amp;quot;search engine optimization requires continuous work, and this kind of work can usually not be done by creating a website in some way.&amp;quot;&lt;/p&gt;&lt;p&gt;&lt;br/&gt;&lt;/p&gt;&lt;p&gt;I often advise customers to add a blog on their website to get more content and increase their chances of ranking.&lt;/p&gt;&lt;p&gt;&lt;br/&gt;&lt;/p&gt;&lt;p&gt;Conclusion&lt;/p&gt;&lt;p&gt;&lt;br/&gt;&lt;/p&gt;&lt;p&gt;While this is a short summary, these are the most important SEO topics that website owners and designers will face. By understanding this knowledge, you can better create websites that are user-friendly and search engine friendly.&lt;/p&gt;&lt;p&gt;&lt;br/&gt;&lt;/p&gt;&lt;p&gt;This article is designed by Yi You Xiaobian Original Authorized to publish Yiyou website, unauthorized, reprinted.&lt;/p&gt;&lt;p&gt;&lt;br/&gt;&lt;/p&gt;', '1545272054', '1545272054');
INSERT INTO `ey_article_content` VALUES ('26', '67', '&lt;p&gt;Many SEO partners understand that search engine ranking optimization is optimized by internal and external websites. When users search for corresponding keywords, the website can be ranked in front of the search engine. Specifically, Baidu search &amp;quot;network marketing course&amp;quot; to view the operation of Shangmeng. Case!&lt;/p&gt;&lt;p&gt;&lt;br/&gt;&lt;/p&gt;&lt;p&gt;But a single page SEO many partners may be a bit strange, single-page SEO is a SEO optimization program that combines a single-page website with content content, mainly to improve the website traffic utilization so that users can see the target page when they open the website, and the conversion is more More orders, create more revenue. The operation concept of the single-page SEO is also proposed by Shangmeng.com, and together it is recommended to operate the model.&lt;/p&gt;&lt;p&gt;&lt;br/&gt;&lt;/p&gt;&lt;p&gt;So what is a single-page SEO station group, because the success rate of operating SEO is not 100%, which means that you do not definitely have a ranking. Because at any time the search engine, especially Baidu&amp;#39;s index database, only 60% of the number of pages. That is to say, a large number of web pages are not included, and its own capabilities are limited to all the tens of billions of web pages in Chinese. So, for most sites, there are deleted pages, no rankings, ｏｒ experiences with K, ｏｒ no rankings. Deal with it: calmly face it all. How much is the cost of a website? If you lose confidence in SEO, it is the biggest loss.&lt;/p&gt;&lt;p&gt;&lt;br/&gt;&lt;/p&gt;&lt;p&gt;However, we also thought of a better solution. We started the operation in the earliest stage and achieved a very good result of “station group”. We can assume that the chance of a website ranking is 1, if we use 10 Websites can be upgraded by 10 times for optimal rankings. We don’t require 10 websites to get rankings. We only need 1 to 3 websites to get rankings. This operation is successful because we put 10 websites for our group. The cost is about 1000 yuan; this investment is also very cost-effective, this idea is actually a bit like bidding, unlike traditional SEO, because the traditional SEO we invest in a website cost one ｏｒ two hundred, we want to get the ranking, and then give us a few hundred Thousands of times return. The result is equivalent to pinning our hopes on a tree. As a result, the tree has not blossomed and we are starving.&lt;/p&gt;&lt;p&gt;&lt;br/&gt;&lt;/p&gt;&lt;p&gt;Wanting to build dozens of websites for a project also requires a lot of technology, especially in terms of mass construction and post-maintenance. This single-page SEO station group operation method upgraded by Shangmeng Online School does not have a long story to show you how to do it. You only need to copy the methods we provide. Of course, there are also a lot of core technologies in it. For example, domain registration and space purchase techniques are very simple, but they will directly affect our later operation results. The skills we provide will also lower your costs. If you invest in 10 websites. The cost of domain names and space is less than $1,000. Equivalent to 1000 you can start a station group project. The core is still the collection of the article. Our principle is to use the locomotive to collect original articles and then realize the automatic release of the hang-up. It only needs to set the software to automatically ｕｐｄａｔｅ the website articles when the software is running every day, and automatically automatically advertise the text automatically. . Many of these students may ask if it will be too complicated. You can tell us the complicated work. We have already helped you to get it. When you use it, it is already a packaged solution.&lt;/p&gt;&lt;p&gt;&lt;br/&gt;&lt;/p&gt;&lt;p&gt;The overall construction of the website can be done in the early stage, but the real test is based on the later optimization. For the post-optimization of the website, especially the addition of the external link and the weight, we still have no long-term discussion to give you a practical and efficient demonstration. The way to get your station group to quickly get included, increase the weight, get the ranking, you need to do to copy the methods and models of our business dream school; these experiences are compiled by our long-term operation, not the result of a few days of cultivation .&lt;/p&gt;&lt;p&gt;&lt;br/&gt;&lt;/p&gt;', '1545272097', '1545272097');
INSERT INTO `ey_article_content` VALUES ('27', '68', '&lt;p&gt;Note: The User Interface (UI) design is one of several interdisciplinary topics involved in designing software products. Whether it is user experience (UX, User Experience), interaction design (ID, Interaction Design), ｏｒ visual / graphic design (Visual / Graphic Design), can involve user interface design.&lt;/p&gt;&lt;p&gt;&lt;br/&gt;&lt;/p&gt;&lt;p&gt;First, what is the user interface design?&lt;/p&gt;&lt;p&gt;&lt;br/&gt;&lt;/p&gt;&lt;p&gt;Broadly speaking, the user interface is the medium through which people interact with machines. The user issues an instruction to the machine, and the machine begins a process, responds to the message, and gives feedback. Users can make decisions about the next step based on user feedback.&lt;/p&gt;&lt;p&gt;&lt;br/&gt;&lt;/p&gt;&lt;p&gt;Human Computer Inter-citon (HCI) focuses on the digital interface, that is, the past punch, command line, and today&amp;#39;s graphical interface (GUI, Graphic Design).&lt;/p&gt;&lt;p&gt;&lt;br/&gt;&lt;/p&gt;&lt;p&gt;User interface design For digital products, the main focus is on layout, information structure, and the display of interface elements on the display and various terminal platforms. Video games and TV interfaces are also included.&lt;/p&gt;&lt;p&gt;&lt;br/&gt;&lt;/p&gt;', '1545272159', '1545272159');
INSERT INTO `ey_article_content` VALUES ('28', '69', '&lt;p&gt;Z Yuhan: User Interface (UI) design is one of several interdisciplinary topics involved in designing software products. Whether it is user experience (UX, User Experience), interaction design (ID, Interaction Design), ｏｒ visual / graphic design (Visual / Graphic Design), can involve user interface design.&lt;/p&gt;&lt;p&gt;&lt;br/&gt;&lt;/p&gt;&lt;p&gt;First, what is the user interface design?&lt;/p&gt;&lt;p&gt;Broadly speaking, the user interface is the medium through which people interact with machines. The user issues an instruction to the machine, and the machine begins a process, responds to the message, and gives feedback. Users can make decisions about the next step based on user feedback.&lt;/p&gt;&lt;p&gt;&lt;br/&gt;&lt;/p&gt;&lt;p&gt;Human Computer Inter-citon (HCI) focuses on the digital interface, that is, the past punch, command line, and today&amp;#39;s graphical interface (GUI, Graphic Design).&lt;/p&gt;&lt;p&gt;&lt;br/&gt;&lt;/p&gt;&lt;p&gt;User interface design For digital products, the main focus is on layout, information structure, and the display of interface elements on the display and various terminal platforms. Video games and TV interfaces are also included.&lt;/p&gt;&lt;p&gt;&lt;br/&gt;&lt;/p&gt;', '1545272218', '1545272218');
INSERT INTO `ey_article_content` VALUES ('29', '70', '&lt;p&gt;In the early morning of May 31st, Beijing time, Mary Mickel, who is known as the “Queen of the Internet”, published the Internet Trend Report for 2018, which is the 23rd year of her Internet report.&lt;/p&gt;&lt;p&gt;&lt;br/&gt;&lt;/p&gt;&lt;p&gt;The annual Internet Queen&amp;#39;s report will almost always become a must-read report for every Internet entrepreneur. So, who is the Internet Queen? Why is her report so concerned?&lt;/p&gt;&lt;p&gt;&lt;br/&gt;&lt;/p&gt;&lt;p&gt;Internet Queen: The symbol of Wall Street in the 90s&lt;/p&gt;&lt;p&gt;&lt;br/&gt;&lt;/p&gt;&lt;p&gt;In September 1958, Mary Meeker was born in Indiana, USA.&lt;/p&gt;&lt;p&gt;&lt;br/&gt;&lt;/p&gt;&lt;p&gt;In 1982, Mikel joined Merrill Lynch, the most prestigious brokerage company at the time, as a stockbroker.&lt;/p&gt;&lt;p&gt;&lt;br/&gt;&lt;/p&gt;&lt;p&gt;Mickel’s star analysts began in 1991, when she joined the well-known investment bank Morgan Stanley and began her brilliant career as a technology analyst.&lt;/p&gt;&lt;p&gt;&lt;br/&gt;&lt;/p&gt;&lt;p&gt;Since 1995, Mikel&amp;#39;s work has changed with the changing trend of the Internet. She has focused on how well-known companies such as Yahoo, AOL and Amazon will adjust their structure and compete with each other.&lt;/p&gt;&lt;p&gt;&lt;br/&gt;&lt;/p&gt;&lt;p&gt;In 1996, Mary Mickel became the head of Morgan Stanley&amp;#39;s technology stock analysis department, and created a new career on Wall Street – Internet analysts. Just as junk bonds represent Wall Street in the 1980s, Mary Mickel became a symbol of Wall Street in the 1990s.&lt;/p&gt;&lt;p&gt;&lt;br/&gt;&lt;/p&gt;&lt;p&gt;At the end of 2010, Mikel resigned as managing director of Morgan Stanley, left Wall Street, and went to California to become a partner of the well-known venture capital KPCB. KPCB (Kleiner Perkins Caufield &amp;amp; Byers) was founded in 1972 and is the largest venture fund in the United States. Its most proud masterpiece is the creation of Netscape.&lt;/p&gt;&lt;p&gt;&lt;br/&gt;&lt;/p&gt;&lt;p&gt;Internet Queen&amp;#39;s Report: Investment in the Internet, Bible, stock selection guide&lt;/p&gt;&lt;p&gt;&lt;br/&gt;&lt;/p&gt;&lt;p&gt;In 1994, Mikel accidentally saw a story about the startup&amp;#39;s Mosaic web browser in the New York Times. Mikel immediately realized that such a web browser might change the way people get information. She then contacted the two founders of Mosaic and introduced the company to Wall Street investors.&lt;/p&gt;&lt;p&gt;&lt;br/&gt;&lt;/p&gt;&lt;p&gt;Mosaic later changed its name to Netscape and was listed in New York in 1995. Thanks to the good relationship between Mikel and Netscape&amp;#39;s founders, Morgan Stanley became the lead underwriter for Netscape&amp;#39;s initial public offering (IPO).&lt;/p&gt;&lt;p&gt;&lt;br/&gt;&lt;/p&gt;&lt;p&gt;On August 9 of that year, Netscape closed on the first day of listing, and the stock price surged from the issue price of US$14 to US$75, setting a record for the first day of the listed company. Netscape IPO also became a major symbol of the arrival of the Internet era.&lt;/p&gt;&lt;p&gt;&lt;br/&gt;&lt;/p&gt;&lt;p&gt;In 1995, in addition to being responsible for the listing of Netscape, Mikel and his colleague Chris Opp began to publish the &amp;quot;Internet Report&amp;quot;, and first proposed the analysis of network stocks such as &amp;quot;page views&amp;quot;. This report is regarded by investors as an investment Bible in the Internet field, and it has been published in public, which has caused great repercussions in the entire technology industry.&lt;/p&gt;&lt;p&gt;&lt;br/&gt;&lt;/p&gt;&lt;p&gt;In 1996-1997, Mikel and Morgan Stanley released the &amp;quot;Internet Advertising Report&amp;quot; and &amp;quot;Internet Retail Report&amp;quot;, which laid the foundation for the first analyst of Mikel&amp;#39;s Internet field. The Internet Queen’s report almost became a must-read report for every Internet entrepreneur at the time.&lt;/p&gt;&lt;p&gt;&lt;br/&gt;&lt;/p&gt;&lt;p&gt;The Internet Queen’s report is tantamount to a stock picking guide. The stocks of companies such as AOL, Dell, Amazon, and eBay that she recommended to investors quickly brought in more than ten times the return on investment.&lt;/p&gt;&lt;p&gt;&lt;br/&gt;&lt;/p&gt;&lt;p&gt;&amp;quot;God Prediction&amp;quot; in the Internet Queen&amp;#39;s Report&lt;/p&gt;&lt;p&gt;&lt;br/&gt;&lt;/p&gt;&lt;p&gt;The main reason why the industry values the Internet Queen’s report so much is the predictions of Mikel’s gods. Below, we briefly list some examples of God predictions in the Internet Queen&amp;#39;s report.&lt;/p&gt;&lt;p&gt;&lt;br/&gt;&lt;/p&gt;', '1545272280', '1545272280');
INSERT INTO `ey_article_content` VALUES ('30', '71', '&lt;p&gt;Website construction, static pages and dynamic pages how to choose&lt;/p&gt;&lt;p&gt;&lt;br/&gt;&lt;/p&gt;&lt;p&gt;Why should e-commerce website construction use static page production? We all know that website production is divided into static page production and dynamic web page production. So which website design technology is better for building e-commerce websites?&lt;/p&gt;&lt;p&gt;&lt;br/&gt;&lt;/p&gt;&lt;p&gt;The ultimate goal of our website is to provide users with a view, so it is most practical to think from the user&amp;#39;s point of view. Although the dynamic webpage creation technology has greatly improved the aesthetics of the webpage, it is not conducive to website optimization. Today&amp;#39;s Xiaobian focus and Let&amp;#39;s talk about why website construction uses static pages.&lt;/p&gt;&lt;p&gt;&lt;img alt=&quot;&quot; class=&quot;limg&quot; src=&quot;/uploads/allimg/20181220/4e7474448185b797c4c1d796b3e581fe.jpg&quot; style=&quot;box-sizing: inherit; border-style: none; vertical-align: top; max-width: 100%; height: auto !important;&quot;/&gt;&lt;/p&gt;&lt;p&gt;　　&lt;/p&gt;&lt;p&gt;The technical principle adopted for static website construction is one-to-one. That is to say, on a website, one content corresponds to one page. No matter how the website visitor operates, the server only transmits the inherent data to the requester. There is no script calculation and background database reading process, which greatly reduces some security risks. In addition to the above-mentioned features of high speed and high security, the static website design also has cross-platform and cross-server functions.&lt;/p&gt;&lt;p&gt;&lt;br/&gt;&lt;/p&gt;&lt;p&gt;Now friends who are familiar with the working principle of the search engine should know that the information it provides to the majority of users is the information that exists in the database itself rather than the real-time information. The fixed information content is easier to accept and save. We may often encounter such problems. When we search for the information we need, the results may have expired. This is the inadequacy of static page website design, but because it is stable, it will not be ｄｅｌｅｔｅ.&lt;/p&gt;&lt;p&gt;&lt;br/&gt;&lt;/p&gt;&lt;p&gt;Different from static page website design, the generated dynamic page information is not only difficult to be searched by search engines, but also slow to open and unstable. This is why so many professional website construction companies have repeatedly suggested that customers use static forms of website design. The reason is that some website construction companies will consider pseudo-static processing of the page, but I don&amp;#39;t know if you have noticed that the pseudo-statically processed URL is usually irregular.&lt;/p&gt;&lt;p&gt;&lt;br/&gt;&lt;/p&gt;', '1547463680', '1547463680');

-- -----------------------------
-- Table structure for `ey_auth_role`
-- -----------------------------
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

-- -----------------------------
-- Records of `ey_auth_role`
-- -----------------------------
INSERT INTO `ey_auth_role` VALUES ('1', '优化推广员', '0', '', '0', 'a:1:{i:0;s:2:\"cn\";}', '0', '1', 'a:3:{i:0;s:3:\"add\";i:1;s:4:\"edit\";i:2;s:3:\"del\";}', 'a:2:{s:5:\"rules\";a:8:{i:0;s:1:\"1\";i:1;s:1:\"3\";i:2;s:1:\"4\";i:3;s:1:\"8\";i:4;s:1:\"9\";i:5;s:2:\"10\";i:6;s:2:\"14\";i:7;i:2;}s:7:\"arctype\";a:63:{i:0;s:1:\"1\";i:1;s:1:\"2\";i:2;s:1:\"3\";i:3;s:1:\"4\";i:4;s:1:\"5\";i:5;s:1:\"6\";i:6;s:2:\"33\";i:7;s:2:\"34\";i:8;s:2:\"35\";i:9;s:2:\"36\";i:10;s:2:\"37\";i:11;s:2:\"38\";i:12;s:2:\"39\";i:13;s:2:\"40\";i:14;s:2:\"41\";i:15;s:2:\"42\";i:16;s:2:\"43\";i:17;s:2:\"44\";i:18;s:2:\"45\";i:19;s:2:\"46\";i:20;s:2:\"47\";i:21;s:2:\"48\";i:22;s:1:\"8\";i:23;s:2:\"32\";i:24;s:1:\"9\";i:25;s:2:\"30\";i:26;s:2:\"31\";i:27;s:2:\"11\";i:28;s:2:\"12\";i:29;s:2:\"13\";i:30;s:2:\"23\";i:31;s:2:\"20\";i:32;s:2:\"24\";i:33;s:2:\"25\";i:34;s:2:\"21\";i:35;s:2:\"26\";i:36;s:2:\"22\";i:37;s:2:\"27\";i:38;s:2:\"28\";i:39;s:2:\"29\";i:40;s:2:\"31\";i:41;s:2:\"32\";i:42;s:2:\"33\";i:43;s:2:\"34\";i:44;s:2:\"35\";i:45;s:2:\"36\";i:46;s:2:\"37\";i:47;s:2:\"38\";i:48;s:2:\"39\";i:49;s:2:\"40\";i:50;s:2:\"41\";i:51;s:2:\"42\";i:52;s:2:\"43\";i:53;s:2:\"44\";i:54;s:2:\"45\";i:55;s:2:\"46\";i:56;s:2:\"47\";i:57;s:2:\"48\";i:58;s:2:\"49\";i:59;s:2:\"50\";i:60;s:2:\"51\";i:61;s:2:\"52\";i:62;s:2:\"53\";}}', '1', '100', '1', '0', '1541207843', '0');
INSERT INTO `ey_auth_role` VALUES ('2', '内容管理员', '0', '', '0', 'a:1:{i:0;s:2:\"cn\";}', '0', '1', 'a:3:{i:0;s:3:\"add\";i:1;s:4:\"edit\";i:2;s:3:\"del\";}', 'a:2:{s:5:\"rules\";a:4:{i:0;s:1:\"1\";i:1;s:2:\"10\";i:2;s:2:\"14\";i:3;i:2;}s:7:\"arctype\";a:63:{i:0;s:1:\"1\";i:1;s:1:\"2\";i:2;s:1:\"3\";i:3;s:1:\"4\";i:4;s:1:\"5\";i:5;s:1:\"6\";i:6;s:2:\"33\";i:7;s:2:\"34\";i:8;s:2:\"35\";i:9;s:2:\"36\";i:10;s:2:\"37\";i:11;s:2:\"38\";i:12;s:2:\"39\";i:13;s:2:\"40\";i:14;s:2:\"41\";i:15;s:2:\"42\";i:16;s:2:\"43\";i:17;s:2:\"44\";i:18;s:2:\"45\";i:19;s:2:\"46\";i:20;s:2:\"47\";i:21;s:2:\"48\";i:22;s:1:\"8\";i:23;s:2:\"32\";i:24;s:1:\"9\";i:25;s:2:\"30\";i:26;s:2:\"31\";i:27;s:2:\"11\";i:28;s:2:\"12\";i:29;s:2:\"13\";i:30;s:2:\"23\";i:31;s:2:\"20\";i:32;s:2:\"24\";i:33;s:2:\"25\";i:34;s:2:\"21\";i:35;s:2:\"26\";i:36;s:2:\"22\";i:37;s:2:\"27\";i:38;s:2:\"28\";i:39;s:2:\"29\";i:40;s:2:\"31\";i:41;s:2:\"32\";i:42;s:2:\"33\";i:43;s:2:\"34\";i:44;s:2:\"35\";i:45;s:2:\"36\";i:46;s:2:\"37\";i:47;s:2:\"38\";i:48;s:2:\"39\";i:49;s:2:\"40\";i:50;s:2:\"41\";i:51;s:2:\"42\";i:52;s:2:\"43\";i:53;s:2:\"44\";i:54;s:2:\"45\";i:55;s:2:\"46\";i:56;s:2:\"47\";i:57;s:2:\"48\";i:58;s:2:\"49\";i:59;s:2:\"50\";i:60;s:2:\"51\";i:61;s:2:\"52\";i:62;s:2:\"53\";}}', '1', '100', '1', '0', '1541207846', '0');

-- -----------------------------
-- Table structure for `ey_channelfield`
-- -----------------------------
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

-- -----------------------------
-- Records of `ey_channelfield`
-- -----------------------------
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

-- -----------------------------
-- Table structure for `ey_channeltype`
-- -----------------------------
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

-- -----------------------------
-- Records of `ey_channeltype`
-- -----------------------------
INSERT INTO `ey_channeltype` VALUES ('1', 'article', '文章模型', '文章', 'article', 'Article', '1', '1', '0', '1547473464');
INSERT INTO `ey_channeltype` VALUES ('4', 'download', '下载模型', '下载', 'download', 'Download', '1', '4', '0', '1547473464');
INSERT INTO `ey_channeltype` VALUES ('2', 'product', '产品模型', '产品', 'product', 'Product', '1', '2', '0', '1547473464');
INSERT INTO `ey_channeltype` VALUES ('8', 'guestbook', '留言模型', '留言', 'guestbook', 'Guestbook', '1', '8', '1509197711', '1547473464');
INSERT INTO `ey_channeltype` VALUES ('6', 'single', '单页模型', '单页', 'single', 'Single', '1', '6', '1523091961', '1547473464');
INSERT INTO `ey_channeltype` VALUES ('3', 'images', '图集模型', '图集', 'images', 'Images', '1', '3', '1523929121', '1547473464');

-- -----------------------------
-- Table structure for `ey_config`
-- -----------------------------
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
) ENGINE=MyISAM AUTO_INCREMENT=174 DEFAULT CHARSET=utf8 COMMENT='系统配置表';

-- -----------------------------
-- Records of `ey_config`
-- -----------------------------
INSERT INTO `ey_config` VALUES ('1', 'is_mark', '0', 'water', '', 'cn', '0', '0');
INSERT INTO `ey_config` VALUES ('2', 'mark_txt', '易优Cms', 'water', '', 'cn', '0', '0');
INSERT INTO `ey_config` VALUES ('3', 'mark_img', '/uploads/allimg/20190114/f0d5e5830502125f5077212a90ef3a33.png', 'water', '', 'cn', '0', '1547463466');
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
INSERT INTO `ey_config` VALUES ('29', 'web_logo', '/uploads/allimg/20190114/ba52bdcbb075530e33454279df374aba.png', 'web', '', 'cn', '0', '1547463501');
INSERT INTO `ey_config` VALUES ('30', 'web_ico', '/favicon.ico', 'web', '', 'cn', '0', '0');
INSERT INTO `ey_config` VALUES ('31', 'web_basehost', 'http://127.0.0.6', 'web', '', 'cn', '0', '0');
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
INSERT INTO `ey_config` VALUES ('57', 'web_authortoken', '', 'web', '', 'cn', '0', '0');
INSERT INTO `ey_config` VALUES ('58', 'web_attr_3', '123456789', 'web', '', 'cn', '0', '0');
INSERT INTO `ey_config` VALUES ('59', 'web_attr_2', '8888-88888888', 'web', '', 'cn', '0', '0');
INSERT INTO `ey_config` VALUES ('60', 'web_attr_1', 'http://www.weibo.com', 'web', '', 'cn', '0', '0');
INSERT INTO `ey_config` VALUES ('61', 'web_attr_4', '/uploads/allimg/20190114/6a9bcb2f4cf5a66473fa8491f63481de.jpg', 'web', '', 'cn', '0', '1547463501');
INSERT INTO `ey_config` VALUES ('62', 'seo_inlet', '1', 'seo', '', 'cn', '0', '0');
INSERT INTO `ey_config` VALUES ('63', 'web_cmspath', '', 'web', '', 'cn', '0', '0');
INSERT INTO `ey_config` VALUES ('64', 'web_sqldatapath', '/data/sqldata', 'web', '', 'cn', '0', '0');
INSERT INTO `ey_config` VALUES ('65', 'web_cmsurl', '', 'web', '', 'cn', '0', '0');
INSERT INTO `ey_config` VALUES ('66', 'web_templets_dir', '/template', 'web', '', 'cn', '0', '0');
INSERT INTO `ey_config` VALUES ('67', 'web_templeturl', '/template', 'web', '', 'cn', '0', '0');
INSERT INTO `ey_config` VALUES ('68', 'web_templets_pc', '/template/pc', 'web', '', 'cn', '0', '0');
INSERT INTO `ey_config` VALUES ('69', 'web_templets_m', '/template/mobile', 'web', '', 'cn', '0', '0');
INSERT INTO `ey_config` VALUES ('70', 'web_eyoucms', 'http://www.eyoucms.com', 'web', '', 'cn', '0', '0');
INSERT INTO `ey_config` VALUES ('78', '_cmscopyright', '1iSPLLttotxgQliKEfaKtlfh', 'php', '', 'cn', '0', '1547473432');
INSERT INTO `ey_config` VALUES ('76', 'seo_liststitle_format', '2', 'seo', '', 'cn', '0', '0');
INSERT INTO `ey_config` VALUES ('77', 'web_status', '0', 'web', '', 'cn', '0', '0');
INSERT INTO `ey_config` VALUES ('80', 'web_is_authortoken', '-1', 'web', '', 'cn', '0', '1547473277');
INSERT INTO `ey_config` VALUES ('81', 'web_adminbasefile', '/login.php', 'web', '', 'cn', '0', '0');
INSERT INTO `ey_config` VALUES ('82', 'seo_rewrite_format', '1', 'seo', '', 'cn', '0', '0');
INSERT INTO `ey_config` VALUES ('83', 'web_cmsmode', '2', 'web', '', 'cn', '0', '0');
INSERT INTO `ey_config` VALUES ('84', 'web_htmlcache_expires_in', '0', 'web', '', 'cn', '0', '1546477337');
INSERT INTO `ey_config` VALUES ('85', 'web_show_popup_upgrade', '1', 'web', '', 'cn', '0', '0');
INSERT INTO `ey_config` VALUES ('86', 'web_weapp_switch', '-1', 'web', '', 'cn', '0', '0');
INSERT INTO `ey_config` VALUES ('88', 'seo_dynamic_format', '1', 'seo', '', 'cn', '0', '0');
INSERT INTO `ey_config` VALUES ('89', 'system_sql_mode', 'NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION', 'system', '', 'cn', '0', '0');
INSERT INTO `ey_config` VALUES ('90', 'system_home_default_lang', 'cn', 'system', '', 'cn', '0', '0');
INSERT INTO `ey_config` VALUES ('91', 'system_langnum', '2', 'system', '', 'cn', '0', '1545267532');
INSERT INTO `ey_config` VALUES ('92', 'system_version', 'v1.2.3', 'system', '', 'cn', '0', '1546477013');
INSERT INTO `ey_config` VALUES ('93', 'is_mark', '0', 'water', '', 'en', '0', '0');
INSERT INTO `ey_config` VALUES ('94', 'mark_txt', '易优Cms', 'water', '', 'en', '0', '0');
INSERT INTO `ey_config` VALUES ('95', 'mark_img', '/uploads/allimg/20190114/f0d5e5830502125f5077212a90ef3a33.png', 'water', '', 'en', '0', '1547463466');
INSERT INTO `ey_config` VALUES ('96', 'mark_width', '200', 'water', '', 'en', '0', '0');
INSERT INTO `ey_config` VALUES ('97', 'mark_height', '50', 'water', '', 'en', '0', '0');
INSERT INTO `ey_config` VALUES ('98', 'mark_degree', '54', 'water', '', 'en', '0', '0');
INSERT INTO `ey_config` VALUES ('99', 'mark_quality', '56', 'water', '', 'en', '0', '0');
INSERT INTO `ey_config` VALUES ('100', 'mark_sel', '9', 'water', '', 'en', '0', '0');
INSERT INTO `ey_config` VALUES ('101', 'sms_time_out', '120', 'sms', '', 'en', '0', '0');
INSERT INTO `ey_config` VALUES ('102', 'theme_style', '1', 'basic', '', 'en', '0', '0');
INSERT INTO `ey_config` VALUES ('103', 'file_size', '500', 'basic', '', 'en', '0', '0');
INSERT INTO `ey_config` VALUES ('104', 'image_type', 'jpg|gif|png|bmp|jpeg|ico', 'basic', '', 'en', '0', '0');
INSERT INTO `ey_config` VALUES ('105', 'file_type', 'zip|gz|rar|iso|doc|xsl|ppt|wps', 'basic', '', 'en', '0', '0');
INSERT INTO `ey_config` VALUES ('106', 'media_type', 'swf|mpg|mp3|rm|rmvb|wmv|wma|wav|mid|mov|mp4', 'basic', '', 'en', '0', '0');
INSERT INTO `ey_config` VALUES ('107', 'web_keywords', '', 'web', '', 'en', '0', '0');
INSERT INTO `ey_config` VALUES ('108', 'sms_platform', '1', 'sms', '', 'en', '0', '0');
INSERT INTO `ey_config` VALUES ('109', 'seo_viewtitle_format', '2', 'seo', '', 'en', '0', '0');
INSERT INTO `ey_config` VALUES ('110', 'smtp_server', 'smtp.qq.com', 'smtp', '', 'en', '0', '0');
INSERT INTO `ey_config` VALUES ('111', 'smtp_port', '465', 'smtp', '', 'en', '0', '0');
INSERT INTO `ey_config` VALUES ('112', 'smtp_user', 'xxxxxxxxx@qq.com', 'smtp', '', 'en', '0', '0');
INSERT INTO `ey_config` VALUES ('113', 'smtp_pwd', 'xxxxxxxxxxx', 'smtp', '', 'en', '0', '0');
INSERT INTO `ey_config` VALUES ('114', 'inc_type', 'smtp', 'smtp', '', 'en', '0', '0');
INSERT INTO `ey_config` VALUES ('115', 'mark_type', 'img', 'water', '', 'en', '0', '0');
INSERT INTO `ey_config` VALUES ('116', 'mark_txt_size', '30', 'water', '', 'en', '0', '0');
INSERT INTO `ey_config` VALUES ('117', 'mark_txt_color', '#000000', 'water', '', 'en', '0', '0');
INSERT INTO `ey_config` VALUES ('118', 'oss_switch', '0', 'oss', '', 'en', '0', '0');
INSERT INTO `ey_config` VALUES ('119', 'web_name', 'en易优Cms-演示站', 'web', '', 'en', '0', '0');
INSERT INTO `ey_config` VALUES ('120', 'web_logo', '/uploads/allimg/20190114/ba52bdcbb075530e33454279df374aba.png', 'web', '', 'en', '0', '0');
INSERT INTO `ey_config` VALUES ('121', 'web_ico', '/favicon.ico', 'web', '', 'en', '0', '0');
INSERT INTO `ey_config` VALUES ('122', 'web_basehost', 'http://127.0.0.6', 'web', '', 'en', '0', '0');
INSERT INTO `ey_config` VALUES ('123', 'web_description', '', 'web', '', 'en', '0', '0');
INSERT INTO `ey_config` VALUES ('124', 'web_copyright', 'Copyright © 2012-2018 EYOUCMS. EYOU CMS All rights reserved', 'web', '', 'en', '0', '1545272727');
INSERT INTO `ey_config` VALUES ('125', 'web_thirdcode_pc', '', 'web', '', 'en', '0', '0');
INSERT INTO `ey_config` VALUES ('126', 'web_thirdcode_wap', '', 'web', '', 'en', '0', '0');
INSERT INTO `ey_config` VALUES ('127', 'seo_arcdir', '/html', 'seo', '', 'en', '0', '0');
INSERT INTO `ey_config` VALUES ('128', 'seo_pseudo', '1', 'seo', '', 'en', '0', '0');
INSERT INTO `ey_config` VALUES ('129', 'list_symbol', '&gt;', 'basic', '', 'en', '0', '0');
INSERT INTO `ey_config` VALUES ('130', 'sitemap_auto', '1', 'sitemap', '', 'en', '0', '0');
INSERT INTO `ey_config` VALUES ('131', 'sitemap_not1', '0', 'sitemap', '', 'en', '0', '0');
INSERT INTO `ey_config` VALUES ('132', 'sitemap_not2', '1', 'sitemap', '', 'en', '0', '0');
INSERT INTO `ey_config` VALUES ('133', 'sitemap_xml', '1', 'sitemap', '', 'en', '0', '0');
INSERT INTO `ey_config` VALUES ('134', 'sitemap_txt', '0', 'sitemap', '', 'en', '0', '0');
INSERT INTO `ey_config` VALUES ('135', 'sitemap_zzbaidutoken', '', 'sitemap', '', 'en', '0', '0');
INSERT INTO `ey_config` VALUES ('136', 'seo_expires_in', '7200', 'seo', '', 'en', '0', '0');
INSERT INTO `ey_config` VALUES ('137', 'web_title', '易优CMS -  Powered by Eyoucms.com', 'web', '', 'en', '0', '0');
INSERT INTO `ey_config` VALUES ('138', 'smtp_test_eamil', 'xxxxxxxx@qq.com', 'smtp', '', 'en', '0', '0');
INSERT INTO `ey_config` VALUES ('139', 'web_authortoken', '', 'web', '', 'en', '0', '0');
INSERT INTO `ey_config` VALUES ('140', 'web_attr_3', '123456789', 'web', '', 'en', '0', '0');
INSERT INTO `ey_config` VALUES ('141', 'web_attr_2', '8888-88888888', 'web', '', 'en', '0', '0');
INSERT INTO `ey_config` VALUES ('142', 'web_attr_1', 'http://www.weibo.com', 'web', '', 'en', '0', '0');
INSERT INTO `ey_config` VALUES ('143', 'web_attr_4', '/uploads/allimg/20190114/6a9bcb2f4cf5a66473fa8491f63481de.jpg', 'web', '', 'en', '0', '0');
INSERT INTO `ey_config` VALUES ('144', 'seo_inlet', '1', 'seo', '', 'en', '0', '0');
INSERT INTO `ey_config` VALUES ('145', 'web_cmspath', '', 'web', '', 'en', '0', '0');
INSERT INTO `ey_config` VALUES ('146', 'web_sqldatapath', '/data/sqldata', 'web', '', 'en', '0', '0');
INSERT INTO `ey_config` VALUES ('147', 'web_cmsurl', '', 'web', '', 'en', '0', '0');
INSERT INTO `ey_config` VALUES ('148', 'web_templets_dir', '/template', 'web', '', 'en', '0', '0');
INSERT INTO `ey_config` VALUES ('149', 'web_templeturl', '/template', 'web', '', 'en', '0', '0');
INSERT INTO `ey_config` VALUES ('150', 'web_templets_pc', '/template/pc', 'web', '', 'en', '0', '0');
INSERT INTO `ey_config` VALUES ('151', 'web_templets_m', '/template/mobile', 'web', '', 'en', '0', '0');
INSERT INTO `ey_config` VALUES ('152', 'web_eyoucms', 'http://www.eyoucms.com', 'web', '', 'en', '0', '0');
INSERT INTO `ey_config` VALUES ('153', 'seo_liststitle_format', '2', 'seo', '', 'en', '0', '0');
INSERT INTO `ey_config` VALUES ('154', 'web_status', '0', 'web', '', 'en', '0', '0');
INSERT INTO `ey_config` VALUES ('155', '_cmscopyright', 'PNE4s643Sw21jwhjmhfFeaKg', 'php', '', 'en', '0', '1547473432');
INSERT INTO `ey_config` VALUES ('156', 'web_recordnum', 'Qiong ICP Prepares xxxxxxx Number', 'web', '', 'en', '0', '1545272757');
INSERT INTO `ey_config` VALUES ('157', 'web_is_authortoken', '-1', 'web', '', 'en', '0', '1547473277');
INSERT INTO `ey_config` VALUES ('158', 'web_adminbasefile', '/login.php', 'web', '', 'en', '0', '0');
INSERT INTO `ey_config` VALUES ('159', 'seo_rewrite_format', '1', 'seo', '', 'en', '0', '0');
INSERT INTO `ey_config` VALUES ('160', 'web_cmsmode', '2', 'web', '', 'en', '0', '0');
INSERT INTO `ey_config` VALUES ('161', 'web_htmlcache_expires_in', '0', 'web', '', 'en', '0', '1546477338');
INSERT INTO `ey_config` VALUES ('162', 'web_show_popup_upgrade', '-1', 'web', '', 'en', '0', '1547463831');
INSERT INTO `ey_config` VALUES ('163', 'web_weapp_switch', '-1', 'web', '', 'en', '0', '0');
INSERT INTO `ey_config` VALUES ('164', 'seo_dynamic_format', '1', 'seo', '', 'en', '0', '0');
INSERT INTO `ey_config` VALUES ('165', 'system_sql_mode', 'NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION', 'system', '', 'en', '0', '0');
INSERT INTO `ey_config` VALUES ('166', 'system_home_default_lang', 'cn', 'system', '', 'en', '0', '0');
INSERT INTO `ey_config` VALUES ('167', 'system_langnum', '2', 'system', '', 'en', '0', '1545267532');
INSERT INTO `ey_config` VALUES ('168', 'system_version', 'v1.2.3', 'system', '', 'en', '0', '1546477013');
INSERT INTO `ey_config` VALUES ('169', 'basic_indexname', 'Home', 'basic', '', 'en', '0', '1545272633');
INSERT INTO `ey_config` VALUES ('170', 'web_exception', '0', 'web', '', 'cn', '0', '1546477337');
INSERT INTO `ey_config` VALUES ('171', 'web_language_switch', '1', 'web', '', 'cn', '0', '1546477337');
INSERT INTO `ey_config` VALUES ('172', 'web_exception', '0', 'web', '', 'en', '0', '1546477338');
INSERT INTO `ey_config` VALUES ('173', 'web_language_switch', '1', 'web', '', 'en', '0', '1546477338');

-- -----------------------------
-- Table structure for `ey_config_attribute`
-- -----------------------------
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

-- -----------------------------
-- Records of `ey_config_attribute`
-- -----------------------------
INSERT INTO `ey_config_attribute` VALUES ('1', 'web', '微博地址', 'web_attr_1', '0', 'cn', '1525962574', '1526008818');
INSERT INTO `ey_config_attribute` VALUES ('2', 'web', '手机/固话', 'web_attr_2', '0', 'cn', '1525962600', '1525962600');
INSERT INTO `ey_config_attribute` VALUES ('3', 'web', 'QQ号码', 'web_attr_3', '0', 'cn', '1525962624', '1525962624');
INSERT INTO `ey_config_attribute` VALUES ('4', 'web', '微信二维码', 'web_attr_4', '3', 'cn', '1525999090', '1526008783');
INSERT INTO `ey_config_attribute` VALUES ('5', 'web', '微博地址', 'web_attr_1', '0', 'en', '1525962574', '1526008818');
INSERT INTO `ey_config_attribute` VALUES ('6', 'web', '手机/固话', 'web_attr_2', '0', 'en', '1525962600', '1525962600');
INSERT INTO `ey_config_attribute` VALUES ('7', 'web', 'QQ号码', 'web_attr_3', '0', 'en', '1525962624', '1525962624');
INSERT INTO `ey_config_attribute` VALUES ('8', 'web', '微信二维码', 'web_attr_4', '3', 'en', '1525999090', '1526008783');

-- -----------------------------
-- Table structure for `ey_download_content`
-- -----------------------------
DROP TABLE IF EXISTS `ey_download_content`;
CREATE TABLE `ey_download_content` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `aid` int(10) DEFAULT '0' COMMENT '文档ID',
  `content` longtext COMMENT '内容详情',
  `add_time` int(11) DEFAULT '0' COMMENT '新增时间',
  `update_time` int(11) DEFAULT '0' COMMENT '更新时间',
  PRIMARY KEY (`id`),
  KEY `news_id` (`aid`) USING BTREE
) ENGINE=MyISAM AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COMMENT='下载附加表';

-- -----------------------------
-- Records of `ey_download_content`
-- -----------------------------
INSERT INTO `ey_download_content` VALUES ('1', '30', '&lt;p&gt;工程机械推土挖掘机类网站模板，下载地址：&lt;a href=&quot;http://www.eyoucms.com/moban/16/668.html&quot; target=&quot;_self&quot;&gt;http://www.eyoucms.com/moban/16/668.html&lt;/a&gt;&lt;/p&gt;&lt;p&gt;&lt;br/&gt;&lt;/p&gt;&lt;p&gt;&lt;img src=&quot;/uploads/allimg/20190114/4873105f54a14f3785047bd8ecc8b5ac.jpg&quot;/&gt;&lt;/p&gt;', '1547463959', '1547463959');
INSERT INTO `ey_download_content` VALUES ('2', '31', '&lt;p&gt;职业教育培训机构网站模板，下载地址：&lt;a href=&quot;http://www.eyoucms.com/moban/10/673.html&quot; target=&quot;_self&quot;&gt;http://www.eyoucms.com/moban/10/673.html&lt;/a&gt;&lt;/p&gt;', '1547463404', '1547463404');
INSERT INTO `ey_download_content` VALUES ('4', '48', '&lt;p&gt;Construction machinery bulldozer website template, download address：&lt;a href=&quot;http://www.eyoucms.com/moban/16/668.html&quot; target=&quot;_self&quot;&gt;http://www.eyoucms.com/moban/16/668.html&lt;/a&gt;&lt;/p&gt;&lt;p&gt;&lt;br style=&quot;box-sizing: inherit;&quot;/&gt;&lt;/p&gt;&lt;p&gt;&lt;img src=&quot;http://www.eyoucms.com/uploads/allimg/180426/150RQ155-0.jpg&quot; style=&quot;box-sizing: inherit; border-style: none; vertical-align: top; max-width: 100%; height: auto !important;&quot;/&gt;&lt;/p&gt;&lt;p&gt;&lt;br/&gt;&lt;/p&gt;', '1547463855', '1547463855');
INSERT INTO `ey_download_content` VALUES ('5', '49', '&lt;p&gt;Web template for vocational education and training institutions, download address: &lt;a href=&quot;http://www.eyoucms.com/moban/10/673.html&quot; target=&quot;_self&quot;&gt;http://www.eyoucms.com/moban/10/673.html&lt;/a&gt;&lt;/p&gt;', '1545268305', '1545268305');

-- -----------------------------
-- Table structure for `ey_download_file`
-- -----------------------------
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
) ENGINE=MyISAM AUTO_INCREMENT=16 DEFAULT CHARSET=utf8 COMMENT='下载附件表';

-- -----------------------------
-- Records of `ey_download_file`
-- -----------------------------
INSERT INTO `ey_download_file` VALUES ('15', '30', '工程机械推土挖掘机类网站模板', '/uploads/soft/20190114/4b0f01441b5a246badf158fa99c140ac.zip', '9268', 'zip', '4b0f01441b5a246badf158fa99c140ac.zip', 'application/x-zip-compressed', '1837c4067aa99f7005e62b20bdb1a67f', '1837c4067aa99f7005e62b20bdb1a67f', '1', '1547463434');
INSERT INTO `ey_download_file` VALUES ('13', '31', '职业教育培训机构网站模板', '/uploads/soft/20190114/3b3f753af0f13e6e0237b9577e0bcd17.zip', '9268', 'zip', '3b3f753af0f13e6e0237b9577e0bcd17.zip', 'application/x-zip-compressed', '1837c4067aa99f7005e62b20bdb1a67f', '1837c4067aa99f7005e62b20bdb1a67f', '1', '1547463404');
INSERT INTO `ey_download_file` VALUES ('14', '31', '职业教育培训机构网站模板', '/uploads/soft/20190114/44bbd259222c81bd3c41112a73c904a0.zip', '9268', 'zip', '44bbd259222c81bd3c41112a73c904a0.zip', 'application/x-zip-compressed', '1837c4067aa99f7005e62b20bdb1a67f', '1837c4067aa99f7005e62b20bdb1a67f', '2', '1547463404');
INSERT INTO `ey_download_file` VALUES ('10', '48', '工程机械推土挖掘机类网站模板', '/uploads/soft/20181220/4b0f01441b5a246badf158fa99c140ac.zip', '9268', 'zip', '4b0f01441b5a246badf158fa99c140ac.zip', 'application/x-zip-compressed', '1837c4067aa99f7005e62b20bdb1a67f', '1837c4067aa99f7005e62b20bdb1a67f', '1', '1545268147');
INSERT INTO `ey_download_file` VALUES ('11', '49', 'Website Template of Vocational Education and Training Institutions', '/uploads/soft/20181220/44bbd259222c81bd3c41112a73c904a0.zip', '9268', 'zip', '44bbd259222c81bd3c41112a73c904a0.zip', 'application/x-zip-compressed', '1837c4067aa99f7005e62b20bdb1a67f', '1837c4067aa99f7005e62b20bdb1a67f', '1', '1545268233');
INSERT INTO `ey_download_file` VALUES ('12', '49', 'Website Template of Vocational Education and Training Institutions', '/uploads/soft/20181220/3b3f753af0f13e6e0237b9577e0bcd17.zip', '9268', 'zip', '3b3f753af0f13e6e0237b9577e0bcd17.zip', 'application/x-zip-compressed', '1837c4067aa99f7005e62b20bdb1a67f', '1837c4067aa99f7005e62b20bdb1a67f', '2', '1545268233');

-- -----------------------------
-- Table structure for `ey_field_type`
-- -----------------------------
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

-- -----------------------------
-- Records of `ey_field_type`
-- -----------------------------
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

-- -----------------------------
-- Table structure for `ey_guestbook`
-- -----------------------------
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

-- -----------------------------
-- Records of `ey_guestbook`
-- -----------------------------
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

-- -----------------------------
-- Table structure for `ey_guestbook_attr`
-- -----------------------------
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

-- -----------------------------
-- Records of `ey_guestbook_attr`
-- -----------------------------
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

-- -----------------------------
-- Table structure for `ey_guestbook_attribute`
-- -----------------------------
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

-- -----------------------------
-- Records of `ey_guestbook_attribute`
-- -----------------------------
INSERT INTO `ey_guestbook_attribute` VALUES ('1', '姓名', '30', '0', '', '100', 'cn', '0', '1526616441', '1526616441');
INSERT INTO `ey_guestbook_attribute` VALUES ('2', '手机号码', '30', '0', '', '100', 'cn', '0', '1526616453', '1526616453');
INSERT INTO `ey_guestbook_attribute` VALUES ('3', '约谈对象', '30', '1', '隔壁老王\r\n前台美女\r\n扫地阿姨', '100', 'cn', '0', '1526616497', '1526616812');
INSERT INTO `ey_guestbook_attribute` VALUES ('4', '姓名', '6', '0', '', '100', 'cn', '0', '1526634369', '1526874914');
INSERT INTO `ey_guestbook_attribute` VALUES ('5', '联系方式', '6', '0', '', '100', 'cn', '0', '1526634383', '1526634383');
INSERT INTO `ey_guestbook_attribute` VALUES ('6', '备注信息', '6', '2', '', '100', 'cn', '0', '1526634393', '1526875056');
INSERT INTO `ey_guestbook_attribute` VALUES ('7', '模式', '6', '1', '个人\r\n团队', '100', 'cn', '0', '1526875483', '1526876172');
INSERT INTO `ey_guestbook_attribute` VALUES ('9', 'Name', '34', '0', '', '100', 'en', '0', '1526616441', '1545272376');
INSERT INTO `ey_guestbook_attribute` VALUES ('10', 'Telephone', '34', '0', '', '100', 'en', '0', '1526616453', '1545272410');
INSERT INTO `ey_guestbook_attribute` VALUES ('11', 'Object of negotiation', '34', '1', 'Old king next door\r\nFront desk beauty\r\nAunt sweep', '100', 'en', '0', '1526616497', '1545272446');
INSERT INTO `ey_guestbook_attribute` VALUES ('12', 'Name', '53', '0', '', '100', 'en', '0', '1526634369', '1545267932');
INSERT INTO `ey_guestbook_attribute` VALUES ('13', 'Tel', '53', '0', '', '100', 'en', '0', '1526634383', '1545267998');
INSERT INTO `ey_guestbook_attribute` VALUES ('14', 'Remarks', '53', '2', '', '100', 'en', '0', '1526634393', '1545268014');
INSERT INTO `ey_guestbook_attribute` VALUES ('15', 'Pattern', '53', '1', 'personal\r\nteam', '100', 'en', '0', '1526875483', '1545272477');

-- -----------------------------
-- Table structure for `ey_hooks`
-- -----------------------------
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


-- -----------------------------
-- Table structure for `ey_images_content`
-- -----------------------------
DROP TABLE IF EXISTS `ey_images_content`;
CREATE TABLE `ey_images_content` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `aid` int(10) DEFAULT '0' COMMENT '文档ID',
  `content` longtext COMMENT '内容详情',
  `add_time` int(11) DEFAULT '0' COMMENT '新增时间',
  `update_time` int(11) DEFAULT '0' COMMENT '更新时间',
  PRIMARY KEY (`id`),
  KEY `news_id` (`aid`) USING BTREE
) ENGINE=MyISAM AUTO_INCREMENT=15 DEFAULT CHARSET=utf8 COMMENT='图集附加表';

-- -----------------------------
-- Records of `ey_images_content`
-- -----------------------------
INSERT INTO `ey_images_content` VALUES ('5', '22', '&lt;p&gt;新闻模型下的图集新闻模型下的图集新闻模型下的图集新闻模型下的图集新闻模型下的图集新闻模型下的图集新闻模型下的图集新闻模型下的图集新闻模型下的图集新闻模型下的图集新闻模型下的图集新闻模型下的图集新闻模型下的图集新闻模型下的图集新闻模型下的图集新闻模型下的图集新闻模型下的图集新闻模型下的图集新闻模型下的图集新闻模型下的图集新闻模型下的图集新闻模型下的图集新闻模型下的图集新闻模型下的图集新闻模型下的图集新闻模型下的图集新闻模型下的图集新闻模型下的图集新闻模型下的图集新闻模型下的图集新闻模型下的图集新闻模型下的图集新闻模型下的图集新闻模型下的图集新闻模型下的图集新闻模型下的图集新闻模型下的图集新闻模型下的图集新闻模型下的图集新闻模型下的图集新闻模型下的图集新闻模型下的图集新闻模型下的图集新闻模型下的图集新闻模型下的图集新闻模型下的图集新闻模型下的图集新闻模型下的图集新闻模型下的图集新闻模型下的图集新闻模型下的图集新闻模型下的图集新闻模型下的图集新闻模型下的图集新闻模型下的图集新闻模型下的图集新闻模型下的图集新闻模型下的图集&lt;/p&gt;', '1547462752', '1547462752');
INSERT INTO `ey_images_content` VALUES ('6', '23', '&lt;p&gt;新闻模型下的图集二新闻模型下的图集二新闻模型下的图集二新闻模型下的图集二新闻模型下的图集二新闻模型下的图集二新闻模型下的图集二新闻模型下的图集二新闻模型下的图集二新闻模型下的图集二新闻模型下的图集二新闻模型下的图集二新闻模型下的图集二新闻模型下的图集二新闻模型下的图集二新闻模型下的图集二新闻模型下的图集二新闻模型下的图集二新闻模型下的图集二新闻模型下的图集二新闻模型下的图集二新闻模型下的图集二新闻模型下的图集二新闻模型下的图集二新闻模型下的图集二新闻模型下的图集二新闻模型下的图集二新闻模型下的图集二新闻模型下的图集二新闻模型下的图集二新闻模型下的图集二新闻模型下的图集二新闻模型下的图集二新闻模型下的图集二新闻模型下的图集二新闻模型下的图集二新闻模型下的图集二&lt;/p&gt;', '1547462702', '1547462702');
INSERT INTO `ey_images_content` VALUES ('7', '42', '', '1547462847', '1547462847');
INSERT INTO `ey_images_content` VALUES ('8', '43', '', '1547462829', '1547462829');
INSERT INTO `ey_images_content` VALUES ('9', '44', '', '1547462806', '1547462806');
INSERT INTO `ey_images_content` VALUES ('10', '50', '', '1545268466', '1545268466');
INSERT INTO `ey_images_content` VALUES ('11', '51', '', '1545268514', '1545268514');
INSERT INTO `ey_images_content` VALUES ('12', '52', '', '1545268563', '1545268563');
INSERT INTO `ey_images_content` VALUES ('13', '57', '', '1545270783', '1545270783');
INSERT INTO `ey_images_content` VALUES ('14', '58', '', '1545270816', '1545270816');

-- -----------------------------
-- Table structure for `ey_images_upload`
-- -----------------------------
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
) ENGINE=MyISAM AUTO_INCREMENT=39 DEFAULT CHARSET=utf8 COMMENT='图集图片表';

-- -----------------------------
-- Records of `ey_images_upload`
-- -----------------------------
INSERT INTO `ey_images_upload` VALUES ('32', '22', '新闻模型下的图集', '/uploads/allimg/20190114/84cb8dc1626776b7c8a54a78f0177f48.jpg', '400', '400', '0', 'image/jpeg', '2', '1547462752');
INSERT INTO `ey_images_upload` VALUES ('31', '22', '新闻模型下的图集', '/uploads/allimg/20190114/546f502c79cf1b653816006be5d9e3fd.jpg', '560', '560', '0', 'image/jpeg', '1', '1547462752');
INSERT INTO `ey_images_upload` VALUES ('30', '23', '新闻模型下的图集二', '/uploads/allimg/20190114/f7a54389683dc21843aed505561de39a.jpg', '560', '560', '0', 'image/jpeg', '1', '1547462702');
INSERT INTO `ey_images_upload` VALUES ('38', '42', '客户案例一', '/uploads/allimg/20190114/9764f13943d3aca2f7d3b1065d143a7d.jpg', '1000', '782', '0', 'image/jpeg', '1', '1547462847');
INSERT INTO `ey_images_upload` VALUES ('37', '43', '客户案例二', '/uploads/allimg/20190114/f8373e1b08853b8bec3f0198bd83d671.jpg', '1000', '782', '0', 'image/jpeg', '2', '1547462829');
INSERT INTO `ey_images_upload` VALUES ('36', '43', '客户案例二', '/uploads/allimg/20190114/d26baa8e6d8069091afbe90c8cdf88b3.jpg', '1000', '782', '0', 'image/jpeg', '1', '1547462829');
INSERT INTO `ey_images_upload` VALUES ('35', '44', '客户案例三', '/uploads/allimg/20190114/f588a2247388733dfbf4ff54d9234db5.jpg', '1000', '782', '0', 'image/jpeg', '3', '1547462806');
INSERT INTO `ey_images_upload` VALUES ('34', '44', '客户案例三', '/uploads/allimg/20190114/34914446f0730fd1d15130fc92b9d4d1.jpg', '1000', '782', '0', 'image/jpeg', '2', '1547462806');
INSERT INTO `ey_images_upload` VALUES ('33', '44', '客户案例三', '/uploads/allimg/20190114/21b287f5e527170a57e51647b109b02b.jpg', '1000', '782', '0', 'image/jpeg', '1', '1547462806');
INSERT INTO `ey_images_upload` VALUES ('24', '50', 'Customer Case I', '/uploads/allimg/20181220/9d1ad4b6be1ecc79929e3e55cb671a14.jpg', '1000', '782', '0', 'image/jpeg', '1', '1545268466');
INSERT INTO `ey_images_upload` VALUES ('25', '51', 'Customer Case II', '/uploads/allimg/20181220/e33caf1e51fcefac340c351769a9928c.jpg', '1000', '782', '0', 'image/jpeg', '1', '1545268514');
INSERT INTO `ey_images_upload` VALUES ('26', '52', 'Customer Case III', '/uploads/allimg/20181220/5ae19f75c0465f48f00719a0f15d2f02.jpg', '1000', '782', '0', 'image/jpeg', '1', '1545268563');
INSERT INTO `ey_images_upload` VALUES ('27', '57', 'Atlas under News Model', '/uploads/allimg/20181220/b1a53d661f80d231d794ba8e7f9154ba.jpg', '560', '560', '0', 'image/jpeg', '1', '1545270783');
INSERT INTO `ey_images_upload` VALUES ('28', '57', 'Atlas under News Model', '/uploads/allimg/20181220/a85e92ce6e2561d5c93a4cf62b7a8201.jpg', '400', '400', '0', 'image/jpeg', '2', '1545270783');
INSERT INTO `ey_images_upload` VALUES ('29', '58', 'Atlas II under News Model', '/uploads/allimg/20181220/c76f2be2ebee26b8d8b2ebcc015280ef.jpg', '560', '560', '0', 'image/jpeg', '1', '1545270816');

-- -----------------------------
-- Table structure for `ey_language`
-- -----------------------------
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
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COMMENT='多语言主表';

-- -----------------------------
-- Records of `ey_language`
-- -----------------------------
INSERT INTO `ey_language` VALUES ('1', '简体中文', 'cn', '', '0', '1', '1', '24', '1', '100', '1541583096', '1543890743');
INSERT INTO `ey_language` VALUES ('2', 'English', 'en', '', '0', '0', '0', '24', '1', '100', '1545267531', '1545267534');

-- -----------------------------
-- Table structure for `ey_language_attr`
-- -----------------------------
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
) ENGINE=MyISAM AUTO_INCREMENT=83 DEFAULT CHARSET=utf8 COMMENT='多语言模板变量关联绑定表';

-- -----------------------------
-- Records of `ey_language_attr`
-- -----------------------------
INSERT INTO `ey_language_attr` VALUES ('1', 'tid1', '1', 'arctype', 'cn', '1545267517', '1545267517');
INSERT INTO `ey_language_attr` VALUES ('2', 'tid2', '2', 'arctype', 'cn', '1545267517', '1545267517');
INSERT INTO `ey_language_attr` VALUES ('3', 'tid3', '3', 'arctype', 'cn', '1545267517', '1545267517');
INSERT INTO `ey_language_attr` VALUES ('4', 'tid4', '4', 'arctype', 'cn', '1545267517', '1545267517');
INSERT INTO `ey_language_attr` VALUES ('5', 'tid5', '5', 'arctype', 'cn', '1545267517', '1545267517');
INSERT INTO `ey_language_attr` VALUES ('6', 'tid6', '6', 'arctype', 'cn', '1545267517', '1545267517');
INSERT INTO `ey_language_attr` VALUES ('7', 'tid8', '8', 'arctype', 'cn', '1545267517', '1545267517');
INSERT INTO `ey_language_attr` VALUES ('8', 'tid9', '9', 'arctype', 'cn', '1545267517', '1545267517');
INSERT INTO `ey_language_attr` VALUES ('9', 'tid10', '10', 'arctype', 'cn', '1545267517', '1545267517');
INSERT INTO `ey_language_attr` VALUES ('10', 'tid11', '11', 'arctype', 'cn', '1545267517', '1545267517');
INSERT INTO `ey_language_attr` VALUES ('11', 'tid12', '12', 'arctype', 'cn', '1545267517', '1545267517');
INSERT INTO `ey_language_attr` VALUES ('12', 'tid13', '13', 'arctype', 'cn', '1545267517', '1545267517');
INSERT INTO `ey_language_attr` VALUES ('13', 'tid20', '20', 'arctype', 'cn', '1545267517', '1545267517');
INSERT INTO `ey_language_attr` VALUES ('14', 'tid21', '21', 'arctype', 'cn', '1545267517', '1545267517');
INSERT INTO `ey_language_attr` VALUES ('15', 'tid22', '22', 'arctype', 'cn', '1545267517', '1545267517');
INSERT INTO `ey_language_attr` VALUES ('16', 'tid23', '23', 'arctype', 'cn', '1545267517', '1545267517');
INSERT INTO `ey_language_attr` VALUES ('17', 'tid24', '24', 'arctype', 'cn', '1545267517', '1545267517');
INSERT INTO `ey_language_attr` VALUES ('18', 'tid25', '25', 'arctype', 'cn', '1545267517', '1545267517');
INSERT INTO `ey_language_attr` VALUES ('19', 'tid26', '26', 'arctype', 'cn', '1545267517', '1545267517');
INSERT INTO `ey_language_attr` VALUES ('20', 'tid27', '27', 'arctype', 'cn', '1545267517', '1545267517');
INSERT INTO `ey_language_attr` VALUES ('21', 'tid28', '28', 'arctype', 'cn', '1545267517', '1545267517');
INSERT INTO `ey_language_attr` VALUES ('22', 'tid29', '29', 'arctype', 'cn', '1545267517', '1545267517');
INSERT INTO `ey_language_attr` VALUES ('23', 'tid30', '30', 'arctype', 'cn', '1545267517', '1545267517');
INSERT INTO `ey_language_attr` VALUES ('24', 'attr_1', '1', 'guestbook_attribute', 'cn', '1545267518', '1545267518');
INSERT INTO `ey_language_attr` VALUES ('25', 'attr_2', '2', 'guestbook_attribute', 'cn', '1545267518', '1545267518');
INSERT INTO `ey_language_attr` VALUES ('26', 'attr_3', '3', 'guestbook_attribute', 'cn', '1545267518', '1545267518');
INSERT INTO `ey_language_attr` VALUES ('27', 'attr_4', '4', 'guestbook_attribute', 'cn', '1545267518', '1545267518');
INSERT INTO `ey_language_attr` VALUES ('28', 'attr_5', '5', 'guestbook_attribute', 'cn', '1545267518', '1545267518');
INSERT INTO `ey_language_attr` VALUES ('29', 'attr_6', '6', 'guestbook_attribute', 'cn', '1545267518', '1545267518');
INSERT INTO `ey_language_attr` VALUES ('30', 'attr_7', '7', 'guestbook_attribute', 'cn', '1545267518', '1545267518');
INSERT INTO `ey_language_attr` VALUES ('31', 'attr_1', '1', 'product_attribute', 'cn', '1545267518', '1545267518');
INSERT INTO `ey_language_attr` VALUES ('32', 'attr_2', '2', 'product_attribute', 'cn', '1545267518', '1545267518');
INSERT INTO `ey_language_attr` VALUES ('33', 'attr_3', '3', 'product_attribute', 'cn', '1545267518', '1545267518');
INSERT INTO `ey_language_attr` VALUES ('34', 'attr_4', '4', 'product_attribute', 'cn', '1545267518', '1545267518');
INSERT INTO `ey_language_attr` VALUES ('35', 'attr_5', '5', 'product_attribute', 'cn', '1545267518', '1545267518');
INSERT INTO `ey_language_attr` VALUES ('36', 'attr_6', '6', 'product_attribute', 'cn', '1545267518', '1545267518');
INSERT INTO `ey_language_attr` VALUES ('37', 'attr_7', '7', 'product_attribute', 'cn', '1545267518', '1545267518');
INSERT INTO `ey_language_attr` VALUES ('38', 'attr_8', '8', 'product_attribute', 'cn', '1545267518', '1545267518');
INSERT INTO `ey_language_attr` VALUES ('39', 'ad1', '1', 'ad', 'cn', '1545267518', '1545267518');
INSERT INTO `ey_language_attr` VALUES ('40', 'ad2', '2', 'ad', 'cn', '1545267518', '1545267518');
INSERT INTO `ey_language_attr` VALUES ('41', 'adp1', '1', 'ad_position', 'cn', '1545267518', '1545267518');
INSERT INTO `ey_language_attr` VALUES ('42', 'tid1', '31', 'arctype', 'en', '1545267531', '1545267531');
INSERT INTO `ey_language_attr` VALUES ('43', 'tid8', '32', 'arctype', 'en', '1545267531', '1545267531');
INSERT INTO `ey_language_attr` VALUES ('44', 'tid9', '33', 'arctype', 'en', '1545267531', '1545267531');
INSERT INTO `ey_language_attr` VALUES ('45', 'tid30', '34', 'arctype', 'en', '1545267531', '1545267531');
INSERT INTO `ey_language_attr` VALUES ('46', 'tid2', '35', 'arctype', 'en', '1545267531', '1545267531');
INSERT INTO `ey_language_attr` VALUES ('47', 'tid10', '36', 'arctype', 'en', '1545267531', '1545267531');
INSERT INTO `ey_language_attr` VALUES ('48', 'tid11', '37', 'arctype', 'en', '1545267531', '1545267531');
INSERT INTO `ey_language_attr` VALUES ('49', 'tid12', '38', 'arctype', 'en', '1545267531', '1545267531');
INSERT INTO `ey_language_attr` VALUES ('50', 'tid13', '39', 'arctype', 'en', '1545267531', '1545267531');
INSERT INTO `ey_language_attr` VALUES ('51', 'tid23', '40', 'arctype', 'en', '1545267531', '1545267531');
INSERT INTO `ey_language_attr` VALUES ('52', 'tid3', '41', 'arctype', 'en', '1545267531', '1545267531');
INSERT INTO `ey_language_attr` VALUES ('53', 'tid20', '42', 'arctype', 'en', '1545267531', '1545267531');
INSERT INTO `ey_language_attr` VALUES ('54', 'tid24', '43', 'arctype', 'en', '1545267531', '1545267531');
INSERT INTO `ey_language_attr` VALUES ('55', 'tid25', '44', 'arctype', 'en', '1545267531', '1545267531');
INSERT INTO `ey_language_attr` VALUES ('56', 'tid21', '45', 'arctype', 'en', '1545267531', '1545267531');
INSERT INTO `ey_language_attr` VALUES ('57', 'tid26', '46', 'arctype', 'en', '1545267531', '1545267531');
INSERT INTO `ey_language_attr` VALUES ('58', 'tid22', '47', 'arctype', 'en', '1545267531', '1545267531');
INSERT INTO `ey_language_attr` VALUES ('59', 'tid27', '48', 'arctype', 'en', '1545267531', '1545267531');
INSERT INTO `ey_language_attr` VALUES ('60', 'tid28', '49', 'arctype', 'en', '1545267531', '1545267531');
INSERT INTO `ey_language_attr` VALUES ('61', 'tid29', '50', 'arctype', 'en', '1545267531', '1545267531');
INSERT INTO `ey_language_attr` VALUES ('62', 'tid4', '51', 'arctype', 'en', '1545267531', '1545267531');
INSERT INTO `ey_language_attr` VALUES ('63', 'tid5', '52', 'arctype', 'en', '1545267531', '1545267531');
INSERT INTO `ey_language_attr` VALUES ('64', 'tid6', '53', 'arctype', 'en', '1545267531', '1545267531');
INSERT INTO `ey_language_attr` VALUES ('65', 'attr_1', '11', 'product_attribute', 'en', '1545267531', '1545267531');
INSERT INTO `ey_language_attr` VALUES ('66', 'attr_2', '12', 'product_attribute', 'en', '1545267531', '1545267531');
INSERT INTO `ey_language_attr` VALUES ('67', 'attr_3', '13', 'product_attribute', 'en', '1545267531', '1545267531');
INSERT INTO `ey_language_attr` VALUES ('68', 'attr_4', '14', 'product_attribute', 'en', '1545267531', '1545267531');
INSERT INTO `ey_language_attr` VALUES ('69', 'attr_5', '15', 'product_attribute', 'en', '1545267531', '1545267531');
INSERT INTO `ey_language_attr` VALUES ('70', 'attr_6', '16', 'product_attribute', 'en', '1545267531', '1545267531');
INSERT INTO `ey_language_attr` VALUES ('71', 'attr_7', '17', 'product_attribute', 'en', '1545267531', '1545267531');
INSERT INTO `ey_language_attr` VALUES ('72', 'attr_8', '18', 'product_attribute', 'en', '1545267531', '1545267531');
INSERT INTO `ey_language_attr` VALUES ('73', 'attr_1', '9', 'guestbook_attribute', 'en', '1545267531', '1545267531');
INSERT INTO `ey_language_attr` VALUES ('74', 'attr_2', '10', 'guestbook_attribute', 'en', '1545267531', '1545267531');
INSERT INTO `ey_language_attr` VALUES ('75', 'attr_3', '11', 'guestbook_attribute', 'en', '1545267531', '1545267531');
INSERT INTO `ey_language_attr` VALUES ('76', 'attr_4', '12', 'guestbook_attribute', 'en', '1545267531', '1545267531');
INSERT INTO `ey_language_attr` VALUES ('77', 'attr_5', '13', 'guestbook_attribute', 'en', '1545267531', '1545267531');
INSERT INTO `ey_language_attr` VALUES ('78', 'attr_6', '14', 'guestbook_attribute', 'en', '1545267531', '1545267531');
INSERT INTO `ey_language_attr` VALUES ('79', 'attr_7', '15', 'guestbook_attribute', 'en', '1545267531', '1545267531');
INSERT INTO `ey_language_attr` VALUES ('80', 'adp1', '2', 'ad_position', 'en', '1545267532', '1545267532');
INSERT INTO `ey_language_attr` VALUES ('81', 'ad1', '3', 'ad', 'en', '1545267532', '1545267532');
INSERT INTO `ey_language_attr` VALUES ('82', 'ad2', '4', 'ad', 'en', '1545267532', '1545267532');

-- -----------------------------
-- Table structure for `ey_language_attribute`
-- -----------------------------
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
) ENGINE=MyISAM AUTO_INCREMENT=42 DEFAULT CHARSET=utf8 COMMENT='多语言模板变量表';

-- -----------------------------
-- Records of `ey_language_attribute`
-- -----------------------------
INSERT INTO `ey_language_attribute` VALUES ('1', '关于我们', 'tid1', 'arctype', '0', '1545267517', '1545267517');
INSERT INTO `ey_language_attribute` VALUES ('2', '新闻动态', 'tid2', 'arctype', '0', '1545267517', '1545267517');
INSERT INTO `ey_language_attribute` VALUES ('3', '产品展示', 'tid3', 'arctype', '0', '1545267517', '1545267517');
INSERT INTO `ey_language_attribute` VALUES ('4', '客户案例', 'tid4', 'arctype', '0', '1545267517', '1545267517');
INSERT INTO `ey_language_attribute` VALUES ('5', '资料下载', 'tid5', 'arctype', '0', '1545267517', '1545267517');
INSERT INTO `ey_language_attribute` VALUES ('6', '报名入口', 'tid6', 'arctype', '0', '1545267517', '1545267517');
INSERT INTO `ey_language_attribute` VALUES ('7', '公司简介', 'tid8', 'arctype', '0', '1545267517', '1545267517');
INSERT INTO `ey_language_attribute` VALUES ('8', '公司荣誉', 'tid9', 'arctype', '0', '1545267517', '1545267517');
INSERT INTO `ey_language_attribute` VALUES ('9', '媒体报道', 'tid10', 'arctype', '0', '1545267517', '1545267517');
INSERT INTO `ey_language_attribute` VALUES ('10', 'SEO优化', 'tid11', 'arctype', '0', '1545267517', '1545267517');
INSERT INTO `ey_language_attribute` VALUES ('11', '企业运营', 'tid12', 'arctype', '0', '1545267517', '1545267517');
INSERT INTO `ey_language_attribute` VALUES ('12', '单页面', 'tid13', 'arctype', '0', '1545267517', '1545267517');
INSERT INTO `ey_language_attribute` VALUES ('13', '手机', 'tid20', 'arctype', '0', '1545267517', '1545267517');
INSERT INTO `ey_language_attribute` VALUES ('14', '电脑', 'tid21', 'arctype', '0', '1545267517', '1545267517');
INSERT INTO `ey_language_attribute` VALUES ('15', '通用配件', 'tid22', 'arctype', '0', '1545267517', '1545267517');
INSERT INTO `ey_language_attribute` VALUES ('16', '风景图集', 'tid23', 'arctype', '0', '1545267517', '1545267517');
INSERT INTO `ey_language_attribute` VALUES ('17', '智能手机', 'tid24', 'arctype', '0', '1545267517', '1545267517');
INSERT INTO `ey_language_attribute` VALUES ('18', '畅玩手机', 'tid25', 'arctype', '0', '1545267517', '1545267517');
INSERT INTO `ey_language_attribute` VALUES ('19', '笔记本电脑', 'tid26', 'arctype', '0', '1545267517', '1545267517');
INSERT INTO `ey_language_attribute` VALUES ('20', '耳机', 'tid27', 'arctype', '0', '1545267517', '1545267517');
INSERT INTO `ey_language_attribute` VALUES ('21', '音箱', 'tid28', 'arctype', '0', '1545267517', '1545267517');
INSERT INTO `ey_language_attribute` VALUES ('22', '充电宝', 'tid29', 'arctype', '0', '1545267517', '1545267517');
INSERT INTO `ey_language_attribute` VALUES ('23', '预约面试', 'tid30', 'arctype', '0', '1545267517', '1545267517');
INSERT INTO `ey_language_attribute` VALUES ('24', '姓名', 'attr_1', 'guestbook_attribute', '0', '1545267518', '1545267518');
INSERT INTO `ey_language_attribute` VALUES ('25', '手机号码', 'attr_2', 'guestbook_attribute', '0', '1545267518', '1545267518');
INSERT INTO `ey_language_attribute` VALUES ('26', '约谈对象', 'attr_3', 'guestbook_attribute', '0', '1545267518', '1545267518');
INSERT INTO `ey_language_attribute` VALUES ('27', '姓名', 'attr_4', 'guestbook_attribute', '0', '1545267518', '1545267518');
INSERT INTO `ey_language_attribute` VALUES ('28', '联系方式', 'attr_5', 'guestbook_attribute', '0', '1545267518', '1545267518');
INSERT INTO `ey_language_attribute` VALUES ('29', '备注信息', 'attr_6', 'guestbook_attribute', '0', '1545267518', '1545267518');
INSERT INTO `ey_language_attribute` VALUES ('30', '模式', 'attr_7', 'guestbook_attribute', '0', '1545267518', '1545267518');
INSERT INTO `ey_language_attribute` VALUES ('31', '用户界面', 'attr_1', 'product_attribute', '0', '1545267518', '1545267518');
INSERT INTO `ey_language_attribute` VALUES ('32', '操作系统', 'attr_2', 'product_attribute', '0', '1545267518', '1545267518');
INSERT INTO `ey_language_attribute` VALUES ('33', '键盘类型', 'attr_3', 'product_attribute', '0', '1545267518', '1545267518');
INSERT INTO `ey_language_attribute` VALUES ('34', ' 型号', 'attr_4', 'product_attribute', '0', '1545267518', '1545267518');
INSERT INTO `ey_language_attribute` VALUES ('35', '屏幕大小', 'attr_5', 'product_attribute', '0', '1545267518', '1545267518');
INSERT INTO `ey_language_attribute` VALUES ('36', '重量', 'attr_6', 'product_attribute', '0', '1545267518', '1545267518');
INSERT INTO `ey_language_attribute` VALUES ('37', '型号', 'attr_7', 'product_attribute', '0', '1545267518', '1545267518');
INSERT INTO `ey_language_attribute` VALUES ('38', '支持蓝牙', 'attr_8', 'product_attribute', '0', '1545267518', '1545267518');
INSERT INTO `ey_language_attribute` VALUES ('39', '共展蓝图', 'ad1', 'ad', '0', '1545267518', '1545267518');
INSERT INTO `ey_language_attribute` VALUES ('40', '易优模板库', 'ad2', 'ad', '0', '1545267518', '1545267518');
INSERT INTO `ey_language_attribute` VALUES ('41', '首页-大幻灯片', 'adp1', 'ad_position', '0', '1545267518', '1545267518');

-- -----------------------------
-- Table structure for `ey_language_mark`
-- -----------------------------
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

-- -----------------------------
-- Records of `ey_language_mark`
-- -----------------------------
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

-- -----------------------------
-- Table structure for `ey_language_pack`
-- -----------------------------
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
) ENGINE=MyISAM AUTO_INCREMENT=51 DEFAULT CHARSET=utf8 COMMENT='模板语言包变量';

-- -----------------------------
-- Records of `ey_language_pack`
-- -----------------------------
INSERT INTO `ey_language_pack` VALUES ('1', 'sys1', '首页', '1', 'cn', '100', '1543890216', '1543890216');
INSERT INTO `ey_language_pack` VALUES ('2', 'sys2', '上一页', '1', 'cn', '100', '1543890216', '1543890216');
INSERT INTO `ey_language_pack` VALUES ('3', 'sys3', '下一页', '1', 'cn', '100', '1543890216', '1543890216');
INSERT INTO `ey_language_pack` VALUES ('4', 'sys4', '末页', '1', 'cn', '100', '1543890216', '1543890216');
INSERT INTO `ey_language_pack` VALUES ('5', 'sys5', '共<strong>%s</strong>页 <strong>%s</strong>条', '1', 'cn', '100', '1543890216', '1543890216');
INSERT INTO `ey_language_pack` VALUES ('6', 'sys6', '全部', '1', 'cn', '100', '1543890216', '1543890216');
INSERT INTO `ey_language_pack` VALUES ('7', 'sys7', '搜索', '1', 'cn', '100', '1543890216', '1543890216');
INSERT INTO `ey_language_pack` VALUES ('8', 'sys8', '查看详情', '1', 'cn', '100', '1543890216', '1543890216');
INSERT INTO `ey_language_pack` VALUES ('9', 'sys9', '网站首页', '1', 'cn', '100', '1543890216', '1543890216');
INSERT INTO `ey_language_pack` VALUES ('10', 'sys10', '暂无', '1', 'cn', '100', '1543890216', '1543890216');
INSERT INTO `ey_language_pack` VALUES ('11', 'sys11', '上一篇', '1', 'cn', '100', '1543890216', '1543890216');
INSERT INTO `ey_language_pack` VALUES ('12', 'sys12', '下一篇', '1', 'cn', '100', '1543890216', '1543890216');
INSERT INTO `ey_language_pack` VALUES ('13', 'sys1', 'Home', '1', 'en', '100', '1545267534', '1545267534');
INSERT INTO `ey_language_pack` VALUES ('14', 'sys2', 'Previous', '1', 'en', '100', '1545267534', '1545267534');
INSERT INTO `ey_language_pack` VALUES ('15', 'sys3', 'Next', '1', 'en', '100', '1545267534', '1545267534');
INSERT INTO `ey_language_pack` VALUES ('16', 'sys4', 'Last', '1', 'en', '100', '1545267534', '1545267534');
INSERT INTO `ey_language_pack` VALUES ('17', 'sys5', 'Road <strong>%s</strong> page <strong>%s</strong> strip', '1', 'en', '100', '1545267534', '1545267534');
INSERT INTO `ey_language_pack` VALUES ('18', 'sys6', 'All', '1', 'en', '100', '1545267534', '1545267534');
INSERT INTO `ey_language_pack` VALUES ('19', 'sys7', 'Search', '1', 'en', '100', '1545267534', '1545267534');
INSERT INTO `ey_language_pack` VALUES ('20', 'sys8', 'View details', '1', 'en', '100', '1545267534', '1545267534');
INSERT INTO `ey_language_pack` VALUES ('21', 'sys9', 'Home', '1', 'en', '100', '1545267534', '1545267534');
INSERT INTO `ey_language_pack` VALUES ('22', 'sys10', 'No time', '1', 'en', '100', '1545267534', '1545267534');
INSERT INTO `ey_language_pack` VALUES ('23', 'sys11', 'Previous', '1', 'en', '100', '1545267534', '1545267534');
INSERT INTO `ey_language_pack` VALUES ('24', 'sys12', 'Next', '1', 'en', '100', '1545267534', '1545267534');
INSERT INTO `ey_language_pack` VALUES ('25', 'yybl1', '网站首页', '0', 'cn', '100', '1545272835', '1545272835');
INSERT INTO `ey_language_pack` VALUES ('26', 'yybl1', 'Home', '0', 'en', '100', '1545272835', '1545272835');
INSERT INTO `ey_language_pack` VALUES ('27', 'yybl2', '全部', '0', 'cn', '100', '1545272897', '1545272897');
INSERT INTO `ey_language_pack` VALUES ('28', 'yybl2', 'All', '0', 'en', '100', '1545272897', '1545272897');
INSERT INTO `ey_language_pack` VALUES ('29', 'yybl3', '查看更多', '0', 'cn', '100', '1545272961', '1545272961');
INSERT INTO `ey_language_pack` VALUES ('30', 'yybl3', 'View more', '0', 'en', '100', '1545272961', '1545272961');
INSERT INTO `ey_language_pack` VALUES ('31', 'yybl4', '联系热线', '0', 'cn', '100', '1545273023', '1545273023');
INSERT INTO `ey_language_pack` VALUES ('32', 'yybl4', 'Contact Hotline', '0', 'en', '100', '1545273023', '1545273023');
INSERT INTO `ey_language_pack` VALUES ('33', 'yybl5', '你的位置', '0', 'cn', '100', '1545273158', '1545273158');
INSERT INTO `ey_language_pack` VALUES ('34', 'yybl5', 'Rosition', '0', 'en', '100', '1545273158', '1545273158');
INSERT INTO `ey_language_pack` VALUES ('35', 'yybl6', '请输入关键词', '0', 'cn', '100', '1545273239', '1545273239');
INSERT INTO `ey_language_pack` VALUES ('36', 'yybl6', 'Please enter a keyword', '0', 'en', '100', '1545273239', '1545273239');
INSERT INTO `ey_language_pack` VALUES ('37', 'yybl7', '为您推荐', '0', 'cn', '100', '1545273292', '1545273292');
INSERT INTO `ey_language_pack` VALUES ('38', 'yybl7', 'Recommend for you', '0', 'en', '100', '1545273292', '1545273292');
INSERT INTO `ey_language_pack` VALUES ('39', 'yybl8', '热门推荐', '0', 'cn', '100', '1545273376', '1545273376');
INSERT INTO `ey_language_pack` VALUES ('40', 'yybl8', 'Popular recommendation', '0', 'en', '100', '1545273376', '1545273376');
INSERT INTO `ey_language_pack` VALUES ('41', 'yybl9', '详细信息', '0', 'cn', '100', '1545273418', '1545273418');
INSERT INTO `ey_language_pack` VALUES ('42', 'yybl9', 'Details', '0', 'en', '100', '1545273418', '1545273418');
INSERT INTO `ey_language_pack` VALUES ('43', 'yybl10', '下载包', '0', 'cn', '100', '1545273596', '1545273596');
INSERT INTO `ey_language_pack` VALUES ('44', 'yybl10', 'Download package', '0', 'en', '100', '1545273596', '1545273596');
INSERT INTO `ey_language_pack` VALUES ('45', 'yybl11', '文件附件列表', '0', 'cn', '100', '1545273655', '1545273655');
INSERT INTO `ey_language_pack` VALUES ('46', 'yybl11', 'List of file attachments', '0', 'en', '100', '1545273655', '1545273655');
INSERT INTO `ey_language_pack` VALUES ('47', 'yybl12', '结果', '0', 'cn', '100', '1545274437', '1545274437');
INSERT INTO `ey_language_pack` VALUES ('48', 'yybl12', 'Result', '0', 'en', '100', '1545274437', '1545274437');
INSERT INTO `ey_language_pack` VALUES ('49', 'yybl13', '没有数据了', '0', 'cn', '100', '1545274472', '1546477350');
INSERT INTO `ey_language_pack` VALUES ('50', 'yybl13', 'No data.', '0', 'en', '100', '1545274472', '1546477350');

-- -----------------------------
-- Table structure for `ey_links`
-- -----------------------------
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

-- -----------------------------
-- Records of `ey_links`
-- -----------------------------
INSERT INTO `ey_links` VALUES ('1', '1', '百度', 'http://www.baidu.com', '', '100', '1', '', '', '1', 'cn', '0', '1524975826', '1537585074');
INSERT INTO `ey_links` VALUES ('2', '1', '腾讯', 'http://www.qq.com', '', '100', '1', '', '', '1', 'cn', '0', '1524976095', '1537585061');
INSERT INTO `ey_links` VALUES ('3', '1', '新浪', 'http://www.sina.com.cn', '', '100', '1', '', '', '1', 'cn', '0', '1532414285', '1537585047');
INSERT INTO `ey_links` VALUES ('4', '1', '小程序开发教程', 'http://www.yiyongtong.com', '', '100', '1', '', '', '1', 'cn', '0', '1532414529', '1537585013');
INSERT INTO `ey_links` VALUES ('5', '1', '素材58', 'http://www.sucai58.com', '', '100', '1', '', '', '1', 'cn', '0', '1532414726', '1537585146');
INSERT INTO `ey_links` VALUES ('6', '1', 'baidu', 'http://www.baidu.com', '', '100', '1', '', '', '1', 'en', '0', '1524975826', '1547473399');
INSERT INTO `ey_links` VALUES ('7', '1', 'qq', 'http://www.qq.com', '', '100', '1', '', '', '1', 'en', '0', '1524976095', '1547473391');
INSERT INTO `ey_links` VALUES ('8', '1', 'sina', 'http://www.sina.com.cn', '', '100', '1', '', '', '1', 'en', '0', '1532414285', '1547473376');
INSERT INTO `ey_links` VALUES ('9', '1', 'yiyongtong', 'http://www.yiyongtong.com', '', '100', '1', '', '', '1', 'en', '0', '1532414529', '1547473365');
INSERT INTO `ey_links` VALUES ('10', '1', 'sucai58', 'http://www.sucai58.com', '', '100', '1', '', '', '1', 'en', '0', '1532414726', '1547473355');

-- -----------------------------
-- Table structure for `ey_product_attr`
-- -----------------------------
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
) ENGINE=MyISAM AUTO_INCREMENT=37 DEFAULT CHARSET=utf8 COMMENT='产品表单属性值';

-- -----------------------------
-- Records of `ey_product_attr`
-- -----------------------------
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
INSERT INTO `ey_product_attr` VALUES ('25', '53', '17', 'AKG&amp;HUAWEI', '', '1545268991', '1545268991');
INSERT INTO `ey_product_attr` VALUES ('26', '53', '18', 'Support', '', '1545268991', '1545268991');
INSERT INTO `ey_product_attr` VALUES ('27', '54', '15', '13.3', '', '1545270139', '1545270139');
INSERT INTO `ey_product_attr` VALUES ('28', '54', '16', '3KG', '', '1545270139', '1545270139');
INSERT INTO `ey_product_attr` VALUES ('29', '55', '12', 'EMUI 4.1 + Android 6.0', '', '1545270361', '1545270361');
INSERT INTO `ey_product_attr` VALUES ('30', '55', '11', 'EMUI 4.1', '', '1545270361', '1545270361');
INSERT INTO `ey_product_attr` VALUES ('31', '55', '13', 'Virtual keyboard', '', '1545270361', '1545270361');
INSERT INTO `ey_product_attr` VALUES ('32', '55', '14', 'EDI-AL10', '', '1545270361', '1545270361');
INSERT INTO `ey_product_attr` VALUES ('33', '56', '12', 'iOS 9.0', '', '1545270634', '1545270634');
INSERT INTO `ey_product_attr` VALUES ('34', '56', '11', '4.7 inch display screen', '', '1545270634', '1545270634');
INSERT INTO `ey_product_attr` VALUES ('35', '56', '13', 'Virtual keyboard', '', '1545270634', '1545270634');
INSERT INTO `ey_product_attr` VALUES ('36', '56', '14', '6S', '', '1545270634', '1545270634');

-- -----------------------------
-- Table structure for `ey_product_attribute`
-- -----------------------------
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

-- -----------------------------
-- Records of `ey_product_attribute`
-- -----------------------------
INSERT INTO `ey_product_attribute` VALUES ('1', '用户界面', '24', '0', '0', '', '100', 'cn', '0', '1526612774', '1526612774');
INSERT INTO `ey_product_attribute` VALUES ('2', '操作系统', '24', '0', '0', '', '10', 'cn', '0', '1526612785', '1526612785');
INSERT INTO `ey_product_attribute` VALUES ('3', '键盘类型', '24', '0', '0', '', '100', 'cn', '0', '1526613004', '1526613004');
INSERT INTO `ey_product_attribute` VALUES ('4', ' 型号', '24', '0', '0', '', '100', 'cn', '0', '1526613011', '1526613011');
INSERT INTO `ey_product_attribute` VALUES ('5', '屏幕大小', '26', '0', '0', '', '100', 'cn', '0', '1526613252', '1526613252');
INSERT INTO `ey_product_attribute` VALUES ('6', '重量', '26', '0', '0', '', '100', 'cn', '0', '1526613259', '1526613259');
INSERT INTO `ey_product_attribute` VALUES ('7', '型号', '27', '0', '0', '', '100', 'cn', '0', '1526613668', '1526613668');
INSERT INTO `ey_product_attribute` VALUES ('8', '支持蓝牙', '27', '0', '0', '', '100', 'cn', '0', '1526613732', '1526613732');
INSERT INTO `ey_product_attribute` VALUES ('11', 'User Interface', '43', '0', '0', '', '100', 'en', '0', '1526612774', '1545274001');
INSERT INTO `ey_product_attribute` VALUES ('12', 'operating system', '43', '0', '0', '', '10', 'en', '0', '1526612785', '1545273990');
INSERT INTO `ey_product_attribute` VALUES ('13', 'Keyboard type', '43', '0', '0', '', '100', 'en', '0', '1526613004', '1545274014');
INSERT INTO `ey_product_attribute` VALUES ('14', 'model', '43', '0', '0', '', '100', 'en', '0', '1526613011', '1545274025');
INSERT INTO `ey_product_attribute` VALUES ('15', 'Screen size', '46', '0', '0', '', '100', 'en', '0', '1526613252', '1545270158');
INSERT INTO `ey_product_attribute` VALUES ('16', 'Weight', '46', '0', '0', '', '100', 'en', '0', '1526613259', '1545270171');
INSERT INTO `ey_product_attribute` VALUES ('17', 'Model', '48', '0', '0', '', '100', 'en', '0', '1526613668', '1545268934');
INSERT INTO `ey_product_attribute` VALUES ('18', 'Support Bluetooth', '48', '0', '0', '', '100', 'en', '0', '1526613732', '1545268951');

-- -----------------------------
-- Table structure for `ey_product_content`
-- -----------------------------
DROP TABLE IF EXISTS `ey_product_content`;
CREATE TABLE `ey_product_content` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `aid` int(10) DEFAULT '0' COMMENT '文档ID',
  `content` longtext COMMENT '内容详情',
  `add_time` int(11) DEFAULT '0' COMMENT '新增时间',
  `update_time` int(11) DEFAULT '0' COMMENT '更新时间',
  PRIMARY KEY (`id`),
  KEY `news_id` (`aid`) USING BTREE
) ENGINE=MyISAM AUTO_INCREMENT=10 DEFAULT CHARSET=utf8 COMMENT='产品附加表';

-- -----------------------------
-- Records of `ey_product_content`
-- -----------------------------
INSERT INTO `ey_product_content` VALUES ('2', '27', '&lt;p&gt;&lt;span style=&quot;color: rgb(94, 115, 135); font-family: &amp;quot;Segoe UI&amp;quot;, &amp;quot;Lucida Grande&amp;quot;, Helvetica, Arial, &amp;quot;Microsoft YaHei&amp;quot;, FreeSans, Arimo, &amp;quot;Droid Sans&amp;quot;, &amp;quot;wenquanyi micro hei&amp;quot;, &amp;quot;Hiragino Sans GB&amp;quot;, &amp;quot;Hiragino Sans GB W3&amp;quot;, Roboto, Arial, sans-serif; font-size: 14px; background-color: rgb(255, 255, 255);&quot;&gt;全向录音/指向回放、定向免提、指关节手势、分屏多窗口、语音控制、情景智能、单手操作、杂志锁屏、手机找回、无线WIFI打印、学生模式、多屏互动、运动健康&lt;/span&gt;&lt;span style=&quot;color: rgb(94, 115, 135); font-family: &amp;quot;Segoe UI&amp;quot;, &amp;quot;Lucida Grande&amp;quot;, Helvetica, Arial, &amp;quot;Microsoft YaHei&amp;quot;, FreeSans, Arimo, &amp;quot;Droid Sans&amp;quot;, &amp;quot;wenquanyi micro hei&amp;quot;, &amp;quot;Hiragino Sans GB&amp;quot;, &amp;quot;Hiragino Sans GB W3&amp;quot;, Roboto, Arial, sans-serif; font-size: 14px; background-color: rgb(255, 255, 255);&quot;&gt;全向录音/指向回放、定向免提、指关节手势、分屏多窗口、语音控制、情景智能、单手操作、杂志锁屏、手机找回、无线WIFI打印、学生模式、多屏互动、运动健康&lt;/span&gt;&lt;span style=&quot;color: rgb(94, 115, 135); font-family: &amp;quot;Segoe UI&amp;quot;, &amp;quot;Lucida Grande&amp;quot;, Helvetica, Arial, &amp;quot;Microsoft YaHei&amp;quot;, FreeSans, Arimo, &amp;quot;Droid Sans&amp;quot;, &amp;quot;wenquanyi micro hei&amp;quot;, &amp;quot;Hiragino Sans GB&amp;quot;, &amp;quot;Hiragino Sans GB W3&amp;quot;, Roboto, Arial, sans-serif; font-size: 14px; background-color: rgb(255, 255, 255);&quot;&gt;全向录音/指向回放、定向免提、指关节手势、分屏多窗口、语音控制、情景智能、单手操作、杂志锁屏、手机找回、无线WIFI打印、学生模式、多屏互动、运动健康的&lt;/span&gt;&lt;/p&gt;', '1547462188', '1547462188');
INSERT INTO `ey_product_content` VALUES ('3', '28', '&lt;p&gt;轻薄全金属机身 / 256GB SSD / 第八代 Intel 酷睿i5 处理器 / FHD 全贴合屏幕 / 指纹解锁 / office激活不支持7天无理由退货&lt;/p&gt;&lt;p&gt;&lt;img src=&quot;/uploads/ueditor/20190114/aa0555d4f00163878c1d39ab046bb742.jpg&quot; title=&quot;aa0555d4f00163878c1d39ab046bb742.jpg&quot; alt=&quot;aa0555d4f00163878c1d39ab046bb742.jpg&quot;/&gt;&lt;/p&gt;', '1547462162', '1547462162');
INSERT INTO `ey_product_content` VALUES ('4', '29', '&lt;p&gt;&lt;span style=&quot;color: rgb(94, 115, 135); font-family: &amp;quot;Segoe UI&amp;quot;, &amp;quot;Lucida Grande&amp;quot;, Helvetica, Arial, &amp;quot;Microsoft YaHei&amp;quot;, FreeSans, Arimo, &amp;quot;Droid Sans&amp;quot;, &amp;quot;wenquanyi micro hei&amp;quot;, &amp;quot;Hiragino Sans GB&amp;quot;, &amp;quot;Hiragino Sans GB W3&amp;quot;, Roboto, Arial, sans-serif; font-size: 14px; background-color: rgb(255, 255, 255);&quot;&gt;特性	M3平板定制AKG品牌高保真耳机，配合M3平板享受HiFi音质&lt;/span&gt;&lt;/p&gt;', '1547462018', '1547462018');
INSERT INTO `ey_product_content` VALUES ('5', '37', '&lt;p&gt;&lt;img src=&quot;/uploads/ueditor/20190114/288f1763cd97030de176a4a4a0936fd4.jpg&quot; title=&quot;288f1763cd97030de176a4a4a0936fd4.jpg&quot; alt=&quot;288f1763cd97030de176a4a4a0936fd4.jpg&quot;/&gt;&lt;/p&gt;', '1547461970', '1547461970');
INSERT INTO `ey_product_content` VALUES ('6', '53', '&lt;p&gt;Features: M3 Tablet Customized AKG Brand High Fidelity Headphones, Enjoy HiFi Sound Quality with M3 Tablet&lt;/p&gt;', '1545270011', '1545270011');
INSERT INTO `ey_product_content` VALUES ('7', '54', '&lt;p style=&quot;box-sizing: inherit; margin-top: 0px; margin-bottom: 0.8em; color: rgb(42, 51, 60); font-family: &amp;quot;Segoe UI&amp;quot;, &amp;quot;Lucida Grande&amp;quot;, Helvetica, Arial, &amp;quot;Microsoft YaHei&amp;quot;, FreeSans, Arimo, &amp;quot;Droid Sans&amp;quot;, &amp;quot;wenquanyi micro hei&amp;quot;, &amp;quot;Hiragino Sans GB&amp;quot;, &amp;quot;Hiragino Sans GB W3&amp;quot;, Roboto, Arial, sans-serif; white-space: normal; background-color: rgb(255, 255, 255);&quot;&gt;Light and thin all-metal fuselage / 256GB SSD / 8th generation Intel Core i5 processor / FHD full-fit screen / fingerprint unlock / Office activation does not support 7 days without reason to return the goods&lt;/p&gt;&lt;p style=&quot;box-sizing: inherit; margin-top: 0px; margin-bottom: 0.8em; color: rgb(42, 51, 60); font-family: &amp;quot;Segoe UI&amp;quot;, &amp;quot;Lucida Grande&amp;quot;, Helvetica, Arial, &amp;quot;Microsoft YaHei&amp;quot;, FreeSans, Arimo, &amp;quot;Droid Sans&amp;quot;, &amp;quot;wenquanyi micro hei&amp;quot;, &amp;quot;Hiragino Sans GB&amp;quot;, &amp;quot;Hiragino Sans GB W3&amp;quot;, Roboto, Arial, sans-serif; white-space: normal; background-color: rgb(255, 255, 255);&quot;&gt;&lt;img src=&quot;/uploads/ueditor/20181220/5c1af35580c9a.png&quot; title=&quot;4e5a31ff6bb3f88e03ae2d80353cdc67.jpg&quot; alt=&quot;4e5a31ff6bb3f88e03ae2d80353cdc67.jpg&quot; style=&quot;box-sizing: inherit; border-style: none; vertical-align: top; max-width: 100%; height: auto !important;&quot;/&gt;&lt;/p&gt;&lt;p&gt;&lt;br/&gt;&lt;/p&gt;', '1545270139', '1545270139');
INSERT INTO `ey_product_content` VALUES ('8', '55', '&lt;p&gt;Omnidirectional recording/pointing playback, directional hands-free, finger joint gesture, split screen multi-window, voice control, situational intelligence, single-handed operation, magazine lock screen, mobile phone retrieval, wireless WIFI printing, student mode, multi-screen interaction, sports health omnidirectional recording/pointing playback, directional hands-free, finger joint gesture, split screen multi-window, voice control, situational intelligence, single-handed operation, magazine lock Screen, mobile phone retrieval, wireless WIFI printing, student mode, multi-screen interaction, omnidirectional recording/pointing playback of sports health, directional hands-free, finger joint gesture, split screen multi-window, voice control, situational intelligence, single-handed operation, magazine lock screen, mobile phone retrieval, wireless WIFI printing, student mode, multi-screen interaction, sports health&lt;/p&gt;', '1545270361', '1545270361');
INSERT INTO `ey_product_content` VALUES ('9', '56', '&lt;p style=&quot;text-align: center;&quot;&gt;&lt;img src=&quot;/uploads/ueditor/20181220/ac06829b2cc1070d75c6d3ea8e6aa55e.jpg&quot; title=&quot;ac06829b2cc1070d75c6d3ea8e6aa55e.jpg&quot; alt=&quot;ac06829b2cc1070d75c6d3ea8e6aa55e.jpg&quot;/&gt;&lt;/p&gt;', '1545270643', '1545270643');

-- -----------------------------
-- Table structure for `ey_product_img`
-- -----------------------------
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
) ENGINE=MyISAM AUTO_INCREMENT=75 DEFAULT CHARSET=utf8 COMMENT='产品图片表';

-- -----------------------------
-- Records of `ey_product_img`
-- -----------------------------
INSERT INTO `ey_product_img` VALUES ('74', '27', '华为HUAWEI NOTE 8', '/uploads/allimg/20190114/c293bf2f7095774bb0a7d5b3405212fa.jpg', '400', '400', '0', 'image/jpeg', '1', '1547462188');
INSERT INTO `ey_product_img` VALUES ('73', '28', '小米笔记本Air 13.3', '/uploads/allimg/20190114/ab5d06499e319c69ea0f07e7443846f0.jpg', '400', '400', '0', 'image/jpeg', '2', '1547462162');
INSERT INTO `ey_product_img` VALUES ('72', '28', '小米笔记本Air 13.3', '/uploads/allimg/20190114/44bfc4ca62d0c69d750716616410ff96.jpg', '560', '560', '0', 'image/jpeg', '1', '1547462162');
INSERT INTO `ey_product_img` VALUES ('71', '29', ' 小米蓝牙项圈耳机', '/uploads/allimg/20190114/e4c13f6756671c2352699564e72090cd.jpg', '400', '400', '0', 'image/jpeg', '3', '1547462018');
INSERT INTO `ey_product_img` VALUES ('70', '29', ' 小米蓝牙项圈耳机', '/uploads/allimg/20190114/252a53e6fbc8f441b2570f755d2bbeb8.jpg', '400', '400', '0', 'image/jpeg', '2', '1547462018');
INSERT INTO `ey_product_img` VALUES ('69', '29', ' 小米蓝牙项圈耳机', '/uploads/allimg/20190114/6d22b1d211614d5e5576eab6165a01f4.jpg', '400', '400', '0', 'image/jpeg', '1', '1547462018');
INSERT INTO `ey_product_img` VALUES ('68', '37', 'Apple iPhone 6s 16GB 玫瑰金色 移动联通电信4G手机', '/uploads/allimg/20190114/072f5c74e44d385f0ffb3da201589465.jpg', '800', '800', '0', 'image/jpeg', '4', '1547461970');
INSERT INTO `ey_product_img` VALUES ('67', '37', 'Apple iPhone 6s 16GB 玫瑰金色 移动联通电信4G手机', '/uploads/allimg/20190114/cac28a6a5fd82547bd3a9d998a7fcfb9.jpg', '800', '800', '0', 'image/jpeg', '3', '1547461970');
INSERT INTO `ey_product_img` VALUES ('66', '37', 'Apple iPhone 6s 16GB 玫瑰金色 移动联通电信4G手机', '/uploads/allimg/20190114/63f4484dee1c69f20794262f270bc7e7.jpg', '800', '800', '0', 'image/jpeg', '2', '1547461970');
INSERT INTO `ey_product_img` VALUES ('65', '37', 'Apple iPhone 6s 16GB 玫瑰金色 移动联通电信4G手机', '/uploads/allimg/20190114/7f3a7afff3a43f6e4aef96ea0cc40146.jpg', '800', '800', '0', 'image/jpeg', '1', '1547461970');
INSERT INTO `ey_product_img` VALUES ('53', '53', 'Millet Bluetooth Necklace Headset', '/uploads/allimg/20181220/076dc6f94445ca25c80f9bdd76fd51ca.jpg', '400', '400', '0', 'image/jpeg', '3', '1545270011');
INSERT INTO `ey_product_img` VALUES ('52', '53', 'Millet Bluetooth Necklace Headset', '/uploads/allimg/20181220/e574d239dda300f806d5cb0c3d3f993e.jpg', '400', '400', '0', 'image/jpeg', '2', '1545270011');
INSERT INTO `ey_product_img` VALUES ('51', '53', 'Millet Bluetooth Necklace Headset', '/uploads/allimg/20181220/d2464706d9e621164caa8d613f6e3ed7.jpg', '400', '400', '0', 'image/jpeg', '1', '1545270011');
INSERT INTO `ey_product_img` VALUES ('54', '54', 'Millet notebook Air 13.3', '/uploads/allimg/20181220/da4e2737e982fd5655a8945e85a57773.jpg', '560', '560', '0', 'image/jpeg', '1', '1545270139');
INSERT INTO `ey_product_img` VALUES ('55', '54', 'Millet notebook Air 13.3', '/uploads/allimg/20181220/28b9c72484b187acc2562553bf4e2751.jpg', '400', '400', '0', 'image/jpeg', '2', '1545270139');
INSERT INTO `ey_product_img` VALUES ('56', '55', 'HUAWEI NOTE 8', '/uploads/allimg/20181220/a0f7262557ef417ad237ff268843ff7e.jpg', '400', '400', '0', 'image/jpeg', '1', '1545270361');
INSERT INTO `ey_product_img` VALUES ('64', '56', 'Apple iPhone 6s 16GB ', '/uploads/allimg/20181220/91d1360d886bfaedae98ab0b2a0e2adb.jpg', '800', '800', '0', 'image/jpeg', '4', '1545270643');
INSERT INTO `ey_product_img` VALUES ('63', '56', 'Apple iPhone 6s 16GB ', '/uploads/allimg/20181220/23004c3ebfc092aa34f94e28d849bc4f.jpg', '800', '800', '0', 'image/jpeg', '3', '1545270643');
INSERT INTO `ey_product_img` VALUES ('62', '56', 'Apple iPhone 6s 16GB ', '/uploads/allimg/20181220/f4bba94ad9473b0ef23517613eed5bc8.jpg', '800', '800', '0', 'image/jpeg', '2', '1545270643');
INSERT INTO `ey_product_img` VALUES ('61', '56', 'Apple iPhone 6s 16GB ', '/uploads/allimg/20181220/658d0bdb72a0798baea2b255384e7c7a.jpg', '800', '800', '0', 'image/jpeg', '1', '1545270643');

-- -----------------------------
-- Table structure for `ey_single_content`
-- -----------------------------
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

-- -----------------------------
-- Records of `ey_single_content`
-- -----------------------------
INSERT INTO `ey_single_content` VALUES ('1', '1', '1', '', '0', '1527836335');
INSERT INTO `ey_single_content` VALUES ('2', '2', '8', '&lt;p style=&quot;white-space: normal; text-indent: 2em;&quot;&gt;易优内容管理系统(&lt;a href=&quot;http://www.eyoucms.com/&quot; target=&quot;_blank&quot;&gt;EyouCms&lt;/a&gt;) 以模板多、易优化、开源而闻名，是国内新锐的PHP开源网站管理系统，也是最受用户好评的PHP类CMS系统，在经历多年的发展，目前的版本无论在功能，还是在后台易用性方面，都有了长足的发展和进步，eyoucms免费版的主要目标用户锁定在有企业建站需求的群体，当然也不乏有个人用户和学校等在使用该系统。&lt;/p&gt;&lt;p style=&quot;white-space: normal; text-indent: 2em;&quot;&gt;企业网站，无论大型还是中小型企业，利用网络传递信息在一定程度上提高了办事的效率，提高企业的竞争力。&lt;a href=&quot;http://www.eyoucms.com/&quot; target=&quot;_blank&quot;&gt;EyouCms&lt;/a&gt;网站建设系统做各种网站，&lt;a href=&quot;http://www.eyoucms.com/&quot; target=&quot;_blank&quot;&gt;EyouCms&lt;/a&gt;是什么，&lt;a href=&quot;http://www.eyoucms.com/&quot; target=&quot;_blank&quot;&gt;EyouCms&lt;/a&gt;是一个自由和开放源码的内容管理系统，它是一个可以独立使用的内容发布系统（CMS）。在中国，&lt;a href=&quot;http://www.eyoucms.com/&quot; target=&quot;_blank&quot;&gt;EyouCms&lt;/a&gt;属于最受人们喜爱的CMS系统。&lt;/p&gt;&lt;p style=&quot;white-space: normal; text-indent: 2em;&quot;&gt;政府机关，通过建立政府门户，有利于各种信息和资源的整合，为政府和社会公众之间加强联系和沟通，从而使政府可以更快、更便捷、更有效开展工作。&lt;/p&gt;&lt;p style=&quot;white-space: normal; text-indent: 2em;&quot;&gt;教育机构，通过网络信息的引入，使得教育机构之间及教育机构内部和教育者之间进行信息传递，全面提升教育类网站的层面。&lt;/p&gt;&lt;h3 style=&quot;white-space: normal;&quot;&gt;优点&lt;/h3&gt;&lt;ol class=&quot; list-paddingleft-2&quot;&gt;&lt;li&gt;&lt;p&gt;易用：使用易优你可以用它十分钟搭建一个企业网站，后台简单易用。&lt;/p&gt;&lt;/li&gt;&lt;li&gt;&lt;p&gt;完善：易优基本包含了一个常规企业网站需要的一切功能。&lt;/p&gt;&lt;/li&gt;&lt;li&gt;&lt;p&gt;扩展性：易优亦可通过插件库支持更多功能，如阿里短信或小程序等第三方扩展。&lt;br/&gt;&lt;/p&gt;&lt;/li&gt;&lt;li&gt;&lt;p&gt;丰富的资料：作为一个国内cms，易优拥有完善的帮助文档及标签手册。&lt;/p&gt;&lt;/li&gt;&lt;li&gt;&lt;p&gt;丰富的模版：易优拥有大量免费的漂亮模版，涵盖各行各业，任用户自由选择。&lt;/p&gt;&lt;/li&gt;&lt;/ol&gt;&lt;h3 style=&quot;white-space: normal;&quot;&gt;缺点&lt;/h3&gt;&lt;ol class=&quot; list-paddingleft-2&quot;&gt;&lt;li&gt;&lt;p&gt;创新性：易优是一个基于用户需求开发的系统，用户需求不断改变，我们竭力跟着并改变。&lt;/p&gt;&lt;/li&gt;&lt;li&gt;&lt;p&gt;社区：目前专注模板建设，这对于一个开源项目来说社区互动并没有真正建立起来。&lt;/p&gt;&lt;p&gt;&lt;br/&gt;&lt;/p&gt;&lt;/li&gt;&lt;/ol&gt;&lt;p style=&quot;white-space: normal; text-indent: 2em;&quot;&gt;未来，期待与用户携手缔造一个更好的易而优CMS...2018.6.1&lt;/p&gt;&lt;p&gt;&lt;br/&gt;&lt;/p&gt;', '0', '1527836706');
INSERT INTO `ey_single_content` VALUES ('3', '3', '13', '&lt;div yne-bulb-block=&quot;paragraph&quot; style=&quot;box-sizing: border-box; color: rgb(34, 34, 34); font-family: &amp;quot;Segoe UI&amp;quot;, &amp;quot;Lucida Grande&amp;quot;, Helvetica, Arial, &amp;quot;Microsoft YaHei&amp;quot;, FreeSans, Arimo, &amp;quot;Droid Sans&amp;quot;, &amp;quot;wenquanyi micro hei&amp;quot;, &amp;quot;Hiragino Sans GB&amp;quot;, &amp;quot;Hiragino Sans GB W3&amp;quot;, Roboto, Arial, sans-serif; font-size: 18px; white-space: normal;&quot;&gt;针对不同服务器、虚拟空间，运行PHP的环境也有所不同，目前主要分为：Nginx、apache、IIS以及其他服务器。下面分享如何去掉URL上的index.php字符，&lt;span style=&quot;box-sizing: border-box; color: rgb(255, 0, 0);&quot;&gt;记得最后要重启服务器，在管理后台清除缓存哦！&lt;/span&gt;&lt;/div&gt;&lt;div yne-bulb-block=&quot;paragraph&quot; style=&quot;box-sizing: border-box; color: rgb(34, 34, 34); font-family: &amp;quot;Segoe UI&amp;quot;, &amp;quot;Lucida Grande&amp;quot;, Helvetica, Arial, &amp;quot;Microsoft YaHei&amp;quot;, FreeSans, Arimo, &amp;quot;Droid Sans&amp;quot;, &amp;quot;wenquanyi micro hei&amp;quot;, &amp;quot;Hiragino Sans GB&amp;quot;, &amp;quot;Hiragino Sans GB W3&amp;quot;, Roboto, Arial, sans-serif; font-size: 18px; white-space: normal;&quot;&gt;&amp;nbsp;&lt;/div&gt;&lt;div yne-bulb-block=&quot;paragraph&quot; style=&quot;box-sizing: border-box; color: rgb(34, 34, 34); font-family: &amp;quot;Segoe UI&amp;quot;, &amp;quot;Lucida Grande&amp;quot;, Helvetica, Arial, &amp;quot;Microsoft YaHei&amp;quot;, FreeSans, Arimo, &amp;quot;Droid Sans&amp;quot;, &amp;quot;wenquanyi micro hei&amp;quot;, &amp;quot;Hiragino Sans GB&amp;quot;, &amp;quot;Hiragino Sans GB W3&amp;quot;, Roboto, Arial, sans-serif; font-size: 18px; white-space: normal;&quot;&gt;【IIS服务器】&lt;/div&gt;&lt;div yne-bulb-block=&quot;paragraph&quot; style=&quot;box-sizing: border-box; color: rgb(34, 34, 34); font-family: &amp;quot;Segoe UI&amp;quot;, &amp;quot;Lucida Grande&amp;quot;, Helvetica, Arial, &amp;quot;Microsoft YaHei&amp;quot;, FreeSans, Arimo, &amp;quot;Droid Sans&amp;quot;, &amp;quot;wenquanyi micro hei&amp;quot;, &amp;quot;Hiragino Sans GB&amp;quot;, &amp;quot;Hiragino Sans GB W3&amp;quot;, Roboto, Arial, sans-serif; font-size: 18px; white-space: normal;&quot;&gt;在网站根目录下有个 web.config 文件，这个文件的作用是重写URL，让URL变得简短，易于SEO优化，以及用户的记忆。打开 web.config 文件，在原有的基础上加以下代码片段即可。&lt;/div&gt;&lt;div yne-bulb-block=&quot;paragraph&quot; style=&quot;box-sizing: border-box; color: rgb(34, 34, 34); font-family: &amp;quot;Segoe UI&amp;quot;, &amp;quot;Lucida Grande&amp;quot;, Helvetica, Arial, &amp;quot;Microsoft YaHei&amp;quot;, FreeSans, Arimo, &amp;quot;Droid Sans&amp;quot;, &amp;quot;wenquanyi micro hei&amp;quot;, &amp;quot;Hiragino Sans GB&amp;quot;, &amp;quot;Hiragino Sans GB W3&amp;quot;, Roboto, Arial, sans-serif; font-size: 18px; white-space: normal;&quot;&gt;&lt;span style=&quot;box-sizing: border-box; color: rgb(255, 0, 0);&quot;&gt;&amp;lt;rewrite&amp;gt;&lt;/span&gt;&lt;/div&gt;&lt;div yne-bulb-block=&quot;paragraph&quot; style=&quot;box-sizing: border-box; color: rgb(34, 34, 34); font-family: &amp;quot;Segoe UI&amp;quot;, &amp;quot;Lucida Grande&amp;quot;, Helvetica, Arial, &amp;quot;Microsoft YaHei&amp;quot;, FreeSans, Arimo, &amp;quot;Droid Sans&amp;quot;, &amp;quot;wenquanyi micro hei&amp;quot;, &amp;quot;Hiragino Sans GB&amp;quot;, &amp;quot;Hiragino Sans GB W3&amp;quot;, Roboto, Arial, sans-serif; font-size: 18px; white-space: normal;&quot;&gt;&lt;span style=&quot;box-sizing: border-box; color: rgb(255, 0, 0);&quot;&gt;&amp;lt;rules&amp;gt;&lt;/span&gt;&lt;/div&gt;&lt;div yne-bulb-block=&quot;paragraph&quot; style=&quot;box-sizing: border-box; color: rgb(34, 34, 34); font-family: &amp;quot;Segoe UI&amp;quot;, &amp;quot;Lucida Grande&amp;quot;, Helvetica, Arial, &amp;quot;Microsoft YaHei&amp;quot;, FreeSans, Arimo, &amp;quot;Droid Sans&amp;quot;, &amp;quot;wenquanyi micro hei&amp;quot;, &amp;quot;Hiragino Sans GB&amp;quot;, &amp;quot;Hiragino Sans GB W3&amp;quot;, Roboto, Arial, sans-serif; font-size: 18px; white-space: normal;&quot;&gt;&lt;span style=&quot;box-sizing: border-box; color: rgb(255, 0, 0);&quot;&gt;&amp;lt;rule name=&amp;quot;Imported Rule 1&amp;quot; enabled=&amp;quot;true&amp;quot; stopProcessing=&amp;quot;true&amp;quot;&amp;gt;&lt;/span&gt;&lt;/div&gt;&lt;div yne-bulb-block=&quot;paragraph&quot; style=&quot;box-sizing: border-box; color: rgb(34, 34, 34); font-family: &amp;quot;Segoe UI&amp;quot;, &amp;quot;Lucida Grande&amp;quot;, Helvetica, Arial, &amp;quot;Microsoft YaHei&amp;quot;, FreeSans, Arimo, &amp;quot;Droid Sans&amp;quot;, &amp;quot;wenquanyi micro hei&amp;quot;, &amp;quot;Hiragino Sans GB&amp;quot;, &amp;quot;Hiragino Sans GB W3&amp;quot;, Roboto, Arial, sans-serif; font-size: 18px; white-space: normal;&quot;&gt;&lt;span style=&quot;box-sizing: border-box; color: rgb(255, 0, 0);&quot;&gt;&amp;lt;match url=&amp;quot;^(.*)$&amp;quot; /&amp;gt;&lt;/span&gt;&lt;/div&gt;&lt;div yne-bulb-block=&quot;paragraph&quot; style=&quot;box-sizing: border-box; color: rgb(34, 34, 34); font-family: &amp;quot;Segoe UI&amp;quot;, &amp;quot;Lucida Grande&amp;quot;, Helvetica, Arial, &amp;quot;Microsoft YaHei&amp;quot;, FreeSans, Arimo, &amp;quot;Droid Sans&amp;quot;, &amp;quot;wenquanyi micro hei&amp;quot;, &amp;quot;Hiragino Sans GB&amp;quot;, &amp;quot;Hiragino Sans GB W3&amp;quot;, Roboto, Arial, sans-serif; font-size: 18px; white-space: normal;&quot;&gt;&lt;span style=&quot;box-sizing: border-box; color: rgb(255, 0, 0);&quot;&gt;&amp;lt;conditions logicalGrouping=&amp;quot;MatchAll&amp;quot;&amp;gt;&lt;/span&gt;&lt;/div&gt;&lt;div yne-bulb-block=&quot;paragraph&quot; style=&quot;box-sizing: border-box; color: rgb(34, 34, 34); font-family: &amp;quot;Segoe UI&amp;quot;, &amp;quot;Lucida Grande&amp;quot;, Helvetica, Arial, &amp;quot;Microsoft YaHei&amp;quot;, FreeSans, Arimo, &amp;quot;Droid Sans&amp;quot;, &amp;quot;wenquanyi micro hei&amp;quot;, &amp;quot;Hiragino Sans GB&amp;quot;, &amp;quot;Hiragino Sans GB W3&amp;quot;, Roboto, Arial, sans-serif; font-size: 18px; white-space: normal;&quot;&gt;&lt;span style=&quot;box-sizing: border-box; color: rgb(255, 0, 0);&quot;&gt;&amp;lt;add input=&amp;quot;{HTTP_HOST}&amp;quot; pattern=&amp;quot;^(.*)$&amp;quot; /&amp;gt;&lt;/span&gt;&lt;/div&gt;&lt;div yne-bulb-block=&quot;paragraph&quot; style=&quot;box-sizing: border-box; color: rgb(34, 34, 34); font-family: &amp;quot;Segoe UI&amp;quot;, &amp;quot;Lucida Grande&amp;quot;, Helvetica, Arial, &amp;quot;Microsoft YaHei&amp;quot;, FreeSans, Arimo, &amp;quot;Droid Sans&amp;quot;, &amp;quot;wenquanyi micro hei&amp;quot;, &amp;quot;Hiragino Sans GB&amp;quot;, &amp;quot;Hiragino Sans GB W3&amp;quot;, Roboto, Arial, sans-serif; font-size: 18px; white-space: normal;&quot;&gt;&lt;span style=&quot;box-sizing: border-box; color: rgb(255, 0, 0);&quot;&gt;&amp;lt;add input=&amp;quot;{REQUEST_FILENAME}&amp;quot; matchType=&amp;quot;IsFile&amp;quot; negate=&amp;quot;true&amp;quot; /&amp;gt;&lt;/span&gt;&lt;/div&gt;&lt;div yne-bulb-block=&quot;paragraph&quot; style=&quot;box-sizing: border-box; color: rgb(34, 34, 34); font-family: &amp;quot;Segoe UI&amp;quot;, &amp;quot;Lucida Grande&amp;quot;, Helvetica, Arial, &amp;quot;Microsoft YaHei&amp;quot;, FreeSans, Arimo, &amp;quot;Droid Sans&amp;quot;, &amp;quot;wenquanyi micro hei&amp;quot;, &amp;quot;Hiragino Sans GB&amp;quot;, &amp;quot;Hiragino Sans GB W3&amp;quot;, Roboto, Arial, sans-serif; font-size: 18px; white-space: normal;&quot;&gt;&lt;span style=&quot;box-sizing: border-box; color: rgb(255, 0, 0);&quot;&gt;&amp;lt;add input=&amp;quot;{REQUEST_FILENAME}&amp;quot; matchType=&amp;quot;IsDirectory&amp;quot; negate=&amp;quot;true&amp;quot; /&amp;gt;&lt;/span&gt;&lt;/div&gt;&lt;div yne-bulb-block=&quot;paragraph&quot; style=&quot;box-sizing: border-box; color: rgb(34, 34, 34); font-family: &amp;quot;Segoe UI&amp;quot;, &amp;quot;Lucida Grande&amp;quot;, Helvetica, Arial, &amp;quot;Microsoft YaHei&amp;quot;, FreeSans, Arimo, &amp;quot;Droid Sans&amp;quot;, &amp;quot;wenquanyi micro hei&amp;quot;, &amp;quot;Hiragino Sans GB&amp;quot;, &amp;quot;Hiragino Sans GB W3&amp;quot;, Roboto, Arial, sans-serif; font-size: 18px; white-space: normal;&quot;&gt;&lt;span style=&quot;box-sizing: border-box; color: rgb(255, 0, 0);&quot;&gt;&amp;lt;/conditions&amp;gt;&lt;/span&gt;&lt;/div&gt;&lt;div yne-bulb-block=&quot;paragraph&quot; style=&quot;box-sizing: border-box; color: rgb(34, 34, 34); font-family: &amp;quot;Segoe UI&amp;quot;, &amp;quot;Lucida Grande&amp;quot;, Helvetica, Arial, &amp;quot;Microsoft YaHei&amp;quot;, FreeSans, Arimo, &amp;quot;Droid Sans&amp;quot;, &amp;quot;wenquanyi micro hei&amp;quot;, &amp;quot;Hiragino Sans GB&amp;quot;, &amp;quot;Hiragino Sans GB W3&amp;quot;, Roboto, Arial, sans-serif; font-size: 18px; white-space: normal;&quot;&gt;&lt;span style=&quot;box-sizing: border-box; color: rgb(255, 0, 0);&quot;&gt;&amp;lt;action type=&amp;quot;Rewrite&amp;quot; url=&amp;quot;index.php/{R:1}&amp;quot; /&amp;gt;&lt;/span&gt;&lt;/div&gt;&lt;div yne-bulb-block=&quot;paragraph&quot; style=&quot;box-sizing: border-box; color: rgb(34, 34, 34); font-family: &amp;quot;Segoe UI&amp;quot;, &amp;quot;Lucida Grande&amp;quot;, Helvetica, Arial, &amp;quot;Microsoft YaHei&amp;quot;, FreeSans, Arimo, &amp;quot;Droid Sans&amp;quot;, &amp;quot;wenquanyi micro hei&amp;quot;, &amp;quot;Hiragino Sans GB&amp;quot;, &amp;quot;Hiragino Sans GB W3&amp;quot;, Roboto, Arial, sans-serif; font-size: 18px; white-space: normal;&quot;&gt;&lt;span style=&quot;box-sizing: border-box; color: rgb(255, 0, 0);&quot;&gt;&amp;lt;/rule&amp;gt;&lt;/span&gt;&lt;/div&gt;&lt;div yne-bulb-block=&quot;paragraph&quot; style=&quot;box-sizing: border-box; color: rgb(34, 34, 34); font-family: &amp;quot;Segoe UI&amp;quot;, &amp;quot;Lucida Grande&amp;quot;, Helvetica, Arial, &amp;quot;Microsoft YaHei&amp;quot;, FreeSans, Arimo, &amp;quot;Droid Sans&amp;quot;, &amp;quot;wenquanyi micro hei&amp;quot;, &amp;quot;Hiragino Sans GB&amp;quot;, &amp;quot;Hiragino Sans GB W3&amp;quot;, Roboto, Arial, sans-serif; font-size: 18px; white-space: normal;&quot;&gt;&lt;span style=&quot;box-sizing: border-box; color: rgb(255, 0, 0);&quot;&gt;&amp;lt;/rules&amp;gt;&lt;/span&gt;&lt;/div&gt;&lt;div yne-bulb-block=&quot;paragraph&quot; style=&quot;box-sizing: border-box; color: rgb(34, 34, 34); font-family: &amp;quot;Segoe UI&amp;quot;, &amp;quot;Lucida Grande&amp;quot;, Helvetica, Arial, &amp;quot;Microsoft YaHei&amp;quot;, FreeSans, Arimo, &amp;quot;Droid Sans&amp;quot;, &amp;quot;wenquanyi micro hei&amp;quot;, &amp;quot;Hiragino Sans GB&amp;quot;, &amp;quot;Hiragino Sans GB W3&amp;quot;, Roboto, Arial, sans-serif; font-size: 18px; white-space: normal;&quot;&gt;&lt;span style=&quot;box-sizing: border-box; color: rgb(255, 0, 0);&quot;&gt;&amp;lt;/rewrite&amp;gt;&lt;/span&gt;&lt;/div&gt;&lt;div yne-bulb-block=&quot;paragraph&quot; style=&quot;box-sizing: border-box; color: rgb(34, 34, 34); font-family: &amp;quot;Segoe UI&amp;quot;, &amp;quot;Lucida Grande&amp;quot;, Helvetica, Arial, &amp;quot;Microsoft YaHei&amp;quot;, FreeSans, Arimo, &amp;quot;Droid Sans&amp;quot;, &amp;quot;wenquanyi micro hei&amp;quot;, &amp;quot;Hiragino Sans GB&amp;quot;, &amp;quot;Hiragino Sans GB W3&amp;quot;, Roboto, Arial, sans-serif; font-size: 18px; white-space: normal;&quot;&gt;&amp;nbsp;&lt;/div&gt;&lt;div yne-bulb-block=&quot;paragraph&quot; style=&quot;box-sizing: border-box; color: rgb(34, 34, 34); font-family: &amp;quot;Segoe UI&amp;quot;, &amp;quot;Lucida Grande&amp;quot;, Helvetica, Arial, &amp;quot;Microsoft YaHei&amp;quot;, FreeSans, Arimo, &amp;quot;Droid Sans&amp;quot;, &amp;quot;wenquanyi micro hei&amp;quot;, &amp;quot;Hiragino Sans GB&amp;quot;, &amp;quot;Hiragino Sans GB W3&amp;quot;, Roboto, Arial, sans-serif; font-size: 18px; white-space: normal;&quot;&gt;以下是某个香港虚拟空间的效果：&lt;/div&gt;&lt;div yne-bulb-block=&quot;paragraph&quot; style=&quot;box-sizing: border-box; color: rgb(34, 34, 34); font-family: &amp;quot;Segoe UI&amp;quot;, &amp;quot;Lucida Grande&amp;quot;, Helvetica, Arial, &amp;quot;Microsoft YaHei&amp;quot;, FreeSans, Arimo, &amp;quot;Droid Sans&amp;quot;, &amp;quot;wenquanyi micro hei&amp;quot;, &amp;quot;Hiragino Sans GB&amp;quot;, &amp;quot;Hiragino Sans GB W3&amp;quot;, Roboto, Arial, sans-serif; font-size: 18px; white-space: normal;&quot;&gt;&amp;lt;?xml version=&amp;quot;1.0&amp;quot; encoding=&amp;quot;UTF-8&amp;quot;?&amp;gt;&lt;/div&gt;&lt;div yne-bulb-block=&quot;paragraph&quot; style=&quot;box-sizing: border-box; color: rgb(34, 34, 34); font-family: &amp;quot;Segoe UI&amp;quot;, &amp;quot;Lucida Grande&amp;quot;, Helvetica, Arial, &amp;quot;Microsoft YaHei&amp;quot;, FreeSans, Arimo, &amp;quot;Droid Sans&amp;quot;, &amp;quot;wenquanyi micro hei&amp;quot;, &amp;quot;Hiragino Sans GB&amp;quot;, &amp;quot;Hiragino Sans GB W3&amp;quot;, Roboto, Arial, sans-serif; font-size: 18px; white-space: normal;&quot;&gt;&amp;lt;configuration&amp;gt;&lt;/div&gt;&lt;div yne-bulb-block=&quot;paragraph&quot; style=&quot;box-sizing: border-box; color: rgb(34, 34, 34); font-family: &amp;quot;Segoe UI&amp;quot;, &amp;quot;Lucida Grande&amp;quot;, Helvetica, Arial, &amp;quot;Microsoft YaHei&amp;quot;, FreeSans, Arimo, &amp;quot;Droid Sans&amp;quot;, &amp;quot;wenquanyi micro hei&amp;quot;, &amp;quot;Hiragino Sans GB&amp;quot;, &amp;quot;Hiragino Sans GB W3&amp;quot;, Roboto, Arial, sans-serif; font-size: 18px; white-space: normal;&quot;&gt;&amp;lt;system.webServer&amp;gt;&lt;/div&gt;&lt;div yne-bulb-block=&quot;paragraph&quot; style=&quot;box-sizing: border-box; color: rgb(34, 34, 34); font-family: &amp;quot;Segoe UI&amp;quot;, &amp;quot;Lucida Grande&amp;quot;, Helvetica, Arial, &amp;quot;Microsoft YaHei&amp;quot;, FreeSans, Arimo, &amp;quot;Droid Sans&amp;quot;, &amp;quot;wenquanyi micro hei&amp;quot;, &amp;quot;Hiragino Sans GB&amp;quot;, &amp;quot;Hiragino Sans GB W3&amp;quot;, Roboto, Arial, sans-serif; font-size: 18px; white-space: normal;&quot;&gt;&amp;lt;handlers&amp;gt;&lt;/div&gt;&lt;div yne-bulb-block=&quot;paragraph&quot; style=&quot;box-sizing: border-box; color: rgb(34, 34, 34); font-family: &amp;quot;Segoe UI&amp;quot;, &amp;quot;Lucida Grande&amp;quot;, Helvetica, Arial, &amp;quot;Microsoft YaHei&amp;quot;, FreeSans, Arimo, &amp;quot;Droid Sans&amp;quot;, &amp;quot;wenquanyi micro hei&amp;quot;, &amp;quot;Hiragino Sans GB&amp;quot;, &amp;quot;Hiragino Sans GB W3&amp;quot;, Roboto, Arial, sans-serif; font-size: 18px; white-space: normal;&quot;&gt;&amp;lt;remove name=&amp;quot;PHP-7.0-7i24.com&amp;quot; /&amp;gt;&lt;/div&gt;&lt;div yne-bulb-block=&quot;paragraph&quot; style=&quot;box-sizing: border-box; color: rgb(34, 34, 34); font-family: &amp;quot;Segoe UI&amp;quot;, &amp;quot;Lucida Grande&amp;quot;, Helvetica, Arial, &amp;quot;Microsoft YaHei&amp;quot;, FreeSans, Arimo, &amp;quot;Droid Sans&amp;quot;, &amp;quot;wenquanyi micro hei&amp;quot;, &amp;quot;Hiragino Sans GB&amp;quot;, &amp;quot;Hiragino Sans GB W3&amp;quot;, Roboto, Arial, sans-serif; font-size: 18px; white-space: normal;&quot;&gt;&amp;lt;remove name=&amp;quot;PHP-5.6-7i24.com&amp;quot; /&amp;gt;&lt;/div&gt;&lt;div yne-bulb-block=&quot;paragraph&quot; style=&quot;box-sizing: border-box; color: rgb(34, 34, 34); font-family: &amp;quot;Segoe UI&amp;quot;, &amp;quot;Lucida Grande&amp;quot;, Helvetica, Arial, &amp;quot;Microsoft YaHei&amp;quot;, FreeSans, Arimo, &amp;quot;Droid Sans&amp;quot;, &amp;quot;wenquanyi micro hei&amp;quot;, &amp;quot;Hiragino Sans GB&amp;quot;, &amp;quot;Hiragino Sans GB W3&amp;quot;, Roboto, Arial, sans-serif; font-size: 18px; white-space: normal;&quot;&gt;&amp;lt;remove name=&amp;quot;PHP-5.5-7i24.com&amp;quot; /&amp;gt;&lt;/div&gt;&lt;div yne-bulb-block=&quot;paragraph&quot; style=&quot;box-sizing: border-box; color: rgb(34, 34, 34); font-family: &amp;quot;Segoe UI&amp;quot;, &amp;quot;Lucida Grande&amp;quot;, Helvetica, Arial, &amp;quot;Microsoft YaHei&amp;quot;, FreeSans, Arimo, &amp;quot;Droid Sans&amp;quot;, &amp;quot;wenquanyi micro hei&amp;quot;, &amp;quot;Hiragino Sans GB&amp;quot;, &amp;quot;Hiragino Sans GB W3&amp;quot;, Roboto, Arial, sans-serif; font-size: 18px; white-space: normal;&quot;&gt;&amp;lt;remove name=&amp;quot;PHP-5.4-7i24.com&amp;quot; /&amp;gt;&lt;/div&gt;&lt;div yne-bulb-block=&quot;paragraph&quot; style=&quot;box-sizing: border-box; color: rgb(34, 34, 34); font-family: &amp;quot;Segoe UI&amp;quot;, &amp;quot;Lucida Grande&amp;quot;, Helvetica, Arial, &amp;quot;Microsoft YaHei&amp;quot;, FreeSans, Arimo, &amp;quot;Droid Sans&amp;quot;, &amp;quot;wenquanyi micro hei&amp;quot;, &amp;quot;Hiragino Sans GB&amp;quot;, &amp;quot;Hiragino Sans GB W3&amp;quot;, Roboto, Arial, sans-serif; font-size: 18px; white-space: normal;&quot;&gt;&amp;lt;remove name=&amp;quot;PHP-5.3-7i24.com&amp;quot; /&amp;gt;&lt;/div&gt;&lt;div yne-bulb-block=&quot;paragraph&quot; style=&quot;box-sizing: border-box; color: rgb(34, 34, 34); font-family: &amp;quot;Segoe UI&amp;quot;, &amp;quot;Lucida Grande&amp;quot;, Helvetica, Arial, &amp;quot;Microsoft YaHei&amp;quot;, FreeSans, Arimo, &amp;quot;Droid Sans&amp;quot;, &amp;quot;wenquanyi micro hei&amp;quot;, &amp;quot;Hiragino Sans GB&amp;quot;, &amp;quot;Hiragino Sans GB W3&amp;quot;, Roboto, Arial, sans-serif; font-size: 18px; white-space: normal;&quot;&gt;&amp;lt;remove name=&amp;quot;PHP-5.2-7i24.com&amp;quot; /&amp;gt;&lt;/div&gt;&lt;div yne-bulb-block=&quot;paragraph&quot; style=&quot;box-sizing: border-box; color: rgb(34, 34, 34); font-family: &amp;quot;Segoe UI&amp;quot;, &amp;quot;Lucida Grande&amp;quot;, Helvetica, Arial, &amp;quot;Microsoft YaHei&amp;quot;, FreeSans, Arimo, &amp;quot;Droid Sans&amp;quot;, &amp;quot;wenquanyi micro hei&amp;quot;, &amp;quot;Hiragino Sans GB&amp;quot;, &amp;quot;Hiragino Sans GB W3&amp;quot;, Roboto, Arial, sans-serif; font-size: 18px; white-space: normal;&quot;&gt;&amp;lt;add name=&amp;quot;PHP-5.4-7i24.com&amp;quot; path=&amp;quot;*.php&amp;quot; verb=&amp;quot;*&amp;quot; modules=&amp;quot;FastCgiModule&amp;quot; scriptProcessor=&amp;quot;c:php.4php-cgi.exe&amp;quot; resourceType=&amp;quot;Either&amp;quot; /&amp;gt;&lt;/div&gt;&lt;div yne-bulb-block=&quot;paragraph&quot; style=&quot;box-sizing: border-box; color: rgb(34, 34, 34); font-family: &amp;quot;Segoe UI&amp;quot;, &amp;quot;Lucida Grande&amp;quot;, Helvetica, Arial, &amp;quot;Microsoft YaHei&amp;quot;, FreeSans, Arimo, &amp;quot;Droid Sans&amp;quot;, &amp;quot;wenquanyi micro hei&amp;quot;, &amp;quot;Hiragino Sans GB&amp;quot;, &amp;quot;Hiragino Sans GB W3&amp;quot;, Roboto, Arial, sans-serif; font-size: 18px; white-space: normal;&quot;&gt;&amp;lt;/handlers&amp;gt;&lt;/div&gt;&lt;div yne-bulb-block=&quot;paragraph&quot; style=&quot;box-sizing: border-box; color: rgb(34, 34, 34); font-family: &amp;quot;Segoe UI&amp;quot;, &amp;quot;Lucida Grande&amp;quot;, Helvetica, Arial, &amp;quot;Microsoft YaHei&amp;quot;, FreeSans, Arimo, &amp;quot;Droid Sans&amp;quot;, &amp;quot;wenquanyi micro hei&amp;quot;, &amp;quot;Hiragino Sans GB&amp;quot;, &amp;quot;Hiragino Sans GB W3&amp;quot;, Roboto, Arial, sans-serif; font-size: 18px; white-space: normal;&quot;&gt;&lt;span style=&quot;box-sizing: border-box; color: rgb(255, 0, 0);&quot;&gt;&amp;lt;rewrite&amp;gt;&lt;/span&gt;&lt;/div&gt;&lt;div yne-bulb-block=&quot;paragraph&quot; style=&quot;box-sizing: border-box; color: rgb(34, 34, 34); font-family: &amp;quot;Segoe UI&amp;quot;, &amp;quot;Lucida Grande&amp;quot;, Helvetica, Arial, &amp;quot;Microsoft YaHei&amp;quot;, FreeSans, Arimo, &amp;quot;Droid Sans&amp;quot;, &amp;quot;wenquanyi micro hei&amp;quot;, &amp;quot;Hiragino Sans GB&amp;quot;, &amp;quot;Hiragino Sans GB W3&amp;quot;, Roboto, Arial, sans-serif; font-size: 18px; white-space: normal;&quot;&gt;&lt;span style=&quot;box-sizing: border-box; color: rgb(255, 0, 0);&quot;&gt;&amp;lt;rules&amp;gt;&lt;/span&gt;&lt;/div&gt;&lt;div yne-bulb-block=&quot;paragraph&quot; style=&quot;box-sizing: border-box; color: rgb(34, 34, 34); font-family: &amp;quot;Segoe UI&amp;quot;, &amp;quot;Lucida Grande&amp;quot;, Helvetica, Arial, &amp;quot;Microsoft YaHei&amp;quot;, FreeSans, Arimo, &amp;quot;Droid Sans&amp;quot;, &amp;quot;wenquanyi micro hei&amp;quot;, &amp;quot;Hiragino Sans GB&amp;quot;, &amp;quot;Hiragino Sans GB W3&amp;quot;, Roboto, Arial, sans-serif; font-size: 18px; white-space: normal;&quot;&gt;&lt;span style=&quot;box-sizing: border-box; color: rgb(255, 0, 0);&quot;&gt;&amp;lt;rule name=&amp;quot;Imported Rule 1&amp;quot; enabled=&amp;quot;true&amp;quot; stopProcessing=&amp;quot;true&amp;quot;&amp;gt;&lt;/span&gt;&lt;/div&gt;&lt;div yne-bulb-block=&quot;paragraph&quot; style=&quot;box-sizing: border-box; color: rgb(34, 34, 34); font-family: &amp;quot;Segoe UI&amp;quot;, &amp;quot;Lucida Grande&amp;quot;, Helvetica, Arial, &amp;quot;Microsoft YaHei&amp;quot;, FreeSans, Arimo, &amp;quot;Droid Sans&amp;quot;, &amp;quot;wenquanyi micro hei&amp;quot;, &amp;quot;Hiragino Sans GB&amp;quot;, &amp;quot;Hiragino Sans GB W3&amp;quot;, Roboto, Arial, sans-serif; font-size: 18px; white-space: normal;&quot;&gt;&lt;span style=&quot;box-sizing: border-box; color: rgb(255, 0, 0);&quot;&gt;&amp;lt;match url=&amp;quot;^(.*)$&amp;quot; /&amp;gt;&lt;/span&gt;&lt;/div&gt;&lt;div yne-bulb-block=&quot;paragraph&quot; style=&quot;box-sizing: border-box; color: rgb(34, 34, 34); font-family: &amp;quot;Segoe UI&amp;quot;, &amp;quot;Lucida Grande&amp;quot;, Helvetica, Arial, &amp;quot;Microsoft YaHei&amp;quot;, FreeSans, Arimo, &amp;quot;Droid Sans&amp;quot;, &amp;quot;wenquanyi micro hei&amp;quot;, &amp;quot;Hiragino Sans GB&amp;quot;, &amp;quot;Hiragino Sans GB W3&amp;quot;, Roboto, Arial, sans-serif; font-size: 18px; white-space: normal;&quot;&gt;&lt;span style=&quot;box-sizing: border-box; color: rgb(255, 0, 0);&quot;&gt;&amp;lt;conditions logicalGrouping=&amp;quot;MatchAll&amp;quot;&amp;gt;&lt;/span&gt;&lt;/div&gt;&lt;div yne-bulb-block=&quot;paragraph&quot; style=&quot;box-sizing: border-box; color: rgb(34, 34, 34); font-family: &amp;quot;Segoe UI&amp;quot;, &amp;quot;Lucida Grande&amp;quot;, Helvetica, Arial, &amp;quot;Microsoft YaHei&amp;quot;, FreeSans, Arimo, &amp;quot;Droid Sans&amp;quot;, &amp;quot;wenquanyi micro hei&amp;quot;, &amp;quot;Hiragino Sans GB&amp;quot;, &amp;quot;Hiragino Sans GB W3&amp;quot;, Roboto, Arial, sans-serif; font-size: 18px; white-space: normal;&quot;&gt;&lt;span style=&quot;box-sizing: border-box; color: rgb(255, 0, 0);&quot;&gt;&amp;lt;add input=&amp;quot;{HTTP_HOST}&amp;quot; pattern=&amp;quot;^(.*)$&amp;quot; /&amp;gt;&lt;/span&gt;&lt;/div&gt;&lt;div yne-bulb-block=&quot;paragraph&quot; style=&quot;box-sizing: border-box; color: rgb(34, 34, 34); font-family: &amp;quot;Segoe UI&amp;quot;, &amp;quot;Lucida Grande&amp;quot;, Helvetica, Arial, &amp;quot;Microsoft YaHei&amp;quot;, FreeSans, Arimo, &amp;quot;Droid Sans&amp;quot;, &amp;quot;wenquanyi micro hei&amp;quot;, &amp;quot;Hiragino Sans GB&amp;quot;, &amp;quot;Hiragino Sans GB W3&amp;quot;, Roboto, Arial, sans-serif; font-size: 18px; white-space: normal;&quot;&gt;&lt;span style=&quot;box-sizing: border-box; color: rgb(255, 0, 0);&quot;&gt;&amp;lt;add input=&amp;quot;{REQUEST_FILENAME}&amp;quot; matchType=&amp;quot;IsFile&amp;quot; negate=&amp;quot;true&amp;quot; /&amp;gt;&lt;/span&gt;&lt;/div&gt;&lt;div yne-bulb-block=&quot;paragraph&quot; style=&quot;box-sizing: border-box; color: rgb(34, 34, 34); font-family: &amp;quot;Segoe UI&amp;quot;, &amp;quot;Lucida Grande&amp;quot;, Helvetica, Arial, &amp;quot;Microsoft YaHei&amp;quot;, FreeSans, Arimo, &amp;quot;Droid Sans&amp;quot;, &amp;quot;wenquanyi micro hei&amp;quot;, &amp;quot;Hiragino Sans GB&amp;quot;, &amp;quot;Hiragino Sans GB W3&amp;quot;, Roboto, Arial, sans-serif; font-size: 18px; white-space: normal;&quot;&gt;&lt;span style=&quot;box-sizing: border-box; color: rgb(255, 0, 0);&quot;&gt;&amp;lt;add input=&amp;quot;{REQUEST_FILENAME}&amp;quot; matchType=&amp;quot;IsDirectory&amp;quot; negate=&amp;quot;true&amp;quot; /&amp;gt;&lt;/span&gt;&lt;/div&gt;&lt;div yne-bulb-block=&quot;paragraph&quot; style=&quot;box-sizing: border-box; color: rgb(34, 34, 34); font-family: &amp;quot;Segoe UI&amp;quot;, &amp;quot;Lucida Grande&amp;quot;, Helvetica, Arial, &amp;quot;Microsoft YaHei&amp;quot;, FreeSans, Arimo, &amp;quot;Droid Sans&amp;quot;, &amp;quot;wenquanyi micro hei&amp;quot;, &amp;quot;Hiragino Sans GB&amp;quot;, &amp;quot;Hiragino Sans GB W3&amp;quot;, Roboto, Arial, sans-serif; font-size: 18px; white-space: normal;&quot;&gt;&lt;span style=&quot;box-sizing: border-box; color: rgb(255, 0, 0);&quot;&gt;&amp;lt;/conditions&amp;gt;&lt;/span&gt;&lt;/div&gt;&lt;div yne-bulb-block=&quot;paragraph&quot; style=&quot;box-sizing: border-box; color: rgb(34, 34, 34); font-family: &amp;quot;Segoe UI&amp;quot;, &amp;quot;Lucida Grande&amp;quot;, Helvetica, Arial, &amp;quot;Microsoft YaHei&amp;quot;, FreeSans, Arimo, &amp;quot;Droid Sans&amp;quot;, &amp;quot;wenquanyi micro hei&amp;quot;, &amp;quot;Hiragino Sans GB&amp;quot;, &amp;quot;Hiragino Sans GB W3&amp;quot;, Roboto, Arial, sans-serif; font-size: 18px; white-space: normal;&quot;&gt;&lt;span style=&quot;box-sizing: border-box; color: rgb(255, 0, 0);&quot;&gt;&amp;lt;action type=&amp;quot;Rewrite&amp;quot; url=&amp;quot;index.php/{R:1}&amp;quot; /&amp;gt;&lt;/span&gt;&lt;/div&gt;&lt;div yne-bulb-block=&quot;paragraph&quot; style=&quot;box-sizing: border-box; color: rgb(34, 34, 34); font-family: &amp;quot;Segoe UI&amp;quot;, &amp;quot;Lucida Grande&amp;quot;, Helvetica, Arial, &amp;quot;Microsoft YaHei&amp;quot;, FreeSans, Arimo, &amp;quot;Droid Sans&amp;quot;, &amp;quot;wenquanyi micro hei&amp;quot;, &amp;quot;Hiragino Sans GB&amp;quot;, &amp;quot;Hiragino Sans GB W3&amp;quot;, Roboto, Arial, sans-serif; font-size: 18px; white-space: normal;&quot;&gt;&lt;span style=&quot;box-sizing: border-box; color: rgb(255, 0, 0);&quot;&gt;&amp;lt;/rule&amp;gt;&lt;/span&gt;&lt;/div&gt;&lt;div yne-bulb-block=&quot;paragraph&quot; style=&quot;box-sizing: border-box; color: rgb(34, 34, 34); font-family: &amp;quot;Segoe UI&amp;quot;, &amp;quot;Lucida Grande&amp;quot;, Helvetica, Arial, &amp;quot;Microsoft YaHei&amp;quot;, FreeSans, Arimo, &amp;quot;Droid Sans&amp;quot;, &amp;quot;wenquanyi micro hei&amp;quot;, &amp;quot;Hiragino Sans GB&amp;quot;, &amp;quot;Hiragino Sans GB W3&amp;quot;, Roboto, Arial, sans-serif; font-size: 18px; white-space: normal;&quot;&gt;&lt;span style=&quot;box-sizing: border-box; color: rgb(255, 0, 0);&quot;&gt;&amp;lt;/rules&amp;gt;&lt;/span&gt;&lt;/div&gt;&lt;div yne-bulb-block=&quot;paragraph&quot; style=&quot;box-sizing: border-box; color: rgb(34, 34, 34); font-family: &amp;quot;Segoe UI&amp;quot;, &amp;quot;Lucida Grande&amp;quot;, Helvetica, Arial, &amp;quot;Microsoft YaHei&amp;quot;, FreeSans, Arimo, &amp;quot;Droid Sans&amp;quot;, &amp;quot;wenquanyi micro hei&amp;quot;, &amp;quot;Hiragino Sans GB&amp;quot;, &amp;quot;Hiragino Sans GB W3&amp;quot;, Roboto, Arial, sans-serif; font-size: 18px; white-space: normal;&quot;&gt;&lt;span style=&quot;box-sizing: border-box; color: rgb(255, 0, 0);&quot;&gt;&amp;lt;/rewrite&amp;gt;&lt;/span&gt;&lt;/div&gt;&lt;div yne-bulb-block=&quot;paragraph&quot; style=&quot;box-sizing: border-box; color: rgb(34, 34, 34); font-family: &amp;quot;Segoe UI&amp;quot;, &amp;quot;Lucida Grande&amp;quot;, Helvetica, Arial, &amp;quot;Microsoft YaHei&amp;quot;, FreeSans, Arimo, &amp;quot;Droid Sans&amp;quot;, &amp;quot;wenquanyi micro hei&amp;quot;, &amp;quot;Hiragino Sans GB&amp;quot;, &amp;quot;Hiragino Sans GB W3&amp;quot;, Roboto, Arial, sans-serif; font-size: 18px; white-space: normal;&quot;&gt;&amp;lt;/system.webServer&amp;gt;&lt;/div&gt;&lt;div yne-bulb-block=&quot;paragraph&quot; style=&quot;box-sizing: border-box; color: rgb(34, 34, 34); font-family: &amp;quot;Segoe UI&amp;quot;, &amp;quot;Lucida Grande&amp;quot;, Helvetica, Arial, &amp;quot;Microsoft YaHei&amp;quot;, FreeSans, Arimo, &amp;quot;Droid Sans&amp;quot;, &amp;quot;wenquanyi micro hei&amp;quot;, &amp;quot;Hiragino Sans GB&amp;quot;, &amp;quot;Hiragino Sans GB W3&amp;quot;, Roboto, Arial, sans-serif; font-size: 18px; white-space: normal;&quot;&gt;&amp;lt;/configuration&amp;gt;&lt;/div&gt;&lt;div yne-bulb-block=&quot;paragraph&quot; style=&quot;box-sizing: border-box; color: rgb(34, 34, 34); font-family: &amp;quot;Segoe UI&amp;quot;, &amp;quot;Lucida Grande&amp;quot;, Helvetica, Arial, &amp;quot;Microsoft YaHei&amp;quot;, FreeSans, Arimo, &amp;quot;Droid Sans&amp;quot;, &amp;quot;wenquanyi micro hei&amp;quot;, &amp;quot;Hiragino Sans GB&amp;quot;, &amp;quot;Hiragino Sans GB W3&amp;quot;, Roboto, Arial, sans-serif; font-size: 18px; white-space: normal;&quot;&gt;&amp;nbsp;&lt;/div&gt;&lt;div yne-bulb-block=&quot;paragraph&quot; style=&quot;box-sizing: border-box; color: rgb(34, 34, 34); font-family: &amp;quot;Segoe UI&amp;quot;, &amp;quot;Lucida Grande&amp;quot;, Helvetica, Arial, &amp;quot;Microsoft YaHei&amp;quot;, FreeSans, Arimo, &amp;quot;Droid Sans&amp;quot;, &amp;quot;wenquanyi micro hei&amp;quot;, &amp;quot;Hiragino Sans GB&amp;quot;, &amp;quot;Hiragino Sans GB W3&amp;quot;, Roboto, Arial, sans-serif; font-size: 18px; white-space: normal;&quot;&gt;【Nginx服务器】&lt;/div&gt;&lt;div yne-bulb-block=&quot;paragraph&quot; style=&quot;box-sizing: border-box; color: rgb(34, 34, 34); font-family: &amp;quot;Segoe UI&amp;quot;, &amp;quot;Lucida Grande&amp;quot;, Helvetica, Arial, &amp;quot;Microsoft YaHei&amp;quot;, FreeSans, Arimo, &amp;quot;Droid Sans&amp;quot;, &amp;quot;wenquanyi micro hei&amp;quot;, &amp;quot;Hiragino Sans GB&amp;quot;, &amp;quot;Hiragino Sans GB W3&amp;quot;, Roboto, Arial, sans-serif; font-size: 18px; white-space: normal;&quot;&gt;在原有的nginx重写文件里新增以下代码片段：&lt;/div&gt;&lt;div yne-bulb-block=&quot;paragraph&quot; style=&quot;box-sizing: border-box; color: rgb(34, 34, 34); font-family: &amp;quot;Segoe UI&amp;quot;, &amp;quot;Lucida Grande&amp;quot;, Helvetica, Arial, &amp;quot;Microsoft YaHei&amp;quot;, FreeSans, Arimo, &amp;quot;Droid Sans&amp;quot;, &amp;quot;wenquanyi micro hei&amp;quot;, &amp;quot;Hiragino Sans GB&amp;quot;, &amp;quot;Hiragino Sans GB W3&amp;quot;, Roboto, Arial, sans-serif; font-size: 18px; white-space: normal;&quot;&gt;&lt;span style=&quot;box-sizing: border-box; color: rgb(255, 0, 0);&quot;&gt;location / {&lt;/span&gt;&lt;/div&gt;&lt;div yne-bulb-block=&quot;paragraph&quot; style=&quot;box-sizing: border-box; color: rgb(34, 34, 34); font-family: &amp;quot;Segoe UI&amp;quot;, &amp;quot;Lucida Grande&amp;quot;, Helvetica, Arial, &amp;quot;Microsoft YaHei&amp;quot;, FreeSans, Arimo, &amp;quot;Droid Sans&amp;quot;, &amp;quot;wenquanyi micro hei&amp;quot;, &amp;quot;Hiragino Sans GB&amp;quot;, &amp;quot;Hiragino Sans GB W3&amp;quot;, Roboto, Arial, sans-serif; font-size: 18px; white-space: normal;&quot;&gt;&lt;span style=&quot;box-sizing: border-box; color: rgb(255, 0, 0);&quot;&gt;if (!-e $request_filename) {&lt;/span&gt;&lt;/div&gt;&lt;div yne-bulb-block=&quot;paragraph&quot; style=&quot;box-sizing: border-box; color: rgb(34, 34, 34); font-family: &amp;quot;Segoe UI&amp;quot;, &amp;quot;Lucida Grande&amp;quot;, Helvetica, Arial, &amp;quot;Microsoft YaHei&amp;quot;, FreeSans, Arimo, &amp;quot;Droid Sans&amp;quot;, &amp;quot;wenquanyi micro hei&amp;quot;, &amp;quot;Hiragino Sans GB&amp;quot;, &amp;quot;Hiragino Sans GB W3&amp;quot;, Roboto, Arial, sans-serif; font-size: 18px; white-space: normal;&quot;&gt;&lt;span style=&quot;box-sizing: border-box; color: rgb(255, 0, 0);&quot;&gt;rewrite ^(.*)$ /index.php?s=/$1 last;&lt;/span&gt;&lt;/div&gt;&lt;div yne-bulb-block=&quot;paragraph&quot; style=&quot;box-sizing: border-box; color: rgb(34, 34, 34); font-family: &amp;quot;Segoe UI&amp;quot;, &amp;quot;Lucida Grande&amp;quot;, Helvetica, Arial, &amp;quot;Microsoft YaHei&amp;quot;, FreeSans, Arimo, &amp;quot;Droid Sans&amp;quot;, &amp;quot;wenquanyi micro hei&amp;quot;, &amp;quot;Hiragino Sans GB&amp;quot;, &amp;quot;Hiragino Sans GB W3&amp;quot;, Roboto, Arial, sans-serif; font-size: 18px; white-space: normal;&quot;&gt;&lt;span style=&quot;box-sizing: border-box; color: rgb(255, 0, 0);&quot;&gt;break;&lt;/span&gt;&lt;/div&gt;&lt;div yne-bulb-block=&quot;paragraph&quot; style=&quot;box-sizing: border-box; color: rgb(34, 34, 34); font-family: &amp;quot;Segoe UI&amp;quot;, &amp;quot;Lucida Grande&amp;quot;, Helvetica, Arial, &amp;quot;Microsoft YaHei&amp;quot;, FreeSans, Arimo, &amp;quot;Droid Sans&amp;quot;, &amp;quot;wenquanyi micro hei&amp;quot;, &amp;quot;Hiragino Sans GB&amp;quot;, &amp;quot;Hiragino Sans GB W3&amp;quot;, Roboto, Arial, sans-serif; font-size: 18px; white-space: normal;&quot;&gt;&lt;span style=&quot;box-sizing: border-box; color: rgb(255, 0, 0);&quot;&gt;}&lt;/span&gt;&lt;/div&gt;&lt;div yne-bulb-block=&quot;paragraph&quot; style=&quot;box-sizing: border-box; color: rgb(34, 34, 34); font-family: &amp;quot;Segoe UI&amp;quot;, &amp;quot;Lucida Grande&amp;quot;, Helvetica, Arial, &amp;quot;Microsoft YaHei&amp;quot;, FreeSans, Arimo, &amp;quot;Droid Sans&amp;quot;, &amp;quot;wenquanyi micro hei&amp;quot;, &amp;quot;Hiragino Sans GB&amp;quot;, &amp;quot;Hiragino Sans GB W3&amp;quot;, Roboto, Arial, sans-serif; font-size: 18px; white-space: normal;&quot;&gt;&lt;span style=&quot;box-sizing: border-box; color: rgb(255, 0, 0);&quot;&gt;}&lt;/span&gt;&lt;/div&gt;&lt;div yne-bulb-block=&quot;paragraph&quot; style=&quot;box-sizing: border-box; color: rgb(34, 34, 34); font-family: &amp;quot;Segoe UI&amp;quot;, &amp;quot;Lucida Grande&amp;quot;, Helvetica, Arial, &amp;quot;Microsoft YaHei&amp;quot;, FreeSans, Arimo, &amp;quot;Droid Sans&amp;quot;, &amp;quot;wenquanyi micro hei&amp;quot;, &amp;quot;Hiragino Sans GB&amp;quot;, &amp;quot;Hiragino Sans GB W3&amp;quot;, Roboto, Arial, sans-serif; font-size: 18px; white-space: normal;&quot;&gt;&amp;nbsp;&lt;/div&gt;&lt;div yne-bulb-block=&quot;paragraph&quot; style=&quot;box-sizing: border-box; color: rgb(34, 34, 34); font-family: &amp;quot;Segoe UI&amp;quot;, &amp;quot;Lucida Grande&amp;quot;, Helvetica, Arial, &amp;quot;Microsoft YaHei&amp;quot;, FreeSans, Arimo, &amp;quot;Droid Sans&amp;quot;, &amp;quot;wenquanyi micro hei&amp;quot;, &amp;quot;Hiragino Sans GB&amp;quot;, &amp;quot;Hiragino Sans GB W3&amp;quot;, Roboto, Arial, sans-serif; font-size: 18px; white-space: normal;&quot;&gt;【apache服务器】&lt;br style=&quot;box-sizing: border-box;&quot;/&gt;易优CMS在apache服务器环境默认自动隐藏index.php入口。&lt;br style=&quot;box-sizing: border-box;&quot;/&gt;如果发现没隐藏，可以检查根目录.htaccess是否含有以下代码段：&lt;/div&gt;&lt;div yne-bulb-block=&quot;paragraph&quot; style=&quot;box-sizing: border-box; color: rgb(34, 34, 34); font-family: &amp;quot;Segoe UI&amp;quot;, &amp;quot;Lucida Grande&amp;quot;, Helvetica, Arial, &amp;quot;Microsoft YaHei&amp;quot;, FreeSans, Arimo, &amp;quot;Droid Sans&amp;quot;, &amp;quot;wenquanyi micro hei&amp;quot;, &amp;quot;Hiragino Sans GB&amp;quot;, &amp;quot;Hiragino Sans GB W3&amp;quot;, Roboto, Arial, sans-serif; font-size: 18px; white-space: normal;&quot;&gt;&amp;lt;IfModule mod_rewrite.c&amp;gt;&lt;/div&gt;&lt;div yne-bulb-block=&quot;paragraph&quot; style=&quot;box-sizing: border-box; color: rgb(34, 34, 34); font-family: &amp;quot;Segoe UI&amp;quot;, &amp;quot;Lucida Grande&amp;quot;, Helvetica, Arial, &amp;quot;Microsoft YaHei&amp;quot;, FreeSans, Arimo, &amp;quot;Droid Sans&amp;quot;, &amp;quot;wenquanyi micro hei&amp;quot;, &amp;quot;Hiragino Sans GB&amp;quot;, &amp;quot;Hiragino Sans GB W3&amp;quot;, Roboto, Arial, sans-serif; font-size: 18px; white-space: normal;&quot;&gt;&lt;div style=&quot;box-sizing: border-box;&quot;&gt;Options +FollowSymlinks -Multiviews&lt;/div&gt;&lt;div style=&quot;box-sizing: border-box;&quot;&gt;&lt;span style=&quot;box-sizing: border-box; color: rgb(255, 0, 0);&quot;&gt;RewriteEngine on&lt;/span&gt;&lt;/div&gt;&lt;div style=&quot;box-sizing: border-box;&quot;&gt;&lt;span style=&quot;box-sizing: border-box; color: rgb(255, 0, 0);&quot;&gt;RewriteCond %{REQUEST_FILENAME} !-d&lt;/span&gt;&lt;/div&gt;&lt;div style=&quot;box-sizing: border-box;&quot;&gt;&lt;span style=&quot;box-sizing: border-box; color: rgb(255, 0, 0);&quot;&gt;RewriteCond %{REQUEST_FILENAME} !-f&lt;/span&gt;&lt;/div&gt;&lt;div style=&quot;box-sizing: border-box;&quot;&gt;&lt;span style=&quot;box-sizing: border-box; color: rgb(255, 0, 0);&quot;&gt;RewriteRule ^(.*)$ index.php/$1 [QSA,PT,L]&lt;/span&gt;&lt;/div&gt;&lt;/div&gt;&lt;div yne-bulb-block=&quot;paragraph&quot; style=&quot;box-sizing: border-box; color: rgb(34, 34, 34); font-family: &amp;quot;Segoe UI&amp;quot;, &amp;quot;Lucida Grande&amp;quot;, Helvetica, Arial, &amp;quot;Microsoft YaHei&amp;quot;, FreeSans, Arimo, &amp;quot;Droid Sans&amp;quot;, &amp;quot;wenquanyi micro hei&amp;quot;, &amp;quot;Hiragino Sans GB&amp;quot;, &amp;quot;Hiragino Sans GB W3&amp;quot;, Roboto, Arial, sans-serif; font-size: 18px; white-space: normal;&quot;&gt;&amp;lt;/IfModule&amp;gt;&lt;br style=&quot;box-sizing: border-box;&quot;/&gt;&lt;br style=&quot;box-sizing: border-box;&quot;/&gt;如果存在，继续查看apache是否开启了URL重写模块 rewrite_module ， 然后重启服务就行了。&lt;/div&gt;&lt;p&gt;&lt;br/&gt;&lt;/p&gt;', '0', '1531710225');
INSERT INTO `ey_single_content` VALUES ('4', '45', '31', '', '1545272580', '1545272580');
INSERT INTO `ey_single_content` VALUES ('5', '46', '32', '&lt;p&gt;EyouCms is known for its many templates, easy to optimize, and open source. It is a new PHP open source website management system and the most popular PHP CMS system. After years of development, the current version is no matter. In terms of functions and ease of use in the background, there has been considerable development and progress. The main target users of eyoucms free version are locked in groups that have the needs of enterprises to establish their stations. Of course, there are also some users and schools that use the system.&lt;/p&gt;&lt;p&gt;&lt;br/&gt;&lt;/p&gt;&lt;p&gt;Enterprise websites, whether large ｏｒ small ｏｒ medium-sized enterprises, use the network to transmit information to a certain extent to improve the efficiency of business and improve the competitiveness of enterprises. EyouCms website construction system to do various websites, what is EyouCms, EyouCms is a free and open source content management system, it is a content publishing system (CMS) that can be used independently. In China, EyouCms belongs to the most popular CMS system.&lt;/p&gt;&lt;p&gt;&lt;br/&gt;&lt;/p&gt;&lt;p&gt;Government agencies, through the establishment of government portals, facilitate the integration of various information and resources, and strengthen communication and communication between the government and the public, so that the government can work faster, more conveniently, and more effectively.&lt;/p&gt;&lt;p&gt;&lt;br/&gt;&lt;/p&gt;&lt;p&gt;Educational institutions, through the introduction of network information, enable information transmission between educational institutions and within educational institutions and educators, and comprehensively enhance the level of educational websites.&lt;/p&gt;&lt;p&gt;&lt;br/&gt;&lt;/p&gt;&lt;p&gt;advantage&lt;/p&gt;&lt;p&gt;Easy to use: You can use it for ten minutes to build a corporate website with easy-to-use background.&lt;/p&gt;&lt;p&gt;&lt;br/&gt;&lt;/p&gt;&lt;p&gt;Perfect: Yiyou Basic contains all the features needed for a regular corporate website.&lt;/p&gt;&lt;p&gt;&lt;br/&gt;&lt;/p&gt;&lt;p&gt;Scalability: Yiyou can also support more functions through the plugin library, such as third-party extensions such as Ali SMS ｏｒ applet.&lt;/p&gt;&lt;p&gt;&lt;br/&gt;&lt;/p&gt;&lt;p&gt;Rich information: As a domestic cms, Yiyou has a complete help document and label manual.&lt;/p&gt;&lt;p&gt;&lt;br/&gt;&lt;/p&gt;&lt;p&gt;Rich template: Yiyou has a large number of free and beautiful templates, covering all walks of life, and users are free to choose.&lt;/p&gt;&lt;p&gt;&lt;br/&gt;&lt;/p&gt;&lt;p&gt;Disadvantage&lt;/p&gt;&lt;p&gt;Innovative: Yiyou is a system developed based on user needs. User needs are constantly changing, and we strive to follow and change.&lt;/p&gt;&lt;p&gt;&lt;br/&gt;&lt;/p&gt;&lt;p&gt;Community: Currently focused on template building, this is not really established for an open source project.&lt;/p&gt;&lt;p&gt;&lt;br/&gt;&lt;/p&gt;&lt;p&gt;&lt;br/&gt;&lt;/p&gt;&lt;p&gt;&lt;br/&gt;&lt;/p&gt;&lt;p&gt;In the future, we look forward to working with users to create a better and more excellent CMS...2018.6.1&lt;/p&gt;&lt;p&gt;&lt;br/&gt;&lt;/p&gt;', '1545272565', '1545272565');
INSERT INTO `ey_single_content` VALUES ('6', '47', '39', '&lt;p&gt;For different servers and virtual spaces, the environment for running PHP is also different, currently mainly divided into: Nginx, apache, IIS and other servers. Here&amp;#39;s how to remove the index. PHP character from the URL. Remember to restart the server and clear the cache in the management background.&lt;/p&gt;&lt;p&gt;[IIS Server]&lt;/p&gt;&lt;p&gt;There is a web. config file in the root directory of the website. The function of this file is to rewrite the URL, make the URL short, easy to optimize by SEO, and the user&amp;#39;s memory. Open the web. config file and add the following code fragments on the original basis.&lt;/p&gt;&lt;p&gt;&amp;lt;rewrite&amp;gt;&lt;/p&gt;&lt;p&gt;&amp;lt;rules&amp;gt;&lt;/p&gt;&lt;p&gt;&amp;lt;rule name= &amp;quot;Imported Rule 1&amp;quot; enabled= &amp;quot;true&amp;quot; stopProcessing= &amp;quot;true&amp;quot;&amp;gt;&lt;/p&gt;&lt;p&gt;&amp;lt;match url=&amp;quot;^(. *)$&amp;quot;/&amp;gt;&lt;/p&gt;&lt;p&gt;&amp;lt;conditions logicalGrouping=&amp;quot;MatchAll&amp;quot;&amp;gt;&lt;/p&gt;&lt;p&gt;&amp;lt;add input=&amp;quot;{HTTP_HOST}&amp;quot; pattern=&amp;quot;^(. *)$&amp;quot;/&amp;gt;&amp;quot;&lt;/p&gt;&lt;p&gt;&amp;lt;add input=&amp;quot;{REQUEST_FILENAME}&amp;quot; matchType= &amp;quot;IsFile&amp;quot; negate= &amp;quot;true&amp;quot;/&amp;gt;&lt;/p&gt;&lt;p&gt;&amp;lt;add input=&amp;quot;{REQUEST_FILENAME}&amp;quot; matchType= &amp;quot;IsDirectory&amp;quot; negate= &amp;quot;true&amp;quot;/&amp;gt;&lt;/p&gt;&lt;p&gt;&amp;lt;/conditions&amp;gt;&lt;/p&gt;&lt;p&gt;&amp;lt;action type=&amp;quot;Rewrite&amp;quot; url=&amp;quot;index.php/{R:1}&amp;quot;/&amp;gt;&lt;/p&gt;&lt;p&gt;&amp;lt;/rule&amp;gt;&lt;/p&gt;&lt;p&gt;&amp;lt;/rules&amp;gt;&lt;/p&gt;&lt;p&gt;&amp;lt;/rewrite&amp;gt;&lt;/p&gt;&lt;p&gt;The following is the effect of a Hong Kong virtual space:&lt;/p&gt;&lt;p&gt;&amp;lt;? XML version = &amp;quot;1.0&amp;quot; encoding = &amp;quot;UTF-8&amp;quot;?&amp;gt;&lt;/p&gt;&lt;p&gt;&amp;lt;configuration&amp;gt;&lt;/p&gt;&lt;p&gt;&amp;lt;system.webServer&amp;gt;&lt;/p&gt;&lt;p&gt;&amp;lt;handlers&amp;gt;&lt;/p&gt;&lt;p&gt;&amp;lt;remove name=&amp;quot;PHP-7.0-7i24.com&amp;quot;/&amp;gt;&lt;/p&gt;&lt;p&gt;&amp;lt;remove name=&amp;quot;PHP-5.6-7i24.com&amp;quot;/&amp;gt;&lt;/p&gt;&lt;p&gt;&amp;lt;remove name=&amp;quot;PHP-5.5-7i24.com&amp;quot;/&amp;gt;&lt;/p&gt;&lt;p&gt;&amp;lt;remove name=&amp;quot;PHP-5.4-7i24.com&amp;quot;/&amp;gt;&lt;/p&gt;&lt;p&gt;&amp;lt;remove name=&amp;quot;PHP-5.3-7i24.com&amp;quot;/&amp;gt;&lt;/p&gt;&lt;p&gt;&amp;lt;remove name=&amp;quot;PHP-5.2-7i24.com&amp;quot;/&amp;gt;&lt;/p&gt;&lt;p&gt;&amp;lt;add name=&amp;quot;PHP-5.4-7i24.com&amp;quot; path=&amp;quot;*.php&amp;quot; verb=&amp;quot;*&amp;quot; modules=&amp;quot;FastCgiModule&amp;quot; scriptProcessor=&amp;quot;c:php.4php-cgi.exe&amp;quot; resourceType=&amp;quot;Either&amp;quot;/&amp;gt;&lt;/p&gt;&lt;p&gt;&amp;lt;/handlers&amp;gt;&lt;/p&gt;&lt;p&gt;&amp;lt;rewrite&amp;gt;&lt;/p&gt;&lt;p&gt;&amp;lt;rules&amp;gt;&lt;/p&gt;&lt;p&gt;&amp;lt;rule name= &amp;quot;Imported Rule 1&amp;quot; enabled= &amp;quot;true&amp;quot; stopProcessing= &amp;quot;true&amp;quot;&amp;gt;&lt;/p&gt;&lt;p&gt;&amp;lt;match url=&amp;quot;^(. *)$&amp;quot;/&amp;gt;&lt;/p&gt;&lt;p&gt;&amp;lt;conditions logicalGrouping=&amp;quot;MatchAll&amp;quot;&amp;gt;&lt;/p&gt;&lt;p&gt;&amp;lt;add input=&amp;quot;{HTTP_HOST}&amp;quot; pattern=&amp;quot;^(. *)$&amp;quot;/&amp;gt;&amp;quot;&lt;/p&gt;&lt;p&gt;&amp;lt;add input=&amp;quot;{REQUEST_FILENAME}&amp;quot; matchType= &amp;quot;IsFile&amp;quot; negate= &amp;quot;true&amp;quot;/&amp;gt;&lt;/p&gt;&lt;p&gt;&amp;lt;add input=&amp;quot;{REQUEST_FILENAME}&amp;quot; matchType= &amp;quot;IsDirectory&amp;quot; negate= &amp;quot;true&amp;quot;/&amp;gt;&lt;/p&gt;&lt;p&gt;&amp;lt;/conditions&amp;gt;&lt;/p&gt;&lt;p&gt;&amp;lt;action type=&amp;quot;Rewrite&amp;quot; url=&amp;quot;index.php/{R:1}&amp;quot;/&amp;gt;&lt;/p&gt;&lt;p&gt;&amp;lt;/rule&amp;gt;&lt;/p&gt;&lt;p&gt;&amp;lt;/rules&amp;gt;&lt;/p&gt;&lt;p&gt;&amp;lt;/rewrite&amp;gt;&lt;/p&gt;&lt;p&gt;&amp;lt;/system.webServer&amp;gt;&lt;/p&gt;&lt;p&gt;&amp;lt;/configuration&amp;gt;&lt;/p&gt;&lt;p&gt;[Nginx Server]&lt;/p&gt;&lt;p&gt;Add the following code fragments to the original nginx rewrite file:&lt;/p&gt;&lt;p&gt;Location / {&lt;/p&gt;&lt;p&gt;If (!-e $request_filename) {&lt;/p&gt;&lt;p&gt;Rewrite ^(. *)$/ index. php? S=/$1 last;&lt;/p&gt;&lt;p&gt;Break;&lt;/p&gt;&lt;p&gt;}&lt;/p&gt;&lt;p&gt;}&lt;/p&gt;&lt;p&gt;[apache server]&lt;/p&gt;&lt;p&gt;Yiyou CMS automatically hides index. PHP entries by default in Apache server environment.&lt;/p&gt;&lt;p&gt;If no hiding is found, you can check whether the root directory. htaccess contains the following code snippets:&lt;/p&gt;&lt;p&gt;&amp;lt;IfModule mod_rewrite.c&amp;gt;&lt;/p&gt;&lt;p&gt;Options + FollowSymlinks - Multiviews&lt;/p&gt;&lt;p&gt;RewriteEngine on&lt;/p&gt;&lt;p&gt;RewriteCond%{REQUEST_FILENAME}!-d&lt;/p&gt;&lt;p&gt;RewriteCond%{REQUEST_FILENAME}!-f&lt;/p&gt;&lt;p&gt;RewriteRule ^(*)$index.php/$1 [QSA, PT, L]&lt;/p&gt;&lt;p&gt;&amp;lt;/IfModule&amp;gt;&lt;/p&gt;&lt;p&gt;If it exists, go ahead and see if Apache has opened the URL rewrite_module and restart the service.&lt;/p&gt;&lt;p&gt;&lt;br/&gt;&lt;/p&gt;', '1545270877', '1545270877');

-- -----------------------------
-- Table structure for `ey_tagindex`
-- -----------------------------
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

-- -----------------------------
-- Records of `ey_tagindex`
-- -----------------------------
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

-- -----------------------------
-- Table structure for `ey_taglist`
-- -----------------------------
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

-- -----------------------------
-- Records of `ey_taglist`
-- -----------------------------
INSERT INTO `ey_taglist` VALUES ('30', '13', '12', '五大核心', '0', 'cn', '1547462639', '0');
INSERT INTO `ey_taglist` VALUES ('29', '13', '12', '建设', '0', 'cn', '1547462639', '0');
INSERT INTO `ey_taglist` VALUES ('34', '27', '24', 'NOTE 8', '0', 'cn', '1547462188', '0');
INSERT INTO `ey_taglist` VALUES ('33', '27', '24', 'HUAWEI', '0', 'cn', '1547462188', '0');
INSERT INTO `ey_taglist` VALUES ('32', '27', '24', '华为', '0', 'cn', '1547462188', '0');
INSERT INTO `ey_taglist` VALUES ('37', '30', '5', '一号', '0', 'cn', '1547463959', '0');
INSERT INTO `ey_taglist` VALUES ('36', '30', '5', '女神', '0', 'cn', '1547463959', '0');
INSERT INTO `ey_taglist` VALUES ('35', '30', '5', '宅男', '0', 'cn', '1547463959', '0');
INSERT INTO `ey_taglist` VALUES ('28', '13', '12', '网站', '0', 'cn', '1547462639', '0');
INSERT INTO `ey_taglist` VALUES ('31', '13', '12', '要素', '0', 'cn', '1547462639', '0');

-- -----------------------------
-- Table structure for `ey_ui_config`
-- -----------------------------
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


-- -----------------------------
-- Table structure for `ey_weapp`
-- -----------------------------
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

