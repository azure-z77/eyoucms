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
use think\Validate;
use app\admin\logic\AuthRoleLogic;

class AuthRole extends Base {
    
    /**
     * 角色管理
     */
    public function index()
    {   
        $map = array();
        $pid = I('pid/d');
        $keywords = I('keywords/s');

        if (!empty($keywords)) {
            $map['c.name'] = array('LIKE', "%{$keywords}%");
        }

        $AuthRole =  M('auth_role');     
        $count = $AuthRole->alias('c')->where($map)->count();// 查询满足要求的总记录数
        $Page = new Page($count, 10);// 实例化分页类 传入总记录数和每页显示的记录数
        $fields = "c.*,s.name AS pname";
        $list = DB::name('auth_role')
            ->field($fields)
            ->alias('c')
            ->join('__AUTH_ROLE__ s','s.id = c.pid','LEFT')
            ->where($map)
            ->order('c.id asc')
            ->limit($Page->firstRow.','.$Page->listRows)
            ->select();
        $show = $Page->show();// 分页显示输出
        $this->assign('page',$show);// 赋值分页输出
        $this->assign('list',$list);// 赋值数据集
        $this->assign('pager',$Page);// 赋值分页集

        return $this->fetch();
    }
    
    /**
     * 新增角色
     */
    public function add()
    {
        if (IS_POST) {
            $rule = array(
                'name'  => 'require',
            );
            $msg = array(
                'name.require' => '角色名称不能为空！',
            );
            $data = array(
                'name' => trim(I('name/s')),
            );
            $validate = new Validate($rule, $msg);
            $result   = $validate->check($data);
            if(!$result){
                $this->error($validate->getError());
            }

            $model = model('AuthRole');
            $count = $model->where('name', $data['name'])->count();
            if(! empty($count)){
                $this->error('该角色名称已存在，请检查');
            }
            $rs = $model->saveAuthRole(input());
            if($rs){
                adminLog('新增角色：'.$data['name']);
                $this->success('操作成功', U('AuthRole/index'));
            }else{
                $this->error('操作失败');
            }


            // $res = I('post.', null, 'trim');
            // if (empty($res['rule_ids'])) {
            //     $this->error("请选择权限分配！");
            // }

            // $auth_role = Db::name('auth_role')->where(['name'=>$res['name']])->find();
            // if ($auth_role) {
            //     $this->error("已存在相同的角色名称！");
            // } else {
            //     // 新增角色表
            //     $role_info = Db::name('auth_role')->where(['id'=>$res['pid']])->find();
            //     $grade = 0;
            //     if ($role_info) {
            //         $grade = $role_info['grade'] + 1;
            //     }
            //     $role_data = array(
            //         'name'      => $res['name'],
            //         'pid'       => $res['pid'],
            //         'grade'     => $grade,
            //         'remark'    => $res['remark'],
            //         'add_time'  => getTime(),
            //     );
            //     $role_id = M('auth_role')->insertGetId($role_data);

            //     // 新增角色权限表
            //     $r = false;
            //     if ($role_id) {
            //         $access_data = array();
            //         foreach ($res['rule_ids'] as $key => $val) {
            //             $access_data[] = array(
            //                 'role_id'   => $role_id,
            //                 'rule_id'   => $val,
            //             );
            //         }
            //         $r = M('auth_access')->insertAll($access_data);
            //     }
            // }

            // if($r){
            //     extra_cache('admin_auth_role_list_logic', NULL);
            //     adminLog('新增角色');
            //     $this->success("操作成功!",U('Admin/role'));
            // }else{
            //     $this->error("操作失败!",U('Admin/role'));
            // }
        }

        // 权限分组
        $modules = getAllMenu();
        $this->assign('modules', $modules);

        // 权限集
        // $singleArr = array_multi2single($modules, 'child'); // 多维数组转为一维
        $auth_rules = get_conf('auth_rule');
        $auth_rule_list = group_same_key($auth_rules, 'menu_id');
        $this->assign('auth_rule_list', $auth_rule_list);

        // 栏目
        $arctype_data = $arctype_array = array();
        $arctype = M('arctype')->select();
        if(! empty($arctype)){
            foreach ($arctype as $item){
                if($item['parent_id'] <= 0){
                    $arctype_data[] = $item;
                }
                $arctype_array[$item['parent_id']][] = $item;
            }
        }
        $this->assign('arctypes', $arctype_data);
        $this->assign('arctype_array', $arctype_array);

        // 插件
        $plugins = model('Weapp')->getList(['status'=>1]);
        $this->assign('plugins', $plugins);

        return $this->fetch();

        // /* 角色ID */
        // if (session('?admin_info') && session('admin_info.role_id') == -1){
        //     $role_id = 0;
        // } else {
        //     $role_id = session('admin_info.role_id');
        // }

        // /**
        //  * 当前管理员的所有下级
        //  */
        // $select_html = '';
        // $authRoleLogic = new AuthRoleLogic();
        // $select_html = $authRoleLogic->auth_role_list($role_id, 0, true);
        // $this->assign('select_html', $select_html);

        // /**
        //  * 当前账号下的模块及权限
        //  */
        // $map = array();
        // if ($role_id > 0){
        //     $access_list = M('auth_access')->where("role_id = {$role_id}")->getAllWithIndex('rule_id');
        //     $map['id'] = array('IN', array_keys($access_list));
        // }
        // $map['is_del'] = 0;
        // $list = M('auth_rule')->field('id,modular_id,name')->where($map)->order('id')->select();
        // foreach ($list as $val){
        //     $rule_list[$val['modular_id']][$val['id']] = $val;
        // }
        // $authModularLogic = new AuthModularLogic();
        // $options = $authModularLogic->auth_modular_list(0, 0, false);
        // $modules = $this->temp_convert_arr($options, $rule_list);
        // $this->assign('modules',$modules);

        // return $this->fetch();
    }

