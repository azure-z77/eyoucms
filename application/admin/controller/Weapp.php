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
use app\admin\logic\WeappLogic;

/**
 * 插件控制器
 */
class Weapp extends Base
{
    public $weappM;
    public $weappLogic;

    /*
     * 初始化操作
     */
    public function _initialize() {
        parent::_initialize();
        $this->weappM = model('Weapp');
        $this->weappLogic = new WeappLogic();
        //  更新插件
        $this->weappLogic->insertWeapp();
    }

    /*
     * 插件列表
     */
    public function index()
    {
        $assign_data = array();
        $condition = array();
        // 获取到所有GET参数
        $get = I('get.');

        // 应用搜索条件
        foreach (['keywords'] as $key) {
            if (isset($get[$key]) && $get[$key] !== '') {
                if ($key == 'keywords') {
                    $condition['a.name|code'] = array('LIKE', "%{$get[$key]}%");
                } else {
                    $condition['a.'.$key] = array('eq', $get[$key]);
                }
            }
        }

        $weappArr = array(); // 插件标识数组

        /**
         * 数据查询，搜索出主键ID的值
         */
        $count = DB::name('weapp')->alias('a')->where($condition)->count();// 查询满足要求的总记录数
        $Page = new Page($count, config('paginate.list_rows'));// 实例化分页类 传入总记录数和每页显示的记录数
        $list = DB::name('weapp')
            ->field('a.*')
            ->alias('a')
            ->order('a.add_time desc')
            ->limit($Page->firstRow.','.$Page->listRows)
            ->getAllWithIndex('id');
        foreach ($list as $key => $val) {
            $val['version'] = getWeappVersion($val['code']);

            switch ($val['status']) {
                case '-1':
                    $status_text = '禁用';
                    break;

                case '1':
                    $status_text = '启用';
                    break;

                default:
                    $status_text = '未安装';
                    break;
            }
            $val['status_text'] = $status_text;

            $list[$key] = $val;

            /*插件标识数组*/
            $weappArr[$val['code']] = array(
                'code'  => $val['code'],
                'version'  => $val['version'],
            );
            /*--end*/
        }
        $show = $Page->show(); // 分页显示输出
        $assign_data['page'] = $show; // 赋值分页输出
        $assign_data['list'] = $list; // 赋值数据集
        $assign_data['pager'] = $Page; // 赋值分页对象

        /*检测更新*/
        $weapp_upgrade = array();
        if (!empty($weappArr)) {
            // 标识
            $codeArr = get_arr_column($weappArr, 'code');
            $codeStr = implode(',', $codeArr);
            // 版本号
            $versionArr = get_arr_column($weappArr, 'version');
            $versionStr = implode(',', $versionArr);
            // URL参数
            $vaules = array(
                'code'  => $codeStr,
                'v'    => $versionStr,
            );
            $tmp_str = 'L2luZGV4LnBocD9tPWFwaSZjPVdlYXBwJmE9Y2hlY2tCYXRjaFZlcnNpb24m';
            $service_url = base64_decode(config('service_ey')).base64_decode($tmp_str);
            $url = $service_url.http_build_query($vaules);
            $context = stream_context_set_default(array('http' => array('timeout' => 3,'method'=>'GET')));
            $response = @file_get_contents($url,false,$context);
            $batch_upgrade = json_decode($response,true);

            if (is_array($batch_upgrade) && !empty($batch_upgrade)) {
                $weapp_upgrade = $this->weappLogic->checkBatchVersion($batch_upgrade); //升级包消息 
            }
        }
        $assign_data['weapp_upgrade'] = $weapp_upgrade;
        /*--end*/

        $this->assign($assign_data);
        return $this->fetch();
    }

    /**
     *  执行插件控制器
     *  控制模块  参数m
     *  控制器名  参数c来确定
     *  控制器里-操作名  参数a
     *  http://网站域名/login.php/weapp/execute?m=login&c=Qq&a=callback
     */
    public function execute($sm = '', $sc = '', $sa = '')
    {
        if (!IS_AJAX) {
            $msg = $this->weappLogic->checkInstall();
            if ($msg !== true) {
                $this->error($msg);
            }
        }
        $sm = request()->param('sm');
        $sc = request()->param('sc');
        $sa = request()->param('sa');
        $controllerName = !empty($sc) ? format_class($sc) : format_class($sm);
        $actionName = !empty($sa) ? $sa : "index";
        $class_path = "\\".WEAPP_DIR_NAME."\\".$sm."\\controller\\".$controllerName;
        $controller = new $class_path();
        $result = $controller->$actionName();
        return $result;
    }

