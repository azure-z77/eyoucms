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

class Channeltype extends Base
{
    // 系统默认的模型ID，不可删除
    private $channeltype_system_id = [];

    // 数据库对象
    public $channeltype_db;
    
    public function _initialize() {
        parent::_initialize();
        $this->channeltype_db = Db::name('channeltype');
        $this->channeltype_system_id = $this->channeltype_db->where([
                'ifsystem'  => 1,
            ])->column('id');
    }

    public function index()
    {
        $list = array();
        $param = input('param.');
        $condition = array();
        // 应用搜索条件
        foreach (['keywords'] as $key) {
            if (isset($param[$key]) && $param[$key] !== '') {
                if ($key == 'keywords') {
                    $condition['a.title'] = array('LIKE', "%{$param[$key]}%");
                } else {
                    $condition['a.'.$key] = array('eq', $param[$key]);
                }
            }
        }

        $count = $this->channeltype_db->alias('a')->where($condition)->count('id');// 查询满足要求的总记录数
        $pageObj = new Page($count, config('paginate.list_rows'));// 实例化分页类 传入总记录数和每页显示的记录数
        $list = $this->channeltype_db->alias('a')
            ->where($condition)
            ->order('ifsystem desc, id asc')
            ->limit($pageObj->firstRow.','.$pageObj->listRows)
            ->select();

        $pageStr = $pageObj->show();// 分页显示输出
        $this->assign('pageStr',$pageStr);// 赋值分页输出
        $this->assign('list',$list);// 赋值数据集
        $this->assign('pageObj',$pageObj);// 赋值分页对象

        return $this->fetch();
    }
    
    /**
     * 新增
     */
    public function add()
    {
        if (IS_POST) {
            $post = input('post.');
            if (!empty($post)) {
                $post['title'] = trim($post['title']);
                if (empty($post['title'])) {
                    $this->error('模型名称不能为空！');
                }

                $post['nid'] = trim($post['nid']);
                if (empty($post['nid'])) {
                    $this->error('模型标识不能为空！');
                } else {
                    if (!preg_match('/^([a-z]+)([a-z0-9]*)$/i', $post['nid'])) {
                        $this->error('模型标识必须以小写字母开头！');
                    }
                }

                $post['nid']    = strtolower($post['nid']);
                $nid = $post['nid'];
                $post['ctl_name'] = ucwords($nid);
                $post['table']    = $nid;
                
                if($this->channeltype_db->where(['nid'=>$nid])->count('id') > 0){
                    $this->error('该模型标识已存在，请检查', url('Channeltype/index'));
                }

                // 创建文件以及数据表
                $this->create_sql_file($post);

                $nowData = array(
                    'ntitle'        => $post['title'],
                    'nid'           => $nid,
                    'add_time'      => getTime(),
                    'update_time'   => getTime(),
                );
                $data = array_merge($post, $nowData);
                $insertId = $this->channeltype_db->insertGetId($data);
                $_POST['id'] = $insertId;
                if ($insertId) {
                    // 复制模型字段基础数据
                    $model_db = Db::name('modelfield');
                    $modelCount = $model_db->where('model_id', $insertId)->count();
                    if (empty($modelCount)) {
                        $modelRow = $model_db->field('id',true)
                            ->where('model_id', 0)
                            ->order('id asc')
                            ->select();
                        if (!empty($modelRow)) {
                            foreach ($modelRow as $key => $val) {
                                $modelRow[$key]['model_id'] = $insertId;
                            }
                            $insertObject = model('modelfield')->saveAll($modelRow);
                            $insertNum = count($insertObject);
                            if ($insertNum != count($modelRow)) {
                                $this->error('保存 '.PREFIX.'modelfield 表的模型字段失败，请删除该模型重新新增，否则会导致发布时表单不正常。');
                            }
                        }
                    }

                    try {
                        schemaTable($post['table'].'_content');
                    } catch (\Exception $e) {}

                    delFile(CACHE_PATH, true);
                    extra_cache('admin_channeltype_list_logic', NULL);
                    adminLog('新增模型：'.$post['title']);
                    $this->success("操作成功", url('Channeltype/index'));
                }
            }
            $this->error("操作失败");
        }

        return $this->fetch();
    }

