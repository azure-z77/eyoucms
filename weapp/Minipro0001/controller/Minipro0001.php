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
 * Date: 2018-06-28
 */

namespace weapp\Minipro0001\controller;

use think\Page;
use app\common\controller\Weapp;
use weapp\Minipro0001\model\Minipro0001Model;
use weapp\Minipro0001\logic\Minipro0001Logic;

/**
 * Minipro0001-插件的控制器
 */
class Minipro0001 extends Weapp{

    /**
     * 实例化DB对象
     */
    private $db;

    /**
     * 实例化模型对象
     */
    private $model;

    /**
     * 实例化业务逻辑对象
     */
    private $logic;

    /**
     * 插件基本信息
     */
    private $weappInfo;

    /**
     * 模板nid，每套模板唯一
     */
    private $nid = 'Minipro0001';

    /**
     * 构造方法
     */
    public function __construct(){
        parent::__construct();
        $this->logic = new Minipro0001Logic;
        $this->model = new Minipro0001Model;
        $this->db = M($this->model->name);

        /*插件基本信息*/
        $this->weappInfo = $this->getWeappInfo();
        $this->assign('weappInfo',$this->weappInfo);
        /*--end*/
    }

    /**
     * 插件使用说明
     */
    public function doc(){
        return $this->fetch('doc');
    }

    /**
     * 插件第一入口
     */
    public function index()
    {
        return $this->globalConf();
    }

    /**
     * 全局参数
     */
    public function globalConf()
    {
        if (IS_POST) {
            $post = I('post.');
            $data = array();
            foreach ($post as $key => $val) {
                if (1 == preg_match('/(_is_remote|_remote|_local)$/', $key)) { // 处理上传本地与远程图片的字段转化
                    if (1 == preg_match('/(_local)$/', $key)) {
                        $tmpkey = preg_replace('/^(.*)(_local)$/', '$1', $key);
                        $tmp_is_remote = !empty($post[$tmpkey.'_is_remote']) ? $post[$tmpkey.'_is_remote'] : 0;
                        $val = '';
                        if ($tmp_is_remote == 1) {
                            $val = $post[$tmpkey.'_remote'];
                        } else {
                            $val = $post[$tmpkey.'_local'];
                        }
                        $data[$tmpkey] = $val;
                        unset($post[$tmpkey.'_local']);
                        unset($post[$tmpkey.'_remote']);
                        unset($post[$tmpkey.'_is_remote']);
                    }
                } else if (1 == preg_match('/(_path_key)$/', $key)) { // 菜单链接转为小程序路径
                    $mn = preg_replace('/^(.*)(_path_key)$/', '$1', $key);
                    $data[$mn.'_path'] = $this->logic->get_pages_path($val, $post[$mn.'_typeid']);
                    $data[$key] = $val;
                } else {
                    $data[$key] = $val;
                }
            }

            /*保存数据*/
            $newData = array(
                'type' => $this->model->globalType,
                'value' => json_encode($data),
            );
            $row = $this->model->getRow($this->model->globalType);
            if (empty($row)) { // 新增
                $newData['add_time'] = getTime();
                $r = $this->model->insert($newData);
            } else {
                $newData['update_time'] = getTime();
                $r = $this->model->where('type','eq',$this->model->globalType)->update($newData);
            }
            if (false !== $r) {
                \think\Cache::clear('minipro');
                $this->success('操作成功', weapp_url('Minipro0001/Minipro0001/index'));
            }
            /*--end*/
            $this->error('操作失败');
        }

        $assign_data = array();

        $webConfig = tpCache('web');
        $assign_data['web'] = $webConfig; // 网站基本信息

        $row = $this->model->getValue($this->model->globalType);
        if (empty($row)) {
            $m1_path_key = 1;
            $m2_path_key = 2;
            $m3_path_key = 7;
            $miniproModel = new \app\weapp\model\Minipro0001();
            $row = array(
                'sel_color' => '#227ff4',
                'menu_color' => '#afb4b2',
                'front_color' => '#ffffff', // 只能黑#000000和白#ffffff
                'nav_title' => $webConfig['web_name'],
                'copyright' => $webConfig['web_copyright'],
                'm1_name' => '首页',
                'm1_show' => 1,
                'm1_path_key' => $m1_path_key,
                'm1_img_is_remote' => 0,
                'm1_img_local' => $miniproModel->getImgRealpath('index.png', false),
                'm1_selimg_local' => $miniproModel->getImgRealpath('index_selected.png', false),
                'm2_name' => '导航',
                'm2_show' => 1,
                'm2_path_key' => $m2_path_key,
                'm2_img_is_remote' => 0,
                'm2_img_local' => $miniproModel->getImgRealpath('product.png', false),
                'm2_selimg_local' => $miniproModel->getImgRealpath('product_selected.png', false),
                'm3_name' => '联系',
                'm3_show' => 1,
                'm3_path_key' => $m3_path_key,
                'm3_img_is_remote' => 0,
                'm3_img_local' => $miniproModel->getImgRealpath('contact.png', false),
                'm3_selimg_local' => $miniproModel->getImgRealpath('contact_selected.png', false),
            );
        } else {
            foreach ($row as $key => $val) {
                /*转换图片为本地与远程*/
                if (1 == preg_match('/(_img|_selimg)$/', $key)) {
                    if (is_http_url($val)) {
                        $row[$key.'_is_remote'] = 1;
                        $row[$key.'_remote'] = $val;
                    } else {
                        $row[$key.'_is_remote'] = 0;
                        $row[$key.'_local'] = $val;
                    }
                }
                /*--end*/
            }
        }
        $assign_data['row'] = $row;
        $assign_data['pages_list'] = $this->logic->pages_list(); // 小程序页面路径链接

        $this->assign($assign_data);

        return $this->fetch();
    }

