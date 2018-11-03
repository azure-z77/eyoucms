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

namespace app\common\controller;

use think\Session;
load_trait('controller/Jump');
/**
 * 插件基类
 */
abstract class Weapp{
    use \traits\controller\Jump;
    /**
     * 视图实例对象
     * @var view
     * @access protected
     */
    protected $view = null;

    /**
     * @var \think\Request Request 实例
     */
    protected $request;

    public $info                =   array();
    public $weapp_path          =   '';
    public $config_file         =   '';
    public $custom_config       =   '';
    public $admin_list          =   array();
    public $custom_adminlist    =   '';
    public $access_url          =   array();

    public function __construct(Request $request = null){
        if (!session_id()) {
            Session::start();
        }
        header("Cache-control: private");  // history.back返回后输入框值丢失问题

        if (is_null($request)) {
            $request = request();
        }
        $this->request = $request;

        $class = get_class($this); // 返回对象的类名
        $wmcArr = explode('\\', $class);
        !defined('WEAPP_MODULE_NAME') && define('WEAPP_MODULE_NAME', $this->request->param('sm')?:$wmcArr[1]);  // 当前插件模块名称是
        !defined('WEAPP_CONTROLLER_NAME') && define('WEAPP_CONTROLLER_NAME', $this->request->param('sc')?:$wmcArr[3]); // 当前插件控制器名称
        !defined('WEAPP_ACTION_NAME') && define('WEAPP_ACTION_NAME', $this->request->param('sa')?:'index'); // 当前插件操作名称是

        // 模板路径
        config('template.view_path', '.'.__ROOT__.'/'.WEAPP_DIR_NAME.'/'.WEAPP_MODULE_NAME.'/template/');
        config('view_replace_str.__ADMIN_SKIN__', __ROOT__.'/public/static/admin');
        config('view_replace_str.__WEAPP_TEMPLATE__', __ROOT__.'/'.WEAPP_DIR_NAME.'/'.WEAPP_MODULE_NAME.'/template');
        
        $this->view    = \think\View::instance(config('template'), config('view_replace_str'));

        $this->weapp_path   =   WEAPP_DIR_NAME.DS.WEAPP_MODULE_NAME.DS;
        if(is_file($this->weapp_path.'config.php')){
            $this->config_file = $this->weapp_path.'config.php';
        }

        // 验证插件的配置完整性
        $this->checkConfig();

        // 控制器初始化
        $this->_initialize();
    }

    /**
     * 初始化操作
     * @access protected
     */
    protected function _initialize()
    {
        /*---------*/
        $is_eyou_authortoken = session('web_is_authortoken');
        $is_eyou_authortoken = !empty($is_eyou_authortoken) ? $is_eyou_authortoken : 0;
        $this->assign('is_eyou_authortoken', $is_eyou_authortoken);
        /*--end*/
    }

    /**
     * 渲染内容输出
     * @access public
     * @param string $content 内容
     * @param array  $vars    模板输出变量
     * @param array  $replace 替换内容
     * @param array  $config     模板参数
     * @return mixed
     */
    final protected function display($template = '', $vars = [], $replace = [], $config = [])
    {
        if(empty($template)) {
            die('没有指定模板文件！');
        }
        echo $this->fetch($template, $vars, $replace, $config);
    }

    /**
     * 模板变量赋值
     * @access public
     * @param mixed $name  变量名
     * @param mixed $value 变量值
     * @return $this
     */
    final protected function assign($name,$value='') {
        return $this->view->assign($name,$value);
    }

    /**
     * 解析和获取模板内容 用于输出
     * @param string    $template 模板文件名或者内容
     * @param array     $vars     模板输出变量
     * @param array     $replace 替换内容
     * @param array     $config     模板参数
     * @param bool      $renderContent     是否渲染内容
     * @return string
     * @throws Exception
     */
    final protected function fetch($template = '', $vars = [], $replace = [], $config = [], $renderContent = false){
        $view_path = config('template.view_path');

        if (empty($template)) {
            $template = WEAPP_ACTION_NAME;
        }
        if('' == pathinfo($template, PATHINFO_EXTENSION)){
            $template = str_replace('\\', '/', $template);
            $arr = explode('/', $template);
            if (1 == count($arr)) {
                $template = $view_path.$arr[0];
            } else if (2 == count($arr)) {
                $template = $view_path.$arr[0].DS.$arr[1];
            } else if (3 == count($arr)) {
                $view_path = str_replace('/'.WEAPP_MODULE_NAME.'/template/', '/'.$arr[0].'/template/', $view_path);
                $template = $view_path.$arr[1].DS.$arr[2];
            } else {
                $template = $view_path.$arr[count($arr) - 1];
            }
            $template = $template.'.'.config('template.view_suffix');
        }
        if(!is_file($template)){
            die("模板不存在:$template");
        }
        // $this->view->engine(config('template'));
        $replace = array_merge(config('view_replace_str'), $replace);
        $config = array_merge(config('template'), $config);
        return $this->view->fetch($template, $vars, $replace, $config, $renderContent);
    }

    /**
     * 验证插件的配置完整性
     * @return string
     * @throws Exception
     */
    final public function checkConfig(){
        $config_check_keys = array('code','name','description','scene','author','version','min_version');
        $config = include $this->config_file;
        foreach ($config_check_keys as $value) {
            if(!array_key_exists($value, $config)) {
                die("插件配置文件config.php不符合官方规范，缺少{$value}数组元素！");
                // throw new \Exception("插件配置文件config.php不符合官方规范，缺少{$value}数组元素！");
            }
        }
        return true;
    }

    /**
     * 获取插件信息
     */
    final public function getWeappInfo($code = ''){
        static $_weapp = array();
        if(empty($code)){
            $config = $this->getConfig();
            $code = !empty($config['code']) ? $config['code'] : WEAPP_MODULE_NAME;
        }
        if(isset($_weapp[$code])){
            return $_weapp[$code];
        }
        $values =   array();
        $config  =   M('Weapp')->where('code',$code)->getField('config');
        if(!empty($config)){
            $values   =   json_decode($config, true);
        }
        $_weapp[$code]     =   $values;
        
        return $values;
    }

    /**
     * 获取插件的配置
     */
    final public function getConfig(){
        static $_config = array();
        if(!empty($_config)){
            return $_config;
        }
        $config = include $this->config_file;
        $_config     =   $config;

        return $config;
    }

    /**
     * 插件模板渲染
     */
    public function template($template_name = '', $params = [])
    {
        $class = get_class($this);
        $arr = explode("\\", $class);
        $sm = $arr[1];
        $view_path = WEAPP_DIR_NAME."/{$sm}/template/";
        $this->assign('weapp_skin_path', __ROOT__.'/' .WEAPP_DIR_NAME . "/{$sm}/template/skin");
        $this->assign('admin_skin_path', __ROOT__.'/public/static/admin');
        $this->assign('sm', $sm);
        $this->view->engine(['view_path' => $view_path]);
        echo $this->fetch($template_name, $params);
    }

    /**
     * 插件使用说明
     */
    public function doc(){
        $this->success("该插件开发者未完善使用指南！");
    }
}
