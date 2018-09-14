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
use think\Db;
use think\Cache;

class System extends Base
{
    /*
     * 配置入口
     */
    public function index()
    {
        /*配置列表*/
        $group_list = [
            'web'       => '基本信息',
            'web2'     => '核心设置',
            'basic'     => '附件设置',
            // 'sms'       => '短信设置',
            // 'smtp'      => '邮件设置',
            'water'     => '图片水印',
            // 'oss'       => 'OSS对象存储'
        ];      
        $this->assign('group_list',$group_list);

        $inc_type =  I('get.inc_type','web');
        $this->assign('inc_type',$inc_type);

        $config = tpCache($inc_type);
        if ($inc_type == 'web') {
            // 网站logo
            if (is_http_url($config['web_logo'])) {
                $config['web_logo_is_remote'] = 1;
                $config['web_logo_remote'] = $config['web_logo'];
            } else {
                $config['web_logo_is_remote'] = 0;
                $config['web_logo_local'] = $config['web_logo'];
            }
            // 浏览器地址图标
            if (is_http_url($config['web_ico'])) {
                $config['web_ico_is_remote'] = 1;
                $config['web_ico_remote'] = $config['web_ico'];
            } else {
                $config['web_ico_is_remote'] = 0;
                $config['web_ico_local'] = $config['web_ico'];
            }
            
            /*系统模式*/
            $web_cmsmode = isset($config['web_cmsmode']) ? $config['web_cmsmode'] : 2;
            $this->assign('web_cmsmode', $web_cmsmode);
            /*--end*/

            /*自定义变量*/
            $eyou_row = M('config_attribute')->field('a.attr_id, a.attr_name, a.attr_var_name, a.attr_input_type, b.value, b.id, b.name')
                ->alias('a')
                ->join('__CONFIG__ b', 'b.name = a.attr_var_name', 'LEFT')
                ->where('a.inc_type', $inc_type)
                ->order('a.attr_id asc')
                ->select();
            $this->assign('eyou_row',$eyou_row);
            /*--end*/

        } elseif ($inc_type == 'web2') {
            $config = tpCache('web');
            //自定义后台路径名
            $web_adminbasefile = !empty($config['web_adminbasefile']) ? $config['web_adminbasefile'] : '/login.php';
            $adminbasefile = preg_replace('/^\/(.*)\.([^\.]+)$/i', '$1', $web_adminbasefile);
            $this->assign('adminbasefile', $adminbasefile);
            // 数据库备份目录
            $sqlbackuppath = config('DATA_BACKUP_PATH');
            $this->assign('sqlbackuppath', $sqlbackuppath);

        } elseif ($inc_type == 'water') {
            if (is_http_url($config['mark_img'])) {
                $config['mark_img_is_remote'] = 1;
                $config['mark_img_remote'] = $config['mark_img'];
            } else {
                $config['mark_img_is_remote'] = 0;
                $config['mark_img_local'] = $config['mark_img'];
            }
        }
                //config('TOKEN_ON',false);
        $this->assign('config',$config);//当前配置项
        return $this->fetch($inc_type);
    }
    
