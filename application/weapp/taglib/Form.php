<?php
/**
 * 易优CMS
 * ============================================================================
 * 版权所有 2016-2028 海南赞赞网络科技有限公司，并保留所有权利。
 * 网站地址: http://www.eyoucms.com
 * ----------------------------------------------------------------------------
 * 如果商业用途务必到官方购买正版授权, 以免引起不必要的法律纠纷.
 * ============================================================================
 * Author: King超 <23939139@qq.com>
 * Date: 2018-10-29
 */

namespace app\weapp\taglib;

use think\template\TagLib;

/**
 * form插件标签库解析类
 * @category   Think
 * @package  Think
 * @subpackage  Driver.Taglib
 * @author    King超 <23939139@qq.com>
 */
class Form extends Taglib
{

    // 标签定义
    protected $tags = [
        // 标签定义： attr 属性列表 close 是否闭合（0 或者1 默认1） alias 标签别名 level 嵌套层次
        'list'        => ['attr' => 'typeid,id,key'],
        'test'        => ['attr' => ''],
    ];

    public function tagList($tag, $content)
    {
        $typeid = !empty($tag['typeid']) ? $tag['typeid'] : '';
        $id     = isset($tag['id']) ? $tag['id'] : 'field';
        $key    = !empty($tag['key']) ? $tag['key'] : 'i';

        $parseStr = '<?php ';
        $parseStr .= '$model = new \weapp\form\model\FormModel();';
        $parseStr .= '$_result = $model->getAttrbuteList(' . $typeid . ');';
        $parseStr .= '$__LIST__ = $_result["list"];';
        $parseStr .= '$' . $key . '= 0;';        
        $parseStr .= 'foreach($__LIST__ as $key=>$' . $id . '): ';
        $parseStr .= '$' . $key . '++; ?>';        
        $parseStr .= $content;
        $parseStr .= '<?php endforeach;?>';
        return $parseStr;        
    }
}
