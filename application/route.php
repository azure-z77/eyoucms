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

$home_rewrite = array();
$seo_pseudo = tpCache('seo.seo_pseudo');
$uiset = I('param.uiset/s', 'off');
$uiset = trim($uiset, '/');
if ($seo_pseudo == 3 && $uiset != 'on') {
  $home_rewrite = array(
    // 文章模型伪静态
    'article$' => array('home/Article/index',array('method' => 'get', 'ext' => 'html'), 'cache'=>1),
    'article/<tid>$' => array('home/Article/lists',array('method' => 'get', 'ext' => 'html'), 'cache'=>1),
    'article/<dirname>/<aid>$' => array('home/Article/view',array('method' => 'get', 'ext' => 'html'),'cache'=>1),
    // 产品模型伪静态
    'product$' => array('home/Product/index',array('method' => 'get', 'ext' => 'html'), 'cache'=>1),
    'product/<tid>$' => array('home/Product/lists',array('method' => 'get', 'ext' => 'html'), 'cache'=>1),
    'product/<dirname>/<aid>$' => array('home/Product/view',array('method' => 'get', 'ext' => 'html'),'cache'=>1),
    // 图集模型伪静态
    'images$' => array('home/Images/index',array('method' => 'get', 'ext' => 'html'), 'cache'=>1),
    'images/<tid>$' => array('home/Images/lists',array('method' => 'get', 'ext' => 'html'), 'cache'=>1),
    'images/<dirname>/<aid>$' => array('home/Images/view',array('method' => 'get', 'ext' => 'html'),'cache'=>1),
    // 下载模型伪静态
    'download$' => array('home/Download/index',array('method' => 'get', 'ext' => 'html'), 'cache'=>1),
    'download/<tid>$' => array('home/Download/lists',array('method' => 'get', 'ext' => 'html'), 'cache'=>1),
    'download/<dirname>/<aid>$' => array('home/Download/view',array('method' => 'get', 'ext' => 'html'),'cache'=>1),
    'downfile/<id>/<uhash>$' => array('home/Download/downfile',array('method' => 'get', 'ext' => 'html'),'cache'=>1),
    // 单页模型伪静态
    'single$' => array('home/Single/index',array('method' => 'get', 'ext' => 'html'), 'cache'=>1),
    'single/<tid>$' => array('home/Single/lists',array('method' => 'get', 'ext' => 'html'), 'cache'=>1),
    'single/<dirname>/<aid>$' => array('home/Single/view',array('method' => 'get', 'ext' => 'html'),'cache'=>1),
    // 标签伪静态
    'tags$' => array('home/Tags/index',array('method' => 'get', 'ext' => 'html'), 'cache'=>1),
    'tags/<tagid>$' => array('home/Tags/lists',array('method' => 'get', 'ext' => 'html'), 'cache'=>1),
    // 留言模型
    'guestbook$' => array('home/Guestbook/index',array('method' => 'get', 'ext' => 'html'), 'cache'=>1),
    'guestbook/<tid>$' => array('home/Guestbook/lists',array('method' => 'get', 'ext' => 'html'), 'cache'=>1),
    'guestbook/submit$' => array('home/Guestbook/submit',array('method' => 'post', 'ext' => 'html'), 'cache'=>1),
  );
}

$route = array(
    '__pattern__' => array(
        'tid' => '\w+',
        'aid' => '\d+',
    ),
    '__alias__' => array(),
    '__domain__' => array(),
);

$route = array_merge($route, $home_rewrite);

/*插件模块路由*/
$weapp_route = include_once 'weapp/route.php';
$route = array_merge($weapp_route, $route);
/*--end*/

return $route;
