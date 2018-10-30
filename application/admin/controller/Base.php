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
use app\admin\logic\UpgradeLogic;
use think\Controller;
use think\Db;
use think\response\Json;
use think\Session;
class Base extends Controller {

    public $session_id;

    /**
     * 析构函数
     */
    function __construct() 
    {
        if (!session_id()) {
            Session::start();
        }
        header("Cache-control: private");  // history.back返回后输入框值丢失问题
        parent::__construct();
        $this->global_assign();

        /*---------*/
        $is_eyou_authortoken = session('web_is_authortoken');
        $is_eyou_authortoken = !empty($is_eyou_authortoken) ? $is_eyou_authortoken : 0;
        $this->assign('is_eyou_authortoken', $is_eyou_authortoken);
        /*--end*/

        $upgradeLogic = new UpgradeLogic();
        $upgradeMsg = $upgradeLogic->checkVersion(); //升级包消息     
        $this->assign('upgradeMsg',$upgradeMsg);
        tpversion();
    }
    
    /*
     * 初始化操作
     */
    public function _initialize() 
    {
        $this->session_id = session_id(); // 当前的 session_id
        !defined('SESSION_ID') && define('SESSION_ID', $this->session_id); //将当前的session_id保存为常量，供其它方法调用

        parent::_initialize();

        /*及时更新cookie中的admin_id，用于前台的可视化权限验证*/
        $admin_id = cookie('admin_id'); // 传递到前台
        if (empty($admin_id) && session('?admin_info.admin_id')) {
            cookie('admin_id', session('admin_info.admin_id')); // 传递到前台
        }
        $auth_role_info = model('AuthRole')->getRole(array('id' => session('admin_info.role_id')));
        session('admin_info.auth_role_info', $auth_role_info);
        /*--end*/

        //过滤不需要登陆的行为
        $ctl_act = CONTROLLER_NAME.'@'.ACTION_NAME;
        $ctl_all = CONTROLLER_NAME.'@*';
        $uneed_check_action = config('uneed_check_action');
        if (in_array($ctl_act, $uneed_check_action) || in_array($ctl_all, $uneed_check_action)) {
            //return;
        }else{
            if(session('admin_id') > 0 ){
                $this->check_priv();//检查管理员菜单操作权限
            }else{
                $url = request()->baseFile().'?s=/Admin/login';
                $this->redirect($url);
            }
        }
    }
    
    public function check_priv()
    {
        $ctl = CONTROLLER_NAME;
        $act = ACTION_NAME;
        $ctl_act = $ctl.'@'.$act;
        $ctl_all = $ctl.'@*';
        //无需验证的操作
        $uneed_check_action = config('uneed_check_action');
        if (session('admin_info.role_id') == -1) {
            //超级管理员无需验证
            return true;
        } else {
            $bool = false;

            /*检测是否有该权限*/
            if (is_check_access($ctl_act)) {
                $bool = true;
            }
            /*--end*/

            /*在列表中的操作不需要验证权限*/
            if (IS_AJAX || strpos($act,'ajax') !== false || in_array($ctl_act, $uneed_check_action) || in_array($ctl_all, $uneed_check_action)) {
                $bool = true;
            }
            /*--end*/

            //检查是否拥有此操作权限
            if (!$bool) {
                $this->error('您没有操作权限，请联系超级管理员分配权限', U('Index/welcome'));
            }
        }
    }  

    /**
     * 保存系统设置 
     */
    public function global_assign()
    {
        $this->assign('version', getCmsVersion());
        $this->assign('global', tpCache('global'));
    } 
}