    /**
     * 首页参数
     */
    public function homeConf()
    {
        if (IS_POST) {
            $post = I('post.');
            $data = array();
            foreach ($post as $key => $val) {
                if (is_array($val)) {
                    $data[$key] = array();
                    foreach ($val as $k2 => $v2) {
                        if (1 == preg_match('/(_is_remote|_remote|_local)$/', $k2)) { // 处理上传本地与远程图片的字段转化
                            if (1 == preg_match('/(_local)$/', $k2)) {
                                $tmpkey = preg_replace('/^(.*)(_local)$/', '$1', $k2);
                                $tmp_is_remote = !empty($post[$key][$tmpkey.'_is_remote']) ? $post[$key][$tmpkey.'_is_remote'] : 0;
                                $v2 = '';
                                if ($tmp_is_remote == 1) {
                                    $v2 = $post[$key][$tmpkey.'_remote'];
                                } else {
                                    $v2 = $post[$key][$tmpkey.'_local'];
                                }
                                $data[$key][$tmpkey] = $v2;
                                unset($post[$key][$tmpkey.'_local']);
                                unset($post[$key][$tmpkey.'_remote']);
                                unset($post[$key][$tmpkey.'_is_remote']);
                            }
                        } else if (1 == preg_match('/(_path_key)$/', $k2)) { // 栏目里诶包链接转为小程序路径
                            $mn = preg_replace('/^(.*)(_path_key)$/', '$1', $k2);
                            $data[$key][$mn.'_path'] = $this->logic->get_pages_path($v2, $post[$key][$mn.'_typeid']);
                            $data[$key][$k2] = $v2;
                        } else {
                            $data[$key][$k2] = $v2;
                        }

                        /*栏目模块是否显示*/
                        if ('cate' == $key && 1 == preg_match('/^m(\d+)_show$/', $k2)) {
                            $mn = preg_replace('/^(.*)(_show)$/', '$1', $k2);
                            if (1 == $post[$key][$mn.'_show']) {
                                $data[$key]['show'] = 1;
                            }
                        } else if ('video' == $key) {
                            if (!isset($data[$key]['show_video'])) {
                                $data[$key]['show_video'] = false;
                            }
                        }
                        /*--end*/
                    }
                } else {
                    $data[$key] = $val;
                }
            }

            /*保存数据*/
            $newData = array(
                'type' => $this->model->homeType,
                'value' => json_encode($data),
            );
            $row = $this->model->getRow($this->model->homeType);
            if (empty($row)) { // 新增
                $newData['add_time'] = getTime();
                $r = $this->model->insert($newData);
            } else {
                $newData['update_time'] = getTime();
                $r = $this->model->where('type','eq',$this->model->homeType)->update($newData);
            }
            if (false !== $r) {
                \think\Cache::clear('minipro');
                $this->success('操作成功', weapp_url('Minipro0001/Minipro0001/homeConf'));
            }
            /*--end*/
            $this->error('操作失败');
        }

        $assign_data = array();

        $row = $this->model->getValue($this->model->homeType);
        if (empty($row)) {
            $m1_path_key = 4;
            $m2_path_key = 3;
            $m3_path_key = 3;
            $m4_path_key = 7;
            $miniproModel = new \app\weapp\model\Minipro0001();
            $row = array(
                'swipers' => array(
                    'aid'   => '',
                    'show'  => 1,
                ),
                'cate'  => array(
                    'show' => 1,
                    'm1_name' => '公司简介',
                    'm1_show' => 1,
                    'm1_path_key' => $m1_path_key,
                    'm1_img_is_remote' => 0,
                    'm1_img_local' => $miniproModel->getImgRealpath('about.png', false),
                    'm2_name' => '案例展示',
                    'm2_show' => 1,
                    'm2_path_key' => $m2_path_key,
                    'm2_img_is_remote' => 0,
                    'm2_img_local' => $miniproModel->getImgRealpath('images.png', false),
                    'm3_name' => '新闻中心',
                    'm3_show' => 1,
                    'm3_path_key' => $m3_path_key,
                    'm3_img_is_remote' => 0,
                    'm3_img_local' => $miniproModel->getImgRealpath('article.png', false),
                    'm4_name' => '联系我们',
                    'm4_show' => 1,
                    'm4_path_key' => $m4_path_key,
                    'm4_img_is_remote' => 0,
                    'm4_img_local' => $miniproModel->getImgRealpath('business.png', false),
                ),
                'notice'    => array(
                    'icon_img_is_remote' => 0,
                    'icon_img_local'  => $miniproModel->getImgRealpath('notice.png', false),
                    'show'  => 1,
                ),
                'video'    => array(
                    'title' => '视频专区',
                    'src'   => '',
                    'v_img_is_remote' => 0,
                    'v_img_local' => $miniproModel->getImgRealpath('video.jpg', false),
                    'show'  => 1,
                ),
                'images'    => array(
                    'title' => '案例展示',
                    'typeid' => '',
                    'num'   => 4,
                    'more_path_key' => 3,
                    'show'  => 1,
                ),
                'article'    => array(
                    'title' => '新闻中心',
                    'typeid' => '',
                    'num'   => 5,
                    'more_path_key' => 3,
                    'show'  => 1,
                ),
            );
        } else {
            foreach ($row as $key => $val) {
                foreach ($val as $k2 => $v2) {
                    /*转换图片为本地与远程*/
                    if (1 == preg_match('/(_img)$/', $k2)) {
                        if (is_http_url($v2)) {
                            $row[$key][$k2.'_is_remote'] = 1;
                            $row[$key][$k2.'_remote'] = $v2;
                        } else {
                            $row[$key][$k2.'_is_remote'] = 0;
                            $row[$key][$k2.'_local'] = $v2;
                        }
                    }
                    /*--end*/
                }
            }
        }
        $assign_data['row'] = $row;
        $assign_data['pages_list'] = $this->logic->pages_list(); // 小程序页面路径链接

        $this->assign($assign_data);

        return $this->fetch();
    }

