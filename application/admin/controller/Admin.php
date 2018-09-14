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
use think\Verify;
use think\Db;
use think\db\Query;
use think\Session;
use app\admin\logic\AuthModularLogic;
use app\admin\logic\AuthRoleLogic;

class Admin extends Base {
    private $modular_system_id = array(); // 系统默认的模块id，不可删除
    private $admin_system_id = array(1); // 系统默认的管理员ID，不可删除

    public function index()
    {
        $list = array();
        $keywords = I('keywords/s');

        $map = array();
        $mapOr = array();
        if (!empty($keywords)) {
            $map['a.user_name|a.true_name'] = array('LIKE', "%{$keywords}%");
        }
        if (session('?admin_id') && session('admin_info.role_id') > 0) {
            $role_ids = M('auth_role')->where("pid", session('admin_info.role_id'))->getField('id',true);
            $map['b.role_id'] = array('IN', $role_ids);
            $mapOr['a.admin_id'] = session('admin_id');
        }

        $Admin =  M('admin');
        $count = $Admin->field('a.admin_id')
            ->alias('a')
            ->join('__AUTH_ROLE_ADMIN__ b', 'a.admin_id = b.admin_id', 'LEFT')
            ->where($map)
            ->whereOr($mapOr)
            ->count();// 查询满足要求的总记录数
        $Page = new Page($count,10);// 实例化分页类 传入总记录数和每页显示的记录数
        $list = $Admin->field('a.*, b.role_id, a.admin_id')
            ->alias('a')
            ->join('__AUTH_ROLE_ADMIN__ b', 'a.admin_id = b.admin_id', 'LEFT')
            ->where($map)
            ->whereOr($mapOr)
            ->order('a.admin_id desc')
            ->limit($Page->firstRow.','.$Page->listRows)
            ->select();

        /**
         * 角色列表
         */
        $admin_ids = array_keys(convert_arr_key($list, 'admin_id'));
        $fields = "c.role_id, c.admin_id, s.name AS role_name";
        $role_admin_list = DB::name('auth_role_admin')
            ->field($fields)
            ->alias('c')
            ->join('__AUTH_ROLE__ s','s.id = c.role_id','LEFT')
            ->where(array('c.admin_id'=>array('IN', $admin_ids)))
            ->getAllWithIndex('admin_id');

        foreach ($list as $key => $val) {
            $role_name = '游客';
            $role_id = 0;
            if (isset($role_admin_list[$val['admin_id']])) {
                $role_id = $role_admin_list[$val['admin_id']]['role_id'];
                $role_name = $role_admin_list[$val['admin_id']]['role_name'];
            }

            $val['role_id'] = $role_id;
            $val['role_name'] = ($role_id == -1) ? '超级管理员' : $role_name;
            $list[$key] = $val;
        }

        $show = $Page->show();// 分页显示输出
        $this->assign('page',$show);// 赋值分页输出
        $this->assign('list',$list);// 赋值数据集
        $this->assign('pager',$Page);// 赋值分页集
        return $this->fetch();
    }

