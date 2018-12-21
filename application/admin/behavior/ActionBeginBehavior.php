<?php

namespace app\admin\behavior;

/**
 * 系统行为扩展：新增/更新/删除之后的后置操作
 */
class ActionBeginBehavior {
    protected static $actionName;
    protected static $controllerName;
    protected static $moduleName;
    protected static $method;

    /**
     * 构造方法
     * @param Request $request Request对象
     * @access public
     */
    public function __construct()
    {

    }

    // 行为扩展的执行入口必须是run
    public function run(&$params){
        self::$actionName = request()->action();
        self::$controllerName = request()->controller();
        self::$moduleName = request()->module();
        self::$method = request()->method();
        // file_put_contents ( DATA_PATH."log.txt", date ( "Y-m-d H:i:s" ) . "  " . var_export('admin_AfterSaveBehavior',true) . "\r\n", FILE_APPEND );
        $this->_initialize();
    }

    private function _initialize() {
        if ('POST' == self::$method) {
            $this->clearWeapp();
            $this->sitemap();
        }
    }

    /**
     * 自动生成sitemap
     * @access public
     */
    private function sitemap()
    {
        /*只有相应的控制器和操作名才执行，以便提高性能*/
        $ctlArr = ['Arctype','Article','Product','Images','Download'];
        $actArr = ['add','edit'];
        if (in_array(self::$controllerName, $ctlArr) && in_array(self::$actionName, $actArr)) {
            sitemap_auto();
        }
        /*--end*/
    }

    /**
     * 插件每次post提交都清除插件相关缓存
     * @access public
     */
    private function clearWeapp()
    {
        /*只有相应的控制器和操作名才执行，以便提高性能*/
        $ctlActArr = array(
            'Weapp@*',
        );
        $ctlActStr = self::$controllerName.'@*';
        if (in_array($ctlActStr, $ctlActArr)) {
            \think\Cache::clear('hooks');
        }
        /*--end*/
    }
}