    // public function temp_convert_arr($options, $rule_list)
    // {
    //     $data = array();

    //     /**
    //      * 将最底层的子类归于上一级父类
    //      */
    //     foreach ($options as $key => $val) {
    //         if (0 < $val['grade']) {
    //             if (1 < $val['grade']) {
    //                 if (isset($data[$val['parent_id']])) {
    //                     $child = isset($rule_list[$val['id']]) ? $rule_list[$val['id']] : array();
    //                     if ($data[$val['parent_id']]['yes_child'] == 0 && !empty($child)) {
    //                         $data[$val['parent_id']]['yes_child'] = 1;
    //                     }
    //                     if (!empty($child)) {
    //                         $data[$val['parent_id']]['child'][$val['id']] = array(
    //                             'id'        => $val['id'],
    //                             'parent_id' => $val['parent_id'],
    //                             'name'      => $val['name'],
    //                             'grade'     => $val['grade'],
    //                             'child'     => $child,
    //                         );
    //                     }
    //                 }
    //             } else {
    //                 $data[$val['id']] = array(
    //                     'id'        => $val['id'],
    //                     'parent_id' => $val['parent_id'],
    //                     'name'      => $val['name'],
    //                     'grade'     => $val['grade'],
    //                     'yes_child' => 0,
    //                     'child'     => array(),
    //                 );
    //             }
    //             unset($options[$key]);
    //         }
    //     }

    //     /**
    //      * 将子类归于上一级父类
    //      */
    //     $data0 = array();
    //     foreach ($data as $d_k => $d_v) {
    //         if ($d_v['yes_child'] == 1) {
    //             $data0[$d_v['parent_id']][$d_v['id']] = $d_v;
    //         }
    //     }

    //     /**
    //      * 将子类归于顶级父类
    //      */
    //     $arr = array();
    //     foreach ($options as $key => $val) {
    //         if (0 == $val['parent_id'] && isset($data0[$val['id']])) {
    //             $yes_child = 0;
    //             foreach ($data0[$val['id']] as $sk => $sv) {
    //                 if ($sv['yes_child'] == 1) {
    //                     $yes_child = $sv['yes_child'];
    //                 }
    //             }
    //             $arr[$val['id']] = array(
    //                 'id'        => $val['id'],
    //                 'parent_id' => $val['parent_id'],
    //                 'name'      => $val['name'],
    //                 'grade'     => $val['grade'],
    //                 'yes_child' => $yes_child,
    //                 'child'     => $data0[$val['id']],
    //             );
    //         }
    //         unset($options[$key]);
    //     }

    //     /**
    //      * 移除没有权限的模块
    //      */
    //     foreach ($arr as $ak => $av) {
    //         if ($av['yes_child'] == 0) {
    //             unset($arr[$ak]);
    //         }
    //     }

    //     if ($arr) {
    //         $data = $arr;
    //     }

    //     return $data;
    // }
    
