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

class Uiset extends Base
{
    public $theme_style;
    public $templateArr = array();

    /*
     * 初始化操作
     */
    public function _initialize() {
        parent::_initialize();
        $this->theme_style = 'pc';

        /*模板列表*/
        if (file_exists(ROOT_PATH.'template/pc/uiset.txt')) {
            array_push($this->templateArr, 'pc');
        }
        if (file_exists(ROOT_PATH.'template/mobile/uiset.txt')) {
            array_push($this->templateArr, 'mobile');
        }
        /*--end*/

        /*权限控制 by 小虎哥*/
        $admin_info = session('admin_info');
        if (-1 != $admin_info['role_id']) {
            $auth_role_info = $admin_info['auth_role_info'];
            $permission = $auth_role_info['permission'];
            $auth_rule = get_auth_rule();
            $all_auths = []; // 系统全部权限对应的菜单ID
            $admin_auths = []; // 用户当前拥有权限对应的菜单ID
            $diff_auths = []; // 用户没有被授权的权限对应的菜单ID
            foreach($auth_rule as $key => $val){
                $all_auths = array_merge($all_auths, explode(',', $val['menu_id']), explode(',', $val['menu_id2']));
                if (in_array($val['id'], $permission['rules'])) {
                    $admin_auths = array_merge($admin_auths, explode(',', $val['menu_id']), explode(',', $val['menu_id2']));
                }
            }
            $all_auths = array_unique($all_auths);
            $admin_auths = array_unique($admin_auths);
            $diff_auths = array_diff($all_auths, $admin_auths);

            if(in_array(2002, $diff_auths)){
                $this->error('您没有操作权限，请联系超级管理员分配权限');
            }
        }
        /*--end*/
    }

    /**
     * PC调试外观
     */
    public function pc()
    {
        $index_url = url('home/Index/index', array('uiset'=>'on', 'v'=>'pc'));
        // 自动隐藏index.php入口文件
        $index_url = auto_hide_index($index_url);
        header('Location: '.$index_url);
        exit;
    }

    /**
     * 手机调试外观
     */
    public function mobile()
    {
        $index_url = url('home/Index/index', array('uiset'=>'on', 'v'=>'mobile'));
        // 自动隐藏index.php入口文件
        $index_url = auto_hide_index($index_url);
        header('Location: '.$index_url);
        exit;
    }

    /**
     * 调试外观
     */
    public function index()
    {
        return $this->fetch();
    }

    /**
     * 数据列表
     */
    public function ui_index()
    {
        $condition = array();
        // 获取到所有GET参数
        $param = I('param.');
        /*模板主题*/
        $param['theme_style'] = $this->theme_style = I('param.theme_style/s', 'pc');
        /*--end*/

        // 应用搜索条件
        foreach (['keywords','theme_style'] as $key) {
            if (isset($param[$key]) && $param[$key] !== '') {
                if ($key == 'keywords') {
                    $condition['a.page|a.type|a.name'] = array('eq', "%{$param[$key]}%");
                } else {
                    $condition['a.'.$key] = array('eq', $param[$key]);
                }
            }
        }

        $list = array();

        $uiconfigM =  M('ui_config');
        $count = $uiconfigM->alias('a')->where($condition)->count('id');// 查询满足要求的总记录数
        $Page = $pager = new Page($count, config('paginate.list_rows'));// 实例化分页类 传入总记录数和每页显示的记录数
        $list = $uiconfigM->alias('a')->where($condition)->order('id desc')->limit($Page->firstRow.','.$Page->listRows)->select();

        $show = $Page->show();// 分页显示输出
        $this->assign('page',$show);// 赋值分页输出
        $this->assign('list',$list);// 赋值数据集
        $this->assign('pager',$pager);// 赋值分页对象
        $this->assign('theme_style',$this->theme_style);// 模板主题
        $this->assign('templateArr',$this->templateArr);// 模板列表

        return $this->fetch();
    }
    
    /**
     * 删除
     */
    public function del()
    {
        $id_arr = I('del_id/a');
        $id_arr = eyIntval($id_arr);
        if(!empty($id_arr)){
            $result = M('ui_config')->where("id",'IN',$id_arr)->getAllWithIndex('name');
            $r = M('ui_config')->where("id",'IN',$id_arr)->delete();
            if($r){
                \think\Cache::clear('ui_config');
                delFile(RUNTIME_PATH.'ui/'.$this->theme_style);
                adminLog('删除可视化数据 e-id：'.implode(array_keys($result)));
                respose(array('status'=>1, 'msg'=>'删除成功'));
            }else{
                respose(array('status'=>0, 'msg'=>'删除失败'));
            }
        }else{
            respose(array('status'=>0, 'msg'=>'参数有误'));
        }
    }
}