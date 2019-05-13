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
 * Date: 2019-2-25
 */

namespace app\user\controller;

use think\Db;
// use think\Session;
use think\Config;
use think\Page;

class Pay extends Base
{
    public $php_version = '';

    public function _initialize() {
        parent::_initialize();
        $this->users_db       = Db::name('users');      // 会员数据表
        $this->users_money_db = Db::name('users_money');// 会员金额明细表
        $this->shop_order_db = Db::name('shop_order'); // 订单主表
        $this->shop_order_details_db = Db::name('shop_order_details'); // 订单明细表

        // 判断PHP版本信息
        if (version_compare(PHP_VERSION,'5.5.0','<')) {
            $this->php_version = 1; // PHP5.5.0以下版本，可使用旧版支付方式
        }else{
            $this->php_version = 0;// PHP5.5.0以上版本，可使用新版支付方式，兼容旧版支付方式
        }

        // 支付功能是否开启
        $redirect_url = '';
        $pay_open = getUsersConfigData('pay.pay_open');
        $web_users_switch = tpCache('web.web_users_switch');
        if (empty($pay_open)) { 
            // 支付功能关闭，立马跳到会员中心
            $redirect_url = url('user/Users/index');
            $msg = '支付功能尚未开启！';
        } else if (empty($web_users_switch)) { 
            // 前台会员中心已关闭，跳到首页
            $redirect_url = ROOT_DIR.'/';
            $msg = '会员中心尚未开启！';
        }
        if (!empty($redirect_url)) {
            Db::name('users_menu')->where([
                    'mca'   => 'user/Pay/pay_consumer_details',
                    'lang'  => $this->home_lang,
                ])->update([
                    'status'    => 0,
                    'update_time' => getTime(),
                ]);
            $this->error($msg, $redirect_url);
            exit;
        }
        // --end
    }

    // 消费明细
    public function pay_consumer_details()
    {
        // 订单超过 get_order_validity 设定的时间，则修改订单为已取消状态，无需返回数据
        model('Pay')->UpdateOrderData($this->users_id);

        // 数据查询
        $condition['a.users_id'] = $this->users_id;
        $condition['a.lang'] = $this->home_lang;
        $count = $this->users_money_db->alias('a')->where($condition)->count();// 查询满足要求的总记录数
        $Page = new Page($count, config('paginate.list_rows'));// 实例化分页类 传入总记录数和每页显示的记录数
        $list = $this->users_money_db->field('a.*')
            ->alias('a')
            ->where($condition)
            ->order('a.moneyid desc')
            ->limit($Page->firstRow.','.$Page->listRows)
            ->select();
        $show = $Page->show();// 分页显示输出
        $this->assign('page',$show);// 赋值分页输出
        $this->assign('list',$list);// 赋值数据集
        $this->assign('pager',$Page);// 赋值分页集

        // 获取金额明细类型
        $pay_cause_type_arr = Config::get('global.pay_cause_type_arr');
        $this->assign('pay_cause_type_arr',$pay_cause_type_arr);

        // 获取金额明细状态
        $pay_status_arr     = Config::get('global.pay_status_arr');
        $this->assign('pay_status_arr',$pay_status_arr);

        $result = [];

        // 菜单名称
        $result['title'] = Db::name('users_menu')->where([
                'mca'   => 'user/Pay/pay_consumer_details',
                'lang'  => $this->home_lang,
            ])->getField('title');

        $eyou = array(
            'field' => $result,
        );
        $this->assign('eyou', $eyou);

        return $this->fetch('users/pay_consumer_details');
    }

