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

use think\Cache;

class Guestbook extends Base
{
    // 模型标识
    public $nid = 'guestbook';
    // 模型ID
    public $channeltype = '';
    
    public function _initialize() {
        parent::_initialize();
        $channeltype_list = config('global.channeltype_list');
        $this->channeltype = $channeltype_list[$this->nid];
    }

    public function index()
    {
        $fetch_tpl = './template/'.$this->theme_style.'/'.$this->nid.'_index.'.$this->view_suffix;
        if ($this->exists($fetch_tpl) == false) {
            return $this->lists();
        }
        $this->assign('eyou', $this->eyou);
        return $this->fetch($fetch_tpl);
    }

    public function lists()
    {
        $param = input('param.');
        $tid = !empty($param['tid']) ? $param['tid'] : '';
        if (empty($tid)) {
            $map = array(
                'channeltype'   => $this->channeltype,
                'parent_id' => 0,
                'is_hidden' => 0,
                'status'    => 1,
            );
            $tid = M('arctype')->where($map)->order('sort_order asc')->limit(1)->getField('id');
        } else {
            $tid_tmp = strval(intval($tid));
            if ($tid_tmp != strval($tid)) {
                $tid = M('Arctype')->field('id')->where(array('dirname'=>$tid))->getField('id');
            }
        }

        $result = array();
        
        if (!empty($tid)) {
            $result = model('Arctype')->getInfo($tid);
            if (!empty($result)) {
                /*自定义字段的数据格式处理*/
                $result = $this->fieldLogic->getTableFieldList($result, config('global.arctype_channel_id'));
                /*--end*/
                /*是否有子栏目，用于标记【全部】选中状态*/
                $result['has_children'] = model('Arctype')->hasChildren($tid);
                /*--end*/
                // seo
                $result['seo_title'] = set_typeseotitle($result['typename'], $result['seo_title']);
            }
        }

        $eyou = array(
            'field' => $result,
        );
        $this->eyou = array_merge($this->eyou, $eyou);
        $this->assign('eyou', $this->eyou);

        /*模板文件*/
        $templist = !empty($result['templist']) ? $result['templist'] : 'lists_'.$this->nid.'.'.$this->view_suffix;
        /*--end*/

        $fetch_tpl = './template/'.$this->theme_style.'/'.$templist;
        return $this->fetch($fetch_tpl);
    }

    /**
     * 留言提交 
     */
    public function submit()
    {
        $post = I('post.');
        $typeid = I('post.typeid/d');
        $ip = clientIP();

        if (!empty($typeid)) {
            $map = array(
                'ip'    => $ip,
                'typeid'    => $typeid,
                'add_time'  => array('gt', getTime() - 60),
            );
            $count = M('guestbook')->where($map)->count('aid');
            if ($count > 0) {
                $this->error('同一个IP在60秒之内不能重复提交！');
                exit;
            }

            $newData = array(
                'typeid'    => $typeid,
                'channel'   => $this->channeltype,
                'ip'    => $ip,
                'add_time'  => getTime(),
                'update_time' => getTime(),
            );
            $data = array_merge($post, $newData);

            // 数据验证            
            $validate = \think\Loader::validate('Guestbook');
            if(!$validate->batch()->check($data))
            {
                $error = $validate->getError();
                $error_msg = array_values($error);
                $this->error($error_msg[0]);
                exit;
            } else {
                $aid = M('guestbook')->insertGetId($data);
                if ($aid > 0) {
                    $this->saveGuestbookAttr($aid, $typeid);
                }
                $this->success('操作成功！');
                exit;
            }  
        }

        $this->error('表单typeid值丢失！');
        exit;
    }

    /**
     *  给指定留言添加表单值到 guestbook_attr
     * @param int $aid  留言id
     * @param int $typeid  留言栏目id
     */
    public function saveGuestbookAttr($aid, $typeid)
    {  
        // post 提交的属性  以 attr_id _ 和值的 组合为键名    
        $post = I("post.");
        foreach($post as $k => $v)
        {
            $attr_id = str_replace('attr_','',$k);
            if(!strstr($k, 'attr_'))
                continue;                                 

            //$v = str_replace('_', '', $v); // 替换特殊字符
            //$v = str_replace('@', '', $v); // 替换特殊字符
            $v = trim($v);
            $adddata = array(
                'aid'   => $aid,
                'attr_id'   => $attr_id,
                'attr_value'   => filter_line_return($v, '。'),
                'add_time'   => getTime(),
                'update_time'   => getTime(),
            );
            M('GuestbookAttr')->add($adddata);                       
        }
    }
}