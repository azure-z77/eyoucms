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

namespace app\user\model;

use think\Model;
use think\Db;
use think\Config;
use think\Page;

/**
 * 商城
 */
class Shop extends Model
{
    //初始化
    protected function initialize()
    {
        // 需要调用`Model`的`initialize`方法
        parent::initialize();
        $this->home_lang = get_home_lang();
    }

    // 处理购买订单，超过指定时间修改为已订单过期，针对未付款订单
    public function UpdateShopOrderData($users_id){
        $time  = getTime() - Config::get('global.get_shop_order_validity');
        $where = array(
            'users_id'     => $users_id,
            'order_status' => 0,
            'add_time'     => array('<',$time),
        );
        $data = [
            'order_status' => 4, // 订单取消
            'update_time'  => getTime(),
        ];

        // 查询订单id数组用于添加订单操作记录
        $OrderIds = Db::name('shop_order')->field('order_id')->where($where)->select();

        //批量修改订单状态 
        Db::name('shop_order')->where($where)->update($data);
        
        // 添加订单操作记录
        if (!empty($OrderIds)) {
	        AddOrderAction($OrderIds,$users_id,'0','4','0','0','订单过期！','会员未在订单有效期内支付，订单过期！');
        }
    }

    // 通过商品名称模糊查询订单信息
    public function QueryOrderList($pagesize,$users_id,$keywords,$query_get){
        // 商品名称模糊查询订单明细表，获取订单主表ID
        $DetailsWhere = [
            'users_id' => $users_id,
            'lang'     => $this->home_lang,
        ];
        $DetailsWhere['product_name'] =  ['LIKE', "%{$keywords}%"];
        $DetailsData = Db::name('shop_order_details')->field('order_id')->where($DetailsWhere)->select();
        // 若查无数据，则返回false
        if (empty($DetailsData)) {
            return false;
        }

        $order_ids = '';
        // 处理订单ID，查询订单主表信息
        foreach ($DetailsData as $key => $value) {
            if ('0' < $key) {
                $order_ids .= ',';
            }
            $order_ids .= $value['order_id'];
        }
        // 查询条件
        $OrderWhere = [
            'users_id' => $users_id,
            'lang'     => $this->home_lang,
            'order_id' => ['IN', $order_ids],
        ];

        $paginate_type = 'userseyou';
        if (isMobile()) {
            $paginate_type = 'usersmobile';
        }

        $paginate = array(
            'type'     => $paginate_type,
            'var_page' => config('paginate.var_page'),
            'query'    => $query_get,
        );

        $pages = Db::name('shop_order')
            ->field("*")
            ->where($OrderWhere)
            ->order('add_time desc')
            ->paginate($pagesize, false, $paginate);

        $data['list']  = $pages->items();
        $data['pages'] = $pages;

        return $data;
    }

    public function GetOrderIsEmpty($users_id,$keywords,$select_status){
        // 基础查询条件
        $OrderWhere = [
            'users_id' => $users_id,
            'lang'     => $this->home_lang,
        ];

        // 应用搜索条件
        if (!empty($keywords)) {
            $OrderWhere['order_code'] =  ['LIKE', "%{$keywords}%"];
        }

        // 订单状态搜索
        if (!empty($select_status)) {
            if ('dzf' === $select_status) {
                $select_status = 0;
            }
            $OrderWhere['order_status'] = $select_status;
        }

        $order = Db::name('shop_order')->where($OrderWhere)->count();
        // 查询存在数据，则返回1
        if (!empty($order)) {
            $data = '1';
            return $data;
            exit;
        }
        
        // 查询订单明细表
        if (empty($order) && !empty($keywords)) {
            $DetailsWhere = [
                'users_id' => $users_id,
                'lang'     => $this->home_lang,
            ];
            $DetailsWhere['product_name'] =  ['LIKE', "%{$keywords}%"];
            $DetailsData = Db::name('shop_order_details')->field('order_id')->where($DetailsWhere)->select();
            // 查询无数据，则返回0
            if (empty($DetailsData)) {
                $data = '0';
                return $data;
                exit;
            }

            $order_ids = '';
            // 处理订单ID，查询订单主表信息
            foreach ($DetailsData as $key => $value) {
                if ('0' < $key) {
                    $order_ids .= ',';
                }
                $order_ids .= $value['order_id'];
            }
            // 查询条件
            $OrderWhere = [
                'users_id' => $users_id,
                'lang'     => $this->home_lang,
                'order_id' => ['IN', $order_ids],
            ];

            $order2 = Db::name('shop_order')->where($OrderWhere)->count();
            if (!empty($order2)) {
                $data = '1';
                return $data;
            }else{
                $data = '0';
                return $data;
            }
        }
    }
}