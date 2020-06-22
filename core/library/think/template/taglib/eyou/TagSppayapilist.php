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
 * Date: 2020-05-25
 */

namespace think\template\taglib\eyou;

use think\Config;
use think\Request;
use think\Db;

/**
 * 支付API列表
 */
load_trait('controller/Jump');
class TagSppayapilist extends Base
{ 
    use \traits\controller\Jump;

    /**
     * 会员ID
     */
    public $users_id = 0;
    public $users    = [];
    
    //初始化
    protected function _initialize()
    {
        parent::_initialize();
        // 会员信息
        $this->users    = session('users');
        $this->users_id = session('users_id');
        $this->users_id = !empty($this->users_id) ? $this->users_id : 0;
    }

    /**
     * 获取提交订单数据
     */
    public function getSppayapilist()
    {
        // 获取解析数据
        // $querystr  = input('param.querystr/s');
        // $hash      = input('param.hash/s');
        // $auth_code = tpCache('system.system_auth_code');
        // if(!empty($querystr) && md5("payment" . $querystr . $auth_code) == $hash) {
        //     // 数据解析
        //     parse_str(mchStrCode($querystr, 'DECODE'), $querydata);
        //     // 判断支付类型
        //     if (!empty($querydata['moneyid']) && !empty($querydata['order_number'])) {
        //         // 充值信息
        //         $money_id   = !empty($querydata['moneyid']) ? intval($querydata['moneyid']) : 0;
        //         $money_code = !empty($querydata['order_number']) ? strval($querydata['order_number']) : '';
        //         // 都为空则返回
        //     } else if (!empty($querydata['order_id']) && !empty($querydata['order_code'])) {
        //         // 订单信息
        //         $order_id   = !empty($querydata['order_id']) ? intval($querydata['order_id']) : 0;
        //         $order_code = !empty($querydata['order_code']) ? strval($querydata['order_code']) : '';
        //     }
        // }

        // 接收数据读取解析
        $Paystr = input('param.paystr/s');
        $PayData = cookie($Paystr);

        if (!empty($PayData['moneyid']) && !empty($PayData['order_number'])) {
            // 充值信息
            $moneyid = !empty($PayData['moneyid']) ? intval($PayData['moneyid']) : 0;
            $money_code = !empty($PayData['order_number']) ? $PayData['order_number'] : '';
        } else if (!empty($PayData['order_id']) && !empty($PayData['order_code'])) {
            // 订单信息
            $order_id   = !empty($PayData['order_id']) ? intval($PayData['order_id']) : 0;
            $order_code = !empty($PayData['order_code']) ? $PayData['order_code'] : '';
        }
        
        $JsonData['unified_id']       = '';
        $JsonData['unified_amount']   = '';
        $JsonData['unified_number']   = '';
        $JsonData['transaction_type'] = 3; // 交易类型，3为会员升级

        if (is_array($PayData) && (!empty($order_id) || !empty($money_id)) && (!empty($money_code) || !empty($order_code))) {
            $Result = [];
            if (!empty($money_id)) {
                // 获取会员充值信息
                $where = [
                    'moneyid'      => $money_id,
                    'order_number' => $money_code,
                    'users_id'     => $this->users_id,
                    'lang'         => $this->home_lang
                ];
                $Result = Db::name('users_money')->where($where)->find();
                if (empty($Result)) $this->error('订单不存在！');

                // 组装数据返回
                $JsonData['transaction_type'] = 1; // 交易类型，1为充值
                $JsonData['unified_id']       = $Result['moneyid'];
                $JsonData['unified_amount']   = $Result['money'];
                $JsonData['unified_number']   = $Result['order_number'];

            } else if (!empty($order_id)) {
                // 获取支付订单
                $where = [
                    'order_id'   => $order_id,
                    'order_code' => $order_code,
                    'users_id'   => $this->users_id,
                    'lang'       => $this->home_lang
                ];
                $Result = Db::name('shop_order')->where($where)->find();
                if (empty($Result)) $this->error('订单不存在！');
                
                // 判断订单状态，1已付款(待发货)，2已发货(待收货)，3已完成(确认收货)，-1订单取消(已关闭)，4订单过期
                $url = urldecode(url('user/Shop/shop_order_details', ['order_id' => $Result['order_id']]));
                if (in_array($Result['order_status'], [1, 2, 3])) {
                    $this->error('订单已支付，即将跳转', $url);
                } elseif ($Result['order_status'] == 4) {
                    $this->error('订单已过期，即将跳转', $url);
                } elseif ($Result['order_status'] == -1) {
                    $this->error('订单已关闭，即将跳转', $url);
                }

                // 组装数据返回
                $JsonData['transaction_type'] = 2; // 交易类型，2为购买
                $JsonData['unified_id']       = $Result['order_id'];
                $JsonData['unified_amount']   = $Result['order_amount'];
                $JsonData['unified_number']   = $Result['order_code'];
            }
        }

        $where = [
            'status' => 1,
            'pay_info' => ['NEQ', '']
        ];
        if ((isMobile() && isWeixin()) || isWeixinApplets()) $where['pay_mark'] = ['NEQ', 'alipay'];
        $PayApiList = Db::name('pay_api_config')->where($where)->select();
        if (!empty($PayApiList)) {
            foreach ($PayApiList as $key => $value) {
                $PayApiList[$key]['pay_img'] = '';
                if (!empty($value['pay_info'])) {
                    $ValuePayInfo = unserialize($value['pay_info']);
                    if ('wechat' == $value['pay_mark'] && 1 == $ValuePayInfo['is_open_wechat']) {
                        unset($PayApiList[$key]);
                    } else if ('alipay' == $value['pay_mark'] && 1 == $ValuePayInfo['is_open_alipay']) {
                        unset($PayApiList[$key]);
                    } else if (0 == $value['system_built']) {
                        if (1 == $ValuePayInfo['is_open_pay']) {
                            unset($PayApiList[$key]);
                        } else {
                            foreach ($ValuePayInfo as $kk => $vv) {
                                if ('is_open_pay' != $kk && empty($vv)) {
                                    unset($PayApiList[$key]); break;
                                }
                            }
                        }
                        if (!empty($PayApiList[$key])) {
                            $PayApiList[$key]['pay_img'] = get_default_pic('/weapp/'.$value['pay_mark'].'/pay.png');
                        }
                    }
                } else {
                    unset($PayApiList[$key]);
                }
            }
        }

        // 传入JS参数
        $JsonData['PayDealWith']     = url('user/Pay/pay_deal_with', ['_ajax' => 1], true, false, 1, 1, 0);
        $JsonData['SelectPayMethod'] = url('user/PayApi/select_pay_method', ['_ajax' => 1], true, false, 1, 1, 0);
        $JsonData['OrderPayPolling'] = url('user/PayApi/order_pay_polling', ['_ajax' => 1], true, false, 1, 1, 0);
        $JsonData['UsersUpgradePay'] = url('user/PayApi/users_upgrade_pay', ['_ajax' => 1], true, false, 1, 1, 0);
        $JsonData = json_encode($JsonData);
        $version   = getCmsVersion();
        // 循环中第一个数据带上JS代码加载
        if (!empty($PayApiList)) {
            $PayApiList[$key]['hidden'] = <<<EOF
<script type="text/javascript">
    var eyou_data_json_1590627847 = {$JsonData};
</script>
<script type="text/javascript" src="{$this->root_dir}/public/static/common/js/tag_sppayapilist.js?v={$version}"></script>
EOF;
        }
        
        return $PayApiList;
    }
}