    // 账户充值
    public function pay_account_recharge()
    {
        if (IS_AJAX_POST) {
            // 获取微信配置信息
            $pay_wechat_config = !empty($this->usersConfig['pay_wechat_config']) ? unserialize($this->usersConfig['pay_wechat_config']) : [];
            
            // 获取支付宝配置信息
            $pay_alipay_config = !empty($this->usersConfig['pay_alipay_config']) ? unserialize($this->usersConfig['pay_alipay_config']) : [];

            if (empty($pay_wechat_config) && empty($pay_alipay_config)) {
                $this->error('网站支付配置未完善，请联系管理员！');
            }

            $money = input('post.money/f');
            $unified_number = input('post.unified_number/s');
            if (!empty($unified_number) && !preg_match('/^\d+$/',$unified_number)) {
                $this->error('订单号不存在！');
            }

            // 判断是否为数字和数字字符串
            if (!empty($money) && is_numeric($money)) {
                $moneyRow = [];
                if (!empty($unified_number)) {
                    $moneyRow = $this->users_money_db->where([
                            'order_number'  => $unified_number,
                            'status'    => 1,
                            'lang'  => $this->home_lang,
                        ])->find();
                }
                if (!empty($moneyRow)) { // 更改充值金额
                    $moneyid = $moneyRow['moneyid'];
                    $order_number = $moneyRow['order_number'];
                    $old_money = $moneyRow['money'];
                    $data = [
                        'money'         => $money,
                        'users_money'   => Db::raw('users_money-'.$old_money),
                        'status'        => 1,
                        'update_time'      => getTime(),
                    ];
                    $this->users_money_db->where([
                            'moneyid'   => $moneyid,
                            'users_id'  => $this->users_id,
                        ])->update($data);
                } else {
                    // 数据添加到订单表
                    $users = M('users')->field('users_money')->where([
                            'users_id'  => $this->users_id,
                            'lang'  => $this->home_lang,
                        ])->find();
                    $pay_cause_type_arr = Config::get('global.pay_cause_type_arr');
                    $time = getTime();
                    $cause_type = 1;
                    $order_number = date('Ymd').$time.rand(10,100); //订单生成规则
                    $data = [
                        'users_id'      => $this->users_id,
                        'cause_type'    => $cause_type,
                        'cause'         => $pay_cause_type_arr[$cause_type],
                        'money'         => $money,
                        'users_money'   => $users['users_money'] + $money,
                        'order_number'  => $order_number,
                        'status'        => 1,
                        'lang'          => $this->home_lang,
                        'add_time'      => $time,
                    ];
                    $moneyid = $this->users_money_db->add($data);
                }
                // 添加状态
                if (!empty($moneyid)) {
                    // 对ID和订单号加密，拼装url路径
                    $querydata = [
                        'moneyid'    => $moneyid,
                        'order_number' => $order_number,
                    ];
                    $querystr    = base64_encode(serialize($querydata));
                    $url = urldecode(url('user/Pay/pay_recharge_detail', ['querystr'=>$querystr]));
                    $this->success('等待支付', $url);
                }
                $this->error('充值表单提交失败');
            }
            $this->error('请输入正确的充值金额！');
        }

        $money = input('param.money/f');
        $this->assign('money', $money);

        $unified_number = input('param.unified_number/s');
        $this->assign('unified_number', $unified_number);

        return $this->fetch('users/pay_account_recharge');
    }