    /**
     * 关于参数
     */
    public function aboutConf()
    {
        if (IS_POST) {
            $post = I('post.');
            $data = array();
            foreach ($post as $key => $val) {
                if (1 == preg_match('/(_is_remote|_remote|_local)$/', $key)) { // 处理上传本地与远程图片的字段转化
                    if (1 == preg_match('/(_local)$/', $key)) {
                        $tmpkey = preg_replace('/^(.*)(_local)$/', '$1', $key);
                        $tmp_is_remote = !empty($post[$tmpkey.'_is_remote']) ? $post[$tmpkey.'_is_remote'] : 0;
                        $val = '';
                        if ($tmp_is_remote == 1) {
                            $val = $post[$tmpkey.'_remote'];
                        } else {
                            $val = $post[$tmpkey.'_local'];
                        }
                        $data[$tmpkey] = $val;
                        unset($post[$tmpkey.'_local']);
                        unset($post[$tmpkey.'_remote']);
                        unset($post[$tmpkey.'_is_remote']);
                    }
                } else {
                    if ('coordinate' == $key) {
                        $coordinateArr = explode(',', $val);
                        $data['latitude'] = !empty($coordinateArr[0]) ? $coordinateArr[0] : 0;
                        $data['longitude'] = !empty($coordinateArr[1]) ? $coordinateArr[1] : 0;
                    }
                    $data[$key] = $val;
                }
            }

            /*保存数据*/
            $newData = array(
                'type' => $this->model->aboutType,
                'value' => json_encode($data),
            );
            $row = $this->model->getRow($this->model->aboutType);
            if (empty($row)) { // 新增
                $newData['add_time'] = getTime();
                $r = $this->model->insert($newData);
            } else {
                $newData['update_time'] = getTime();
                $r = $this->model->where('type','eq',$this->model->aboutType)->update($newData);
            }
            if (false !== $r) {
                \think\Cache::clear('minipro');
                $this->success('操作成功', weapp_url('Minipro0001/Minipro0001/aboutConf'));
            }
            /*--end*/
            $this->error('操作失败');
        }

        $assign_data = array();

        $row = $this->model->getValue($this->model->aboutType);
        if (empty($row)) {
            $miniproModel = new \app\weapp\model\Minipro0001();
            $row = array(
                'logo_is_remote' => 0,
                'logo_local' => $miniproModel->getImgRealpath('logo.png', false),
                'banner_is_remote' => 0,
                'banner_local' => $miniproModel->getImgRealpath('banner.jpg', false),
            );
        } else {
            foreach ($row as $key => $val) {
                /*转换图片为本地与远程*/
                if (1 == preg_match('/(logo|banner)$/', $key)) {
                    if (is_http_url($val)) {
                        $row[$key.'_is_remote'] = 1;
                        $row[$key.'_remote'] = $val;
                    } else {
                        $row[$key.'_is_remote'] = 0;
                        $row[$key.'_local'] = $val;
                    }
                }
                /*--end*/
            }
        }
        $assign_data['row'] = $row;

        $this->assign($assign_data);

        return $this->fetch();
    }
    