    /*
     * 管理员登陆
     */
    public function login()
    {
        if (session('?admin_id') && session('admin_id') > 0) {
             $this->success("您已登录", request()->baseFile());
        }
      
        if (IS_POST) {
            $verify = new Verify();
            if (!$verify->check(I('post.vertify'), "admin_login")) {
                exit(json_encode(array('status'=>0,'msg'=>'验证码错误')));
            }
            $condition['user_name'] = I('post.username/s');
            $condition['password'] = I('post.password/s');
            if (!empty($condition['user_name']) && !empty($condition['password'])) {
                $condition['password'] = func_encrypt($condition['password']);
                $admin_info = M('admin')->where($condition)->find();
                if (is_array($admin_info)) {
                    if ($admin_info['status'] == 0) {
                        exit(json_encode(array('status'=>0,'msg'=>'账号被禁用！')));
                    }

                    $access_list = M('auth_role_admin')
                        ->field("a.admin_id, a.role_id, b.name AS role_name, c.rule_id")
                        ->alias('a')
                        ->join('__AUTH_ROLE__ b', 'b.id = a.role_id','LEFT')
                        ->join('__AUTH_ACCESS__ c', 'c.role_id = a.role_id','LEFT')
                        ->where('a.admin_id','eq', $admin_info['admin_id'])
                        ->select();
                    $act_list = array();
                    $role_id = 0;
                    $role_name = '';
                    foreach ($access_list as $key => $val) {
                        array_push($act_list, $val['rule_id']);
                        $role_id = $val['role_id'];
                        $role_name = $val['role_name'];
                    }
                    $admin_info['act_list'] = $act_list;
                    $admin_info['role_id'] = $role_id;
                    $admin_info['role_name'] = $role_id == -1 ? '超级管理员' : $role_name;

                    $last_login_time = getTime();
                    $last_login_ip = clientIP();
                    $login_cnt = $admin_info['login_cnt'] + 1;
                    M('admin')->where("admin_id = ".$admin_info['admin_id'])->save(array('last_login'=>$last_login_time, 'last_ip'=>$last_login_ip, 'login_cnt'=>$login_cnt, 'session_id'=>$this->session_id));
                    $admin_info['last_login'] = $last_login_time;
                    $admin_info['last_ip'] = $last_login_ip;

                    session('admin_id',$admin_info['admin_id']);
                    session('admin_info', $admin_info);
                    adminLog('后台登录');
                    $url = session('from_url') ? session('from_url') : request()->baseFile();
                    exit(json_encode(array('status'=>1,'url'=>$url)));
                } else {
                    exit(json_encode(array('status'=>0,'msg'=>'账号密码不正确')));
                }
            } else {
                exit(json_encode(array('status'=>0,'msg'=>'请填写账号密码')));
            }
        }

       return $this->fetch();
    }

    /**
     * 验证码获取
     */
    public function vertify()
    {
        $config = array(
            'fontSize' => 30,
            'length' => 4,
            'useCurve' => false,
            'useNoise' => false,
            'reset' => false,
            'fontttf' => '6.ttf',
        );    
        ob_clean(); // 清空缓存，才能显示验证码
        $Verify = new Verify($config);
        $Verify->entry('admin_login');
        exit();
    }
    
    /**
     * 修改管理员密码
     * @return \think\mixed
     */
    public function admin_pwd()
    {
        $admin_id = I('admin_id/d',0);
        $oldPwd = I('old_pw/s');
        $newPwd = I('new_pw/s');
        $new2Pwd = I('new_pw2/s');
       
        if(!$admin_id){
            $admin_id = session('admin_id');
        }
        $info = M('admin')->where("admin_id", $admin_id)->find();
        $info['password'] =  "";
        $this->assign('info',$info);
        
        if(IS_POST){
            //修改密码
            $enOldPwd = func_encrypt($oldPwd);
            $enNewPwd = func_encrypt($newPwd);
            $admin = M('admin')->where('admin_id' , $admin_id)->find();
            if(!$admin || $admin['password'] != $enOldPwd){
                exit(json_encode(array('status'=>-1,'msg'=>'旧密码不正确')));
            }else if($newPwd != $new2Pwd){
                exit(json_encode(array('status'=>-1,'msg'=>'两次密码不一致')));
            }else{
                $data = array(
                    'update_time'   => getTime(),
                    'password'      => $enNewPwd,
                );
                $row = M('admin')->where('admin_id' , $admin_id)->save($data);
                if($row){
                    adminLog('修改管理员密码');
                    exit(json_encode(array('status'=>1,'msg'=>'操作成功')));
                }else{
                    exit(json_encode(array('status'=>-1,'msg'=>'操作失败')));
                }
            }
        }

        if (IS_AJAX) {
            return $this->fetch('admin/admin_pwd_ajax');
        } else {
            return $this->fetch('admin/admin_pwd');
        }
    }
    
    /**
     * 退出登陆
     */
    public function logout()
    {
        adminLog('安全退出');
        session_unset();
        session::clear();
        session_destroy();
        $this->success("安全退出", request()->baseFile());
    }
    