    // 充值详情
    public function pay_recharge_detail()
    {
        $querystr   = input('param.querystr/s');
        $querydata  = unserialize(base64_decode($querystr));

        if (!empty($querydata['moneyid']) && !empty($querydata['order_number'])) {
            // 充值信息
            $moneyid = !empty($querydata['moneyid']) ? intval($querydata['moneyid']) : 0;
            $order_number = !empty($querydata['order_number']) ? $querydata['order_number'] : '';
        } else if (!empty($querydata['order_id']) && !empty($querydata['order_code'])) {
            // 订单信息
            $order_id   = !empty($querydata['order_id']) ? intval($querydata['order_id']) : 0;
            $order_code = !empty($querydata['order_code']) ? $querydata['order_code'] : '';
        } else {
            $this->error('订单不存在！');
        }

        if (is_array($querydata) && (!empty($order_id) || !empty($moneyid)) && (!empty($order_number) || !empty($order_code))) {

            $data = [];

            if (!empty($moneyid)) {
                // 获取会员充值信息
                $data = $this->users_money_db->where([
                        'moneyid'      => $moneyid,
                        'order_number' => $order_number,
                        'users_id'     => $this->users_id,
                        'lang'         => $this->home_lang,
                    ])->find();
                if (empty($data)) {
                    $this->error('订单不存在！');
                }
                $data['transaction_type'] = '1'; // 交易类型，1为充值
                $data['unified_id']       = $data['moneyid'];
                $data['unified_amount']   = $data['money'];
                $data['unified_number']   = $data['order_number'];
                $this->assign('data',$data);
            }else if (!empty($order_id)) {
                $data = $this->shop_order_db->where([
                        'order_id'     => $order_id,
                        'order_code'   => $order_code,
                        'users_id'     => $this->users_id,
                        'lang'         => $this->home_lang,
                    ])->find();
                if (empty($data)) {
                    $this->error('订单不存在！');
                }
                $data['transaction_type'] = '2'; // 交易类型，2为购买
                $data['unified_id']       = $data['order_id'];
                $data['unified_amount']   = $data['order_amount'];
                $data['unified_number']   = $data['order_code'];
                $data['cause'] = '购买产品';
                $this->assign('data',$data);
            }

            // 获取微信配置信息
            $pay_wechat_config = !empty($this->usersConfig['pay_wechat_config']) ? unserialize($this->usersConfig['pay_wechat_config']) : [];
            // 获取支付宝配置信息
            $pay_alipay_config = !empty($this->usersConfig['pay_alipay_config']) ? unserialize($this->usersConfig['pay_alipay_config']) : [];

            // 充值信息存在时，传入订单号等信息获取支付宝支付链接
            $alipay_url = '';
            if (!empty($data)) {
                if (!empty($pay_alipay_config)) {
                    if ($this->php_version == 1) {
                        // 低于5.5版本，仅可使用旧版支付宝支付
                        $alipay_url = model('Pay')->getOldAliPayPayUrl($data, $pay_alipay_config);
                    }else if($this->php_version == 0){
                        // 高于或等于5.5版本，可使用新版支付宝支付
                        if (empty($pay_alipay_config['version'])) {
                            // 新版
                            $alipay_url = url('user/Pay/newAlipayPayUrl',['unified_number'=>$data['unified_number'],'unified_amount'=>$data['unified_amount'],'transaction_type'=>$data['transaction_type']]);
                        }else if($pay_alipay_config['version'] == 1){
                            // 旧版
                            $alipay_url = model('Pay')->getOldAliPayPayUrl($data, $pay_alipay_config);
                        }
                    }
                }
            }

            $isbrowser = $isweixin = 0;
            if (isMobile() && isWeixin()) {
                $isbrowser = 1;
            }

            if (isMobile() && !isWeixin()) {
                $isweixin = 1;
                // 移动端非微信H5页面支付
                $out_trade_no = $data['unified_number'];
                $total_fee    = $data['unified_amount'];
                $weixin_url   = model('Pay')->getMobilePay($out_trade_no,$total_fee);
                $this->assign('weixin_url',$weixin_url);
            }

            $this->assign('isbrowser',$isbrowser);
            $this->assign('isweixin',$isweixin);
            $this->assign('alipay_url',$alipay_url);

            // 是否开启微信支付方式
            $is_open_wechat = 1;
            if (!empty($pay_wechat_config)) {
                $is_open_wechat = !empty($pay_wechat_config['is_open_wechat']) ? $pay_wechat_config['is_open_wechat'] : 0;
            }
            $this->assign('is_open_wechat', $is_open_wechat);
            if ('1' == $is_open_wechat) {
                // 若没有配置支付信息，则提示
                $WechatMsg = '微信支付配置尚未配置完成。<br/>请前往会员中心-支付功能-微信支付配置<br/>填入收款的微信支付配置信息！';
                $this->assign('WechatMsg', $WechatMsg);
            }

            // 是否开启支付宝支付方式
            $is_open_alipay = 1;
            if (!empty($pay_alipay_config)) {
                $is_open_alipay = !empty($pay_alipay_config['is_open_alipay']) ? $pay_alipay_config['is_open_alipay'] : 0;
            }
            $this->assign('is_open_alipay', $is_open_alipay);
            if ('1' == $is_open_alipay) {
                // 若没有配置支付信息，则提示
                $AlipayMsg = '支付宝支付配置尚未配置完成。<br/>请前往会员中心-支付功能-支付宝支付配置<br/>填入收款的支付宝支付配置信息！';
                $this->assign('AlipayMsg', $AlipayMsg);
            }

            return $this->fetch('users/pay_recharge_detail');
        }
        $this->error('参数错误！');
    }

