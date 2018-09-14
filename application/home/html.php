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


$html_cache_arr = array();
// 全局变量数组
$global = tpCache('global');
// 系统模式
$web_cmsmode = isset($global['web_cmsmode']) ? $global['web_cmsmode'] : 2;
/*页面缓存有效期*/
$app_debug = true;
$web_htmlcache_expires_in = -1;
if (1 == $web_cmsmode) { // 运营模式
    $app_debug = false;
    $web_htmlcache_expires_in = isset($global['web_htmlcache_expires_in']) ? $global['web_htmlcache_expires_in'] : 7200;
}
/*--end*/

$html_cache_arr = array(
    // 首页
    array('mca'=>'home_Index_index', 'filename'=>'index/index', 'cache'=>$web_htmlcache_expires_in),  // 缓存首页静态页面
    // 文章
    array('mca'=>'home_Article_index', 'filename'=>'channel/article/index', 'cache'=>$web_htmlcache_expires_in),  
    array('mca'=>'home_Article_lists', 'filename'=>'articlelist/article/list', 'p'=>array('tid','page'), 'cache'=>$web_htmlcache_expires_in), 
    array('mca'=>'home_Article_view', 'filename'=>'detail/article/view', 'p'=>array('aid'), 'cache'=>$web_htmlcache_expires_in), 
    // 产品
    array('mca'=>'home_Product_index', 'filename'=>'channel/product/index', 'cache'=>$web_htmlcache_expires_in), 
    array('mca'=>'home_Product_lists', 'filename'=>'articlelist/product/list', 'p'=>array('tid','page'), 'cache'=>$web_htmlcache_expires_in), 
    array('mca'=>'home_Product_view', 'filename'=>'detail/product/view', 'p'=>array('aid'), 'cache'=>$web_htmlcache_expires_in),
    // 图集
    array('mca'=>'home_Images_index', 'filename'=>'channel/images/index', 'cache'=>$web_htmlcache_expires_in), 
    array('mca'=>'home_Images_lists', 'filename'=>'articlelist/images/list', 'p'=>array('tid','page'), 'cache'=>$web_htmlcache_expires_in), 
    array('mca'=>'home_Images_view', 'filename'=>'detail/images/view', 'p'=>array('aid'), 'cache'=>$web_htmlcache_expires_in),
    // 下载
    array('mca'=>'home_Download_index', 'filename'=>'channel/download/index', 'cache'=>$web_htmlcache_expires_in), 
    array('mca'=>'home_Download_lists', 'filename'=>'articlelist/download/list', 'p'=>array('tid','page'), 'cache'=>$web_htmlcache_expires_in), 
    array('mca'=>'home_Download_view', 'filename'=>'detail/download/view', 'p'=>array('aid'), 'cache'=>$web_htmlcache_expires_in),
    // 简介
    array('mca'=>'home_Single_index', 'filename'=>'channel/single/index', 'cache'=>$web_htmlcache_expires_in), 
    array('mca'=>'home_Single_lists', 'filename'=>'articlelist/single/list', 'p'=>array('tid','page'), 'cache'=>$web_htmlcache_expires_in), 
);

return array(
    // 应用调试模式
    'app_debug' => $app_debug,
    // 模板设置
    'template' => array(
        // 模板路径
        'view_path' => './template/',
        // 模板后缀
        'view_suffix' => 'htm',
    ),
    // 视图输出字符串内容替换
    'view_replace_str' => array(),

    /**假设这个访问地址是 www.xxxxx.dev/home/goods/goodsInfo/id/1.html 
     *就保存名字为 index_goods_goodsinfo_1.html     
     *配置成这样, 指定 模块 控制器 方法名 参数名
     */
    'HTML_CACHE_ARR'=> $html_cache_arr,
);
?>