    /**
     * 安装插件
     */
    public function install(){
        $id       =   I('id');
        $row      =   M('Weapp')->field('code,thorough,min_version')->find($id);
        $class    =   get_weapp_class($row['code']);
        if (!class_exists($class)) {
            $this->error('插件不存在！');
        }
        $weapp  =   new $class;
        if(!$weapp->checkConfig()) {//检测信息的正确性
            $this->error('插件config配置参数不全！');
        }
        $cms_version = getCmsVersion();
        $min_version = $row['min_version'];
        if ($cms_version < $min_version) {
            $this->error('当前CMS版本太低，该插件要求CMS版本 >= '.$min_version.'，请升级系统！');
        }
        $data   =   $weapp->install();
        if (true == $data['status']) {
            /*插件sql文件*/
            $sqlfile = WEAPP_PATH.$row['code'].DS.'data'.DS.'install.sql';
            if (empty($row['thorough']) && file_exists($sqlfile)) {
                $execute_sql = file_get_contents($sqlfile);
                $sqlFormat = $this->sql_split($execute_sql, PREFIX);
                /**
                 * 执行SQL语句
                 */
                $counts = count($sqlFormat);

                for ($i = 0; $i < $counts; $i++) {
                    $sql = trim($sqlFormat[$i]);

                    if (strstr($sql, 'CREATE TABLE')) {
                        Db::execute($sql);
                    } else {
                        if(trim($sql) == '')
                           continue;
                        Db::execute($sql);
                    }
                }
            }
            /*--end*/
            $r = M('weapp')->where('id',$id)->update(array('thorough'=>1,'status'=>1,'add_time'=>getTime()));
            if ($r) {
                cache('hooks', null);
                cache("hookexec_".$row['code'], null);
                $this->success($data['message'], U('Weapp/index'));
                exit;
            }
        }

        $this->error($data['message']);
    }

    /**
     * 卸载插件
     */
    public function uninstall(){
        $id       =   I('param.id/d', 0);
        $thorough = I('param.thorough/d', 0);
        $row      =   M('Weapp')->field('code')->find($id);
        $class    =   get_weapp_class($row['code']);
        if (!class_exists($class)) {
            $this->error('插件不存在！');
        }
        $weapp  =   new $class;
        $data =   $weapp->uninstall();
        if (true == $data['status']) {
            if (1 == $thorough) {
                $r = M('weapp')->where('id',$id)->update(array('thorough'=>$thorough,'status'=>0,'add_time'=>getTime()));
            } else if (0 == $thorough) {
                $r = M('weapp')->where('id',$id)->delete();
            }
            if (false !== $r) {
               /*插件sql文件，不执行删除插件数据表*/
                $sqlfile = WEAPP_PATH.$row['code'].DS.'data'.DS.'uninstall.sql';
                if (empty($thorough) && file_exists($sqlfile)) {
                    $execute_sql = file_get_contents($sqlfile);
                    $sqlFormat = $this->sql_split($execute_sql, PREFIX);
                    /**
                     * 执行SQL语句
                     */
                    $counts = count($sqlFormat);

                    for ($i = 0; $i < $counts; $i++) {
                        $sql = trim($sqlFormat[$i]);

                        if (strstr($sql, 'CREATE TABLE')) {
                            Db::execute($sql);
                        } else {
                            if(trim($sql) == '')
                               continue;
                            Db::execute($sql);
                        }
                    }
                }
                /*--end*/

                cache('hooks', null);
                cache("hookexec_".$row['code'], null);
                $this->success($data['message'], U('Weapp/index'));
                exit;
            }
        }

        $this->error($data['message']);
    }

    /**
     * 启用插件
     */
    public function enable()
    {
        $id       =   I('param.id/d', 0);
        if (0 < $id) {
            $r = M('weapp')->where('id',$id)->update(array('status'=>1,'update_time'=>getTime()));
            if ($r) {
                $row = M('weapp')->field('code')->find($id);
                cache("hookexec_".$row['code'], null);
                cache('hooks', null);
                $this->success('操作成功！', U('Weapp/index'));
                exit;
            }
        }
        $this->success('操作失败！');
        exit;
    }

    /**
     * 禁用插件
     */
    public function disable()
    {
        $id       =   I('param.id/d', 0);
        if (0 < $id) {
            $r = M('weapp')->where('id',$id)->update(array('status'=>-1,'update_time'=>getTime()));
            if ($r) {
                $row = M('weapp')->field('code')->find($id);
                cache("hookexec_".$row['code'], null);
                cache('hooks', null);
                $this->success('操作成功！', U('Weapp/index'));
                exit;
            }
        }
        $this->success('操作失败！');
        exit;
    }

    /**
     * 分解SQL文件的语句
     */
    public function sql_split($sql, $tablepre) {

        $sql = str_replace("#@__", $tablepre, $sql);

        $sql = preg_replace("/TYPE=(InnoDB|MyISAM|MEMORY)( DEFAULT CHARSET=[^; ]+)?/", "ENGINE=\\1 DEFAULT CHARSET=utf8", $sql);
        
        $sql = str_replace("\r", "\n", $sql);
        $ret = array();
        $num = 0;
        $queriesarray = explode(";\n", trim($sql));
        unset($sql);
        foreach ($queriesarray as $query) {
            $ret[$num] = '';
            $queries = explode("\n", trim($query));
            $queries = array_filter($queries);
            foreach ($queries as $query) {
                $str1 = substr($query, 0, 1);
                if ($str1 != '#' && $str1 != '-')
                    $ret[$num] .= $query;
            }
            if (!stristr($ret[$num], 'SET FOREIGN_KEY_CHECKS') && false === stripos($ret[$num], $tablepre.'weapp_')) {
                $this->error('数据表前缀不符合插件规范（#@__weapp_）');
            }
            $num++;
        }
        return $ret;
    }