    public function get_order_detail()
    {
        if (IS_AJAX_POST) {
            // 订单号
            $unified_number = input('post.unified_number/s');
            $unified_id     = input('post.unified_id/d');
            $transaction_type = input('post.transaction_type/d');
            // 跳转链接
            $url = urldecode(url('user/Pay/pay_success', ['transaction_type'=>$transaction_type]));
            if ('2' == $transaction_type) {
                // 购买订单
                // 查询条件
                $OrderWhere = array(
                    'order_id'   => $unified_id,
                    'order_code' => $unified_number,
                    'users_id'   => $this->users_id,
                    'lang'       => $this->home_lang,
                );
                $OrderRow  = $this->shop_order_db->where($OrderWhere)->field('order_status,pay_name')->find();
                if (!empty($OrderRow)) {
                    // 判断返回
                    if ('alipay' == $OrderRow['pay_name'] && in_array($OrderRow['order_status'], [1])) {
                        $this->success('订单已在支付宝付款完成！即将跳转~~~', $url);
                    }else if ('wechat' == $OrderRow['pay_name'] && in_array($OrderRow['order_status'], [1])) {
                        $this->success('订单已在微信付款完成！即将跳转~~~', $url);
                    }else if ('balance' == $OrderRow['pay_name'] && in_array($OrderRow['order_status'], [1])) {
                        $this->success('订单已使用余额支付完成！即将跳转~~~', $url);
                    }else{
                        $this->error('等待支付');
                    }
                }
            }else if ('1' == $transaction_type) {
                // 充值订单
                // 查询条件
                $where = array(
                    'moneyid'     => $unified_id,
                    'order_number' => $unified_number,
                    'users_id'     => $this->users_id,
                    'lang'         => $this->home_lang,
                );
                $moneyRow  = $this->users_money_db->where($where)->field('status,pay_method')->find();
                if (!empty($moneyRow)) {
                    // 判断返回
                    if ('alipay' == $moneyRow['pay_method'] && in_array($moneyRow['status'], [2,3])) {
                        $this->success('订单已在支付宝付款完成！即将跳转~~~', $url);
                    }else if ('wechat' == $moneyRow['pay_method'] && in_array($moneyRow['status'], [2,3])) {
                        $this->success('订单已在微信付款完成！即将跳转~~~', $url);
                    }else if ('artificial' == $moneyRow['pay_method'] && in_array($moneyRow['status'], [2,3])) {
                        $this->success('订单已人为处理完成！即将跳转~~~', $url);
                    }else{
                        $this->error('等待支付');
                    }
                }
            }
        }
        $this->error('访问错误');
    }

    // 选择付款方式，目前用于微信，支付宝方式已直接调用链接
    public function pay_method()
    {
        // 付款方式，跳转至微信支付还是支付宝支付。
        $pay_method = input('param.pay_method/s');
        // 订单交易类型
        $transaction_type = input('param.transaction_type/s');
        // 订单号
        $unified_number   = input('param.unified_number/s');
        // 订单ID
        $unified_id       = input('param.unified_id/d');

        $this->assign('unified_number',$unified_number);
        $this->assign('transaction_type',$transaction_type);
        // 执行跳转
        return $this->fetch('users/pay_'.$pay_method);
    }

    // 微信支付，获取订单信息并调用微信接口，生成二维码用于扫码支付
    public function pay_wechat_png(){
        $users_id = session('users_id');
        if (!empty($users_id)) {
            $unified_number   = input('param.unified_number/s');
            $transaction_type = input('param.transaction_type/s');
            if ('2' == $transaction_type) {
                // 购买订单
                $where  = array(
                    'users_id'   => $users_id,
                    'order_code' => $unified_number,
                );
                $data  = $this->shop_order_db->where($where)->find();
                $out_trade_no = $data['order_code'];
                $total_fee    = $data['order_amount'];
            }else if ('1' == $transaction_type) {
                // 充值订单
                $where  = array(
                    'users_id'     => $users_id,
                    'order_number' => $unified_number,
                );
                $data  = $this->users_money_db->where($where)->find();
                $out_trade_no = $data['order_number'];
                $total_fee    = $data['money'];
            }
            
            // 调取微信支付链接
            $payUrl = model('Pay')->payForQrcode($out_trade_no,$total_fee);// PC调用

            // 生成二维码加载在页面上
            vendor('wechatpay.phpqrcode.phpqrcode');
            $qrcode = new \QRcode;
            $pngurl = $payUrl;
            $qrcode->png($pngurl);
            exit();
        }else{
            $this->redirect('user/Users/login');
        }
    }