    /**
     * 新增管理员
     */
    public function admin_add()
    {
        if (IS_POST) {
            $data = I('post.');
            $data['user_name'] = trim($data['user_name']);
            $data['password'] = func_encrypt($data['password']);
            $data['add_time'] = getTime();
            if (M('admin')->where("user_name", $data['user_name'])->count()) {
                $this->error("此用户名已被注册，请更换",U('Admin/admin_add'));
            } else {
                $role_id = $data['role_id'];
                unset($data['role_id']);

                $admin_id = M('admin')->insertGetId($data);
                $r = false;
                if ($admin_id) {
                    $role_admin_data = array(
                        'role_id'   => $role_id,
                        'admin_id'  => $admin_id,
                    );
                    $r = M('auth_role_admin')->insert($role_admin_data);
                }

                if ($r) {
                    adminLog('新增管理员');
                    $this->success("操作成功",U('Admin/index'));
                } else {
                    $this->error("操作失败",U('Admin/index'));
                }
            }
        }

        /**
         * 当前管理员的所有下级
         */
        $select_html = '';
        if (session('?admin_info') && session('admin_info.role_id') == -1) {
            $role_id = 0;
        } else {
            $role_id = session('admin_info.role_id');
        }
        $authRoleLogic = new AuthRoleLogic();
        $select_html = $authRoleLogic->auth_role_list($role_id, 0, true);
        $this->assign('select_html', $select_html);

        return $this->fetch();
    }
    
    /**
     * 编辑管理员
     */
    public function admin_edit()
    {
        if (IS_POST) {
            $data = I('post.');
            $id = $data['admin_id'];
            if(empty($data['password'])){
                unset($data['password']);
            }else{
                $data['password'] = func_encrypt($data['password']);
            }
            unset($data['user_name']);

            if (session('admin_id') == $id) {
                $role_id = session('admin_info.role_id');
            } else {
                $role_id = $data['role_id'];
                unset($data['role_id']);
            }

            $data['update_time'] = getTime();
            $admin_update = M('admin')->where('admin_id', $id)->save($data);
            $r = false;
            if ($admin_update) {
                M('auth_role_admin')->where('admin_id', $id)->delete();
                $role_admin_data = array(
                    'role_id'   => $role_id,
                    'admin_id'  => $id,
                );
                $r = M('auth_role_admin')->insert($role_admin_data);
            }

            if ($r) {
                adminLog('编辑管理员');
                $this->success("操作成功",U('Admin/index'));
            } else {
                $this->error("操作失败",U('Admin/index'));
            }
        }

        $id = I('get.id/d', 0);
        $info = M('admin')->field('a.*, b.*, a.admin_id')
            ->alias('a')
            ->join('__AUTH_ROLE_ADMIN__ b', 'a.admin_id = b.admin_id', 'LEFT')
            ->where("a.admin_id", $id)->find();
        $info['password'] =  "";
        $this->assign('info',$info);

        /**
         * 当前登录管理员的所有下级
         */
        $select_html = '';
        $selected = $info['role_id'];
        if (session('?admin_info') && session('admin_info.role_id') == -1) {
            $role_id = 0;
        } else {
            $role_id = session('admin_info.role_id');
        }
        $authRoleLogic = new AuthRoleLogic();
        $select_html = $authRoleLogic->auth_role_list($role_id, $selected, true);
        $this->assign('select_html', $select_html);

        return $this->fetch();
    }
    
    /**
     * 删除管理员
     */
    public function admin_del()
    {
        if (IS_POST) {
            $id_arr = I('del_id/a');
            $id_arr = eyIntval($id_arr);
            if (in_array(session('admin_id'), $id_arr)) {
                respose(array('status'=>0, 'msg'=>'禁止删除自己'));
            }
            if (!empty($id_arr)) {
                $count = M('admin')->field('a.admin_id')
                    ->alias('a')
                    ->join('__AUTH_ROLE_ADMIN__ b', 'a.admin_id = b.admin_id', 'LEFT')
                    ->where("a.admin_id in (".implode(',', $id_arr).") AND a.admin_id = 1")
                    // ->where("a.admin_id in ($id) AND b.role_id = -1")
                    ->count();
                if ($count > 0) {
                    respose(array('status'=>0, 'msg'=>'禁止删除超级管理员'));
                }

                $r = M('admin')->where("admin_id",'IN',$id_arr)->delete();
                if($r){
                    M('auth_role_admin')->where("admin_id",'IN',$id_arr)->delete();
                    adminLog('删除管理员');
                    respose(array('status'=>1, 'msg'=>'删除成功'));
                }else{
                    respose(array('status'=>0, 'msg'=>'删除失败'));
                }
            }else{
                respose(array('status'=>0, 'msg'=>'参数有误'));
            }
        }
    }
    