    /*
     * 新增修改配置
     */
    public function handle()
    {
        $param = I('post.');
        $inc_type = $param['inc_type'];
        $inc_type_old = '';
        //unset($param['__hash__']);
        unset($param['inc_type']);

        if ($inc_type == 'web') {
            $param['web_keywords'] = str_replace('，', ',', $param['web_keywords']);
            $param['web_description'] = filter_line_return($param['web_description']);
            
            // 网站根网址
            $web_basehost = rtrim($param['web_basehost'], '/');
            if (!is_http_url($web_basehost) && !empty($web_basehost)) {
                $web_basehost = 'http://'.$web_basehost;
            }
            $param['web_basehost'] = $web_basehost;

            // 网站logo
            $web_logo_is_remote = !empty($param['web_logo_is_remote']) ? $param['web_logo_is_remote'] : 0;
            $web_logo = '';
            if ($web_logo_is_remote == 1) {
                $web_logo = $param['web_logo_remote'];
            } else {
                $web_logo = $param['web_logo_local'];
            }
            $param['web_logo'] = $web_logo;
            unset($param['web_logo_is_remote']);
            unset($param['web_logo_remote']);
            unset($param['web_logo_local']);

            // 浏览器地址图标
            $web_ico_is_remote = !empty($param['web_ico_is_remote']) ? $param['web_ico_is_remote'] : 0;
            $web_ico = '';
            if ($web_ico_is_remote == 1) {
                $web_ico = $param['web_ico_remote'];
            } else {
                $web_ico = $param['web_ico_local'];
            }
            $param['web_ico'] = $web_ico;
            unset($param['web_ico_is_remote']);
            unset($param['web_ico_remote']);
            unset($param['web_ico_local']);
            if (!empty($param['web_ico']) && !is_http_url($param['web_ico'])) {
                $web_ico = trim($param['web_ico'], '/');
                $source = ROOT_PATH.$web_ico;
                $destination = ROOT_PATH.'favicon.ico';
                if (file_exists($source) && copy($source, $destination)) {
                    $param['web_ico'] = '/favicon.ico';
                }
            }

        } elseif ($inc_type == 'web2') { // 该板块下的变量值保存到web板块下
            $inc_type_old = $inc_type;
            $inc_type = 'web'; // 保存的版块
            /*EyouCMS安装目录*/
            $web_cmspath = trim($param['web_cmspath'], '/');
            $web_cmspath = !empty($web_cmspath) ? '/'.$web_cmspath : '';
            $param['web_cmspath'] = $web_cmspath;
            /*--end*/
            /*自定义后台路径名*/
            $adminbasefile = trim($param['adminbasefile']).'.php'; // 新的文件名
            $param['web_adminbasefile'] = '/'.$adminbasefile;
            $adminbasefile_old = trim($param['adminbasefile_old']).'.php'; // 旧的文件名
            unset($param['adminbasefile']);
            unset($param['adminbasefile_old']);
            /*--end*/
            $param['web_sqldatapath'] = '/'.trim($param['web_sqldatapath'], '/'); // 数据库备份目录
            $param['web_htmlcache_expires_in'] = intval($param['web_htmlcache_expires_in']); // 页面缓存有效期

        } elseif ($inc_type == 'water') {
            $mark_img_is_remote = !empty($param['mark_img_is_remote']) ? $param['mark_img_is_remote'] : 0;
            $mark_img = '';
            if ($mark_img_is_remote == 1) {
                $mark_img = $param['mark_img_remote'];
            } else {
                $mark_img = $param['mark_img_local'];
            }
            $param['mark_img'] = $mark_img;
            unset($param['mark_img_is_remote']);
            unset($param['mark_img_remote']);
            unset($param['mark_img_local']);
        }
        tpCache($inc_type,$param);
        write_global_params(); // 写入全局内置参数
        if ($inc_type_old == 'web2') { // 保存该板块下的后续业务逻辑
            /*更改自定义后台路径名*/
            if ($adminbasefile_old != $adminbasefile) {
                if(rename($adminbasefile_old, $adminbasefile)) {
                    $gourl = SITE_URL.'/'.$adminbasefile;
                    $this->success('操作成功', $gourl, '', 1, [], '_parent');
                }
            }
            /*--end*/
        }
        $inc_type = I('post.inc_type/s');
        $this->success('操作成功', U('System/index',array('inc_type'=>$inc_type)));
    }  

    /**
     * 清空缓存
     */
    public function clearCache($arr = array())
    {
        if (IS_POST) {
            $post = I('post.');

            if (!empty($post['clearHtml'])) { // 清除页面缓存
                $this->clearHtmlCache($post['clearHtml']);
            }

            if (!empty($post['clearCache'])) { // 清除数据缓存
                $this->clearSystemCache($post['clearCache']);
            }

            $this->success('操作成功！', U('Index/welcome'));
        }
        return $this->fetch();
    }

    /**
     * 清空数据缓存
     */
    public function fastClearCache($arr = array())
    {
        $this->clearSystemCache();
        $script = "<script>parent.layer.msg('操作成功', {time:3000,icon: 1});window.location='".U('Index/welcome')."';</script>";
        echo $script;
    }

    /**
     * 清空数据缓存
     */
    public function clearSystemCache($arr = array())
    {
        if (empty($arr)) {
            delFile(rtrim(RUNTIME_PATH, '/'));
            Cache::clear();
        } else {
            foreach ($arr as $key => $val) {
                delFile(RUNTIME_PATH.$val);
            }
        }
        tpCache('global');

        return true;
    }