    // ajax异步查询订单状态，轮询方式（微信）
    public function pay_deal_with(){
        if (IS_AJAX_POST) {
            $unified_number   = input('post.unified_number/s');
            $transaction_type = input('post.transaction_type/s');
            if(!empty($unified_number)){
                // ajax异步查询订单是否完成并处理相应逻辑返回。
                vendor('wechatpay.lib.WxPayApi');
                vendor('wechatpay.lib.WxPayConfig');
                // 实例化加载订单号
                $input  = new \WxPayOrderQuery;
                $input->SetOut_trade_no($unified_number);

                // 处理微信配置数据
                $pay_wechat_config = getUsersConfigData('pay.pay_wechat_config');
                $pay_wechat_config = unserialize($pay_wechat_config);
                $config_data['app_id'] = $pay_wechat_config['appid'];
                $config_data['mch_id'] = $pay_wechat_config['mchid'];
                $config_data['key']    = $pay_wechat_config['key'];

                // 实例化微信配置
                $config = new \WxPayConfig($config_data);
                $wxpayapi = new \WxPayApi;

                if (empty($config->app_id)) {
                    $this->error('微信支付配置尚未配置完成。');
                }

                // 返回结果
                $result = $wxpayapi->orderQuery($config, $input);
                // 业务处理
                if ($result['return_code'] == 'SUCCESS' && $result['result_code'] == 'SUCCESS'){
                    if ($result['trade_state'] == 'SUCCESS' && !empty($result['transaction_id'])) {
                        if ('2' == $transaction_type) {
                            // 付款成功
                            $order_data = $this->shop_order_db->where([
                                'order_code' => $result['out_trade_no'],
                                'users_id'   => $this->users_id,
                                'lang'       => $this->home_lang,
                            ])->find();

                            if (empty($order_data)) {
                                $this->error('支付异常，请刷新页面后重试');
                            }

                            // 微信付款成功后，订单并未修改状态时，修改订单状态并返回
                            if (empty($order_data['order_status'])) {
                                $OrderWhere = [
                                    'order_id'  => $order_data['order_id'],
                                    'users_id'  => $this->users_id,
                                    'lang'      => $this->home_lang,
                                ];
                                // 修改会员金额明细表中，对应的订单数据，存入返回的数据，订单已付款
                                $OrderData = [
                                    'order_status' => 1,
                                    'pay_name'     => 'wechat', //微信支付
                                    'pay_details'  => serialize($result),
                                    'pay_time'     => getTime(),
                                    'update_time'  => getTime(),
                                ];
                                $order_id = $this->shop_order_db->where($OrderWhere)->update($OrderData);

                                if (!empty($order_id)) {
                                    $DetailsData['update_time'] = getTime();
                                    $this->shop_order_details_db->where($OrderWhere)->update($DetailsData);

                                    // 添加订单操作记录
                                    AddOrderAction($order_id,$this->users_id,'0','1','0','1','支付成功！','会员使用微信完成支付！');

                                    // 订单支付完成
                                    $url = urldecode(url('user/Pay/pay_success', ['transaction_type'=>$transaction_type]));
                                    $this->success('支付成功，即将跳转~~~', $url, ['status'=>1]);
                                }
                            }

                            if ($order_data['order_status'] == 1 && !empty($order_data['pay_details'])) {
                                // 订单已付款
                                $url = urldecode(url('user/Pay/pay_success', ['transaction_type'=>$transaction_type]));
                                $this->success('支付成功，即将跳转~~~', $url, ['status'=>1]);
                            }

                            if ($order_data['order_status'] == 3) {
                                // 订单已完成，待处理逻辑
                                // 待处理逻辑..........
                            }

                            if ($order_data['order_status'] == 4) {
                                // 订单已取消，待处理逻辑
                                // 待处理逻辑..........
                            }

                        }else if ('1' == $transaction_type) {
                            // 付款成功
                            $moneydata = $this->users_money_db->where([
                                'order_number' => $result['out_trade_no'],
                                'users_id'     => $this->users_id,
                                'lang'         => $this->home_lang,
                            ])->find();

                            if (empty($moneydata)) {
                                $this->error('支付异常，请刷新页面后重试');
                            }

                            // 微信付款成功后，订单并未修改状态时，修改订单状态并返回
                            if ($moneydata['status'] == 1) {
                                // 修改会员金额明细表中，对应的订单数据，存入返回的数据，订单已付款
                                $data = [
                                    'status'        => 2,
                                    'pay_method'    => 'wechat', //微信支付
                                    'pay_details'   => serialize($result),
                                    'update_time'   => getTime(),
                                ];
                                $ismoney = $this->users_money_db->where([
                                        'moneyid'  => $moneydata['moneyid'],
                                        'users_id'  => $this->users_id,
                                    ])->update($data);

                                if (!empty($ismoney)) {
                                    // 同步修改会员的金额
                                    $usersdata = [
                                        'users_money' => Db::raw('users_money+'.($moneydata['money'])),
                                    ];
                                    $isusers = $this->users_db->where([
                                            'users_id'  => $this->users_id,
                                        ])->update($usersdata);

                                    if (!empty($isusers)) {
                                        // 业务处理完成，订单已完成
                                        $data2 = [
                                            'status'    => 3,
                                            'update_time'   => getTime(),
                                        ];
                                        $this->users_money_db->where([
                                                'moneyid'  => $moneydata['moneyid'],
                                                'users_id'  => $this->users_id,
                                            ])->update($data2);
                                        $url = urldecode(url('user/Pay/pay_success', ['transaction_type'=>$transaction_type]));
                                        $this->success('充值成功，即将跳转~~~', $url, ['status'=>1]);
                                    }else{
                                        $this->success('付款成功，但未充值成功，请联系管理员。', null, ['status'=>2]);
                                    }
                                }else{
                                    $this->success('付款成功，数据错误，未能充值成功，请联系管理员。', null, ['status'=>2]);
                                }
                            }

                            if ($moneydata['status'] == 2 && !empty($moneydata['pay_details'])) {
                                // 订单已付款
                                $url = urldecode(url('user/Pay/pay_success', ['transaction_type'=>$transaction_type]));
                                $this->success('充值成功，即将跳转~~~', $url, ['status'=>1]);
                            }

                            if ($moneydata['status'] == 3) {
                                // 订单已完成，待处理逻辑
                                // 待处理逻辑..........
                            }

                            if ($moneydata['status'] == 4) {
                                // 订单已取消，待处理逻辑
                                // 待处理逻辑..........
                            }
                        }
                    }else if ($result['trade_state'] == 'NOTPAY') {
                        // 付款中
                        $this->success('正在付款中~~~~', $url, ['status'=>0]);
                    }
                }else{
                    $msg = '订单号：'.$unified_number.'，支付失败，请重新下单支付。';
                    $this->error($msg, null, ['status'=>0]);
                }
            }
        }
        $this->error('访问错误');
    }