    /**
     * 编辑
     */
    public function edit()
    {
        $id = input('id/d');

        if (IS_POST) {
            $post = input('post.');
            if(!empty($post['id'])){
                $post['title'] = trim($post['title']);

                if (in_array($post['id'], $this->channeltype_system_id)) {
                    unset($post['title']);
                } else {
                    if (empty($post['title'])) {
                        $this->error('模型名称不能为空！');
                    }

                    $map = array(
                        'id'    => ['NEQ', $post['id']],
                        'nid' => strtolower($post['nid']),
                    );
                    if($this->channeltype_db->where($map)->count('id') > 0){
                        $this->error('该模型标识已存在，请检查', url('Channeltype/index'));
                    }
                }

                $nowData = array(
                    'update_time'       => getTime(),
                );
                unset($post['nid']);
                $data = array_merge($post, $nowData);
                $r = $this->channeltype_db
                    ->where(['id'=>$post['id']])
                    ->cache(true,null,"channeltype")
                    ->update($data);
                if ($r) {
                    extra_cache('admin_channeltype_list_logic', NULL);
                    adminLog('编辑模型：'.$data['title']);
                    $this->success("操作成功", url('Channeltype/index'));
                }
            }
            $this->error("操作失败");
        }

        $assign_data = array();

        $info = $this->channeltype_db->field('a.*')
            ->alias('a')
            ->where(array('a.id'=>$id))
            ->find();
        if (empty($info)) {
            $this->error('数据不存在，请联系管理员！');
            exit;
        }
        $assign_data['field'] = $info;

        $this->assign($assign_data);
        return $this->fetch();
    }

    
    /**
     * 删除
     */
    public function del()
    {
        $id_arr = input('del_id/a');
        $id_arr = eyIntval($id_arr);
        if(IS_POST){
            if(!empty($id_arr)){
                foreach ($id_arr as $key => $val) {
                    if (array_key_exists($val, $this->channeltype_system_id)) {
                        $this->error('系统内置模型，禁止删除！');
                    }
                } 

                $result = $this->channeltype_db->field('title,nid')->where("id",'IN',$id_arr)->select();
                $title_list = get_arr_column($result, 'title');

                $r = $this->channeltype_db->where("id",'IN',$id_arr)->delete();
                if ($r) {
                    // 删除栏目
                    $arctype = Db::name('arctype')->where("channeltype",'IN',$id_arr)
                        ->whereOr("current_channel", 'IN', $id_arr)
                        ->delete();
                    // 删除文章
                    $archives = Db::name('archives')->where("channel",'IN',$id_arr)->delete();
                    // 删除模型字段
                    $modelfield = Db::name('modelfield')->where("model_id",'IN',$id_arr)->delete();
                    // 删除自定义字段
                    $channelfield = Db::name('channelfield')->where("channel_id",'IN',$id_arr)->delete();

                    // 删除文件
                    foreach ($result as $key => $value) {
                        $nid = $value['nid'];

                        try {
                            // 删除相关数据表
                            Db::execute('DROP TABLE '.PREFIX.$nid.'_content');
                        } catch (\Exception $e) {}

                        $filelist_path = 'data/model/custom_model_path/'.$nid.'.filelist.txt';
                        $fileStr = file_get_contents($filelist_path);
                        $filelist = explode("\n\r", $fileStr);
                        foreach ($filelist as $k1 => $v1) {
                            $v1 = trim($v1);
                            if (!empty($v1)) {
                                @unlink($v1);
                            }
                        }
                        @unlink($filelist_path);
                        delFile('application/admin/template/'.$nid, true);
                    }
                    
                    delFile(CACHE_PATH, true);
                    extra_cache('admin_channeltype_list_logic', NULL);
                    adminLog('删除模型：'.implode(',', $title_list));
                    $this->success('删除成功');
                }
                $this->error('删除失败');
            }
            $this->error('参数有误');
        }
        $this->error('非法访问');
    }

    public function field_management()
    {
        $assign_data = array();
        $condition = array();
        // 获取到所有GET参数
        $param = input('param.');
        if ($param['id']) {
            $condition['model_id'] = $param['id'];
        }

        // 应用搜索条件
        foreach (['keywords'] as $key) {
            if (isset($param[$key]) && $param[$key] !== '') {
                if ($key == 'keywords') {
                    $condition['name'] = array('LIKE', "%{$param[$key]}%");
                } else {
                    $condition[$key] = array('eq', $param[$key]);
                }
            }
        }
        $condition['status'] = 0;

        $modelfield =  M('modelfield');
        $count = $modelfield->where($condition)->count('id');// 查询满足要求的总记录数
        $Page = $pager = new Page($count, config('paginate.list_rows'));// 实例化分页类 传入总记录数和每页显示的记录数
        $list = $modelfield->where($condition)->order('model_id desc, id desc')->limit($Page->firstRow.','.$Page->listRows)->select();

        $show = $Page->show();// 分页显示输出
        $assign_data['page'] = $show; // 赋值分页输出
        $assign_data['list'] = $list; // 赋值数据集
        $assign_data['pager'] = $Page; // 赋值分页对象

        /*字段类型列表*/
        $assign_data['fieldtypeList'] = M('field_type')->field('name,title')->getAllWithIndex('name');
        /*--end*/

        /*有效的模型列表*/
        $channeltype_list = model('Channeltype')->getAll('*', ['status'=>1], 'nid');
        foreach ($channeltype_list as $key => $val) {
            if ('guestbook' == $key) { // 排除留言模型
                unset($channeltype_list[$key]);
            }
        }
        $assign_data['channeltype_list'] = $channeltype_list;
        /*--end*/

        /*模型ID*/
        $assign_data['channel_id'] = $channel_id;
        /*--end*/

        $this->assign($assign_data);
        return $this->fetch();
    }