    /**
     * 清空页面缓存
     */
    public function clearHtmlCache($arr = array())
    {
        if (empty($arr)) {
            delFile(rtrim(HTML_ROOT, '/'));
        } else {
            foreach ($arr as $key => $val) {
                foreach (['http','https'] as $sk1 => $sv1) {
                    foreach (['pc','mobile'] as $sk2 => $sv2) {
                        delFile(HTML_ROOT."{$sv1}/{$sv2}/{$val}");
                        delFile(HTML_ROOT."{$sv1}/{$sv2}/cache/{$val}");
                    }
                }
                if ($val == 'index') {
                    foreach (['index.html','indexs.html'] as $sk1 => $sv1) {
                        $filename = ROOT_PATH.$sv1;
                        if (file_exists($filename)) {
                            @unlink($filename);
                        }
                    }
                }
            }
        }
    }

    /**
     * 地区设置
     */
    public function region()
    {
        $parent_id = I('parent_id',0);
        if($parent_id == 0){
            $parent = array('id'=>0,'name'=>"中国省份地区",'level'=>0, 'parent_id'=>0);
        }else{
            $parent = M('region')->where("id" ,$parent_id)->find();
        }
        $names = $this->getParentRegionList($parent_id);
        if(!empty($names)){
            $names = array_reverse($names);
            $parent_path = implode($names, '>');
        }
        $region = M('region')->where("parent_id" , $parent_id)->select();
        $this->assign('parent',$parent);
        $this->assign('parent_path',$parent_path);
        $this->assign('region',$region);
        return $this->fetch();
    }

    /**
     * 寻找Region_id的父级字段, $column可自己指定
     * @param $parent_id
     * @return array
     */
    function getParentRegionList($parent_id)
    {
        $names = array();
        $region =  M('region')->where(array('id'=>$parent_id))->find();
        array_push($names,$region['name']);
        if($region['parent_id'] != 0){
            $nregion = $this->getParentRegionList($region['parent_id']);
            if(!empty($nregion)){
                $names = array_merge($names, $nregion);
            }
        }
        return $names;
    }
    
    /**
     * 添加地区
     */
    public function region_add()
    {
        $data = I('post.');
        $referurl =  isset($_SERVER['HTTP_REFERER']) ? $_SERVER['HTTP_REFERER'] : U("System/region");
        $data['level'] = $data['level']+1;
        if(empty($data['name'])){
            $this->error("请填写地区名称", $referurl);
        }else{
            $res = M('region')->where("parent_id = ".$data['parent_id']." and name='".$data['name']."'")->find();
            if(empty($res)){
                // 清除一下缓存
                \think\Cache::clear('region');
                M('region')->add($data);
                $this->success("操作成功", $referurl);
            }else{
                $this->error("该区域下已有该地区，请检查", $referurl);
            }
        }
    }
    
    /**
     * 删除地区
     */
    public function region_del()
    {
        $id = I('id/d', 0);
        $referurl =  isset($_SERVER['HTTP_REFERER']) ? $_SERVER['HTTP_REFERER'] : U("System/region");
        if ($id) {
            M('region')->where("id=$id or parent_id=$id")->delete();
            // 清除一下缓存
            \think\Cache::clear('region');
            $this->success("操作成功", $referurl);
        } else {
            $this->error("操作失败", $referurl);
        }
    }
      
    /**
     * 发送测试邮件
     */
    public function send_email()
    {
        $param = I('post.');
        $res = send_email($param['smtp_test_eamil'],'易优CMS','易优CMS验证码:'.mt_rand(1000,9999), 1);
        exit(json_encode($res));
    }
      
    /**
     * 发送测试短信
     */
    public function send_mobile()
    {
        $param = I('post.');
        $res = sendSms(4,$param['sms_test_mobile'],array('content'=>mt_rand(1000,9999)));
        exit(json_encode($res));
    }

