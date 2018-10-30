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

namespace weapp\Demo\controller;

use think\Page;
use app\common\controller\Weapp;
use weapp\Demo\model\DemoModel;

/**
 * 插件的控制器
 */
class Demo extends Weapp
{

    /**
     * 实例化模型
     */
    private $model;

    /**
     * 插件基本信息
     */
    private $weappInfo;

    /**
     * 构造方法
     */
    public function __construct(){
        parent::__construct();
        
        $this->model = new DemoModel;

        /*插件基本信息*/
        $this->weappInfo = $this->getWeappInfo();
        $this->assign('weappInfo', $this->weappInfo);
        /*--end*/
    }

    /**
     * 插件使用指南
     */
    public function doc(){
        return $this->fetch('doc');
    }

    /**
     * 系统内置钩子show方法，用于在前台模板显示片段的html代码，比如：QQ客服、对联广告等
     *
     * @param  mixed  $params 传入的参数
     */
    public function show($params = null){
        $list = db($this->model->name)->select();
        $this->assign('list', $list);
        $this->display('show');
    }

    /**
     * 插件后台管理 - 列表
     */
    public function index()
    {
        $list = array();
        $keywords = I('keywords/s');

        $map = array();
        if (!empty($keywords)) {
            $map['title'] = array('LIKE', "%{$keywords}%");
        }

        $count = db($this->model->name)->where($map)->count('id');// 查询满足要求的总记录数
        $pageObj = new Page($count, config('paginate.list_rows'));// 实例化分页类 传入总记录数和每页显示的记录数
        $list = db($this->model->name)->where($map)->order('id desc')->limit($pageObj->firstRow.','.$pageObj->listRows)->select();
        $pageStr = $pageObj->show(); // 分页显示输出
        $this->assign('list', $list); // 赋值数据集
        $this->assign('pageStr', $pageStr); // 赋值分页输出
        $this->assign('pageObj', $pageObj); // 赋值分页对象

        return $this->fetch('index');
    }

    /**
     * 插件后台管理 - 新增
     */
    public function add()
    {
        if (IS_POST) {
            $post = I('post.');

            /*------------这里可以实现存储数据之前的额外逻辑 start-------------*/

            /*处理LOGO的本地上传与远程*/
            $is_remote = !empty($post['is_remote']) ? $post['is_remote'] : 0;
            $logo = '';
            if ($is_remote == 1) {
                $logo = $post['logo_remote']; // 远程链接
            } else {
                $logo = $post['logo_local']; // 本地上传链接
            }
            $post['logo'] = $logo;
            /*--end*/

            /*--------------------------------end------------------------------*/

            /*组装存储数据*/
            $nowData = array(
                'add_time'    => getTime(),
                'update_time'    => getTime(),
            );
            $saveData = array_merge($post, $nowData);
            /*--end*/
            $insertId = $this->model->insert($saveData);
            if (false !== $insertId) {
                adminLog('新增'.$this->weappInfo['name'].'：'.$post['title']); // 写入操作日志
                $this->success("操作成功", weapp_url('Demo/Demo/index'));
            }else{
                $this->error("操作失败");
            }
            exit;
        }

        return $this->fetch('add');
    }
    
    /**
     * 插件后台管理 - 编辑
     */
    public function edit()
    {
        if (IS_POST) {
            $post = I('post.');
            $post['id'] = eyIntval($post['id']);
            if(!empty($post['id'])){

                /*------------这里可以实现存储数据之前的额外逻辑 start-------------*/

                /*处理LOGO的本地上传与远程*/
                $is_remote = !empty($post['is_remote']) ? $post['is_remote'] : 0;
                $logo = '';
                if ($is_remote == 1) {
                    $logo = $post['logo_remote']; // 远程链接
                } else {
                    $logo = $post['logo_local']; // 本地上传链接
                }
                $post['logo'] = $logo;
                /*--end*/

                /*--------------------------------end------------------------------*/

                /*组装存储数据*/
                $nowData = array(
                    'typeid'    => empty($post['typeid']) ? 1 : $post['typeid'],
                    'url'    => trim($post['url']),
                    'update_time'    => getTime(),
                );
                $saveData = array_merge($post, $nowData);
                /*--end*/

                $r = $this->model->save($saveData, array('id'=>$post['id']));
                if ($r) {
                    adminLog('编辑'.$this->weappInfo['name'].'：'.$post['title']); // 写入操作日志
                    $this->success("操作成功!", weapp_url('Demo/Demo/index'));
                }
            }
            $this->error("操作失败!");
        }

        $id = I('id/d', 0);
        $row = $this->model->get($id);
        if (empty($row)) {
            $this->error('数据不存在，请联系管理员！');
            exit;
        }
        
        /*同时拥有本地上传与远程URL的逻辑处理*/
        if (is_http_url($row['logo'])) {
            $row['is_remote'] = 1;
            $row['logo_remote'] = $row['logo'];
        } else {
            $row['is_remote'] = 0;
            $row['logo_local'] = $row['logo'];
        }
        /*--end*/

        $this->assign('row',$row);

        return $this->fetch('edit');
    }
    
    /**
     * 删除文档
     */
    public function del()
    {
        $id_arr = I('del_id/a');
        $id_arr = eyIntval($id_arr);
        if(!empty($id_arr)){
            $result = $this->model->where("id",'IN',$id_arr)->select();
            $title_list = get_arr_column($result, 'title');

            $r = $this->model->where("id",'IN',$id_arr)->delete();
            if($r){
                adminLog('删除'.$this->weappInfo['name'].'：'.implode(',', $title_list));
                $this->success("操作成功!");
            }else{
                $this->error("操作失败!");
            }
        }else{
            $this->error("参数有误!");
        }
    }
    
    /**
     * 插件配置
     */
    public function conf()
    {
        if (IS_POST) {
            $post = I('post.');
            if(!empty($post['code'])){
                $data = array(
                    'tag_weapp' => $post['tag_weapp'],
                    'update_time' => getTime(),
                );
                $r = M('weapp')->where('code','eq',$post['code'])->update($data);
                if ($r) {
                    \think\Cache::clear('hooks');
                    adminLog('编辑'.$this->weappInfo['name'].'：插件配置'); // 写入操作日志
                    $this->success("操作成功!", weapp_url('Demo/Demo/conf'));
                }
            }
            $this->error("操作失败!");
        }

        $row = M('weapp')->where('code','eq','Demo')->find();
        $this->assign('row', $row);

        return $this->fetch('conf');
    }
}