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

class Single extends Base
{
    // 模型标识
    public $nid = 'single';
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
                'parent_id' => array('eq', 0),
                'is_hidden' => 0,
                'status'    => 1,
            );
            $res = M('arctype')->where($map)->order('sort_order asc')->limit(1)->find();
            $typeurl = model('Arctype')->getTypeUrl($res);
            header('Location: '.$typeurl);
            exit;
        } else {
            $tid_tmp = strval(intval($tid));
            if ($tid_tmp != strval($tid)) {
                $tid = M('Arctype')->where(array('dirname'=>$tid))->getField('id');
            }
        }

        $result = array();

        if (!empty($tid)) {
            $arctype_info = model('Arctype')->getInfo($tid);
            if (!$arctype_info) {
                $this->error('页面不存在！');
                exit;
            }
            if ($arctype_info) {
                // 读取当前栏目的内容，否则读取每一级第一个子栏目的内容，直到有内容或者最后一级栏目为止。
                $result = $this->readContentFirst($tid);
                // 阅读权限
                if ($result['arcrank'] == -1) {
                    $this->success('待审核稿件，你没有权限阅读！');
                    exit;
                }
                // 外部链接跳转
                if ($result['is_part'] == 1) {
                    header('Location: '.$result['typelink']);
                    exit;
                }
                /*自定义字段的数据格式处理*/
                $result = $this->fieldLogic->getTableFieldList($result, config('global.arctype_channel_id'));
                $result = $this->fieldLogic->getChannelFieldList($result, $this->channeltype);
                /*--end*/
                // 是否有子栏目，用于标记【全部】选中状态
                $result['has_children'] = model('Arctype')->hasChildren($tid);

                $result = array_merge($arctype_info, $result);
                // seo
                $result['seo_title'] = set_typeseotitle($result['typename'], $result['seo_title']);
                /*获取当前页面URL*/
                if (80 == $_SERVER["SERVER_PORT"]) {
                    $result['pageurl'] = SITE_URL.$_SERVER["REQUEST_URI"];
                } else {
                    $result['pageurl'] = SITE_URL.':'.$_SERVER["SERVER_PORT"].$_SERVER["REQUEST_URI"];
                }
                /*--end*/
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
     * 读取指定栏目ID下有内容的栏目信息，只读取每一级的第一个栏目
     */
    public function readContentFirst($typeid)
    {
        $result = false;
        while (true)
        {
            $result = model('Single')->getInfoByTypeid($typeid);
            if (empty($result['content'])) {
                $map = array(
                    'parent_id' => $result['typeid'],
                    'is_hidden' => 0,
                    'status'    => 1,
                );
                $row = M('arctype')->where($map)->field('*')->order('sort_order asc')->find(); // 查找下一级的第一个栏目
                if (empty($row)) { // 不存在并返回当前栏目信息
                    break;
                } elseif ($result['channeltype'] != $row['current_channel']) { // 存在且不是单页模型，并进行跳转
                    $typeurl = model('Arctype')->getTypeUrl($row);
                    header('Location: '.$typeurl);
                    exit;
                } elseif ($result['channeltype'] == $row['current_channel']) { // 存在且是单页模型，则进行继续往下查找，直到有内容为止
                    $typeid = $row['id'];
                }
            } else {
                break;
            }
        }

        return $result;
    }
}