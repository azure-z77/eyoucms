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

namespace weapp\Form\controller;

use think\Page;
use app\common\controller\Weapp;
use weapp\Form\model\FormModel;
use weapp\Form\model\FormAttrbute;
use weapp\Form\logic\FormLogic;
use app\admin\model\Field;
/**
 * 插件的控制器
 */
class Form extends Weapp
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
        $this->model = new FormModel;
        $this->logic = new FormLogic;

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
     * 插件前台展示 - show钩子方法
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
            $map['name'] = array('LIKE', "%{$keywords}%");
        }

        $count = db($this->model->name)->where($map)->count();// 查询满足要求的总记录数
        $pageObj = new Page($count, config('paginate.list_rows'));// 实例化分页类 传入总记录数和每页显示的记录数
        $list = db($this->model->name)->where($map)->limit($pageObj->firstRow.','.$pageObj->listRows)->select();
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
            $data = I('post.');
            $res = $this->logic->addForm($data);
            if ($res === true) {
                adminLog('新增'.$this->weappInfo['name'].'：'.$data['name']); // 写入操作日志
                $this->success("操作成功", weapp_url('Form/Form/index'));
            }else{
                $this->error("操作失败");
            }
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

                /*这里可以实现存储数据之前的额外逻辑 start*/

                /*--end*/

                /*处理LOGO的本地上传与远程*/
                $is_remote = !empty($post['is_remote']) ? $post['is_remote'] : 0; // 远程图片还是本地上传
                $logo = '';
                if ($is_remote == 1) {
                    $logo = $post['logo_remote']; // 远程链接
                } else {
                    $logo = $post['logo_local']; // 本地上传链接
                }
                $post['logo'] = $logo;
                /*--end*/

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
                    $this->success("操作成功!", weapp_url('Form/Form/index'));
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
        $id = I('del_id');
        $res = $this->logic->deleteForm($id);                    
        if($res === true){
            adminLog('删除'.$this->weappInfo['name'].'：'.$id);
            $this->success("操作成功!");
        }else{
            $this->error("操作失败!");
        }
    }

    public function attrbute()
    {
        $form_id = I('form_id');
        $form = FormModel::get($form_id);
        $list = FormAttrbute::all(['form_tag'=>$form['tag']]);

        $this->assign('form',$form);
        $this->assign('list',$list);

        return $this->fetch();
    }

    public function addAttrbute()
    {
        $form_tag = I('form_tag');
        if (IS_POST) {
            $data = I('post.');
            $res = $this->logic->addAttrbute($data);
            if ($res === true) {
                adminLog('新增'.$this->weappInfo['name'].'：'.$data['form_tag'].$data['attr_name']); // 写入操作日志
                $this->success("操作成功");
            }else{
                $this->error("操作失败");
            }
        }
        //字段类型列表
        $field = new Field();
        $fieldtype_list = $field->getFieldTypeAll('name,title,ifoption');

        $this->assign('form_tag',$form_tag);
        $this->assign('fieldtype_list',$fieldtype_list);
        return $this->fetch();
    }

    public function delAttrbute()
    {
        $id = I('del_id');
        $res = $this->logic->deleteAttrbute($id);                    
        if($res === true){
            adminLog('删除'.$this->weappInfo['name'].'：'.$id);
            $this->success("操作成功!");
        }else{
            $this->error("操作失败!");
        }
    }

}