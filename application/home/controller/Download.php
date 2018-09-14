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

class Download extends Base
{
    // 模型标识
    public $nid = 'download';
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
                $tid = M('Arctype')->where(array('dirname'=>$tid))->getField('id');
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

    public function view()
    {
        $param = input('param.');
        $aid = !empty($param['aid']) ? intval($param['aid']) : '';
        if (empty($aid)) {
            $this->redirect('/404');
            exit;
        }
        $result = model('Download')->getInfo($aid);
        if (empty($result)) {
            $this->error('页面不存在！');
            exit;
        } elseif ($result['arcrank'] == -1) {
            $this->success('待审核稿件，你没有权限阅读！');
            exit;
        }
        // 外部链接跳转
        if ($result['is_jump'] == 1) {
            header('Location: '.$result['jumplinks']);
            exit;
        }

        $tid = $result['typeid'];
        $arctypeInfo = model('Arctype')->getInfo($tid);
        /*自定义字段的数据格式处理*/
        $arctypeInfo = $this->fieldLogic->getTableFieldList($arctypeInfo, config('global.arctype_channel_id'));
        /*--end*/
        // 是否有子栏目，用于标记【全部】选中状态
        if (!empty($arctypeInfo)) {
            $arctypeInfo['has_children'] = model('Arctype')->hasChildren($tid);
        }
        $result = array_merge($arctypeInfo, $result);

        // 文档链接
        $result['arcurl'] = '';
        if ($result['is_jump'] != 1) {
            $result['arcurl'] = arcurl(MODULE_NAME.'/Download/view', $result, true, true);
        }
        /*--end*/

        /*获取当前页面URL*/
        if (80 == $_SERVER["SERVER_PORT"]) {
            $result['pageurl'] = SITE_URL.$_SERVER["REQUEST_URI"];
        } else {
            $result['pageurl'] = SITE_URL.':'.$_SERVER["SERVER_PORT"].$_SERVER["REQUEST_URI"];
        }
        /*--end*/

        // 下载资料列表
        $file_list = model('DownloadFile')->getDownFile($aid);
        $result['file_list'] = $file_list;

        // seo
        $result['seo_title'] = set_arcseotitle($result['title'], $result['seo_title'], $result['typename']);
        /*自定义字段的数据格式处理*/
        $result = $this->fieldLogic->getChannelFieldList($result, $this->channeltype);
        /*--end*/

        $eyou = array(
            'field' => $result,
        );
        $this->eyou = array_merge($this->eyou, $eyou);
        $this->assign('eyou', $this->eyou);

        /*模板文件*/
        $tempview = !empty($result['tempview']) ? $result['tempview'] : 'view_'.$this->nid.'.'.$this->view_suffix;
        /*--end*/

        $fetch_tpl = './template/'.$this->theme_style.'/'.$tempview;
        $html = $this->fetch($fetch_tpl);
/*
        $seo_pseudo = tpCache('global.seo_pseudo');
        if ($seo_pseudo == 2) {
            if (empty($result['dirpath'])) {
                return '';
            }
            $filename = ROOT_PATH.ltrim($result['dirpath'], '/');
            tp_mkdir($filename);
            $filename = $filename."/{$aid}.html";
            file_put_contents($filename, $html);
        }
*/
        return $html;
    }

    /**
     * 下载文件
     */
    public function downfile()
    {
        $file_id = I('param.id/d', 0);
        $uhash = I('param.uhash/s', '');

        if (empty($file_id) || empty($uhash)) {
            $this->error('下载地址出错！');
            exit;
        }

        $map = array(
            'file_id'   => $file_id,
            'uhash' => $uhash,
        );
        $result = M('download_file')->where($map)->find();
        $filename = isset($result['file_url']) ? trim($result['file_url'], '/') : '';
        $filename = ROOT_PATH.$filename;
        clearstatcache();
        if (empty($result) || !is_file($filename)) {
            $this->error('下载文件不存在！');
            exit;
        }
        $file_url = is_http_url($result['file_url']) ? $result['file_url'] : ROOT_PATH.trim($result['file_url'], '/');
        if (md5_file($file_url) != $result['md5file']) {
            $this->error('下载文件包不完整！');
            exit;
        }
        
        header('Location: '. $result['file_url']);
        exit;
    }
}