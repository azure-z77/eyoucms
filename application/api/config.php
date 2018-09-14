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

// 加载系统语言包
/*\think\Lang::load([
    APP_PATH . 'admin' . DS . 'lang' . DS . request()->langset() . EXT,
]);*/

$api_config = array(
    // +----------------------------------------------------------------------
    // | 模板设置
    // +----------------------------------------------------------------------
    //默认错误跳转对应的模板文件
    'dispatch_error_tmpl' => 'public:dispatch_jump',
    // 默认成功跳转对应的模板文件
    'dispatch_success_tmpl' => 'public:dispatch_jump',

    // +----------------------------------------------------------------------
    // | 异常及错误设置
    // +----------------------------------------------------------------------

    // 异常页面的模板文件 
    //'exception_tmpl'         => ROOT_PATH.'public/static/errpage/404.html',
    // errorpage 错误页面
    //'error_tmpl'         => ROOT_PATH.'public/static/errpage/404.html',
    
    // 过滤不需要登录的控制器
    'filter_login_controller' => array(
        'Ueditor', // 编辑器上传
        'Uploadify', // 图片上传
    ),

    // 过滤不需要登录的操作
    'filter_login_action' => array(
        'login',
        'logout',
        'vertify',
    ),
);

$html_config = include_once 'html.php';
return array_merge($api_config, $html_config);
?>