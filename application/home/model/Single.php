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

namespace app\home\model;

use think\Model;
use think\Db;

/**
 * 简介
 */
class Single extends Model
{
    //初始化
    protected function initialize()
    {
        // 需要调用`Model`的`initialize`方法
        parent::initialize();
    }

    /**
     * 获取单条记录
     * @author wengxianhu by 2017-7-26
     */
    public function getInfoByTypeid($typeid, $map = array(), $isshowbody = true)
    {
        $result = array();
        if ($isshowbody) {
            $field = 'c.*, b.*, a.*, b.aid, a.id as typeid';
            $result = db('Arctype')->field($field)
                ->alias('a')
                ->join('__ARCHIVES__ b', 'b.typeid = a.id', 'LEFT')
                ->join('__SINGLE_CONTENT__ c', 'c.aid = b.aid', 'LEFT')
                ->where($map)
                ->find($typeid);
        } else {
            $field = 'b.*, a.*, a.id as typeid, b.aid';
            $result = db('Arctype')->field($field)
                ->alias('a')
                ->join('__ARCHIVES__ b', 'b.typeid = a.id', 'LEFT')
                ->where($map)
                ->find($typeid);
        }

        return $result;
    }
}