    /**
     * 小程序配置
     */
    public function setting()
    {
        if (IS_POST) {
            $post = I('post.');
            if (empty($post['nid'])) {
                $this->error('小程序模板nid不存在');
            }
            $post['domain'] = trim($post['domain'], '/');

            /*同步数据到服务器*/
            $response = httpRequest($this->logic->get_api_url("api/MiniproClient/minipro.html"), "POST", $post);
            $params = array();
            $params = json_decode($response, true);
            /*--end*/

            if (!empty($params)) {
                if ($params['errcode'] == 0) {
                    /*保存数据*/
                    $newData = array(
                        'type' => $this->model->miniproType,
                        'value' => json_encode($post),
                    );
                    $row = $this->model->getRow($this->model->miniproType);
                    if (empty($row)) { // 新增
                        $newData['add_time'] = getTime();
                        $r = $this->model->insert($newData);
                    } else {
                        $newData['update_time'] = getTime();
                        $r = $this->model->where('type','eq',$this->model->miniproType)->update($newData);
                    }
                    if (false !== $r) {
                        header('Location: '.weapp_url('Minipro0001/Minipro0001/createMinipro'));
                        exit;
                        // $this->success('操作成功', weapp_url('Minipro0001/Minipro0001/setting'));
                    }
                    /*--end*/
                } else {
                    $this->error($params['errmsg']);
                }
            }
            $this->error('操作失败');
        }

        $assign_data = array();

        $row = $this->logic->getSetting();
        $assign_data['row'] = $row;

        /*模板类型*/
        $template_list = array();
        $response = httpRequest($this->logic->get_api_url("api/MiniproClient/get_minipro_list.html"), "GET");
        $params = json_decode($response,true);
        if (!empty($params) && $params['errcode'] == 0) {
            $template_list = $params['errmsg'];
        } else {
            $this->error('小程序模板不存在');
        }
        $miniproNum = preg_replace('/([a-z])/i', '', $template_list[$this->nid]['nid']);
        $assign_data['version'] = 'v'.intval($miniproNum).'.0';
        $assign_data['template_list'] = $template_list;
        /*--end*/

        $assign_data['nid'] = $this->nid; // 模板nid，每套模板唯一
        $assign_data['type'] = $this->model->miniproType; // 小程序配置信息的type值

        $this->assign($assign_data);

        return $this->fetch();
    }