    /**
     * 显示与隐藏
     */
    public function field_management_show()
    {
        if (IS_POST) {
            $id = input('id/d');
            $ifeditable = input('ifeditable/d');
            if(!empty($id)){
                $row = Db::name('modelfield')->where([
                        'id'    => $id,
                    ])->find();
                if (!empty($row) && 1 == intval($row['status'])) {
                    $this->error('系统内置表单，禁止操作！');
                }
                $r = Db::name('modelfield')->where([
                        'id'    => $id,
                    ])->update([
                        'ifeditable'    => $ifeditable,
                        'update_time'   => getTime(),
                    ]);
                if($r){
                    adminLog('操作自定义模型表单：'.$row['name']);
                    $this->success('操作成功');
                }else{
                    $this->error('操作失败');
                }
            } else {
                $this->error('参数有误');
            }
        }
        $this->error('非法访问');
    }

    // 解析sql语句
    private function sql_split($sql, $tablepre) {
        if ($tablepre != "ey_")
            $sql = str_replace("ey_", $tablepre, $sql);
              
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
            $num++;
        }
        return $ret;
    }

    // 创建文件以及数据表
    private function create_sql_file($post) {
        $demopath = 'data/model/';
        $fileArr = []; // 生成的相关文件记录
        $filelist = getDirFile($demopath);
        foreach ($filelist as $key => $file) {
            if (stristr($file, 'custom_model_path')) {
                unset($filelist[$key]);
                continue;
            }
            $src = $demopath.$file;
            $dst = $file;
            $dst = str_replace('CustomModel', $post['ctl_name'], $dst);
            $dst = str_replace('custommodel', $post['nid'], $dst);
            /*记录相关文件*/
            if (!stristr($dst, 'custom_model_path')) {
                array_push($fileArr, $dst);
            }
            /*--end*/
            if(tp_mkdir(dirname($dst))) {
                $fileContent = @file_get_contents($src);
                $fileContent = str_replace('CustomModel', $post['ctl_name'], $fileContent);
                $fileContent = str_replace('custommodel', strtolower($post['nid']), $fileContent);
                $fileContent = str_replace('CUSTOMMODEL', strtoupper($post['nid']), $fileContent);
                $puts = @file_put_contents($dst, $fileContent);
                if (!$puts) {
                    $this->error('创建自定义模型生成相关文件失败！');
                }
            }
        }
        @file_put_contents($demopath.'custom_model_path/'.$post['nid'].'.filelist.txt', implode("\n\r", $fileArr));

        // 创建自定义模型附加表
        $table = 'ey_'.$post['table'].'_content';
        $tableSql = <<<EOF
CREATE TABLE `{$table}` (
  `id`          int(10) NOT NULL    AUTO_INCREMENT,
  `aid`         int(10) DEFAULT '0' COMMENT         '文档ID',
  `add_time`    int(11) DEFAULT '0' COMMENT         '新增时间',
  `update_time` int(11) DEFAULT '0' COMMENT         '更新时间',
  PRIMARY KEY (`id`),
  KEY `aid` (`aid`) USING BTREE
) ENGINE=MyISAM AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COMMENT='附加表';
EOF;
        $sqlFormat  = $this->sql_split($tableSql, PREFIX);

        // 执行SQL语句
        try {
            $counts = count($sqlFormat);
            for ($i = 0; $i < $counts; $i++) {
                $sql = trim($sqlFormat[$i]);
                if (stristr($sql, 'CREATE TABLE')) {
                    Db::execute($sql);
                } else {
                    if(trim($sql) == '')
                       continue;
                    Db::execute($sql);
                }
            }
        } catch (\Exception $e) {
            $this->error('数据库表创建失败，请检查'.$table.'表是否存在并删除，不行就请求技术支持！');
        }
    }
}