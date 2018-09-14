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

namespace app\home\controller;

class Index extends Base
{
    public function _initialize() {
        parent::_initialize();
    }

    public function index()
    {
        if (is_https()) {
            $filename = 'indexs.html';
        } else {
            $filename = 'index.html';
        }
        if (file_exists(__ROOT__.$filename)) {
            @unlink(__ROOT__.$filename);
        }

        //自动生成HTML版
        if(isset($_GET['clear']) || !file_exists(ROOT_PATH.$filename))
        {
            /*获取当前页面URL*/
            if (80 == $_SERVER["SERVER_PORT"]) {
                $result['pageurl'] = SITE_URL;
            } else {
                $result['pageurl'] = SITE_URL.':'.$_SERVER["SERVER_PORT"];
            }
            /*--end*/
            $eyou = array(
                'field' => $result,
            );
            $this->eyou = array_merge($this->eyou, $eyou);
            $this->assign('eyou', $this->eyou);
            $html = $this->fetch(':index');
            // file_put_contents(ROOT_PATH.$filename, $html);
            return $html;
        }
        else
        {
            // header('HTTP/1.1 301 Moved Permanently');
            // header('Location:'.$filename);
        }
    }
}