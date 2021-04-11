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
use think\Page;

class Tags extends Base
{
    public function index()
    {
        /*纠正tags标签的文档数*/
        $this->correct();
        /*end*/

        $list = array();
        $keywords = input('keywords/s');

        $condition = array();
        if (!empty($keywords)) {
            $condition['tag'] = array('LIKE', "%{$keywords}%");
        }

        // 多语言
        $condition['lang'] = array('eq', $this->admin_lang);

        $tagsM =  M('tagindex');
        $count = $tagsM->where($condition)->count('id');// 查询满足要求的总记录数
        $Page = $pager = new Page($count, config('paginate.list_rows'));// 实例化分页类 传入总记录数和每页显示的记录数
        $list = $tagsM->where($condition)->order('id desc')->limit($Page->firstRow.','.$Page->listRows)->select();

        $show = $Page->show();// 分页显示输出
        $this->assign('page',$show);// 赋值分页输出
        $this->assign('list',$list);// 赋值数据集
        $this->assign('pager',$pager);// 赋值分页对象

        $source = input('param.source/s');
        $this->assign('source', $source);

        return $this->fetch();
    }
 
    public function tag_list()
    {
        /*纠正tags标签的文档数*/
        $this->correct();
        /*end*/

        // 多语言
        $condition['lang'] = array('eq', $this->admin_lang);

        $tagsM =  M('tagindex');

        $count = $tagsM->where($condition)->count('id');
        $Page = $pager = new Page($count, 100);
        $show = $Page->show();

        $order = 'total desc, id desc, monthcc desc, weekcc desc';
        $list = $tagsM->where($condition)->order($order)->limit($Page->firstRow . ',' . $Page->listRows)->select();
        
        $this->assign('page',$show);
        $this->assign('list',$list);
        $this->assign('pager',$pager);

        return $this->fetch();
    }

    /**
     * 编辑
     */    
    public function edit()
    {
        if (IS_POST) {
            $post = input('post.');
            if (!empty($post['id'])) {
                $tag = !empty($post['tag_tag']) ? trim($post['tag_tag']) : '';
                if (empty($tag)) {
                    $this->error('标签名称不能为空！');
                } else {
                    $row = Db::name('tagindex')->where([
                            'tag'   => $tag,
                            'id'    => ['NEQ', $post['id']],
                            'lang'  => $this->admin_lang,
                        ])->find();
                    if (!empty($row)) {
                        $this->error('标签名称已存在，请更改！');
                    }
                }
                $updata = [
                    'tag' => $tag,
                    'seo_title' => !empty($post['tag_seo_title']) ? trim($post['tag_seo_title']) : '',
                    'seo_keywords' => !empty($post['tag_seo_keywords']) ? trim($post['tag_seo_keywords']) : '',
                    'seo_description' => !empty($post['tag_seo_description']) ? trim($post['tag_seo_description']) : '',
                    'update_time' => getTime(),
                ];
                $ResultID = Db::name('tagindex')->where('id', $post['id'])->update($updata);
                if (false !== $ResultID) {
                    if (trim($post['tag_tag']) != trim($post['tag_tagold'])) {
                        Db::name('taglist')->where([
                                'tid'   => $post['id'],
                            ])->update([
                                'tag'   => trim($post['tag_tag']),
                                'update_time'   => getTime(),
                            ]);
                    }
                    $this->success('操作成功');
                }
            }
            $this->error('操作失败');
        }

        $id = input('id/d');
        if (empty($id)) $this->error('操作异常');

        $Result = Db::name('tagindex')->where('id', $id)->find();
        if (empty($Result)) $this->error('操作异常');
        $this->assign('tag', $Result);

        $this->assign('backurl', url('Tags/index'));
        return $this->fetch();
    }

    /**
     * 删除
     */
    public function del()
    {
        if (IS_POST) {
            $id_arr = input('del_id/a');
            $id_arr = eyIntval($id_arr);
            if(!empty($id_arr)){
                $result = M('tagindex')->field('tag')
                    ->where([
                        'id'    => ['IN', $id_arr],
                        'lang'  => $this->admin_lang,
                    ])->select();
                $title_list = get_arr_column($result, 'tag');

                $r = M('tagindex')->where([
                        'id'    => ['IN', $id_arr],
                        'lang'  => $this->admin_lang,
                    ])->delete();
                if($r){
                    M('taglist')->where([
                        'tid'    => ['IN', $id_arr],
                        'lang'  => $this->admin_lang,
                    ])->delete();
                    adminLog('删除Tags标签：'.implode(',', $title_list));
                    $this->success('删除成功');
                }else{
                    $this->error('删除失败');
                }
            } else {
                $this->error('参数有误');
            }
        }
        $this->error('非法访问');
    }
    