    public function edit()
    {
        $id = I('id/d', 0);
        if($id <= 0){
            $this->error('非法访问');
        }

        if (IS_POST) {
            $rule = array(
                'name'  => 'require',
            );
            $msg = array(
                'name.require' => '角色名称不能为空！',
            );
            $data = array(
                'name' => trim(I('name/s')),
            );
            $validate = new Validate($rule, $msg);
            $result   = $validate->check($data);
            if(!$result){
                $this->error($validate->getError());
            }

            $model = model('AuthRole');
            $count = $model->where('name', $data['name'])
                ->where('id', '<>', $id)
                ->count();
            if(! empty($count)){
                $this->error('该角色名称已存在，请检查');
            }
            $rs = $model->saveAuthRole(input(), true);
            if($rs){
                adminLog('编辑角色：'.$data['name']);
                $this->success('操作成功', U('AuthRole/index'));
            }else{
                $this->error('操作失败');
            }

            // $res = I('post.', null ,'trim');
            // $role_id = $res['id'];
            // if (empty($res['rule_ids'])) {
            //     $this->error("请选择权限分配！");
            // }

            // $auth_role = Db::name('auth_role')->where(['name'=>$res['name'],'id'=>['<>',$role_id]])->find();
            // if ($auth_role) {
            //     $this->error("已存在相同的角色名称！");
            // } else {
            //     // 编辑角色表
            //     $role_info = Db::name('auth_role')->where(['id'=>$res['pid']])->find();
            //     $grade = 0;
            //     if ($role_info) {
            //         $grade = $role_info['grade'] + 1;
            //     }
            //     $role_data = array(
            //         'name'      => $res['name'],
            //         'pid'       => $res['pid'],
            //         'grade'     => $grade,
            //         'remark'    => $res['remark'],
            //         'update_time'  => getTime(),
            //     );
            //     $role_update = M('auth_role')->where('id', $role_id)->save($role_data);
                
            //     // 新增角色权限表
            //     $r = false;
            //     if ($role_update) {
            //         M('auth_access')->where('role_id', $role_id)->delete();
            //         $access_data = array();
            //         foreach ($res['rule_ids'] as $key => $val) {
            //             $access_data[] = array(
            //                 'role_id'   => $role_id,
            //                 'rule_id'   => $val,
            //             );
            //         }
            //         $r = M('auth_access')->insertAll($access_data);
            //     }
            // }

            // if($r){
            //     extra_cache('admin_auth_role_list_logic', NULL);
            //     adminLog('编辑角色');
            //     $this->success("操作成功!",U('Admin/role'));
            // }else{
            //     $this->error("操作失败!",U('Admin/role'));
            // }
        }

        $model = model('AuthRole');
        $info = $model->getRole(array('id' => $id));
        if(empty($info)){
            $this->error('数据不存在，请联系管理员！');
        }
        $this->assign('info', $info);

        // 权限分组
        $modules = getAllMenu();
        $this->assign('modules', $modules);

        // 权限集
        $auth_rules = get_conf('auth_rule');
        $auth_rule_list = group_same_key($auth_rules, 'menu_id');
        $this->assign('auth_rule_list', $auth_rule_list);

        // 栏目
        $arctype_data = $arctype_array = array();
        $arctype = M('arctype')->select();
        if(! empty($arctype)){
            foreach ($arctype as $item){
                if($item['parent_id'] <= 0){
                    $arctype_data[] = $item;
                }
                $arctype_array[$item['parent_id']][] = $item;
            }
        }
        $this->assign('arctypes', $arctype_data);
        $this->assign('arctype_array', $arctype_array);

        // 插件
        $plugins = model('Weapp')->getList(['status'=>1]);
        $this->assign('plugins', $plugins);

        return $this->fetch();

        // $id = I('get.id/d');
        // $info = array();
        // if($id){
        //     $info = M('auth_role')->where("id",$id)->find();
        // }
        // $this->assign('info',$info);

        // /* 角色ID */
        // if (session('?admin_info') && session('admin_info.role_id') == -1){
        //     $role_id = 0;
        // } else {
        //     $role_id = session('admin_info.role_id');
        // }

        // /**
        //  * 当前管理员的所有下级
        //  */
        // $select_html = '';
        // $selected = $info['pid'];
        // $authRoleLogic = new AuthRoleLogic();
        // $select_html = $authRoleLogic->auth_role_list($role_id, $selected, true);
        // $this->assign('select_html', $select_html);

        // /**
        //  * 当前角色下分配的权限
        //  */
        // $access_list = M('auth_access')->where("role_id",$id)->getAllWithIndex('rule_id');
        // $this->assign('access_list',$access_list);
        
        // /**
        //  * 全部模块及权限
        //  */
        // $map = array();
        // if ($role_id > 0){
        //     $map['id'] = array('IN', array_keys($access_list));
        // }
        // $map['is_del'] = 0;
        // $list = M('auth_rule')->field('id,modular_id,name')->where($map)->order('id')->select();
        // foreach ($list as $val){
        //     $rule_list[$val['modular_id']][$val['id']] = $val;
        // }
        // $authModularLogic = new AuthModularLogic();
        // $options = $authModularLogic->auth_modular_list(0, 0, false);
        // $modules = $this->temp_convert_arr($options, $rule_list);
        // $this->assign('modules',$modules);

        // return $this->fetch();
    }
    
    public function del()
    {
        $id_arr = I('del_id/a');
        $id_arr = eyIntval($id_arr);
        if (!empty($id_arr)) {
            $role = M('auth_role')->where("pid",'IN',$id_arr)->select();
            if ($role) {
                respose(array('status'=>0, 'msg'=>'请先清空该角色下的子角色'));
            }

            $role_admin = M('admin')->where("role_id",'IN',$id_arr)->select();
            if ($role_admin) {
                respose(array('status'=>0, 'msg'=>'请先清空所属该角色的管理员'));
            } else {
                $r = M('auth_role')->where("id",'IN',$id_arr)->delete();
                if($r){
                    adminLog('删除角色');
                    respose(array('status'=>1, 'msg'=>'删除成功'));
                }else{
                    respose(array('status'=>0, 'msg'=>'删除失败'));
                }
            }
        } else {
            respose(array('status'=>0, 'msg'=>'参数有误'));
        }
    }
}