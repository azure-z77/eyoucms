<?php
/**
 * 易优CMS
 * ============================================================================
 * 版权所有 2016-2028 海南赞赞网络科技有限公司，并保留所有权利。
 * 网站地址: http://www.eyoucms.com
 * ----------------------------------------------------------------------------
 * 如果商业用途务必到官方购买正版授权, 以免引起不必要的法律纠纷.
 * ============================================================================
 * Author: 小虎哥 <1105415366@qq.com>
 * Date: 2018-4-3
 */

namespace app\common\logic;

/**
 * Description of SmsLogic
 *
 * 邮件类
 */
class EmailLogic 
{
    private $config;
    
    public function __construct() 
    {
        $this->config = tpCache('email') ?: [];
    }

    /**
     * 置换邮件模版内容
     * @param unknown $scene
     */
    public function replaceContent($scene, $params)
    {
        $emailTemp = M('email_template')->where("send_scene", $scene)->find();
        $content = !empty($params['content']) ? $params['content'] : false;
        $username = !empty($params['username']) ? $params['username'] : false;

        $emailParams = array(
            1 => "{\"content\":\"$content\"}", //1. 通用
            2 => "{\"content\":\"$content\"}", //2. 用户注册
            3 => "{\"content\":\"$content\"}", //3. 用户找回密码
            4 => "{\"content\":\"$content\"}", //4. 发表评论
            5 => "{\"content\":\"$content\"}", //5. 回复评论
            6 => "{\"content\":\"$content\"}", //6. 申请入驻小程序
            7 => "{\"content\":\"$content\"}", //7. 小程序审核通知
            // 8 => "{\"username\":\"$username\",\"content\":\"$content\"}", //7. 修改邮箱号码
        );

        $emailParam = $emailParams[$scene];

        //置换邮件模版内容
        $msg = $emailTemp['tpl_content'];
        $params_arr = json_decode($emailParam);
        foreach ($params_arr as $k => $v) {
            $msg = str_replace('${' . $k . '}', $v, $msg);
        }

        return array('title'=>$emailTemp['tpl_title'], 'msg'=>$msg);
    }
}
