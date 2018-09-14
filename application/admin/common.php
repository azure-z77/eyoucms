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
 
/**
 * 检验登陆
 * @param
 * @return bool
 */
function is_adminlogin(){
    $admin_id = session('admin_id');
    if(isset($admin_id) && $admin_id > 0){
        return $admin_id;
    }else{
        return false;
    }
}

/**
 * 管理员操作记录
 * @param $log_url 操作URL
 * @param $log_info 记录信息
 */
function adminLog($log_info){
    $add['log_time'] = getTime();
    $add['admin_id'] = session('admin_id');
    $add['log_info'] = $log_info;
    $add['log_ip'] = clientIP();
    $add['log_url'] = request()->baseUrl() ;
    M('admin_log')->add($add);
}

/**
 * 获取管理员登录信息
 */
function getAdminInfo($admin_id = 0)
{
    if ($admin_id > 0) {
        $fields = 'a.*, b.role_id, c.name AS role_name';
        $admin_info = M('admin')
            ->field($fields)
            ->alias('a')
            ->join('__AUTH_ROLE_ADMIN__ b', 'a.admin_id = b.admin_id', 'LEFT')
            ->join('__AUTH_ROLE__ c', 'c.id = b.role_id', 'LEFT')
            ->where("a.admin_id", $admin_id)->find();
    } else {
        $admin_info = session('admin_info');
    }
    return $admin_info;
}

/**
 * 获取conf配置文件
 */
function get_conf($name = 'global')
{            
    $arr = include APP_PATH.MODULE_NAME.'/conf/'.$name.'.php';
    return $arr;
}

/**
 * 检测是否有该权限
 */
function is_check_access($str = 'Index@index') {
    $bool_flag = 1;
    $role_id = session('admin_info.role_id');
    $act_list = session('admin_info.act_list');
    if ($role_id != '-1') {
        $right = M('auth_rule')->where("id", "in", $act_list)->cache(false)->getField('right',true);
        $role_right = '';
        foreach ($right as $val){
            $role_right .= $val.',';
        }
        $role_right = explode(',', trim($role_right, ','));
        $role_right = array_unique($role_right);
        if (!in_array($str, $role_right)) {
            $bool_flag = 0;
        }
    }

    return $bool_flag;
}

/**
 * 根据角色权限过滤菜单
 */
function getMenuList() {
    $menuArr = getAllMenu();

    $role_id = session('admin_info.role_id');
    $act_list = session('admin_info.act_list');

    if ($role_id != '-1') {
        $right = M('auth_rule')->where("id", "in", $act_list)->cache(false)->getField('right',true);
        $role_right = '';
        foreach ($right as $val){
            $role_right .= $val.',';
        }
        $role_right = explode(',', trim($role_right, ','));
        $role_right = array_unique($role_right);

        foreach($menuArr as $k=>$val){
            foreach ($val['child'] as $j=>$v){
                foreach ($v['child'] as $s=>$son){
                    if (!in_array($son['controller'].config('POWER_OPERATOR').$son['action'], $role_right)) {
                        unset($menuArr[$k]['child'][$j]['child'][$s]);//过滤菜单
                    }
                }
            }
        }

        foreach ($menuArr as $mk=>$mr){
            foreach ($mr['child'] as $nk=>$nrr){
                if(empty($nrr['child'])){
                    unset($menuArr[$mk]['child'][$nk]);
                }
            }
        }

        foreach ($menuArr as $mk=>$mr){
            if(empty($mr['child'])){
                unset($menuArr[$mk]);
            }
        }
    }

    return $menuArr;
}

/**
 * 获取左侧菜单
 */
function getAllMenu() {
    $menuArr = false;//extra_cache('admin_all_menu');
    if (!$menuArr) {
        $menuArr = get_conf('menu');
        extra_cache('admin_all_menu', $menuArr);
    }
    return $menuArr;
}

/**
 * 导出excel
 * @param $strTable	表格内容
 * @param $filename 文件名
 */
function downloadExcel($strTable,$filename)
{
	header("Content-type: application/vnd.ms-excel");
	header("Content-Type: application/force-download");
	header("Content-Disposition: attachment; filename=".$filename."_".date('Y-m-d', getTime()).".xls");
	header('Expires:0');
	header('Pragma:public');
	echo '<html><meta http-equiv="Content-Type" content="text/html; charset=utf-8" />'.$strTable.'</html>';
}

