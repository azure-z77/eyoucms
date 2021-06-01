<?php
/**
 * 易优CMS
 * ============================================================================
 * 版权所有 2016-2028 海南赞赞网络科技有限公司，并保留所有权利。
 * 网站地址: http://www.eyoucms.com
 * ----------------------------------------------------------------------------
 * 如果商业用途务必到官方购买正版授权, 以免引起不必要的法律纠纷.
 * ============================================================================
 * Author: 陈风任 <491085389@qq.com>
 * Date: 2019-3-20
 */

namespace app\user\controller;

use think\Db;
use think\Config;
use think\Page;
use think\Cookie;

class ShopComment extends Base
{
    // 初始化
    public function _initialize() {
        parent::_initialize();

        $functionLogic = new \app\common\logic\FunctionLogic;
        $functionLogic->validate_authorfile(2);

        $this->shop_model = model('Shop');  // 商城模型
    }

    // 我的评价
    public function index()
    {
        $order_code = input('param.order_code');
        $functionLogic = new \app\user\logic\FunctionLogic;
        $ServiceInfo = $functionLogic->GetAllCommentInfo($this->users_id, $order_code);
        $eyou = [
            'field' => [
               'comment' => $ServiceInfo['Comment'],
               'pageStr' => $ServiceInfo['pageStr'],
            ],
        ];
        $this->assign('eyou', $eyou);
        return $this->fetch('users/shop_comment_list');
    }

    // 添加评论
    public function product()
    {
        if (IS_AJAX_POST) {
            $post = input('post.');
            if (empty($post['total_score'])) $this->error('请选择评价评分');

            /*再次查询确认商品是否已评价过*/
            $where = [
                'users_id' => $this->users_id,
                'order_id' => $post['order_id'],
                'details_id' => $post['details_id'],
                'product_id' => $post['product_id'],
                'is_comment' => 1
            ];
            $ResultID = Db::name('shop_order_details')->where($where)->count();
            if (!empty($ResultID)) $this->error('商品已评价过');
            /* END */

            /*添加评价数据*/
            $AddData = [
                'users_id'    => $this->users_id,
                'order_id'    => !empty($post['order_id']) ? $post['order_id'] : 0,
                'order_code'  => !empty($post['order_code']) ? $post['order_code'] : 0,
                'details_id'  => !empty($post['details_id']) ? $post['details_id'] : 0,
                'product_id'  => !empty($post['product_id']) ? $post['product_id'] : 0,
                'total_score' => !empty($post['total_score']) ? $post['total_score'] : 1,
                'content'     => !empty($post['content']) ? serialize(htmlspecialchars($post['content'])) : '',
                'upload_img'  => !empty($post['upload_img'][0]) ? serialize(implode(',', $post['upload_img'])) : '',
                'ip_address'  => clientIP(),
                'add_time'    => getTime(),
                'update_time' => getTime()
            ];
            $ResultID = Db::name('shop_order_comment')->insertGetId($AddData);
            /* END */

            if (!empty($ResultID)) {
                /*同步更新订单商品为已评价*/
                $UpDate = [
                    'details_id'  => $AddData['details_id'],
                    'is_comment'  => 1,
                    'update_time' => getTime()
                ];
                Db::name('shop_order_details')->update($UpDate);
                /* END */

                /*如果订单商品已经全部评价，那么订单主表is_comment == 1*/
                $where = [
                    'order_id' => $post['order_id'],
                    'users_id' => $this->users_id,
                    'is_comment' => 0
                ];
                $ResultID = Db::name('shop_order_details')->where($where)->count();
                if (empty($ResultID)){
                    $where = [
                        'order_id' => $post['order_id'],
                        'users_id' => $this->users_id,
                        'order_status'=> 3,
                        'is_comment'  => 0,
                    ];
                    $UpDate = [
                        'is_comment' => 1,
                        'update_time' => getTime()
                    ];
                    Db::name('shop_order')->where($where)->update($UpDate);
                }
                /* END */

                cache('EyouHomeAjaxComment_' . $post['product_id'], null, null, 'shop_order_comment');

                $this->success('评价成功！', url('user/Shop/shop_centre'));
            } else {
                $this->error('评价失败，请重试！');
            }
        }

        // 查询订单信息
        $details_id = input('param.details_id');
        if (empty($details_id)) $this->error('请选择需要评价的商品！');
        // 排除字段
        $field1 = 'add_time, update_time, apply_service';
        // 查询字段
        $field2 = 'b.order_code, b.add_time';
        // 查询条件
        $where = [
            'a.users_id'   => $this->users_id,
            'a.details_id' => $details_id,
        ];
        // 查询数据
        $Details = Db::name('shop_order_details')
            ->alias('a')
            ->field($field1, true, PREFIX . 'shop_order_details', 'a')
            ->field($field2)
            ->where($where)
            ->join('__SHOP_ORDER__ b', 'a.order_id = b.order_id', 'LEFT')
            ->find();

        // 已评价商品跳转路径
        $url = isset($_SERVER['HTTP_REFERER']) ? $_SERVER['HTTP_REFERER'] : url("user/Shop/shop_centre", ['select_status'=>3]);
        if (empty($Details)) $this->error('商品已评价过', $url);
        if (1 == !empty($Details['is_comment'])) $this->error('商品已评价过', $url);

        // 商品规格
        $Details['spec_value'] = htmlspecialchars_decode(unserialize($Details['data'])['spec_value']);

        // 图片处理
        $Details['litpic'] = handle_subdir_pic(get_default_pic($Details['litpic']));

        // 产品内页地址
        $New = get_archives_data([$Details], 'product_id');
        if (!empty($New)) {
            $Details['arcurl'] = urldecode(arcurl('home/Product/view', $New[$Details['product_id']]));
        } else {
            $Details['arcurl'] = urldecode(url('home/View/index', ['aid'=>$Details['product_id']]));
        }

        $eyou = [
            'field' => $Details,
            'SubmitUrl' => url('user/ShopComment/product', ['_ajax'=>1])
        ];
        $this->assign('eyou', $eyou);

        return $this->fetch('shop_comment_product');
    }
}