<?php

namespace think;

use think\exception\ValidateException;
use traits\controller\Jump;

Loader::import('controller/Jump', TRAIT_PATH, EXT);

class Controller
{
    use Jump;

    /**
     * @var \think\View 视图类实例
     */
    protected $view;

    /**
     * @var \think\Request Request 实例
     */
    protected $request;

    /**
     * @var bool 验证失败是否抛出异常
     */
    protected $failException = false;

    /**
     * @var bool 是否批量验证
     */
    protected $batchValidate = false;

    /**
     * @var array 前置操作方法列表
     */
    protected $beforeActionList = [];

    /**
     * 构造方法
     * @access public
     * @param Request $request Request 对象
     */
    public function __construct(Request $request = null)
    {
        if (is_null($request)) {
            $request = Request::instance();
        }

        // 自动判断手机端和PC，以及PC/手机自适应模板 by 小虎哥 2018-05-10
        $v = I('param.v/s', 'pc');
        $v = trim($v, '/');
        $is_mobile = 0;
        if ($v == 'mobile') {
            // session('is_mobile', 1);
            $is_mobile = 1;
        }
        // $is_mobile = session('?is_mobile') ? session('is_mobile') : 0; 
        if((isMobile() || $is_mobile == 1) && file_exists(ROOT_PATH.'template/mobile')) {
            !defined('THEME_STYLE') && define('THEME_STYLE', 'mobile'); // 手机端模板
            // session('is_mobile', 1);
        } else {
            !defined('THEME_STYLE') && define('THEME_STYLE', 'pc'); // pc端模板
            // session('is_mobile', null);
        }
        if (in_array($request->module(), array('home','m'))) {
            config('template.view_path', config('template.view_path').THEME_STYLE.'/');
        }
        // -------end

        $this->view    = View::instance(Config::get('template'), Config::get('view_replace_str'));
        $this->request = $request;

        if (!defined('IS_AJAX')) {
            $this->request->isAjax() ? define('IS_AJAX',true) : define('IS_AJAX',false);  // 
        }
        if (!defined('IS_GET')) {
            ($this->request->method() == 'GET') ? define('IS_GET',true) : define('IS_GET',false);  // 
        }
        if (!defined('IS_POST')) {
            ($this->request->method() == 'POST') ? define('IS_POST',true) : define('IS_POST',false);  // 
        }
        if (!defined('IS_AJAX_POST')) {
            ($this->request->isAjax() && $this->request->method() == 'POST') ? define('IS_AJAX_POST',true) : define('IS_AJAX_POST',false);  // 
        }
        
        !defined('MODULE_NAME') && define('MODULE_NAME',$this->request->module());  // 当前模块名称是
        !defined('CONTROLLER_NAME') && define('CONTROLLER_NAME',$this->request->controller()); // 当前控制器名称
        !defined('ACTION_NAME') && define('ACTION_NAME',$this->request->action()); // 当前操作名称是
        !defined('PREFIX') && define('PREFIX',config('database.prefix')); // 数据库表前缀
        $this->assign('action',ACTION_NAME);    

/*        if(isMobile() && strtolower(MODULE_NAME) == 'home')
        {
            $mobile_url = url('m/Index/index');
            header("Location: ".$mobile_url);
            exit();
        }  */

        $param = $this->request->param();
        if (isset($param['clear']) || config('app_debug') === true) {

        } else {
            read_html_cache(); // 尝试从缓存中读取
        }

        // 控制器初始化
        $this->_initialize();

        // 前置操作方法
        if ($this->beforeActionList) {
            foreach ($this->beforeActionList as $method => $options) {
                is_numeric($method) ?
                $this->beforeAction($options) :
                $this->beforeAction($method, $options);
            }
        }
        // 逻辑化
        $this->coding();
    }

    /**
     * 初始化操作
     * @access protected
     */
    protected function _initialize()
    {
    }

    public function _empty($name)
    {
        abort(404);
    }