    /**
     * 清空
     */
    public function clearall()
    {
        $r = M('tagindex')->where([
                'lang'  => $this->admin_lang,
            ])->delete();
        if(false !== $r){
            M('taglist')->where([
                'lang'  => $this->admin_lang,
            ])->delete();
            adminLog('清空Tags标签');
            $this->success('操作成功');
        }else{
            $this->error('操作失败');
        }
    }

    /**
     * 纠正tags文档数
     */
    private function correct()
    {
        $taglistRow = Db::name('taglist')->field('count(tid) as total, tid, add_time')
            ->where(['lang'=>$this->admin_lang])
            ->group('tid')
            ->getAllWithIndex('tid');
        $updateData = [];
        $weekup = getTime();
        foreach ($taglistRow as $key => $val) {
            $updateData[] = [
                'id'    => $val['tid'],
                'total' => $val['total'],
                'weekup'    => $weekup,
                'add_time'  => $val['add_time'] + 1,
            ];
        }
        if (!empty($updateData)) {
            $r = model('Tagindex')->saveAll($updateData);
            if (false !== $r) {
                // Db::name('tagindex')->where(['weekup'=>['lt', $weekup],'lang'=>$this->admin_lang])->delete();
            }
        }
    }

    /**
     * 获取常用标签列表
     * @return [type] [description]
     */
    public function get_common_list()
    {
        if (IS_AJAX) {
            $tags = input('tags/s');
            $type = input('type/d');
            if (!empty($tags)){
                $tagsArr = explode(',',$tags);
                $tags  = trim(end($tagsArr));
            }

            /*发布最新文档的tag里前3个*/
            $newTagList = [];
            $newtids = [];
            if (empty($tags)){
                $taglistRow = Db::name('taglist')->field('tid,tag')->order('aid desc')->limit(20)->select();
                foreach ($taglistRow as $key => $val) {
                    if (3 <= count($newTagList)) {
                        break;
                    }
                    if (in_array($val['tid'], $newtids)) {
                        continue;
                    }
                    array_push($newTagList, $val);
                    array_push($newtids, $val['tid']);
                }
            }
            $list = $newTagList;
            /*end*/

            /*常用标签*/
            $where = [];
            $where['is_common'] = 1;
            !empty($newtids) && $where['id'] = ['NOTIN', $newtids];
            $where['lang'] = $this->admin_lang;
            if (!empty($tags)){
                $where['tag'] = ['like','%'.$tags."%"];
            }
            $num = 20 - count($list);
            $row = Db::name('tagindex')->field('id as tid,tag')->where($where)
                ->order('total desc, id desc')
                ->limit($num)
                ->select();
            if (is_array($list) && is_array($row)) {
                $list = array_merge($list, $row);
            }
            /*end*/

            // 不够数量进行补充
            $surplusNum = $num - count($list);
            if (0 < $surplusNum) {
                $ids = get_arr_column($list, 'tid');
                $condition['lang'] = $this->admin_lang;
                $condition['id'] = ['NOT IN', $ids];
                if (!empty($tags)){
                    $condition['tag'] = ['like','%'.$tags."%"];
                }
                $row2 = Db::name('tagindex')->field('id as tid,tag')->where($condition)
                    ->order('total desc, id desc')
                    ->limit($surplusNum)
                    ->select();
                if (is_array($list) && is_array($row2)) {
                    $list = array_merge($list, $row2);
                }
            }
            /*end*/

            $html = "";
            $data = [];
            if (!empty($list)) {
                $tags = input('param.tags/s');
                $tags = str_replace('，', ',', $tags);
                $tagArr = explode(',', $tags);
                foreach ($tagArr as $key => $val) {
                    $tagArr[$key] = trim($val);
                }

                foreach ($list as $_k1 => $_v1) {
                    if (!empty($type)){
                        if (in_array($_v1['tag'], $tagArr)) {
                            $html .= "<a class='cur' href='javascript:void(0);' onclick='selectArchivesTagInput(this);'>{$_v1['tag']}</a>";
                        } else {
                            $html .= "<a href='javascript:void(0);' onclick='selectArchivesTagInput(this);'>{$_v1['tag']}</a>";
                        }
                    }else{
                        if (in_array($_v1['tag'], $tagArr)) {
                            $html .= "<a class='cur' href='javascript:void(0);' onclick='selectArchivesTag(this);'>{$_v1['tag']}</a>";
                        } else {
                            $html .= "<a href='javascript:void(0);' onclick='selectArchivesTag(this);'>{$_v1['tag']}</a>";
                        }
                    }
                }
            }

            $is_click = input('param.is_click/d');
            if (!empty($is_click)) {
                if (empty($html)) {
                    $html .= "没有找到记录";
                }
                $html .= "<a href='javascript:void(0);' onclick='tags_list_1610411887(this);' style='float: right;'>[设置]</a>";
            }
            $data['html']   = $html;

            if (!empty($type) && empty($tags)){
                $data = [];
            }

            $this->success('请求成功', null, $data);
        }
        $this->error('请求失败');
    }

    // 批量新增
    public function batch_add()
    {
        return $this->fetch();
    }
}