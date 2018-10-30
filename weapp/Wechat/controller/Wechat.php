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
 * Date: 2018-06-28
 */

namespace weapp\Wechat\controller;

use think\Db;
use think\Page;

/**
 * Wechat插件的控制器
 */
class Wechat extends Base{

    /**
     * 构造方法
     */
    public function __construct(){
        parent::__construct();
    }

    /**
     * 插件使用说明
     */
    public function doc(){
        return $this->fetch('doc');
    }

    /**
     * 公众号列表
     */
    public function index()
    {
        $assign_data = array();
        $condition = array();
        // 获取到所有GET参数
        $param = I('param.');

        // 应用搜索条件
        foreach (['keywords'] as $key) {
            if (isset($param[$key]) && $param[$key] !== '') {
                if ($key == 'keywords') {
                    $condition['a.wxname|a.appid'] = array('LIKE', "%{$param[$key]}%");
                } else {
                    $condition['a.'.$key] = array('eq', $param[$key]);
                }
            }
        }

        /**
         * 数据查询
         */
        $count = M('weapp_wx_config')->alias('a')->where($condition)->count();// 查询满足要求的总记录数
        $pageObj = new Page($count, config('paginate.list_rows'));// 实例化分页类 传入总记录数和每页显示的记录数
        $list = M('weapp_wx_config')
            ->field("a.id, a.wxname, a.appid, a.weixin, a.type, a.wait_access, a.add_time, a.token")
            ->alias('a')
            ->where($condition)
            ->order('a.id desc')
            ->limit($pageObj->firstRow.','.$pageObj->listRows)
            ->getAllWithIndex('id');
        $pageStr = $pageObj->show(); // 分页显示输出
        $assign_data['list'] = $list; // 赋值数据集
        $assign_data['pageStr'] = $pageStr; // 赋值分页输出
        $assign_data['pageObj'] = $pageObj; // 赋值分页对象

        $assign_data['wechat_type'] = $this->wechatLogic->get_wechat_type();

        $this->assign($assign_data);
        return $this->fetch('config_index');
    }

    /**
     * 公众号-新增
     */
    public function config_add()
    {
        if(IS_POST){
            $post = I('post.', '', 'trim');
            $map = array(
                'appid' => $post['appid'],
            );
            if(M('weapp_wx_config')->where($map)->count() > 0){
                $this->error('该公众号appid已存在');
            }

            /*上传头像*/
            $headerpic_is_remote = !empty($post['headerpic_is_remote']) ? $post['headerpic_is_remote'] : 0;
            $headerpic = '';
            if ($headerpic_is_remote == 1) {
                $headerpic = $post['headerpic_remote'];
            } else {
                $headerpic = $post['headerpic_local'];
            }
            $post['headerpic'] = $headerpic;
            /*--end*/

            /*上传二维码*/
            $qr_is_remote = !empty($post['qr_is_remote']) ? $post['qr_is_remote'] : 0;
            $qr = '';
            if ($qr_is_remote == 1) {
                $qr = $post['qr_remote'];
            } else {
                $qr = $post['qr_local'];
            }
            $post['qr'] = $qr;
            /*--end*/

            // 服务器地址(URL)
            $apiurl = U('weapp/Wechat/valid', array('appid'=>$post['appid'], 'ctl'=>'Basis'), true, true);

            $data = array(
                'apiurl' => $apiurl,
                'token' => getTime(),
                'web_expires_in' => 7000, // 最大值不能超过官方7200秒，这里设置提前200秒过期
                'web_expires'   => 0,
                'add_time'  => getTime(),
            );
            $nowData = array_merge($post, $data);
            $insertId = M('weapp_wx_config')->insertGetId($nowData);
            if ($insertId) {
                $this->success("操作成功!", weapp_url('Wechat/Wechat/index'));
            }else{
                $this->error("操作失败!");
            }
        }

        $apiurl = U('weapp/Wechat/valid', array('appid'=>'myappid'));
        $this->assign('apiurl', $apiurl);
        $this->assign('wechat_type', $this->wechatLogic->get_wechat_type());
        return $this->fetch('config_add');
    }

    /**
     * 公众号-编辑
     */
    public function config_edit()
    {
        if(IS_POST){
            $post = I('post.', '', 'trim');
            $map = array(
                'appid' => $post['appid'],
                'id' => array('NEQ', $post['id']),
            );
            if(M('weapp_wx_config')->where($map)->count() > 0){
                $this->error('该公众号appid已存在');
            }

            // 服务器地址(URL)
            $apiurl = U('weapp/Wechat/valid', array('appid'=>$post['appid'], 'ctl'=>'Basis'), true, true);

            $data = array(
                'apiurl' => $apiurl,
                'web_expires_in' => 7000, // 最大值不能超过官方7200秒，这里设置提前200秒过期
                'web_expires'   => 0,
                'update_time'  => getTime(),
            );
            $nowData = array_merge($post, $data);
            $row = M('weapp_wx_config')->where(array('id'=>$post['id']))->update($nowData);
            if ($row) {
                $this->success("操作成功!", weapp_url('Wechat/Wechat/index'));
            }else{
                $this->error("操作失败!");
            }
        }
        $id = I('param.id/d');
        $info = M('weapp_wx_config')->find($id);
        if (empty($info)) {
            $this->error('数据不存在，请联系管理员！');
            exit;
        }
        /*微信头像*/
        if (is_http_url($info['headerpic'])) {
            $info['headerpic_is_remote'] = 1;
            $info['headerpic_remote'] = $info['headerpic'];
        } else {
            $info['headerpic_is_remote'] = 0;
            $info['headerpic_local'] = $info['headerpic'];
        }
        /*--end*/
        /*微信二维码*/
        if (is_http_url($info['qr'])) {
            $info['qr_is_remote'] = 1;
            $info['qr_remote'] = $info['qr'];
        } else {
            $info['qr_is_remote'] = 0;
            $info['qr_local'] = $info['qr'];
        }
        /*--end*/
        $this->assign('field',$info);
        $this->assign('wechat_type', $this->wechatLogic->get_wechat_type());

        return $this->fetch('config_edit');
    }

    /*
     * 公众号 - 删除
     */
    public function config_del()
    {
        $id = $id_arr = I('del_id/a');
        if(is_array($id_arr)){
            foreach ($id_arr as $key => $val) {
                $id_arr[$key] = intval($val);
            }
            $id = implode(',', $id_arr); 
        } else {
            $id = intval($id);
        }
        if(!empty($id)){
            $result = M('weapp_wx_config')->where("id in ($id)")->select();
            $wxname_list = get_arr_column($result, 'wxname');

            $r = M('weapp_wx_config')->where("id in ($id)")->delete();
            if ($r) {
                adminLog('删除'.$this->weappInfo['name'].'：'.implode(',', $wxname_list));
                $this->success("操作成功!");
            } else {
                $this->error("操作失败!");
            }
        }else{
            $this->error("参数有误!");
        }
    }
}