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

$weapp_rewrite = array(
    // 插件公共伪静态
    
);

/*引入全部插件的路由配置*/
$rewrite_list = glob(WEAPP_PATH.'*/route.php');
if (!empty($rewrite_list)) {
    foreach ($rewrite_list as $key => $file) {
        $rewrite_value = include_once $file;
        if (!empty($rewrite_value)) {
            $weapp_rewrite = array_merge($rewrite_value, $weapp_rewrite);
        }
    }
}
/*--end*/

$weapp_route = array(
    '__pattern__' => array(),
    '__alias__' => array(),
    '__domain__' => array(),
);

$weapp_route = array_merge($weapp_route, $weapp_rewrite);

return $weapp_route;
