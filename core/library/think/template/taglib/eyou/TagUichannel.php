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


/**
 * 栏目列表编辑
 */
class TagUichannel extends Base
{
    //初始化
    protected function _initialize()
    {
        parent::_initialize();
    }

    /**
     * 栏目列表编辑
     * @author wengxianhu by 2018-4-20
     */
    public function getUichannel($typeid, $e_id, $e_page)
    {
        if (empty($e_id) || empty($e_page)) {
            echo '标签uichannel报错：缺少属性 e-id | e-page 。';
            return false;
        }

        $result = false;
        $inckey = "channel_{$e_id}";
        $inc = get_ui_inc_params($e_page);

        $info = false;
        if ($inc && !empty($inc[$inckey])) {
            $data = json_decode($inc[$inckey], true);
            $info = $data['info'];
        } else {
            $info['typeid'] = $typeid;
            // $info['row'] = "";
        }

        $result = array(
            'info'  => $info,
        );

        return $result;
    }
}