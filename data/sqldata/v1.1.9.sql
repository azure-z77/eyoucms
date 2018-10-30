DROP TABLE IF EXISTS `ey_addonarticle`;
DROP TABLE IF EXISTS `ey_addondownload`;
DROP TABLE IF EXISTS `ey_addonimages`;
DROP TABLE IF EXISTS `ey_addonproduct`;
DROP TABLE IF EXISTS `ey_plugin`;
DROP TABLE IF EXISTS `ey_sms_log`;
DROP TABLE IF EXISTS `ey_sms_template`;
DROP TABLE IF EXISTS `ey_email_template`;
UPDATE `ey_admin` SET `role_id` = '-2' WHERE `admin_id` > 0;