    /**
     * 新增自定义变量
     */
    public function customvar()
    {
        if (IS_POST) {
            $configAttributeM = model('ConfigAttribute');

            $post_data = I('post.');
            $attr_input_type = isset($post_data['attr_input_type']) ? $post_data['attr_input_type'] : '';

            if ($attr_input_type == 3) {
                // 本地/远程图片上传的处理
                $is_remote = !empty($post_data['is_remote']) ? $post_data['is_remote'] : 0;
                $litpic = '';
                if ($is_remote == 1) {
                    $litpic = $post_data['value_remote'];
                } else {
                    $litpic = $post_data['value_local'];
                }
                $attr_values = $litpic;
            } else {
                $attr_values = I('attr_values');
                // $attr_values = str_replace('_', '', $attr_values); // 替换特殊字符
                // $attr_values = str_replace('@', '', $attr_values); // 替换特殊字符
                $attr_values = trim($attr_values);
                $attr_values = isset($attr_values) ? $attr_values : '';
            }

            $savedata = array(
                'inc_type'    => $post_data['inc_type'],
                'attr_name' => $post_data['attr_name'],
                'attr_input_type'   => $attr_input_type,
                'attr_values'   => $attr_values,
                'update_time'   => getTime(),
            );

            // 数据验证            
            $validate = \think\Loader::validate('ConfigAttribute');
            if(!$validate->batch()->check($savedata))
            {
                $error = $validate->getError();
                $error_msg = array_values($error);
                $return_arr = array(
                    'errcode'   => -1,
                    'errmsg'    => $error_msg[0],
                );
                respose($return_arr);
            } else {
                if (isset($post_data['id']) && $post_data['id'] > 0) {
                    $savedata['attr_id'] = $post_data['attr_id'];
                    $configAttributeM->data($savedata,true); // 收集数据
                    $configAttributeM->isUpdate(true)->save(); // 写入数据到数据库  
                    // 更新变量名
                    $attr_var_name = $post_data['name'];
                    adminLog('编辑自定义变量：'.$savedata['attr_name']);
                } else {
                    $savedata['add_time'] = getTime();
                    $configAttributeM->data($savedata,true); // 收集数据
                    $configAttributeM->save(); // 写入数据到数据库
                    $insert_id = $configAttributeM->getLastInsID();
                    // 更新变量名
                    $attr_var_name = $post_data['inc_type'].'_attr_'.$insert_id;
                    $map = array(
                        'attr_id'   => $insert_id,
                    );
                    M('ConfigAttribute')->where($map)->update(array('attr_var_name'=>$attr_var_name));
                    adminLog('新增自定义变量：'.$savedata['attr_name']);
                }

                // 保存到config表，更新缓存
                $inc_type = $post_data['inc_type'];
                $configData = array(
                    $attr_var_name  => $attr_values,
                );
                tpCache($inc_type, $configData);

                $return_arr = array(
                    'errcode'   => 0,
                    'errmsg'    => '操作成功',
                );
                respose($return_arr);
            }  
        }

        $id = I('param.id/d', 0);
        $field = array();
        if ($id > 0) {
            $field = M('config')->field('a.id, a.value, a.name, b.attr_id, b.attr_name, b.attr_input_type')
                ->alias('a')
                ->join('__CONFIG_ATTRIBUTE__ b', 'a.name = b.attr_var_name', 'LEFT')
                ->find($id);
            if ($field['attr_input_type'] == 3) {
                if (is_http_url($field['value'])) {
                    $field['is_remote'] = 1;
                    $field['value_remote'] = $field['value'];
                } else {
                    $field['is_remote'] = 0;
                    $field['value_local'] = $field['value'];
                }
            }
        }
        $this->assign('field', $field);

        $inc_type = I('param.inc_type/s', '');
        $this->assign('inc_type', $inc_type);

        return $this->fetch();
    }

    /**
     * 删除自定义变量
     */
    public function customvar_del()
    {
        $id = I('del_id/d');
        $inc_type = I('param.inc_type/s', '');
        if(!empty($id)){
            $attr_var_name = M('config')->where("id = $id")->getField('name');

            $r = M('config')->where("id = $id")->delete();
            if($r){
                // 同时删除
                M('config_attribute')->where(array('attr_var_name'=>array('eq', $attr_var_name)))->delete();
                adminLog('删除自定义变量：'.$attr_var_name);
                respose(array('status'=>1, 'msg'=>'删除成功'));
            }else{
                respose(array('status'=>0, 'msg'=>'删除失败'));
            }
        }else{
            respose(array('status'=>0, 'msg'=>'参数有误'));
        }
    }
}