    // 微信支付成功后跳转到此页面
    public function pay_success(){
        if ('1' == input('param.transaction_type')) {
            $url = urldecode(url('user/Pay/pay_consumer_details'));
        }else if ('2' == input('param.transaction_type')) {
            $url = urldecode(url('user/Shop/shop_centre'));
        }
        $this->assign('url',$url);
        return $this->fetch('users/pay_success');
    }

    // 新版支付宝支付
    public function newAlipayPayUrl(){
        $data['unified_number']   = input('param.unified_number/s');
        $data['unified_amount']   = input('param.unified_amount/f');
        $data['transaction_type'] = input('param.transaction_type/d');
        // 调用新版支付宝支付方法
        model('Pay')->getNewAliPayPayUrl($data);
    }

    // 支付宝回调接口，处理订单数据
    public function alipay_return(){
        $param = input('param.');
        $pay_alipay_config = getUsersConfigData('pay.pay_alipay_config');
        if (empty($pay_alipay_config)) {
            return false;
        }
        $is_alipay = unserialize($pay_alipay_config);
        if ($is_alipay['version'] == 0) {
            if ('2' == $param['transaction_type']) {
                if (!empty($param['trade_no']) && !empty($param['out_trade_no'])){
                    $order_data = $this->shop_order_db->where([
                        'order_code' => $param['out_trade_no'],
                        'users_id'   => $this->users_id,
                        'lang'       => $this->home_lang,
                    ])->find();
                    if (empty($order_data)) {
                        $this->error('支付异常，请刷新页面后重试');
                    }

                    // 支付宝付款成功后，订单并未修改状态时，修改订单状态并返回
                    if (empty($order_data['order_status'])) {
                        $OrderWhere = [
                            'order_id'  => $order_data['order_id'],
                            'users_id'  => $this->users_id,
                            'lang'      => $this->home_lang,
                        ];
                        $OrderData = [
                            'order_status' => 1,
                            'pay_name'     => 'alipay', //支付宝支付
                            'pay_details'  => serialize($param),
                            'pay_time'     => getTime(),
                            'update_time'  => getTime(),
                        ];
                        $order_id = $this->shop_order_db->where($OrderWhere)->update($OrderData);

                        if (!empty($order_id)) {
                            $DetailsData['update_time'] = getTime();
                            $this->shop_order_details_db->where($OrderWhere)->update($DetailsData);

                            // 添加订单操作记录
                            AddOrderAction($order_id,$this->users_id,'0','1','0','1','支付成功！','会员使用支付宝完成支付！');
                        }
                    }
                }
                $this->redirect('user/Shop/shop_centre');
            }else if ('1' == $param['transaction_type']) {
                if (!empty($param['trade_no']) && !empty($param['out_trade_no'])){
                    // 付款成功
                    $moneydata = $this->users_money_db->where('order_number',$param['out_trade_no'])->find();
                    if (!empty($moneydata)) {
                        // APPID和伙伴ID验证相等
                        if ($is_alipay['app_id'] == $param['app_id'] && $is_alipay['id'] == $param['seller_id']) {
                            // 支付宝订单处理流程
                            $pay_money = $param['total_amount'];
                            // 参数1为支付宝返回数据集
                            // 参数2为充值记录表数据集
                            // 参数3为订单实际付款金额
                            $this->OrderProcessing($param,$moneydata,$pay_money);
                        }
                    }
                }
                $this->redirect('user/Pay/pay_consumer_details');
            }
        }else if($is_alipay['version'] == 1){
            if ('2' == $param['transaction_type']) {
                if (!empty($param['trade_no']) && !empty($param['out_trade_no'])){
                    $order_data = $this->shop_order_db->where([
                        'order_code' => $param['out_trade_no'],
                        'users_id'   => $this->users_id,
                        'lang'       => $this->home_lang,
                    ])->find();
                    if (empty($order_data)) {
                        $this->error('支付异常，请刷新页面后重试');
                    }

                    // 支付宝付款成功后，订单并未修改状态时，修改订单状态并返回
                    if (empty($order_data['order_status'])) {
                        $OrderWhere = [
                            'order_id'  => $order_data['order_id'],
                            'users_id'  => $this->users_id,
                            'lang'      => $this->home_lang,
                        ];
                        $OrderData = [
                            'order_status' => 1,
                            'pay_name'     => 'alipay', //支付宝支付
                            'pay_details'  => serialize($param),
                            'pay_time'     => getTime(),
                            'update_time'  => getTime(),
                        ];
                        $order_id = $this->shop_order_db->where($OrderWhere)->update($OrderData);

                        if (!empty($order_id)) {
                            $DetailsData['update_time'] = getTime();
                            $this->shop_order_details_db->where($OrderWhere)->update($DetailsData);

                            // 添加订单操作记录
                            AddOrderAction($order_id,$this->users_id,'0','1','0','1','支付成功！','会员使用支付宝完成支付！');
                        }
                    }
                }
                $this->redirect('user/Shop/shop_centre');
            }else if ('1' == $param['transaction_type']) {
                if (!empty($param['trade_no']) && $param['trade_status'] == 'TRADE_SUCCESS') {
                    // 付款成功
                    $moneydata = $this->users_money_db->where('order_number',$param['out_trade_no'])->find();
                    // 伙伴ID验证相等
                    if ($is_alipay['id'] == $param['seller_id']) {
                        // 支付宝订单处理流程
                        $pay_money = $param['total_fee'];
                        // 参数1为支付宝返回数据集
                        // 参数2为充值记录表数据集
                        // 参数3为订单实际付款金额
                        $this->OrderProcessing($param,$moneydata,$pay_money);
                    }
                }

                if($param['trade_status'] == 'WAIT_BUYER_PAY'){
                    // 交易创建，等待买家付款
                }
                if($param['trade_status'] == 'TRADE_CLOSED'){
                    // 未付款交易超时关闭，或支付完成后全额退款
                }
                if($param['trade_status'] == 'TRADE_FINISHED'){
                    // 交易结束，不可退款
                }

                $this->redirect('user/Pay/pay_consumer_details');
            }
        }
    }