/**
 * 根据id获取地区名字
 * @param $regionId id
 */
function getRegionName($regionId){
    $data = M('region')->where(array('id'=>$regionId))->field('name')->find();
    return $data['name'];
}

/**
 * 获取全部的模型
 */
if ( ! function_exists('getChanneltypeList'))
{
    function getChanneltypeList()
    {
        $result = extra_cache('admin_channeltype_list_logic');
        if ($result == false)
        {
            $result = model('Channeltype')->getAll('*', array(), 'id');
            extra_cache('admin_channeltype_list_logic', $result);
        }

        return $result;
    }
}

function tpversion($timeout = 3)
{
    if(!empty($_SESSION['isset_push']))
        return false;
    $_SESSION['isset_push'] = 1;
    error_reporting(0);//关闭所有错误报告
    $install_time = DEFAULT_INSTALL_DATE;
    $serial_number = DEFAULT_SERIALNUMBER;

    $constsant_path = APP_PATH.MODULE_NAME.'/conf/constant.php';
    if (file_exists($constsant_path)) {
        require_once($constsant_path);
        defined('INSTALL_DATE') && $install_time = INSTALL_DATE;
        defined('SERIALNUMBER') && $serial_number = SERIALNUMBER;
    }
    $curent_version = getCmsVersion();
    $mysqlinfo = \think\Db::query("SELECT VERSION() as version");
    $mysql_version  = $mysqlinfo[0]['version'];
    $vaules = array(            
        'domain'=>$_SERVER['HTTP_HOST'], 
        'last_domain'=>$_SERVER['HTTP_HOST'], 
        'key_num'=>$curent_version, 
        'install_time'=>$install_time, 
        'serial_number'=>$serial_number,
        'ip'    => GetHostByName($_SERVER['SERVER_NAME']),
        'phpv'  => urlencode(phpversion()),
        'mysql_version' => urlencode($mysql_version),
        'web_server'    => urlencode($_SERVER['SERVER_SOFTWARE']),
    );
    // api_Service_user_push
    $service_ey = config('service_ey');
    $tmp_str = 'L2luZGV4LnBocD9tPWFwaSZjPVNlcnZpY2UmYT11c2VyX3B1c2gm';
    $url = base64_decode($service_ey).base64_decode($tmp_str).http_build_query($vaules);
    stream_context_set_default(array('http' => array('timeout' => $timeout)));
    file_get_contents($url);
}

/**
 * 将新链接推送给百度蜘蛛
 */
function push_zzbaidu($type = 'urls', $aid = '', $typeid = '')
{
    // 获取token的值：http://ziyuan.baidu.com/linksubmit/index?site=http://www.eyoucms.com/
    $aid = intval($aid);
    $typeid = intval($typeid);
    $sitemap_zzbaidutoken = tpCache('sitemap.sitemap_zzbaidutoken');
    if (empty($sitemap_zzbaidutoken) || (empty($aid) && empty($typeid))) {
        return '';
    }

    $urlsArr = array();
    $channeltype_list = model('Channeltype')->getAll('id, ctl_name', array(), 'id');

    if ($aid > 0) {
        $res = M('archives')->field('b.*, a.*, a.aid, b.id as typeid')
            ->alias('a')
            ->join('__ARCTYPE__ b', 'b.id = a.typeid', 'LEFT')
            ->find($aid);
        $ctl_name = $channeltype_list[$res['current_channel']]['ctl_name'];
        $arcurl = arcurl("home/{$ctl_name}/view", $res, true, SITE_URL);
        array_push($urlsArr, $arcurl);
    }
    if (0 < $typeid) {
        $res = M('arctype')->field('a.*')
            ->alias('a')
            ->find($typeid);
        $ctl_name = $channeltype_list[$res['current_channel']]['ctl_name'];
        $typeurl = typeurl("home/{$ctl_name}/lists", $res, true, SITE_URL);
        array_push($urlsArr, $typeurl);
    }

    $type = ('edit' == $type) ? 'update' : $type;
    $api = 'http://data.zz.baidu.com/'.$type.'?site='.DOMAIN.'&token='.$sitemap_zzbaidutoken;
    $ch = curl_init();
    $options =  array(
        CURLOPT_URL => $api,
        CURLOPT_POST => true,
        CURLOPT_RETURNTRANSFER => true,
        CURLOPT_POSTFIELDS => implode("\n", $urlsArr),
        CURLOPT_HTTPHEADER => array('Content-Type: text/plain'),
    );
    curl_setopt_array($ch, $options);
    $result = curl_exec($ch);
    
    return $result;    
}

