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

/**
 * 设置内容标题
 */
function set_arcseotitle($title = '', $seo_title = '', $typename = '')
{
    /*针对没有自定义SEO标题的文档*/
    if (empty($seo_title)) {
        $web_name = tpCache('web.web_name');
        $seo_viewtitle_format = tpCache('seo.seo_viewtitle_format');
        switch ($seo_viewtitle_format) {
            case '1':
                $seo_title = $title;
                break;
            
            case '3':
                $seo_title = $title.'_'.$typename.'_'.$web_name;
                break;
            
            case '2':
            default:
                $seo_title = $title.'_'.$web_name;
                break;
        }
    }
    /*--end*/

    return $seo_title;
}

/**
 * 设置栏目标题
 */
function set_typeseotitle($typename = '', $seo_title = '')
{
    /*针对没有自定义SEO标题的列表*/
    if (empty($seo_title)) {
        $web_name = tpCache('web.web_name');
        $seo_liststitle_format = tpCache('seo.seo_liststitle_format');
        switch ($seo_liststitle_format) {
            case '1':
                $seo_title = $typename.'_'.$web_name;
                break;
            
            case '2':
            default:
                $page = I('param.page/d', 1);
                if ($page > 1) {
                    $typename .= "_第{$page}页";
                }
                $seo_title = $typename.'_'.$web_name;
                break;
        }
    }

    return $seo_title;
}

/**
 * 获取当前栏目的第一级栏目
 */
function gettoptype($typeid, $field = 'typename')
{
    $parent_list = model('Arctype')->getAllPid($typeid); // 获取当前栏目的所有父级栏目
    $result = current($parent_list); // 第一级栏目
    if (isset($result[$field]) && !empty($result[$field])) {
        return $result[$field];
    } else {
        return '';
    }
}