    /**
     * 角色管理
     */
    public function role()
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
    public function role_add()
    {
        if (IS_POST) {
            $res = I('post.', null, 'trim');
            if (empty($res['rule_ids'])) {
                $this->error("请选择权限分配！");
            }

            $auth_role = Db::name('auth_role')->where(['name'=>$res['name']])->find();
            if ($auth_role) {
                $this->error("已存在相同的角色名称！");
            } else {
                // 新增角色表
                $role_info = Db::name('auth_role')->where(['id'=>$res['pid']])->find();
                $grade = 0;
                if ($role_info) {
                    $grade = $role_info['grade'] + 1;
                }
                $role_data = array(
                    'name'      => $res['name'],
                    'pid'       => $res['pid'],
                    'grade'     => $grade,
                    'remark'    => $res['remark'],
                    'add_time'  => getTime(),
                );
                $role_id = M('auth_role')->insertGetId($role_data);

                // 新增角色权限表
                $r = false;
                if ($role_id) {
                    $access_data = array();
                    foreach ($res['rule_ids'] as $key => $val) {
                        $access_data[] = array(
                            'role_id'   => $role_id,
                            'rule_id'   => $val,
                        );
                    }
                    $r = M('auth_access')->insertAll($access_data);
                }
            }

            if($r){
                extra_cache('admin_auth_role_list_logic', NULL);
                adminLog('新增角色');
                $this->success("操作成功!",U('Admin/role'));
            }else{
                $this->error("操作失败!",U('Admin/role'));
            }
        }

        /* 角色ID */
        if (session('?admin_info') && session('admin_info.role_id') == -1){
            $role_id = 0;
        } else {
            $role_id = session('admin_info.role_id');
        }

        /**
         * 当前管理员的所有下级
         */
        $select_html = '';
        $authRoleLogic = new AuthRoleLogic();
        $select_html = $authRoleLogic->auth_role_list($role_id, 0, true);
        $this->assign('select_html', $select_html);

        /**
         * 当前账号下的模块及权限
         */
        $map = array();
        if ($role_id > 0){
            $access_list = M('auth_access')->where("role_id = {$role_id}")->getAllWithIndex('rule_id');
            $map['id'] = array('IN', array_keys($access_list));
        }
        $map['is_del'] = 0;
        $list = M('auth_rule')->field('id,modular_id,name')->where($map)->order('id')->select();
        foreach ($list as $val){
            $rule_list[$val['modular_id']][$val['id']] = $val;
        }
        $authModularLogic = new AuthModularLogic();
        $options = $authModularLogic->auth_modular_list(0, 0, false);
        $modules = $this->temp_convert_arr($options, $rule_list);
        $this->assign('modules',$modules);

        return $this->fetch();
    }

