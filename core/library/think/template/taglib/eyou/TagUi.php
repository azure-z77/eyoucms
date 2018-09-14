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

namespace think\template\taglib\eyou;


/**
 * 外观调试的最初引入文件
 */
class TagUi extends Base
{
    public $uiset = 'off';

    //初始化
    protected function _initialize()
    {
        parent::_initialize();
        $this->uiset = I("param.uiset/s", "off");
        $this->uiset = trim($this->uiset, '/');
    }

    /**
     * 纯文本编辑
     * @author wengxianhu by 2018-4-20
     */
    public function getUi()
    {
        $v = I('param.v/s', 'pc');
        $v = trim($v, '/');
        $parseStr = '';
        if ("on" == $this->uiset) {
            $version = getCmsVersion();
            $webConfig = tpCache('web');
            $web_cmspath = !empty($webConfig['web_cmspath']) ? $webConfig['web_cmspath'] : ''; // CMS安装路径
            $web_adminbasefile = !empty($webConfig['web_adminbasefile']) ? $webConfig['web_adminbasefile'] : '/login.php'; // 后台入口文件路径
            // $parseStr .= static_version($web_cmspath.'/public/plugins/layer-v3.1.0/layer.js');
            $parseStr .= '<script type="text/javascript" src="'.$web_cmspath.'/public/plugins/layer-v3.1.0/layer.js"></script>';
            $parseStr .= '<link rel="stylesheet" type="text/css" href="'.$web_cmspath.'/public/static/common/css/eyou.css?v='.$version.'" />';
            $parseStr .= '<script type="text/javascript">var admin_basefile = "'.$web_adminbasefile.'"; var admin_module_name = "admin"; var v = "'.$v.'";</script>';
            $parseStr .= '<script type="text/javascript" src="'.$web_cmspath.'/public/static/common/js/eyou.js?v='.$version.'"></script>';
        }

        return $parseStr;
    }
}