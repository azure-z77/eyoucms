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

namespace weapp\Minipro0001\logic;

use weapp\Minipro0001\model\Minipro0001Model;

load_trait('controller/Jump'); // 引入traits\controller\Jump

/**
 * 业务逻辑
 */
class Minipro0001Logic
{
    use \traits\controller\Jump;

    /**
     * 实例化模型
     */
    private $model;

    /**
     * 析构函数
     */
    function __construct() 
    {
        $this->model = new Minipro0001Model;
    }

    /**
     * 小程序链接类型列表
     */
    public function pages_list()
    {
        $conf = include WEAPP_DIR_NAME.DS.'Minipro0001'.DS.'config.php';
        if ('v1.0.5' >= $conf['version']) {
            return pages_list();
        }

        $pages = array(
            1   => array(
                'title' => '首页',
                'path' => '/pages/index/index',
                'showtext'  => false,
            ),
            2   => array(
                'title' => '导航页',
                'path' => '/pages/arctype/index',
                'showtext'  => false,
            ),
            3   => array(
                'title' => '列表页',
                'path' => '/pages/plus/lists?typeid=',
                'showtext'  => true,
            ),
            4   => array(
                'title' => '单页面',
                'path' => '/pages/plus/single?typeid=',
                'showtext'  => true,
            ),
            5   => array(
                'title' => '内容页',
                'path' => '/pages/plus/view?aid=',
                'showtext'  => true,
            ),
            6   => array(
                'title' => '留言模型',
                'path' => '/pages/plus/guestbook?typeid=',
                'showtext'  => true,
            ),
            7   => array(
                'title' => '联系我们',
                'path' => '/pages/contact/index',
                'showtext'  => false,
            ),
        );

        return $pages;
    }

    /**
     * 获取小程序链接
     */
    public function get_pages_path($key, $typeid = '')
    {
        $conf = include WEAPP_DIR_NAME.DS.'Minipro0001'.DS.'config.php';
        if ('v1.0.5' >= $conf['version']) {
            return get_pages_path($key, $typeid);
        }

        $pages = $this->pages_list();
        $path = !empty($pages[$key]) ? $pages[$key]['path'].$typeid : '';

        return $path;
    }

    /**
     * 接口转化 
     */
    public function get_api_url($query_str)
    {
        $conf = include WEAPP_DIR_NAME.DS.'Minipro0001'.DS.'config.php';
        if ('v1.0.5' >= $conf['version']) {
            return get_api_url($query_str);
        }

        $apiUrl = 'aHR0cHM6Ly9zZXJ2aWNlLmV5b3VjbXMuY29tL2luZGV4LnBocC8=';
        return base64_decode($apiUrl).$query_str;
    }

    /**
     * 获取最新的小程序参数配置
     */
    public function getSetting()
    {
        $data = $this->model->getValue($this->model->miniproType);
        if (!empty($data)) {
            $url = "api/MiniproClient/minipro.html?appId=".$data['appId']."&appSecret=".$data['appSecret'];
            $response = httpRequest($this->get_api_url($url));
            $params = array();
            $params = json_decode($response, true);
            if (!empty($params) && $params['errcode'] == 0) {
                $bool = $this->model->setValue($this->model->miniproType, $params['errmsg']);
                if ($bool) {
                    $data = $this->model->getValue($this->model->miniproType);
                } else {
                    $data = $params['errmsg'];
                }
            }
        }

        return $data;
    }
}