    public function temp_convert_arr($options, $rule_list)
    {
        $data = array();

        /**
         * 将最底层的子类归于上一级父类
         */
        foreach ($options as $key => $val) {
            if (0 < $val['grade']) {
                if (1 < $val['grade']) {
                    if (isset($data[$val['parent_id']])) {
                        $child = isset($rule_list[$val['id']]) ? $rule_list[$val['id']] : array();
                        if ($data[$val['parent_id']]['yes_child'] == 0 && !empty($child)) {
                            $data[$val['parent_id']]['yes_child'] = 1;
                        }
                        if (!empty($child)) {
                            $data[$val['parent_id']]['child'][$val['id']] = array(
                                'id'        => $val['id'],
                                'parent_id' => $val['parent_id'],
                                'name'      => $val['name'],
                                'grade'     => $val['grade'],
                                'child'     => $child,
                            );
                        }
                    }
                } else {
                    $data[$val['id']] = array(
                        'id'        => $val['id'],
                        'parent_id' => $val['parent_id'],
                        'name'      => $val['name'],
                        'grade'     => $val['grade'],
                        'yes_child' => 0,
                        'child'     => array(),
                    );
                }
                unset($options[$key]);
            }
        }

        /**
         * 将子类归于上一级父类
         */
        $data0 = array();
        foreach ($data as $d_k => $d_v) {
            if ($d_v['yes_child'] == 1) {
                $data0[$d_v['parent_id']][$d_v['id']] = $d_v;
            }
        }

        /**
         * 将子类归于顶级父类
         */
        $arr = array();
        foreach ($options as $key => $val) {
            if (0 == $val['parent_id'] && isset($data0[$val['id']])) {
                $yes_child = 0;
                foreach ($data0[$val['id']] as $sk => $sv) {
                    if ($sv['yes_child'] == 1) {
                        $yes_child = $sv['yes_child'];
                    }
                }
                $arr[$val['id']] = array(
                    'id'        => $val['id'],
                    'parent_id' => $val['parent_id'],
                    'name'      => $val['name'],
                    'grade'     => $val['grade'],
                    'yes_child' => $yes_child,
                    'child'     => $data0[$val['id']],
                );
            }
            unset($options[$key]);
        }

        /**
         * 移除没有权限的模块
         */
        foreach ($arr as $ak => $av) {
            if ($av['yes_child'] == 0) {
                unset($arr[$ak]);
            }
        }

        if ($arr) {
            $data = $arr;
        }

        return $data;
    }
    
    public function role_edit()
    {
        if (IS_POST) {
            $res = I('post.', null ,'trim');
            $role_id = $res['id'];
            if (empty($res['rule_ids'])) {
                $this->error("请选择权限分配！");
            }

            $auth_role = Db::name('auth_role')->where(['name'=>$res['name'],'id'=>['<>',$role_id]])->find();
            if ($auth_role) {
                $this->error("已存在相同的角色名称！");
            } else {
                // 编辑角色表
                $role_info = Db::name('auth_role')->where(['id'=>$res['pid']])->find();
                $grade = 0;
                if ($role_info) {
                    $grade = $role_info['grade'] + 1;
                }
                $role_data = array(
                    'name'      => $res['name'],
                    'pid'       => $res['pid'],
                    'grade'     => $grade,
                    'remark'    => $res['remark'],
                    'update_time'  => getTime(),
                );
                $role_update = M('auth_role')->where('id', $role_id)->save($role_data);
                
                // 新增角色权限表
                $r = false;
                if ($role_update) {
                    M('auth_access')->where('role_id', $role_id)->delete();
                    $access_data = array();
                    foreach ($res['rule_ids'] as $key => $val) {
                        $access_data[] = array(
                            'role_id'   => $role_id,
                            'rule_id'   => $val,
                        );
                    }
                    $r = M('auth_access')->insertAll($access_data);
                }
            }

            if($r){
                extra_cache('admin_auth_role_list_logic', NULL);
                adminLog('编辑角色');
                $this->success("操作成功!",U('Admin/role'));
            }else{
                $this->error("操作失败!",U('Admin/role'));
            }
        }

        $id = I('get.id/d');
        $info = array();
        if($id){
            $info = M('auth_role')->where("id",$id)->find();
        }
        $this->assign('info',$info);

        /* 角色ID */
        if (session('?admin_info') && session('admin_info.role_id') == -1){
            $role_id = 0;
        } else {
            $role_id = session('admin_info.role_id');
        }

        /**
         * 当前管理员的所有下级
         */
        $select_html = '';
        $selected = $info['pid'];
        $authRoleLogic = new AuthRoleLogic();
        $select_html = $authRoleLogic->auth_role_list($role_id, $selected, true);
        $this->assign('select_html', $select_html);

        /**
         * 当前角色下分配的权限
         */
        $access_list = M('auth_access')->where("role_id",$id)->getAllWithIndex('rule_id');
        $this->assign('access_list',$access_list);
        
        /**
         * 全部模块及权限
         */
        $map = array();
        if ($role_id > 0){
            $map['id'] = array('IN', array_keys($access_list));
        }
        $map['is_del'] = 0;
        $list = M('auth_rule')->field('id,modular_id,name')->where($map)->order('id')->select();
        foreach ($list as $val){
            $rule_list[$val['modular_id']][$val['id']] = $val;
        }
        $authModularLogic = new AuthModularLogic();
        $options = $authModularLogic->auth_modular_list(0, 0, false);
        $modules = $this->temp_convert_arr($options, $rule_list);
        $this->assign('modules',$modules);

        return $this->fetch();
    }
    