    // 余额支付
    public function balance_payment()
    {
        if (IS_AJAX_POST) {
            $post = input('post.');
            $Data = $this->shop_order_db->field('order_amount')->find($post['unified_id']);
            if ($this->users['users_money'] >= $Data['order_amount']) {
                $Where = [
                    'users_id'   => $this->users_id,
                    'lang'       => $this->home_lang,
                ];

                $post['payment_amount'] = $Data['order_amount'];
                $post['payment_type']   = '余额支付';
                $OrderData = [
                    'order_status' => 1,
                    'pay_name'     => 'balance',//余额支付
                    'pay_details'  => serialize($post),
                    'pay_time'     => getTime(),
                    'update_time'  => getTime(),
                ];
                $OrderWhere = [
                    'order_id'   => $post['unified_id'],
                    'order_code' => $post['unified_number'],
                ];
                $OrderWhere = array_merge($Where, $OrderWhere);
                $return = $this->shop_order_db->where($OrderWhere)->update($OrderData);

                if (!empty($return)) {
                    $DetailsWhere = [
                        'order_id'   => $post['unified_id'],
                    ];
                    $DetailsWhere = array_merge($Where, $DetailsWhere);
                    $DetailsData['update_time'] = getTime();
                    $this->shop_order_details_db->where($DetailsWhere)->update($DetailsData);

                    $UsersData = [
                        'users_money' => $this->users['users_money'] - $Data['order_amount'],
                        'update_time' => getTime(),
                    ];
                    $users_id = $this->users_db->where($Where)->update($UsersData);
                    if (!empty($users_id)) {
                        // 添加订单操作记录
                        AddOrderAction($post['unified_id'],$this->users_id,'0','1','0','1','支付成功！','会员使用余额完成支付！');

                        $url = urldecode(url('user/Pay/pay_success', ['transaction_type'=>2]));
                        $this->success('订单已在余额付款完成！即将跳转~~~', $url);
                    }
                }else{
                    $this->error('订单支付异常，请刷新后再进行支付！');
                }
            }else{
                $url = urldecode(url('user/Pay/pay_account_recharge'));
                $this->error('余额不足，若要使用余额支付，请去充值！',$url);
            }
        }
    }