    /**
     * 生成小程序
     */
    public function createMinipro()
    {
        $inc = $this->logic->getSetting();
        if (empty($inc)) {
            $this->error('先填写小程序配置');
        }

        if ($inc['authorizerStatus'] == 0) {
            $gourl = urlencode(weapp_url('Minipro0001/Minipro0001/createMinipro', '', true, SITE_URL));
            $authorization_url = $this->logic->get_api_url("api/Minipro/client_authoriza.html?authorizer_appid=".$inc['appId']."&gourl={$gourl}");
            header('Location: '.$authorization_url);
            exit;
        }

        $post_data = array(
            'appid' => $inc['appId'],
        );
        $response = httpRequest($this->logic->get_api_url("api/Minipro/createMinipro.html"), "POST", $post_data);
        $params = array();
        $params = json_decode($response,true);
        if ($params) {
            if ($params['errcode'] === 0) {
                $this->success('正在生成小程序中……', weapp_url('Minipro0001/Minipro0001/setting'));
            } else {
                $this->error($params['errmsg']);
            }
        }
    }

    /**
     * 获取体验二维码
     */
    public function getQrcode()
    {
        $inc = $this->logic->getSetting();
        if (empty($inc)) {
            $this->error('先填写小程序配置');
        }

        $post_data = array(
            'appid' => $inc['appId'],
        );
        $response = httpRequest($this->logic->get_api_url("api/Minipro/getQrcode.html"), "POST", $post_data);
        $params = array();
        $params = json_decode($response,true);
        if ($params) {
            if ($params['errcode'] === 0) {
                $imgcode = base64_decode($params['errmsg']);
                $filename = md5($inc['appId'].time().mt_rand(1000,9999)).".jpg";
                $bannerurl = UPLOAD_PATH.'minipro/'.date('Y/m/d');
                tp_mkdir($bannerurl);
                $bannerurl = $bannerurl."/".$filename;
                $imgurl = '';
                if (file_put_contents($bannerurl, $imgcode)){
                    $imgurl = SITE_URL."/{$bannerurl}";
                }

                $params['msg'] = $imgurl;
            }
            $this->success('操作成功', null, $params);
        }

        $this->error('获取体验二维码失败，请多重试几次！');
    }