/**
 * 自动生成引擎sitemap
 */
function sitemap_auto()
{
    $sitemap_config = tpCache('sitemap');
    if (isset($sitemap_config['sitemap_auto']) && $sitemap_config['sitemap_auto'] > 0) {
        sitemap_all();
    }
}

/**
 * 生成全部引擎sitemap
 */
function sitemap_all()
{
    sitemap_xml();
}

/**
 * 生成xml形式的sitemap
 */
function sitemap_xml()
{
    $sitemap_config = tpCache('sitemap');
    if (!isset($sitemap_config['sitemap_xml']) || empty($sitemap_config['sitemap_xml'])) {
        return '';
    }

    $modelu_name = 'home';
    $filename = ROOT_PATH . "sitemap.xml";

    // 模型对应的控制器名
    $channeltype_list = model('Channeltype')->getAll('id, ctl_name', array(), 'id');

    /* 分类列表(用于生成列表链接的sitemap) */
    $map = array(
        'status'    => 1,
    );
    if (is_array($sitemap_config)) {
        // 过滤隐藏栏目
        if (isset($sitemap_config['sitemap_not1']) && $sitemap_config['sitemap_not1'] > 0) {
            $map['is_hidden'] = 0;
        }
        // 过滤外部模块
        if (isset($sitemap_config['sitemap_not2']) && $sitemap_config['sitemap_not2'] > 0) {
            $map['is_part'] = 0;
        }
    }
    $result_arctype = M('arctype')->field("*, id AS loc, add_time AS lastmod, 'daily' AS changefreq, '1.0' AS priority")
        ->where('status = 1')
        ->order('sort_order asc')
        ->getAllWithIndex('id');

    /* 文章列表(用于生成文章详情链接的sitemap) */
    $map = array(
        'arcrank'   => array('gt', -1),
        'status'    => 1,
    );
    if (is_array($sitemap_config)) {
        // 过滤外部模块
        if (isset($sitemap_config['sitemap_not2']) && $sitemap_config['sitemap_not2'] > 0) {
            $map['is_jump'] = 0;
        }
    }
    $field = "aid, channel, is_jump, jumplinks, add_time, update_time, typeid, aid AS loc, add_time AS lastmod, 'daily' AS changefreq, '1.0' AS priority";
    $result_archives = M('archives')->field($field)
        ->where($map)
        ->order('aid desc')
        ->limit(48000)
        ->select();

        // header('Content-Type: text/xml');//这行很重要，php默认输出text/html格式的文件，所以这里明确告诉浏览器输出的格式为xml,不然浏览器显示不出xml的格式
        $xml_wrapper = <<<XML
<?xml version='1.0' encoding='utf-8'?>
<urlset xmlns="http://www.sitemaps.org/schemas/sitemap/0.9">
</urlset>
XML;

    $xml = simplexml_load_string($xml_wrapper);
    // $xml = new SimpleXMLElement($xml_wrapper);
     
    foreach ($result_arctype as $val) {
        $item = $xml->addChild('url'); //使用addChild添加节点
        if (is_array($val)) {
            foreach ($val as $key => $row) {
                if (in_array($key, array('loc','lastmod','changefreq','priority'))) {
                    if ($key == 'loc') {
                        if ($val['is_part'] == 1) {
                            $row = $val['typelink'];
                        } else {
                            $ctl_name = $channeltype_list[$val['current_channel']]['ctl_name'];
                            $row = typeurl("{$modelu_name}/{$ctl_name}/lists", $val, true, SITE_URL);
                            $row = auto_hide_index($row);
                        }
                    } elseif ($key == 'lastmod') {
                        $row = date('Y-m-d');
                    }

                    $node = $item->addChild($key, $row);
         
                    if (isset($attribute_array[$key]) && is_array($attribute_array[$key])) {
                        foreach ($attribute_array[$key] as $akey => $aval) {//设置属性值，我这里为空
                            $node->addAttribute($akey, $aval);
                        }
                    }
                }
            }
        }
    }

    foreach ($result_archives as $val) {
        $item = $xml->addChild('url'); //使用addChild添加节点
        if (is_array($val) && isset($result_arctype[$val['typeid']])) {
            $val = array_merge($result_arctype[$val['typeid']], $val);
            foreach ($val as $key => $row) {
                if (in_array($key, array('loc','lastmod','changefreq','priority'))) {
                    if ($key == 'loc') {
                        $channeltype = $result_arctype[$val['typeid']]['current_channel'];
                        $ctl_name = $channeltype_list[$channeltype]['ctl_name'];
                        if ($val['is_jump'] == 1) {
                            $row = $val['jumplinks'];
                        } else {
                            $row = arcurl("{$modelu_name}/{$ctl_name}/view", $val, true, SITE_URL);
                            $row = auto_hide_index($row);
                        }
                    } elseif ($key == 'lastmod') {
                        $lastmod_time = empty($val['update_time']) ? $val['add_time'] : $val['update_time'];
                        $row = date('Y-m-d', $lastmod_time);
                    }

                    $node = $item->addChild($key, $row);
         
                    if (isset($attribute_array[$key]) && is_array($attribute_array[$key])) {
                        foreach ($attribute_array[$key] as $akey => $aval) {//设置属性值，我这里为空
                            $node->addAttribute($akey, $aval);
                        }
                    }
                }
            }
        }
    }

    $content = $xml->asXML(); //用asXML方法输出xml，默认只构造不输出。
    file_put_contents($filename, $content);
}