    public function role_del()
    {
        $id_arr = I('del_id/a');
        $id_arr = eyIntval($id_arr);
        if (!empty($id_arr)) {
            $role = M('auth_role')->where("pid",'IN',$id_arr)->select();
            if ($role) {
                respose(array('status'=>0, 'msg'=>'请先清空该角色下的子角色'));
            }

            $role_admin = M('auth_role_admin')->where("role_id",'IN',$id_arr)->select();
            if ($role_admin) {
                respose(array('status'=>0, 'msg'=>'请先清空所属该角色的管理员'));
            } else {
                $r = M('auth_role')->where("id",'IN',$id_arr)->delete();
                if($r){
                    M('auth_access')->where("role_id",'IN',$id_arr)->delete();
                    extra_cache('admin_auth_role_list_logic', NULL);
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
    
    /**
     * 管理员日志
     */
    public function log()
    {
        $p = I('p/d',1);
        $logs = DB::name('admin_log')->field('l.*, a.*, l.admin_id')
            ->alias('l')
            ->join('__ADMIN__ a','a.admin_id =l.admin_id')
            ->order('log_time DESC')
            ->page($p.',20')
            ->select();
        $this->assign('list',$logs);
        $count = DB::name('admin_log')->count();
        $Page = new Page($count,20);
        $show = $Page->show();
        $this->assign('pager',$Page);
        $this->assign('page',$show);
        return $this->fetch();
    }
    
    /**
     * 权限资源列表
     */
    function rule()
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
    public function rule_add()
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
        $authModularLogic = new AuthModularLogic();
        $select_html = $authModularLogic->auth_modular_list(0, 0, true);
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
    public function rule_edit()
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
    public function rule_del()
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
    
    /**
     * 模块管理
     */
    public function modular()
    {
        $modular_list = array();
        // 模块列表
        $authModularLogic = new AuthModularLogic(); 
        $modular_list = $authModularLogic->auth_modular_list(0, 0, false);
        $this->assign('modular_list', $modular_list);
        return $this->fetch();
    }

    /**
     * 添加模块
     */
    public function modular_add()
    {
        if (IS_POST) {
            $post = I('post.', null, 'trim');
            $map = array(
                'parent_id'=>$post['parent_id'],
                'name' => $post['name'],
            );
            if(M('auth_modular')->where($map)->count() > 0){
                $this->error('该模块名称已存在，请检查',U('Admin/modular'));
            }
            $data = array(
                'grade' => $post['grade'],
                'name'  => $post['name'],
                'parent_id' => $post['parent_id'],
                'sort_order'    => $post['sort_order'],
                'add_time'   => getTime(),
            );
            if (intval($post['grade']) > 0) {
                $data['controller'] = $post['controller'];
                $data['action'] = $post['action'];
            }
            if (intval($post['is_jump']) > 0) {
                $data['url'] = $post['url'];
            }
            $r = M('auth_modular')->add($data);
            
            if($r){
                \think\Cache::clear('auth_modular');
                extra_cache('admin_auth_modular_list_logic', NULL);
                extra_cache('admin_all_menu', NULL);
                adminLog('新增模块');
                $this->success("操作成功!",U('Admin/modular'));
            }else{
                $this->error("操作失败!",U('Admin/modular'));
            }
            exit;
        }

        // 新增模块在指定的模块下
        $parent_id = I('param.parent_id/d');
        $select_html = '';
        $grade = '';
        $selected = 0;
        if (0 < $parent_id) {
            $info = M('auth_modular')->where(array('id'=>$parent_id))->find();
            if ($info) {
                // 级别
                $grade = $info['grade'] + 1;
                // 菜单对应下的模块
                $selected = $info['id'];
            }
        }

        $authModularLogic = new AuthModularLogic();
        $options = $authModularLogic->auth_modular_list(0, $selected, false, 2);
        foreach ($options AS $var)
        {
            $select_html .= '<option value="' . $var['id'] . '" data-grade="' . $var['grade'] . '"';
            $select_html .= ($selected == $var['id']) ? "selected='ture'" : '';
            $select_html .= '>';
            if ($var['level'] > 0)
            {
                $select_html .= str_repeat('&nbsp;', $var['level'] * 4);
            }
            $select_html .= htmlspecialchars(addslashes($var['name'])) . '</option>';
        }

        $this->assign('grade',$grade);
        $this->assign('select_html',$select_html);
        return $this->fetch();
    }
    
    /**
     * 编辑模块
     */
    public function modular_edit()
    {
        if (IS_POST) {
            $post = I('post.', null, 'trim');
            if(!empty($post['id'])){
                $map = array(
                    'id' => array('NEQ', $post['id']),
                    'parent_id'=>$post['parent_id'],
                    'name' => $post['name'],
                );
                if(M('auth_modular')->where($map)->count() > 0){
                    $this->error('该模块名称已添加，请检查',U('Admin/modular'));
                }

                $data = array(
                    'grade' => $post['grade'],
                    'name'  => $post['name'],
                    'parent_id' => $post['parent_id'],
                    'sort_order'    => $post['sort_order'],
                    'update_time'   => getTime(),
                );
                if (intval($post['grade']) > 0) {
                    $data['controller'] = $post['controller'];
                    $data['action'] = $post['action'];
                }
                if (intval($post['is_jump']) > 0) {
                    $data['url'] = $post['url'];
                }
                $r = M('auth_modular')->where(array('id'=>$post['id']))->cache(true,null,"auth_modular")->save($data);
            }
            if($r){
                // \think\Cache::clear('auth_modular');
                extra_cache('admin_auth_modular_list_logic', NULL);
                extra_cache('admin_all_menu', NULL);
                adminLog('编辑模块');
                $this->success("操作成功!",U('Admin/modular'));
            }else{
                $this->error("操作失败!",U('Admin/modular'));
            }
            exit;
        }

        $id = I('id/d');
        $info = M('auth_modular')->where(array('id'=>$id))->find();
        $this->assign('info',$info);

        $select_html = '<option value="0" data-grade="-1">--顶部菜单--</option>';
        $selected = $info['parent_id'];
        $authModularLogic = new AuthModularLogic();
        $options = $authModularLogic->auth_modular_list(0, $selected, false, 2);
        foreach ($options AS $var)
        {
            $select_html .= '<option value="' . $var['id'] . '" data-grade="' . $var['grade'] . '"';
            $select_html .= ($selected == $var['id']) ? "selected='ture'" : '';
            $select_html .= '>';
            if ($var['level'] > 0)
            {
                $select_html .= str_repeat('&nbsp;', $var['level'] * 4);
            }
            $select_html .= htmlspecialchars(addslashes($var['name'])) . '</option>';
        }

        $this->assign('select_html',$select_html);

        return $this->fetch();
    }

    /**
     * 删除模块
     */
    public function modular_del()
    {
        $data = I('post.');   
        $data['id'] = intval($data['id']);
        if (array_key_exists($data['id'],$this->modular_system_id)) {
            respose(array('status'=>0, 'msg'=>'系统预定义，不能删除'));
        }
        $res = M('auth_modular')->where('parent_id', $data['id'])->select();
        if ($res) {
            respose(array('status'=>0, 'msg'=>'该模块下还有子模块，不能删除'));
        }
        $res = M('auth_rule')->where('modular_id', $data['id'])->select();
        if ($res) {
            respose(array('status'=>0, 'msg'=>'该模块下有权限，不允许删除，请先删除该模块下的权限'));
        }       
        $r = M('auth_modular')->where('id', $data['id'])->cache(true,null,"auth_modular")->delete();
        if ($r) {
            // \think\Cache::clear('auth_modular');
            extra_cache('admin_auth_modular_list_logic', NULL);
            extra_cache('admin_all_menu', NULL);
            adminLog('删除模块');
            respose(array('status'=>1, 'msg'=>'删除成功'));
        } else {
            respose(array('status'=>0, 'msg'=>'删除失败'));
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