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

class TagDiyurl extends Base
{
    protected function _initialize()
    {
        parent::_initialize();
    }

    public function getDiyurl($type = 'tags', $link = '', $vars = '', $suffix = '', $domain = '', $seo_pseudo = '', $seo_pseudo_format = '', $seo_inlet = '', $Class = 'ey_active')
    {
        $suffix = !empty($suffix) ? $suffix : true;
        $domain = !empty($domain) ? $domain : false;
        $seo_pseudo = !empty($seo_pseudo) ? $seo_pseudo : null;
        $seo_pseudo_format = !empty($seo_pseudo_format) ? $seo_pseudo_format : null;
        $seo_inlet = !empty($seo_inlet) ? $seo_inlet : null;

        $parseStr = "";
        
        if (in_array($this->request->controller(), ['Search', 'Lists'])) {
            // 获取URL链接上的所有参数
            $Param = $this->request->param();
            // 获取已处理好的 tid
            $Param['tid'] = !empty($this->tid) ? $this->tid : '';
            // 排序条件
            $SortAsc = !empty($Param['sort_asc']) && 'desc' == $Param['sort_asc'] ? 'asc' : 'desc';
            // 当前模型、控制器、方法
            $DynamicURL = "{$Param['m']}/{$Param['c']}/{$Param['a']}";
            // 删除指定参数
            unset($Param['m'], $Param['c'], $Param['a'], $Param['sort_asc']);
            // 默认排序
            if (!empty($type) && 'DefaultUrl' == $type) {
                $urlList['DefaultUrl'] = $this->GetSortHtmlCode($DynamicURL, $Param, $Class, 'default');
            }
            // 最新排序
            if (!empty($type) && 'NewUrl' == $type) {
                $urlList['NewUrl'] = $this->GetSortHtmlCode($DynamicURL, $Param, $Class, 'new');
            }
            // 评价数排序(默认高到低排序)
            if (!empty($type) && 'AppraiseUrl' == $type) {
                $urlList['AppraiseUrl'] = $this->GetSortHtmlCode($DynamicURL, $Param, $Class, 'appraise');
            }
            // 销量数排序(默认高到低排序)
            if (!empty($type) && 'SalesUrl' == $type) {
                $urlList['SalesUrl'] = $this->GetSortHtmlCode($DynamicURL, $Param, $Class, 'sales');
            }
            // 收藏数排序(默认高到低排序)
            if (!empty($type) && 'CollectionUrl' == $type) {
                $urlList['CollectionUrl'] = $this->GetSortHtmlCode($DynamicURL, $Param, $Class, 'collection');
            }
            // 点击数排序(默认高到低排序)
            if (!empty($type) && 'ClickUrl' == $type) {
                $urlList['ClickUrl'] = $this->GetSortHtmlCode($DynamicURL, $Param, $Class, 'click');
            }
            // 下载数排序(默认高到低排序)
            if (!empty($type) && 'DownloadUrl' == $type) {
                $urlList['DownloadUrl'] = $this->GetSortHtmlCode($DynamicURL, $Param, $Class, 'download');
            }
            // 价格排序
            if (!empty($type) && 'PriceUrl' == $type) {
                $urlList['PriceUrl'] = $this->GetSortHtmlCode($DynamicURL, $Param, $Class, 'price', $SortAsc);
            }
            // 取出指定的URL
            $parseStr = !empty($urlList[$type]) ? $urlList[$type] : '';
        } else {
            switch ($type) {
                case "tags":     // 标签主页
                    $parseStr = url('home/Tags/index');
                    break;
                case "login":     // 登录
                    $parseStr = url('user/Users/login');
                    break;
                case "reg":     // 注册
                    $parseStr = url('user/Users/reg');
                    break;
                case "mobile":     // 发送手机短信方法
                case "Mobile":     // 发送手机短信方法
                    $parseStr = url('api/Ajax/SendMobileCode');
                    break;
                case "sindex":     // 搜索主页
                    $parseStr = url('home/Search/index');
                    break;
                default:
                    {
                        if (stristr($link, '/')) {
                            $parseStr = url($link, $vars, $suffix, $domain, $seo_pseudo, $seo_pseudo_format, $seo_inlet);
                        } else {
                            $parseStr = "";
                        }
                    }
                    break;
            }
        }
        return $parseStr;
    }