    /**
     * 加工处理
     * @access protected
     */
    protected function coding()
    {
        \think\Coding::checksd();
        \think\Coding::resetcr();
    }

    /**
     * 前置操作
     * @access protected
     * @param  string $method  前置操作方法名
     * @param  array  $options 调用参数 ['only'=>[...]] 或者 ['except'=>[...]]
     * @return void
     */
    protected function beforeAction($method, $options = [])
    {
        if (isset($options['only'])) {
            if (is_string($options['only'])) {
                $options['only'] = explode(',', $options['only']);
            }

            if (!in_array($this->request->action(), $options['only'])) {
                return;
            }
        } elseif (isset($options['except'])) {
            if (is_string($options['except'])) {
                $options['except'] = explode(',', $options['except']);
            }

            if (in_array($this->request->action(), $options['except'])) {
                return;
            }
        }

        call_user_func([$this, $method]);
    }

    /**
     * 检测是否存在模板文件
     * @access public
     * @param string $template 模板文件或者模板规则
     * @return bool
     */
    protected function exists($template = '')
    {
        $bool = $this->view->exists($template);
        return $bool;
    }

    /**
     * 加载模板输出
     * @access protected
     * @param  string $template 模板文件名
     * @param  array  $vars     模板输出变量
     * @param  array  $replace  模板替换
     * @param  array  $config   模板参数
     * @return mixed
     */
    protected function fetch($template = '', $vars = [], $replace = [], $config = [])
    {
        $html = $this->view->fetch($template, $vars, $replace, $config);
        // \think\Coding::checkcr();
        // write_html_page($html); // 尝试写入静态页面
        write_html_cache($html); // 尝试写入静态缓存
        return $html;
    }

    /**
     * 渲染内容输出
     * @access protected
     * @param  string $content 模板内容
     * @param  array  $vars    模板输出变量
     * @param  array  $replace 替换内容
     * @param  array  $config  模板参数
     * @return mixed
     */
    protected function display($content = '', $vars = [], $replace = [], $config = [])
    {
        return $this->view->display($content, $vars, $replace, $config);
    }

    /**
     * 模板变量赋值
     * @access protected
     * @param  mixed $name  要显示的模板变量
     * @param  mixed $value 变量的值
     * @return $this
     */
    protected function assign($name, $value = '')
    {
        $this->view->assign($name, $value);

        return $this;
    }

    /**
     * 初始化模板引擎
     * @access protected
     * @param array|string $engine 引擎参数
     * @return $this
     */
    protected function engine($engine)
    {
        $this->view->engine($engine);

        return $this;
    }

    /**
     * 设置验证失败后是否抛出异常
     * @access protected
     * @param bool $fail 是否抛出异常
     * @return $this
     */
    protected function validateFailException($fail = true)
    {
        $this->failException = $fail;

        return $this;
    }

    /**
     * 验证数据
     * @access protected
     * @param  array        $data     数据
     * @param  string|array $validate 验证器名或者验证规则数组
     * @param  array        $message  提示信息
     * @param  bool         $batch    是否批量验证
     * @param  mixed        $callback 回调方法（闭包）
     * @return array|string|true
     * @throws ValidateException
     */
    protected function validate($data, $validate, $message = [], $batch = false, $callback = null)
    {
        if (is_array($validate)) {
            $v = Loader::validate();
            $v->rule($validate);
        } else {
            // 支持场景
            if (strpos($validate, '.')) {
                list($validate, $scene) = explode('.', $validate);
            }

            $v = Loader::validate($validate);

            !empty($scene) && $v->scene($scene);
        }

        // 批量验证
        if ($batch || $this->batchValidate) {
            $v->batch(true);
        }

        // 设置错误信息
        if (is_array($message)) {
            $v->message($message);
        }

        // 使用回调验证
        if ($callback && is_callable($callback)) {
            call_user_func_array($callback, [$v, &$data]);
        }

        if (!$v->check($data)) {
            if ($this->failException) {
                throw new ValidateException($v->getError());
            }

            return $v->getError();
        }

        return true;
    }
}
