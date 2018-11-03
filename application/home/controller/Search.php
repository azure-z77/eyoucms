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

class Search extends Base
{
    public function _initialize() {
        parent::_initialize();
    }

    /**
     * 搜索主页
     */
    public function index()
    {
        return $this->lists();
    }

    /**
     * 搜索列表
     */
    public function lists()
    {
        $param = I('param.');
        
        $result = $param;
        $eyou = array(
            'field' => $result,
        );
        $this->eyou = array_merge($this->eyou, $eyou);
        $this->assign('eyou', $this->eyou);

        return $this->fetch('template/'.$this->theme_style.'/lists_search.'.$this->view_suffix);
    }
}