    // 支付宝订单处理流程
    public function OrderProcessing($param,$moneydata,$pay_money){
        // 支付宝付款成功后，订单并未修改状态时，修改订单状态并返回
        if ($moneydata['status'] == 1) {
            $usersdata = $this->users_db->field('users_money')->find($moneydata['users_id']);
            // 修改会员金额明细表中，对应的订单数据，存入返回的数据，订单已付款
            $data['pay_method']  = 'alipay';//支付宝支付
            $data['pay_details'] = serialize($param);
            $data['status']      = 2;
            $data['update_time'] = getTime();
            $ismoney  = $this->users_money_db->where([
                    'moneyid'  => $moneydata['moneyid'],
                    'users_id'  => $this->users_id,
                ])->update($data);

            if (!empty($ismoney)) {
                // 同步修改会员的金额
                $usersdata['users_id']    = $this->users_id;
                $usersdata['users_money'] = Db::raw('users_money+'.$pay_money);
                $isusers = $this->users_db->update($usersdata);

                if (!empty($isusers)) {
                    // 业务处理完成，订单已完成
                    $data_['status']      = 3;
                    $data_['update_time'] = getTime();
                    $this->users_money_db->where([
                            'moneyid'  => $moneydata['moneyid'],
                            'users_id'  => $this->users_id,
                        ])->update($data_);
                    $this->redirect('user/Pay/pay_consumer_details');
                }else{
                    $msg = '付款成功，但未充值成功，请联系管理员。';
                    $this->assign('msg', $msg);
                    return $this->fetch('users/pay_error');
                }
            }else{
                $msg = '付款成功，数据错误，未能充值成功，请联系管理员。';
                $this->assign('msg', $msg);
                return $this->fetch('users/pay_error');
            }
        }

        if ($moneydata['status'] == 2 && !empty($moneydata['pay_details'])) {
            // 订单已付款
            $this->redirect('user/Pay/pay_consumer_details');
        }

        if ($moneydata['status'] == 3) {
            // 订单已完成，待处理逻辑
            // 待处理逻辑..........
        }

        if ($users_money['status'] == 4) {
            // 订单已取消，待处理逻辑
            // 待处理逻辑..........
        }
    }

    public function update_pay_method()
    {
        if (IS_AJAX_POST) {
            $post     = input('post.');
            if (!empty($post)) {
                $UpdateData['moneyid']       = $post['unified_id'];
                $UpdateData['unified_number'] = $post['unified_number'];
                $UpdateData['pay_method']     = $post['pay_method'];
                $UpdateData['update_time']     = getTime();
                $this->users_money_db->update($UpdateData);
            }
        }
    }

}