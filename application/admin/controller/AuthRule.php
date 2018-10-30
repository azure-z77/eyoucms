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

namespace app\admin\controller;

use think\Page;
use think\Db;
use app\admin\logic\AuthModularLogic;

class AuthRule extends Base {
    
    /**
     * 权限资源列表
     */
    public function index()
    {
        $keywords = I('keywords/s');
        $modular_id = I('modular_id/d');
        $map = array();
        $selected = 0;

        if ($modular_id) {
            $map['modular_id'] = $modular_id;
            $selected = $modular_id;
        }
        if ($keywords) {
            $map['name|right'] = array('like',"%$keywords%");
        }

        $authRule =  M('auth_rule');     
        $count = $authRule->where($map)->count();// 查询满足要求的总记录数
        $Page = new Page($count,10);// 实例化分页类 传入总记录数和每页显示的记录数
        $list = $authRule->where($map)->order('id DESC')->limit($Page->firstRow.','.$Page->listRows)->select();

        $show = $Page->show();// 分页显示输出
        $this->assign('page',$show);// 赋值分页输出
        $this->assign('list',$list);// 赋值数据集
        $this->assign('pager',$Page);// 赋值分页集

        /**
         * 全部模块列表
         */
        $authModularLogic = new AuthModularLogic();
        $select_html = $authModularLogic->auth_modular_list(0, $selected, true);
        $this->assign('select_html',$select_html);

        /**
         * 指定模块列表
         */
        $modular_ids = array_keys(convert_arr_key($list, 'modular_id'));
        $m_map = array(
            'id'    => array('IN', $modular_ids),
        );
        $modular = M('auth_modular')->field('id,name')->where($m_map)->getAllWithIndex('id');
        $modular[0]['name'] = '';
        $this->assign('modular',$modular);// 赋值数据集

        return $this->fetch();
    }
    
    /**
     * 添加权限资源
     */
    public function add()
    {
        if (IS_POST) {
            $data = I('post.', null, 'trim');
            $data['right'] = implode(',',$data['right']);
            if(M('auth_rule')->where(array('name'=>$data['name'], 'is_del'=>0))->count()>0){
                $this->error('该权限名称已存在，请检查',U('Admin/rule'));
            }
            $data['add_time'] = getTime();
            $r = M('auth_rule')->add($data);
            
            if($r){
                adminLog('新增权限');
                $this->success("操作成功!",U('Admin/rule'));
            }else{
                $this->error("操作失败!",U('Admin/rule'));
            }
            exit;
        }

        /**
         * 所属模块
         */
        $select_html = menu_select();
        $this->assign('select_html',$select_html);

        /**
         * 权限控制码
         */
        $planPath = APP_PATH.'admin/controller';
        $planList = array();
        $dirRes   = opendir($planPath);
        while($dir = readdir($dirRes))
        {
            if(!in_array($dir,array('.','..','.svn')))
            {
                $ctl = basename($dir,'.php');
                if (!in_array($ctl, config('uneed_check_controller'))) {
                    $planList[] = $ctl;
                }
            }
        }
        $this->assign('planList',$planList);
        $this->assign('power_operator',config('POWER_OPERATOR'));    

        return $this->fetch();
    }
    
    /**
     * 编辑权限资源
     */
    public function edit()
    {
        if(IS_POST){
            $data = I('post.', null, 'trim');
            $data['right'] = implode(',',$data['right']);
            if(!empty($data['id'])){
                $data['update_time'] = getTime();
                $r = M('auth_rule')->where(array('id'=>$data['id']))->save($data);
            }
            if($r){
                adminLog('编辑权限');
                $this->success("操作成功!",U('Admin/rule'));
            }else{
                $this->error("操作失败!",U('Admin/rule'));
            }
            exit;
        }

        $id = I('id/d');
        $selected = 0;
        if($id){
            $info = M('auth_rule')->where(array('id'=>$id))->find();
            $selected = $info['modular_id'];
            $info['right'] = explode(',', $info['right']);
            $this->assign('info',$info);
        }

        /**
         * 所属模块
         */
        $authModularLogic = new AuthModularLogic();
        $select_html = $authModularLogic->auth_modular_list(0, $selected, true);
        $this->assign('select_html',$select_html);

        /**
         * 权限控制码
         */
        $planPath = APP_PATH.'admin/controller';
        $planList = array();
        $dirRes   = opendir($planPath);
        while($dir = readdir($dirRes))
        {
            if(!in_array($dir,array('.','..','.svn')))
            {
                $ctl = basename($dir,'.php');
                if (!in_array($ctl, config('uneed_check_controller'))) {
                    $planList[] = $ctl;
                }
            }
        }
        $this->assign('planList',$planList);
        $this->assign('power_operator',config('POWER_OPERATOR'));  

        return $this->fetch();
    }
    
    /**
     * 删除权限
     */
    public function del()
    {
        $id_arr = I('del_id/a');
        $id_arr = eyIntval($id_arr);
        if(!empty($id_arr)){
            $r = M('auth_rule')->where("id",'IN',$id_arr)->delete();
            if($r){
                adminLog('删除权限');
                respose(array('status'=>1, 'msg'=>'删除成功'));
            }else{
                respose(array('status'=>0, 'msg'=>'删除失败'));
            }
        }else{
            respose(array('status'=>0, 'msg'=>'参数有误'));
        }
    }
     
    public function ajax_get_action()
    {
        $control = I('controller');
        $advContrl = get_class_methods("app\\admin\\controller\\".str_replace('.php','',$control));
        $baseContrl = get_class_methods('app\admin\controller\Base');
        $diffArray  = array_diff($advContrl,$baseContrl);
        asort($diffArray);
        $html = '';
        foreach ($diffArray as $val){
            if(false !== strpos($val,'ajax') || false !== strpos($val,'temp_') || in_array($val, config('uneed_check_action'))) {
                
            } else {
                $html .= "<option value='".$val."'>".$val."</option>";
            }
        }
        exit($html);
    }
}