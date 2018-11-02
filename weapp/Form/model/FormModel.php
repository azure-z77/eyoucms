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

namespace weapp\Form\model;

use think\Model;

/**
 * 模型
 */
class FormModel extends Model
{
    /**
     * 数据表名，不带前缀
     */
    public $name = 'weapp_form';

    //初始化
    protected function initialize()
    {
        // 需要调用`Model`的`initialize`方法
        parent::initialize();
    }

    public function getAttrbuteList($id)
    {
        $form = $this->find($id);

        $attrbute = new FormAttrbute();
        $list = $attrbute->getList($form->tag);

        $data = ['form' => $form, 'list' => $list];
        
        return $data;
    }
}