    /**
     * 提交小程序审核
     */
    public function submitAudit()
    {
        $inc = $this->logic->getSetting();
        if (empty($inc)) {
            $this->error('先填写小程序配置');
        }

        if (2 == $inc['auditstatus']) {
            $estimateTime = date('Y-m-d H:i:s', $inc['estimateTime']);
            $this->success("审核中……预计{$estimateTime}之前完成", weapp_url('Minipro0001/Minipro0001/setting'), '', 3);
        }

        $post_data = array(
            'appid' => $inc['appId'],
        );
        $response = httpRequest($this->logic->get_api_url("api/Minipro/submitAudit.html"), "POST", $post_data);
        $params = array();
        $params = json_decode($response,true);
        if ($params) {
            if ($params['errcode'] === 0) {
                $this->success("进入审核中……", weapp_url('Minipro0001/Minipro0001/setting'));
            } else {
                $this->error($params['errmsg']);
            }
        }

        $this->error('接口调用失败，请重新尝试');
    }

    /**
     * 查询审核状态
     */
    public function getAuditstatus()
    {
        $inc = $this->logic->getSetting();
        if (empty($inc)) {
            $this->error('先填写小程序配置');
        }

        $post_data = array(
            'appid' => $inc['appId'],
        );
        $response = httpRequest($this->logic->get_api_url("api/Minipro/getAuditstatus.html"), "POST", $post_data);
        $params = array();
        $params = json_decode($response,true);
        if ($params) {
            echo json_encode($params);
            exit;
        }

        echo json_encode(array('errcode'=>-1, 'errmsg'=>'查询审核状态出错！'));
        exit;
    }

    /**
     * 发布小程序
     */
    public function release()
    {
        $inc = $this->logic->getSetting();
        if (empty($inc)) {
            $this->error('先填写小程序配置');
        }

        if ($inc['auditstatus'] == 2) {
            $estimateTime = date('Y-m-d H:i:s', $inc['estimateTime']);
            $this->success("审核中……预计{$estimateTime}之前完成", weapp_url('Minipro0001/Minipro0001/setting'), '', 3);
        } else if ($inc['auditstatus'] == 1) {
            $this->error('审核失败，原因：'.$inc['reason'], weapp_url('Minipro0001/Minipro0001/setting'), '', 5);
        }

        $post_data = array(
            'appid' => $inc['appId'],
        );
        $response = httpRequest($this->logic->get_api_url("api/Minipro/release.html"), "POST", $post_data);
        $params = array();
        $params = json_decode($response,true);
        if ($params) {
            if ($params['errcode'] === 0) {
                $this->success("发布成功", weapp_url('Minipro0001/Minipro0001/setting'));
            } else {
                $this->error($params['errmsg'].'(代码'.$params['errcode'].')', weapp_url('Minipro0001/Minipro0001/setting'), '', 3);
            }
        }

        $this->error('接口调用失败，请重新尝试');
    }

    /**
     * 下载小程序码
     */
    public function getWxaCodeunlimit()
    {
        $inc = $this->logic->getSetting();
        if (empty($inc)) {
            $this->error('先填写小程序配置');
        }

        $post_data = array(
            'appid' => $inc['appId'],
        );
        $response = httpRequest($this->logic->get_api_url("api/Minipro/getWxaCodeunlimit.html"), "POST", $post_data);
        $params = array();
        $params = json_decode($response,true);
        if ($params) {
            if ($params['errcode'] === 0) {
                $imgcode = base64_decode($params['errmsg']);
                $filename = md5($inc['appId'].time().mt_rand(1000,9999)).".jpg";
                $bannerurl = UPLOAD_PATH.'minipro/'.date('Y/m/d');
                tp_mkdir($bannerurl);
                $bannerurl = $bannerurl."/".$filename;
                $imgurl = '';
                if (file_put_contents($bannerurl, $imgcode)){
                    $imgurl = SITE_URL."/{$bannerurl}";
                }
                
                $filename = md5($inc['appId'].time().mt_rand(1000,9999)).".jpg";
                // header("Cache-control: private");
                header("Content-Type:application/force-download"); //设置要下载的文件类型
                header("Content-Disposition: attachment; filename={$filename}"); //设置要下载文件的文件名
                readfile($imgurl);
                exit();
            }
        }

        $this->error('接口调用失败，请重新尝试');
    }
}