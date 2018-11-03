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

        //过滤不需要登陆的行为
        if(in_array(ACTION_NAME, config('filter_login_action')) || in_array(CONTROLLER_NAME, config('filter_login_controller'))){
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
        $ctl_act = $ctl.config('POWER_OPERATOR').$act;
        $act_list = session('admin_info.act_list');
        //无需验证的控制器
        $uneed_check_controller = config('uneed_check_controller');
        //无需验证的操作
        $uneed_check_action = config('uneed_check_action');
        if (session('admin_info.role_id') == -1) {
            //超级管理员无需验证
            return true;
        } elseif (in_array($ctl, $uneed_check_controller)) {
            //在列表中的控制器不需要验证权限
            return true;
        } elseif (IS_AJAX || strpos($act,'ajax') !== false || in_array($ctl_act, $uneed_check_action)) {
            //所有ajax请求不需要验证权限
            return true;
        } else {
            $role_right = array();
            $right = M('auth_rule')->where("id", "in", $act_list)->cache(false)->getField('right',true);
            $role_right = '';
            foreach ($right as $val){
                $role_right .= $val.',';
            }
            $role_right = explode(',', trim($role_right, ','));
            $role_right = array_unique($role_right);
            
            //检查是否拥有此操作权限
            if (!in_array($ctl_act, $role_right)) {
                $this->error('您没有操作权限['.($ctl_act).'],请联系超级管理员分配权限', U('Index/welcome'));
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