    // --------------------陈风任----------------------- //
    // 获取URL后封装成HTML代码返回
    private function GetSortHtmlCode($DynamicURL = '', $Param = [], $Class = '', $Sort = '', $SortAsc = '')
    {
        // 判断当前选中的排序方式进行样式标记
        $ClassNew = $this->GetClassValue($Param, $Class, $Sort);
        // 整合参数数组
        $ParamNew = !empty($Sort) ? array_merge($Param, ['sort' => $Sort]) : $Param;
        // 若存在排序条件则执行
        if (!empty($SortAsc)) $ParamNew['sort_asc'] = $SortAsc;
        // 获取动态URL
        $DynamicURL = $this->DynamicURL($DynamicURL, $ParamNew);
        // 获取HTML代码返回
        return $this->GetHtmlCode($DynamicURL, $Param, $Class, $ClassNew, $Sort);
    }

    // 判断当前选中的排序方式进行样式标记
    private function GetClassValue($Param = [], $Class = '', $Sort = '')
    {
        $ClassNew = '';
        if (!empty($Param['sort']) && 'new' == $Param['sort'] && 'new' == $Sort) {
            $ClassNew = $Class;
        } else if (!empty($Param['sort']) && 'appraise' == $Param['sort'] && 'appraise' == $Sort) {
            $ClassNew = $Class;
        } else if (!empty($Param['sort']) && 'sales' == $Param['sort'] && 'sales' == $Sort) {
            $ClassNew = $Class;
        } else if (!empty($Param['sort']) && 'collection' == $Param['sort'] && 'collection' == $Sort) {
            $ClassNew = $Class;
        } else if (!empty($Param['sort']) && 'click' == $Param['sort'] && 'click' == $Sort) {
            $ClassNew = $Class;
        } else if (!empty($Param['sort']) && 'download' == $Param['sort'] && 'download' == $Sort) {
            $ClassNew = $Class;
        } else if (!empty($Param['sort']) && 'price' == $Param['sort'] && 'price' == $Sort) {
            $ClassNew = $Class;
        } else if (!empty($Param['sort']) && 'default' == $Param['sort'] && 'default' == $Sort) {
            $ClassNew = $Class;
        }
        return $ClassNew;
    }

    // 封装纯动态url
    private function DynamicURL($DynamicURL = '', $ParamNew = []) 
    {
        // 拆分URL
        $GetMCA = !empty($DynamicURL) ? explode('/', $DynamicURL) : [];
        if (empty($GetMCA)) {
            $ReturnUrl = ROOT_DIR . '/index.php?m=home&c=Lists&a=index';
        } else {
            $ReturnUrl = ROOT_DIR . '/index.php?m=' . $GetMCA[0] . '&c=' . $GetMCA[1] . '&a=' . $GetMCA[2];
        }
        // 拼装URL及参数
        if (!empty($ParamNew)) $ReturnUrl .= '&' . http_build_query($ParamNew);
        // 返回URL
        return urldecode($ReturnUrl);
    }

    // 封装HTML代码
    private function GetHtmlCode($DynamicURL = '', $Param = [], $Class = '', $ClassNew = '', $Sort = '')
    {
        if (empty($DynamicURL)) return false;
        // 选中默认或初始时执行
        if (empty($Param['sort'])) $Param['sort'] = 'default';
        if ('default' == $Param['sort'] && 'default' == $Sort) $ClassNew = $Class;
        // 返回已封装的HTML代码
        return " href=\"JavaScript:void(0);\" onclick=\"window.location.href='{$DynamicURL}';\" class=\"{$ClassNew}\" ";
    }
    // --------------------分割线----------------------- //
}