    /**
     * 上传插件并解压
     */
    public function upload() 
    {
        if (IS_POST) {
            $fileError = isset($_FILES['weappfile']['error']) ? $_FILES['weappfile']['error'] : 0;
            switch ($fileError) {
                case '1':
                    $errmsg = '上传的文件超过了 php.ini 中 upload_max_filesize选项限制的值';
                    break;
                
                case '2':
                    $errmsg = '上传文件的大小超过了 HTML 表单中 MAX_FILE_SIZE 选项指定的值';
                    break;
                
                case '3':
                    $errmsg = '文件只有部分被上传';
                    break;
                
                case '4':
                    $errmsg = '请上传zip压缩包';
                    break;
                
                case '5':
                    $errmsg = '上传文件大小为0';
                    break;

                default:
                    # code...
                    break;
            }
            if ($fileError > 0) {
                $this->error($errmsg);
                exit;
            }

            $fileExt = 'zip';
            $savePath = UPLOAD_PATH.'tmp'.DS;
            $image_upload_limit_size = intval(tpCache('basic.file_size') * 1024 * 1024);
            $file = request()->file('weappfile');
            if(empty($file)){
                $this->error('请先上传zip文件');
            }
            $error = $file->getError();
            if(!empty($error)){
                $this->error($error);
            }
            $result = $this->validate(
                ['file' => $file], 
                ['file'=>'fileSize:'.$image_upload_limit_size.'|fileExt:'.$fileExt],
                ['file.fileSize' => '上传文件过大','file.fileExt'=>'上传文件后缀名必须为'.$fileExt]
            );
            if (true !== $result || empty($file)) {
                $this->error($result);
            }
            // 移动到框架应用根目录/public/upload/tmp/ 目录下
            $fileName = md5(getTime().uniqid(mt_rand(), TRUE)).'.'.$fileExt; // 上传之后的文件全名
            $folderName = str_replace(".zip", "", $fileName);  // 文件名，不带扩展名
            /*使用自定义的文件保存规则*/
            $info = $file->rule(function ($file) {
                return  $folderName;
            })->move($savePath, $folderName);
            /*--end*/
            if ($info) {
                $filepath = $savePath.$fileName;
                if (file_exists($filepath)) {
                    /*解压之前，删除存在的文件夹*/
                    delFile($savePath.$folderName);
                    /*--end*/

                    /*解压文件*/
                    $zip = new \ZipArchive();//新建一个ZipArchive的对象
                    if ($zip->open($savePath.$fileName) != true) {
                        $this->error("插件压缩包读取失败!");
                    }
                    $zip->extractTo($savePath.$folderName.DS);//假设解压缩到在当前路径下插件名称文件夹内
                    $zip->close();//关闭处理的zip文件
                    /*--end*/
                    
                    /*获取插件目录名称*/
                    $dirList = glob($savePath.$folderName.DS.WEAPP_DIR_NAME.DS.'*');
                    $weappPath = !empty($dirList) ? $dirList[0] : '';
                    if (empty($weappPath)) {
                        $this->error('插件压缩包缺少目录文件');
                    }
                    $weappPath = str_replace("\\", DS, $weappPath);
                    $weappPathArr = explode(DS, $weappPath);
                    $weappName = $weappPathArr[count($weappPathArr) - 1];
                    if (is_dir(ROOT_PATH.WEAPP_DIR_NAME.DS.$weappName)) {
                        $this->error("已存在同名插件{$weappName}，请手工移除".WEAPP_DIR_NAME.DS.$weappName."目录");
                    }
                    /*--end*/

                    // 递归复制文件夹            
                    recurse_copy($savePath.$folderName, rtrim(ROOT_PATH, DS));

                    /*删除上传的插件包*/
                    @unlink(realpath($savePath.$fileName));
                    @delFile($savePath.$folderName, true);
                    /*--end*/

                    $this->success("上传插件成功", U('Weapp/index'));
                }
            }else{
                //上传错误提示错误信息
                $this->error($info->getError());
            }
        }
    }

    /**
     * 一键更新插件
     */
    public function OneKeyUpgrade()
    {
        header('Content-Type:application/json; charset=utf-8');
        $code = I('param.code/s', '');
        $upgradeMsg = $this->weappLogic->OneKeyUpgrade($code); //一键更新插件
        respose($upgradeMsg);
    }

    /**
     * 检查插件是否有更新包
     * @return type 提示语
     */
    public function checkVersion()
    { 
        // error_reporting(0);//关闭所有错误报告
        $upgradeMsg = $this->weappLogic->checkVersion(); //升级包消息   
        respose($upgradeMsg);
    }

    /**
     * 创建初始插件结构
     */
    public function create()
    {

    }
}