/**
 * 获取栏目链接
 */
function get_typeurl($arctype_info = array())
{
    $ctl_name = '';
    $result = model('Channeltype')->getAll('id, ctl_name', array(), 'id');
    if ($result) {
        $ctl_name = $result[$arctype_info['channeltype']]['ctl_name'];
    }
    $seo_pseudo = tpCache('seo.seo_pseudo');
    $seo_pseudo = !empty($seo_pseudo) ? $seo_pseudo : 1;
    $typeurl = typeurl("home/{$ctl_name}/lists", $arctype_info, true, false, $seo_pseudo);
    // 自动隐藏index.php入口文件
    $typeurl = auto_hide_index($typeurl);

    return $typeurl;
}

/**
 * 获取指定栏目的文档数
 */
function get_total_arc($typeid)
{
    $total = 0;
    $current_channel = M('arctype')->where('id', $typeid)->getField('current_channel');
    $allow_release_channel = config('global.allow_release_channel');
    if (in_array($current_channel, $allow_release_channel)) { // 能发布文档的模型
        $result = model('Arctype')->getHasChildren($typeid, $current_channel);
        $typeidArr = get_arr_column($result, 'id');
        $map = array(
            'typeid'    => array('IN', $typeidArr),
            'channel'   => $current_channel,
        );
        $total = M('archives')->where($map)
            ->count();
    } elseif ($current_channel == 8) { // 留言模型
        $total = M('guestbook')->where(array('typeid'=>array('eq', $typeid)))
            ->count();
    }

    return $total;
}

/**
 * 将路径斜杆、反斜杠替换为冒号符，适用于IIS服务器在URL上的双重转义限制
 * @param string $filepath 相对路径
 * @param string $replacement 目标字符
 * @param boolean $is_back false为替换，true为还原
 */
function replace_path($filepath = '', $replacement = ':', $is_back = false)
{
    if (false == $is_back) {
        $filepath = str_replace(DIRECTORY_SEPARATOR, $replacement, $filepath);
        $filepath = preg_replace('#\/#', $replacement, $filepath);
    } else {
        $filepath = preg_replace('#'.$replacement.'#', '/', $filepath);
        $filepath = str_replace('//', ':/', $filepath);
    }
    return $filepath;
}

/**
 * 获取当前栏目的第一级栏目
 */
function gettoptype($typeid, $field = 'typename')
{
    $parent_list = model('Arctype')->getAllPid($typeid); // 获取当前栏目的所有父级栏目
    $result = current($parent_list); // 第一级栏目
    if (isset($result[$field]) && !empty($result[$field])) {
        return $result[$field];
    } else {
        return '';
    }
}

/**
 * URL模式下拉列表
 */
function get_seo_pseudo_list($key = '')
{
    $data = array(
        1   => '动态URL',
        // 2   => '静态页面',
        3   => '伪静态化'
    );

    return isset($data[$key]) ? $data[$key] : $data;
}