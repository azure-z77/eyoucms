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
 * @param $arr
 * @param $key_name
 * @return array
 * 将数据库中查出的列表以指定的 id 作为数组的键名 
 */
function convert_arr_key($arr, $key_name)
{
    $arr2 = array();
    foreach($arr as $key => $val){
        $arr2[$val[$key_name]] = $val;        
    }
    return $arr2;
}

function func_encrypt($str){
    return md5(config("AUTH_CODE").$str);
}
            
/**
 * 获取数组中的某一列
 * @param array $arr 数组
 * @param string $key_name  列名
 * @return array  返回那一列的数组
 */
function get_arr_column($arr, $key_name)
{
    $arr2 = array();
    foreach($arr as $key => $val){
        $arr2[] = $val[$key_name];        
    }
    return $arr2;
}


/**
 * 获取url 中的各个参数  类似于 pay_code=alipay&bank_code=ICBC-DEBIT
 * @param type $str
 * @return type
 */
function parse_url_param($str){
    $data = array();
    $str = explode('?',$str);
    $str = end($str);
    $parameter = explode('&',$str);
    foreach($parameter as $val){
        $tmp = explode('=',$val);
        $data[$tmp[0]] = $tmp[1];
    }
    return $data;
}


/**
 * 二维数组排序
 * @param $arr
 * @param $keys
 * @param string $type
 * @return array
 */
function array_sort($arr, $keys, $type = 'desc')
{
    $key_value = $new_array = array();
    foreach ($arr as $k => $v) {
        $key_value[$k] = $v[$keys];
    }
    if ($type == 'asc') {
        asort($key_value);
    } else {
        arsort($key_value);
    }
    reset($key_value);
    foreach ($key_value as $k => $v) {
        $new_array[$k] = $arr[$k];
    }
    return $new_array;
}


/**
 * 多维数组转化为一维数组
 * @param 多维数组
 * @return array 一维数组
 */
function array_multi2single($array)
{
    static $result_array = array();
    foreach ($array as $value) {
        if (is_array($value)) {
            array_multi2single($value);
        } else
            $result_array [] = $value;
    }
    return $result_array;
}

/**
 * 友好时间显示
 * @param $time
 * @return bool|string
 */
function friend_date($time)
{
    if (!$time)
        return false;
    $fdate = '';
    $d = getTime() - intval($time);
    $ld = $time - mktime(0, 0, 0, 0, 0, date('Y')); //得出年
    $md = $time - mktime(0, 0, 0, date('m'), 0, date('Y')); //得出月
    $byd = $time - mktime(0, 0, 0, date('m'), date('d') - 2, date('Y')); //前天
    $yd = $time - mktime(0, 0, 0, date('m'), date('d') - 1, date('Y')); //昨天
    $dd = $time - mktime(0, 0, 0, date('m'), date('d'), date('Y')); //今天
    $td = $time - mktime(0, 0, 0, date('m'), date('d') + 1, date('Y')); //明天
    $atd = $time - mktime(0, 0, 0, date('m'), date('d') + 2, date('Y')); //后天
    if ($d == 0) {
        $fdate = '刚刚';
    } else {
        switch ($d) {
            case $d < $atd:
                $fdate = date('Y年m月d日', $time);
                break;
            case $d < $td:
                $fdate = '后天' . date('H:i', $time);
                break;
            case $d < 0:
                $fdate = '明天' . date('H:i', $time);
                break;
            case $d < 60:
                $fdate = $d . '秒前';
                break;
            case $d < 3600:
                $fdate = floor($d / 60) . '分钟前';
                break;
            case $d < $dd:
                $fdate = floor($d / 3600) . '小时前';
                break;
            case $d < $yd:
                $fdate = '昨天' . date('H:i', $time);
                break;
            case $d < $byd:
                $fdate = '前天' . date('H:i', $time);
                break;
            case $d < $md:
                $fdate = date('m月d日 H:i', $time);
                break;
            case $d < $ld:
                $fdate = date('m月d日', $time);
                break;
            default:
                $fdate = date('Y年m月d日', $time);
                break;
        }
    }
    return $fdate;
}


/**
 * 返回状态和信息
 * @param $status
 * @param $info
 * @return array
 */
function arrayRes($status, $info, $url = "")
{
    return array("status" => $status, "info" => $info, "url" => $url);
}
       
/**
 * @param $arr
 * @param $key_name
  * @param $key_name2
 * @return array
 * 将数据库中查出的列表以指定的 id 作为数组的键名 数组指定列为元素 的一个数组
 */
function get_id_val($arr, $key_name,$key_name2)
{
    $arr2 = array();
    foreach($arr as $key => $val){
        $arr2[$val[$key_name]] = $val[$key_name2];
    }
    return $arr2;
}

 // 客户端IP
function clientIP() {
    $ip = request()->ip();
    if(preg_match('/^((?:(?:25[0-5]|2[0-4]\d|((1\d{2})|([1-9]?\d)))\.){3}(?:25[0-5]|2[0-4]\d|((1\d{2})|([1 -9]?\d))))$/', $ip))          
        return $ip;
    else
        return '';
}

// 服务器端IP
function serverIP(){   
    return gethostbyname($_SERVER["SERVER_NAME"]);   
}  
 
 
 /**
  * 自定义函数递归的复制带有多级子目录的目录
  * 递归复制文件夹
  * @param type $src 原目录
  * @param type $dst 复制到的目录
  */                        
//参数说明：            
//自定义函数递归的复制带有多级子目录的目录
function recurse_copy($src, $dst)
{
    $now = getTime();
    $dir = opendir($src);
    @mkdir($dst);
    while (false !== $file = readdir($dir)) {
        if (($file != '.') && ($file != '..')) {
            if (is_dir($src . '/' . $file)) {
                recurse_copy($src . '/' . $file, $dst . '/' . $file);
            }
            else {
                if (file_exists($dst . DIRECTORY_SEPARATOR . $file)) {
                    if (!is_writeable($dst . DIRECTORY_SEPARATOR . $file)) {
                        exit($dst . DIRECTORY_SEPARATOR . $file . '不可写');
                    }
                    @unlink($dst . DIRECTORY_SEPARATOR . $file);
                }
                if (file_exists($dst . DIRECTORY_SEPARATOR . $file)) {
                    @unlink($dst . DIRECTORY_SEPARATOR . $file);
                }
                $copyrt = copy($src . DIRECTORY_SEPARATOR . $file, $dst . DIRECTORY_SEPARATOR . $file);
                if (!$copyrt) {
                    echo 'copy ' . $dst . DIRECTORY_SEPARATOR . $file . ' failed<br>';
                }
            }
        }
    }
    closedir($dir);
}

// 递归删除文件夹
function delFile($path,$delDir = FALSE) {
    if(!is_dir($path))
                return FALSE;       
    $handle = @opendir($path);
    if ($handle) {
        while (false !== ( $item = readdir($handle) )) {
            if ($item != "." && $item != "..")
                is_dir("$path/$item") ? delFile("$path/$item", $delDir) : unlink("$path/$item");
        }
        closedir($handle);
        if ($delDir) {
            return rmdir($path);
        }
    }else {
        if (file_exists($path)) {
            return unlink($path);
        } else {
            return FALSE;
        }
    }
}

// 递归读取文件夹文件
function getDirFile($directory, $dir_name='', &$arr_file = array()) {
    if (!file_exists($directory) ) {
        return false;
    }

    $mydir = dir($directory);
    while($file = $mydir->read())
    {
        if((is_dir("$directory/$file")) AND ($file != ".") AND ($file != ".."))
        {
            if ($dir_name) {
                getDirFile("$directory/$file", "$dir_name/$file", $arr_file);
            } else {
                getDirFile("$directory/$file", "$file", $arr_file);
            }
            
        }
        else if(($file != ".") AND ($file != ".."))
        {
            if ($dir_name) {
                $arr_file[] = "$dir_name/$file";
            } else {
                $arr_file[] = "$file";
            }
        }
    }
    $mydir->close();

    return $arr_file;
}
 
/**
 * 多个数组的笛卡尔积
 *
 * @param unknown_type $data
 */
function combineDika() {
    $data = func_get_args();
    $data = current($data);
    $cnt = count($data);
    $result = array();
    $arr1 = array_shift($data);
    foreach($arr1 as $key=>$item) 
    {
        $result[] = array($item);
    }       

    foreach($data as $key=>$item) 
    {                                
        $result = combineArray($result,$item);
    }
    return $result;
}


/**
 * 两个数组的笛卡尔积
 * @param unknown_type $arr1
 * @param unknown_type $arr2
*/
function combineArray($arr1,$arr2) {         
    $result = array();
    foreach ($arr1 as $item1) 
    {
        foreach ($arr2 as $item2) 
        {
            $temp = $item1;
            $temp[] = $item2;
            $result[] = $temp;
        }
    }
    return $result;
}

/**
 * 将二维数组以元素的某个值作为键 并归类数组
 * array( array('name'=>'aa','type'=>'pay'), array('name'=>'cc','type'=>'pay') )
 * array('pay'=>array( array('name'=>'aa','type'=>'pay') , array('name'=>'cc','type'=>'pay') ))
 * @param $arr 数组
 * @param $key 分组值的key
 * @return array
 */
function group_same_key($arr,$key){
    $new_arr = array();
    foreach($arr as $k=>$v ){
        $new_arr[$v[$key]][] = $v;
    }
    return $new_arr;
}

/**
 * 获取随机字符串
 * @param int $randLength  长度
 * @param int $addtime  是否加入当前时间戳
 * @param int $includenumber   是否包含数字
 * @return string
 */
function get_rand_str($randLength=6,$addtime=1,$includenumber=0){
    if ($includenumber){
        $chars='abcdefghijklmnopqrstuvwxyzABCDEFGHJKLMNPQEST123456789';
    }else {
        $chars='abcdefghijklmnopqrstuvwxyz';
    }
    $len=strlen($chars);
    $randStr='';
    for ($i=0;$i<$randLength;$i++){
        $randStr.=$chars[rand(0,$len-1)];
    }
    $tokenvalue=$randStr;
    if ($addtime){
        $tokenvalue=$randStr.getTime();
    }
    return $tokenvalue;
}

/**
 * CURL请求
 * @param $url 请求url地址
 * @param $method 请求方法 get post
 * @param null $postfields post数据数组
 * @param array $headers 请求header信息
 * @param bool|false $debug  调试开启 默认false
 * @return mixed
 */
function httpRequest($url, $method="GET", $postfields = null, $headers = array(), $debug = false) {
    $method = strtoupper($method);
    $ci = curl_init();
    /* Curl settings */
    curl_setopt($ci, CURLOPT_HTTP_VERSION, CURL_HTTP_VERSION_1_0);
    curl_setopt($ci, CURLOPT_USERAGENT, "Mozilla/5.0 (Windows NT 6.2; WOW64; rv:34.0) Gecko/20100101 Firefox/34.0");
    curl_setopt($ci, CURLOPT_CONNECTTIMEOUT, 60); /* 在发起连接前等待的时间，如果设置为0，则无限等待 */
    // curl_setopt($ci, CURLOPT_TIMEOUT, 7); /* 设置cURL允许执行的最长秒数 */
    curl_setopt($ci, CURLOPT_TIMEOUT, 30); /* 设置cURL允许执行的最长秒数 */
    curl_setopt($ci, CURLOPT_RETURNTRANSFER, true);
    switch ($method) {
        case "POST":
            curl_setopt($ci, CURLOPT_POST, true);
            if (!empty($postfields)) {
                $tmpdatastr = is_array($postfields) ? http_build_query($postfields) : $postfields;
                curl_setopt($ci, CURLOPT_POSTFIELDS, $tmpdatastr);
            }
            break;
        default:
            curl_setopt($ci, CURLOPT_CUSTOMREQUEST, $method); /* //设置请求方式 */
            break;
    }
    $ssl = preg_match('/^https:\/\//i',$url) ? TRUE : FALSE;
    curl_setopt($ci, CURLOPT_URL, $url);
    if($ssl){
        curl_setopt($ci, CURLOPT_SSL_VERIFYPEER, FALSE); // https请求 不验证证书和hosts
        curl_setopt($ci, CURLOPT_SSL_VERIFYHOST, FALSE); // 不从证书中检查SSL加密算法是否存在
    }
    //curl_setopt($ci, CURLOPT_HEADER, true); /*启用时会将头文件的信息作为数据流输出*/
    if (ini_get('open_basedir') == '' && ini_get('safe_mode' == 'Off')) {
        curl_setopt($ci, CURLOPT_FOLLOWLOCATION, 1);
    }
    curl_setopt($ci, CURLOPT_MAXREDIRS, 2);/*指定最多的HTTP重定向的数量，这个选项是和CURLOPT_FOLLOWLOCATION一起使用的*/
    curl_setopt($ci, CURLOPT_HTTPHEADER, $headers);
    curl_setopt($ci, CURLINFO_HEADER_OUT, true);
    /*curl_setopt($ci, CURLOPT_COOKIE, $Cookiestr); * *COOKIE带过去** */
    $response = curl_exec($ci);
    $requestinfo = curl_getinfo($ci);
    $http_code = curl_getinfo($ci, CURLINFO_HTTP_CODE);
    if ($debug) {
        echo "=====post data======\r\n";
        var_dump($postfields);
        echo "=====info===== \r\n";
        print_r($requestinfo);
        echo "=====response=====\r\n";
        print_r($response);
    }
    curl_close($ci);
    return $response;
    //return array($http_code, $response,$requestinfo);
}

/**
 * 过滤数组元素前后空格 (支持多维数组)
 * @param $array 要过滤的数组
 * @return array|string
 */
function trim_array_element($array){
    if(!is_array($array))
        return trim($array);
    return array_map('trim_array_element',$array);
}

/**
 * 检查手机号码格式
 * @param $mobile 手机号码
 */
function check_mobile($mobile){
    if(preg_match('/1[34578]\d{9}$/',$mobile))
        return true;
    return false;
}

/**
 * 检查固定电话
 * @param $mobile
 * @return bool
 */
function check_telephone($mobile){
    if(preg_match('/^([0-9]{3,4}-)?[0-9]{7,8}$/',$mobile))
        return true;
    return false;
}

/**
 * 检查邮箱地址格式
 * @param $email 邮箱地址
 */
function check_email($email){
    if(filter_var($email,FILTER_VALIDATE_EMAIL))
        return true;
    return false;
}

/**
 *   实现中文字串截取无乱码的方法
 */
function getSubstr($string, $start, $length) {
    if(mb_strlen($string,'utf-8')>$length){
        $str = msubstr($string, $start, $length, true,'utf-8');
        return $str;
    }else{
        return $string;
    }
}

/**
 * 字符串截取，支持中文和其他编码
 * @static
 * @access public
 * @param string $str 需要转换的字符串
 * @param string $start 开始位置
 * @param string $length 截取长度
 * @param string $suffix 截断显示字符
 * @param string $charset 编码格式
 * @return string
 */
function msubstr($str, $start=0, $length, $suffix=false, $charset="utf-8") {
    if(function_exists("mb_substr"))
        $slice = mb_substr($str, $start, $length, $charset);
    elseif(function_exists('iconv_substr')) {
        $slice = iconv_substr($str,$start,$length,$charset);
        if(false === $slice) {
            $slice = '';
        }
    }else{
        $re['utf-8']   = "/[\x01-\x7f]|[\xc2-\xdf][\x80-\xbf]|[\xe0-\xef][\x80-\xbf]{2}|[\xf0-\xff][\x80-\xbf]{3}/";
        $re['gb2312'] = "/[\x01-\x7f]|[\xb0-\xf7][\xa0-\xfe]/";
        $re['gbk']    = "/[\x01-\x7f]|[\x81-\xfe][\x40-\xfe]/";
        $re['big5']   = "/[\x01-\x7f]|[\x81-\xfe]([\x40-\x7e]|\xa1-\xfe])/";
        preg_match_all($re[$charset], $str, $match);
        $slice = join("",array_slice($match[0], $start, $length));
    }

    $str_len = strlen($str); // 原字符串长度
    $slice_len = strlen($slice); // 截取字符串的长度
    if ($slice_len < $str_len) {
        $slice = $suffix ? $slice.'...' : $slice;
    }

    return $slice;
}

/**
 * 截取内容清除html之后的字符串长度，支持中文和其他编码
 * @static
 * @access public
 * @param string $str 需要转换的字符串
 * @param string $start 开始位置
 * @param string $length 截取长度
 * @param string $suffix 截断显示字符
 * @param string $charset 编码格式
 * @return string
 */
function html_msubstr($str, $start=0, $length, $suffix=false, $charset="utf-8") {
    $str = eyou_htmlspecialchars_decode($str);
    $str = checkStrHtml($str);
    return msubstr($str, $start, $length, $suffix, $charset);
}

/**
 * 自定义只针对htmlspecialchars编码过的字符串进行解码
 * @static
 * @access public
 * @param string $str 需要转换的字符串
 * @param string $start 开始位置
 * @param string $length 截取长度
 * @param string $suffix 截断显示字符
 * @param string $charset 编码格式
 * @return string
 */
function eyou_htmlspecialchars_decode($str) {
    if (is_string($str) && stripos($str, '&lt;') !== false && stripos($str, '&gt;') !== false) {
        $str = htmlspecialchars_decode($str);
    }
    return $str;
}

/**
 * 判断当前访问的用户是  PC端  还是 手机端  返回true 为手机端  false 为PC 端
 * @return boolean
 */
/**
　　* 是否移动端访问访问
　　*
　　* @return bool
　　*/
function isMobile()
{
    // 如果有HTTP_X_WAP_PROFILE则一定是移动设备
    if (isset ($_SERVER['HTTP_X_WAP_PROFILE']))
    return true;

    // 如果via信息含有wap则一定是移动设备,部分服务商会屏蔽该信息
    if (isset ($_SERVER['HTTP_VIA']))
    {
    // 找不到为flase,否则为true
    return stristr($_SERVER['HTTP_VIA'], "wap") ? true : false;
    }
    // 脑残法，判断手机发送的客户端标志,兼容性有待提高
    if (isset ($_SERVER['HTTP_USER_AGENT']))
    {
        $clientkeywords = array ('nokia','sony','ericsson','mot','samsung','htc','sgh','lg','sharp','sie-','philips','panasonic','alcatel','lenovo','iphone','ipod','blackberry','meizu','android','netfront','symbian','ucweb','windowsce','palm','operamini','operamobi','openwave','nexusone','cldc','midp','wap','mobile');
        // 从HTTP_USER_AGENT中查找手机浏览器的关键字
        if (preg_match("/(" . implode('|', $clientkeywords) . ")/i", strtolower($_SERVER['HTTP_USER_AGENT'])))
            return true;
    }
        // 协议法，因为有可能不准确，放到最后判断
    if (isset ($_SERVER['HTTP_ACCEPT']))
    {
    // 如果只支持wml并且不支持html那一定是移动设备
    // 如果支持wml和html但是wml在html之前则是移动设备
        if ((strpos($_SERVER['HTTP_ACCEPT'], 'vnd.wap.wml') !== false) && (strpos($_SERVER['HTTP_ACCEPT'], 'text/html') === false || (strpos($_SERVER['HTTP_ACCEPT'], 'vnd.wap.wml') < strpos($_SERVER['HTTP_ACCEPT'], 'text/html'))))
        {
            return true;
        }
    }
            return false;
 }

function is_weixin() {
    if (strpos($_SERVER['HTTP_USER_AGENT'], 'MicroMessenger') !== false) {
        return true;
    } return false;
}

function is_qq() {
    if (strpos($_SERVER['HTTP_USER_AGENT'], 'QQ') !== false) {
        return true;
    } return false;
}
function is_alipay() {
    if (strpos($_SERVER['HTTP_USER_AGENT'], 'AlipayClient') !== false) {
        return true;
    } return false;
}

//php获取中文字符拼音首字母
function getFirstCharter($str){
      if(empty($str))
      {
            return '';          
      }
      $fchar=ord($str{0});
      if($fchar>=ord('A')&&$fchar<=ord('z')) return strtoupper($str{0});
      $s1=iconv('UTF-8','gb2312',$str);
      $s2=iconv('gb2312','UTF-8',$s1);
      $s=$s2==$str?$s1:$str;
      $asc=ord($s{0})*256+ord($s{1})-65536;
     if($asc>=-20319&&$asc<=-20284) return 'A';
     if($asc>=-20283&&$asc<=-19776) return 'B';
     if($asc>=-19775&&$asc<=-19219) return 'C';
     if($asc>=-19218&&$asc<=-18711) return 'D';
     if($asc>=-18710&&$asc<=-18527) return 'E';
     if($asc>=-18526&&$asc<=-18240) return 'F';
     if($asc>=-18239&&$asc<=-17923) return 'G';
     if($asc>=-17922&&$asc<=-17418) return 'H';
     if($asc>=-17417&&$asc<=-16475) return 'J';
     if($asc>=-16474&&$asc<=-16213) return 'K';
     if($asc>=-16212&&$asc<=-15641) return 'L';
     if($asc>=-15640&&$asc<=-15166) return 'M';
     if($asc>=-15165&&$asc<=-14923) return 'N';
     if($asc>=-14922&&$asc<=-14915) return 'O';
     if($asc>=-14914&&$asc<=-14631) return 'P';
     if($asc>=-14630&&$asc<=-14150) return 'Q';
     if($asc>=-14149&&$asc<=-14091) return 'R';
     if($asc>=-14090&&$asc<=-13319) return 'S';
     if($asc>=-13318&&$asc<=-12839) return 'T';
     if($asc>=-12838&&$asc<=-12557) return 'W';
     if($asc>=-12556&&$asc<=-11848) return 'X';
     if($asc>=-11847&&$asc<=-11056) return 'Y';
     if($asc>=-11055&&$asc<=-10247) return 'Z';
     return null;
}

/**
 * 获取整条字符串汉字拼音首字母
 * @param $zh
 * @return string
 */
function pinyin_long($zh){
    $ret = "";
    $s1 = iconv("UTF-8","gb2312", $zh);
    $s2 = iconv("gb2312","UTF-8", $s1);
    if($s2 == $zh){$zh = $s1;}
    for($i = 0; $i < strlen($zh); $i++){
        $s1 = substr($zh,$i,1);
        $p = ord($s1);
        if($p > 160){
            $s2 = substr($zh,$i++,2);
            $ret .= getFirstCharter($s2);
        }else{
            $ret .= $s1;
        }
    }
    return $ret;
}

function ajaxReturn($data){
    header('Content-Type:application/json; charset=utf-8');
    return json($data);
}

/**
 * 参数 is_jsonp 为true，表示跨域ajax请求的返回值
 */
function respose($res, $is_jsonp = false){
    if (true === $is_jsonp) {
        exit(I('callback')."(".json_encode($res).")");
    } else {
        exit(json_encode($res));
    }
}

/**
 * 根据ip地址获取地址信息
 * @param string $ip
 * @return bool|mixed
 */
function GetIpLookup($ip = ''){
    if(empty($ip)){
        $ip = clientIP();
    }
    $res = @file_get_contents('http://int.dpool.sina.com.cn/iplookup/iplookup.php?format=js&ip=' . $ip);
    if(empty($res)){ return false; }
    $jsonMatches = array();
    preg_match('#\{.+?\}#', $res, $jsonMatches);
    if(!isset($jsonMatches[0])){ return false; }
    $json = json_decode($jsonMatches[0], true);
    if(isset($json['ret']) && $json['ret'] == 1){
        $json['ip'] = $ip;
        unset($json['ret']);
    }else{
        return false;
    }
    return $json;
}

function flash_sale_time_space()
{
    $now_day = date('Y-m-d');
    $now_time = date('H');
    if ($now_time % 2 == 0) {
        $flash_now_time = $now_time;
    } else {
        $flash_now_time = $now_time - 1;
    }
    $flash_sale_time = strtotime($now_day . " " . $flash_now_time . ":00:00");
    $space = 7200;
    $time_space = array(
        '1' => array('font' => date("H:i", $flash_sale_time), 'start_time' => $flash_sale_time, 'end_time' => $flash_sale_time + $space),
        '2' => array('font' => date("H:i", $flash_sale_time + $space), 'start_time' => $flash_sale_time + $space, 'end_time' => $flash_sale_time + 2 * $space),
        '3' => array('font' => date("H:i", $flash_sale_time + 2 * $space), 'start_time' => $flash_sale_time + 2 * $space, 'end_time' => $flash_sale_time + 3 * $space),
        '4' => array('font' => date("H:i", $flash_sale_time + 3 * $space), 'start_time' => $flash_sale_time + 3 * $space, 'end_time' => $flash_sale_time + 4 * $space),
        '5' => array('font' => date("H:i", $flash_sale_time + 4 * $space), 'start_time' => $flash_sale_time + 4 * $space, 'end_time' => $flash_sale_time + 5 * $space),
    );
    return $time_space;
}

/**
 * 验证码操作(不生成图片)
 * @param array $inconfig  配置
 * @param sring $id 要生成验证码的标识 
 * @param string $incode 验证码,若为null生成验证码,否则检验验证码
 */
function capache($inconfig = [], $id = '', $incode = null)
{  
    $config = array(
        'seKey'     =>  'ThinkPHP.CN',   // 验证码加密密钥
        'codeSet'   =>  '2345678abcdefhijkmnpqrstuvwxyzABCDEFGHJKLMNPQRTUVWXY', // 验证码字符集合
        'expire'    =>  1800,            // 验证码过期时间（s）
        'useZh'     =>  false,           // 使用中文验证码 
        'zhSet'     =>  '们以我到他会作时要动国产的一是工就年阶义发成部民可出能方进在了不和有大这主中人上为来分生对于学下级地个用同行面说种过命度革而多子后自社加小机也经力线本电高量长党得实家定深法表着水理化争现所二起政三好十战无农使性前等反体合斗路图把结第里正新开论之物从当两些还天资事队批点育重其思与间内去因件日利相由压员气业代全组数果期导平各基或月毛然如应形想制心样干都向变关问比展那它最及外没看治提五解系林者米群头意只明四道马认次文通但条较克又公孔领军流入接席位情运器并飞原油放立题质指建区验活众很教决特此常石强极土少已根共直团统式转别造切九你取西持总料连任志观调七么山程百报更见必真保热委手改管处己将修支识病象几先老光专什六型具示复安带每东增则完风回南广劳轮科北打积车计给节做务被整联步类集号列温装即毫知轴研单色坚据速防史拉世设达尔场织历花受求传口断况采精金界品判参层止边清至万确究书术状厂须离再目海交权且儿青才证低越际八试规斯近注办布门铁需走议县兵固除般引齿千胜细影济白格效置推空配刀叶率述今选养德话查差半敌始片施响收华觉备名红续均药标记难存测士身紧液派准斤角降维板许破述技消底床田势端感往神便贺村构照容非搞亚磨族火段算适讲按值美态黄易彪服早班麦削信排台声该击素张密害侯草何树肥继右属市严径螺检左页抗苏显苦英快称坏移约巴材省黑武培著河帝仅针怎植京助升王眼她抓含苗副杂普谈围食射源例致酸旧却充足短划剂宣环落首尺波承粉践府鱼随考刻靠够满夫失包住促枝局菌杆周护岩师举曲春元超负砂封换太模贫减阳扬江析亩木言球朝医校古呢稻宋听唯输滑站另卫字鼓刚写刘微略范供阿块某功套友限项余倒卷创律雨让骨远帮初皮播优占死毒圈伟季训控激找叫云互跟裂粮粒母练塞钢顶策双留误础吸阻故寸盾晚丝女散焊功株亲院冷彻弹错散商视艺灭版烈零室轻血倍缺厘泵察绝富城冲喷壤简否柱李望盘磁雄似困巩益洲脱投送奴侧润盖挥距触星松送获兴独官混纪依未突架宽冬章湿偏纹吃执阀矿寨责熟稳夺硬价努翻奇甲预职评读背协损棉侵灰虽矛厚罗泥辟告卵箱掌氧恩爱停曾溶营终纲孟钱待尽俄缩沙退陈讨奋械载胞幼哪剥迫旋征槽倒握担仍呀鲜吧卡粗介钻逐弱脚怕盐末阴丰雾冠丙街莱贝辐肠付吉渗瑞惊顿挤秒悬姆烂森糖圣凹陶词迟蚕亿矩康遵牧遭幅园腔订香肉弟屋敏恢忘编印蜂急拿扩伤飞露核缘游振操央伍域甚迅辉异序免纸夜乡久隶缸夹念兰映沟乙吗儒杀汽磷艰晶插埃燃欢铁补咱芽永瓦倾阵碳演威附牙芽永瓦斜灌欧献顺猪洋腐请透司危括脉宜笑若尾束壮暴企菜穗楚汉愈绿拖牛份染既秋遍锻玉夏疗尖殖井费州访吹荣铜沿替滚客召旱悟刺脑措贯藏敢令隙炉壳硫煤迎铸粘探临薄旬善福纵择礼愿伏残雷延烟句纯渐耕跑泽慢栽鲁赤繁境潮横掉锥希池败船假亮谓托伙哲怀割摆贡呈劲财仪沉炼麻罪祖息车穿货销齐鼠抽画饲龙库守筑房歌寒喜哥洗蚀废纳腹乎录镜妇恶脂庄擦险赞钟摇典柄辩竹谷卖乱虚桥奥伯赶垂途额壁网截野遗静谋弄挂课镇妄盛耐援扎虑键归符庆聚绕摩忙舞遇索顾胶羊湖钉仁音迹碎伸灯避泛亡答勇频皇柳哈揭甘诺概宪浓岛袭谁洪谢炮浇斑讯懂灵蛋闭孩释乳巨徒私银伊景坦累匀霉杜乐勒隔弯绩招绍胡呼痛峰零柴簧午跳居尚丁秦稍追梁折耗碱殊岗挖氏刃剧堆赫荷胸衡勤膜篇登驻案刊秧缓凸役剪川雪链渔啦脸户洛孢勃盟买杨宗焦赛旗滤硅炭股坐蒸凝竟陷枪黎救冒暗洞犯筒您宋弧爆谬涂味津臂障褐陆啊健尊豆拔莫抵桑坡缝警挑污冰柬嘴啥饭塑寄赵喊垫丹渡耳刨虎笔稀昆浪萨茶滴浅拥穴覆伦娘吨浸袖珠雌妈紫戏塔锤震岁貌洁剖牢锋疑霸闪埔猛诉刷狠忽灾闹乔唐漏闻沈熔氯荒茎男凡抢像浆旁玻亦忠唱蒙予纷捕锁尤乘乌智淡允叛畜俘摸锈扫毕璃宝芯爷鉴秘净蒋钙肩腾枯抛轨堂拌爸循诱祝励肯酒绳穷塘燥泡袋朗喂铝软渠颗惯贸粪综墙趋彼届墨碍启逆卸航衣孙龄岭骗休借',              // 中文验证码字符串
        'length'    =>  4,               // 验证码位数
        'reset'     =>  true,           // 验证成功后是否重置
    );
    $config = array_merge($config, $inconfig);
    $authcode = function ($str) use ($config) {
        $key = substr(md5($config['seKey']), 5, 8);
        $str = substr(md5($str), 8, 10);
        return md5($key . $str);
    };

    /* 生成验证码 */
    if ($incode === null) {
        for ($i = 0; $i<$config['length']; $i++) {
            $code[$i] = $config['codeSet'][mt_rand(0, strlen($config['codeSet'])-1)];
        }
        // 保存验证码
        $code_str   =   implode('', $code);
        $key        =   $authcode($config['seKey']);
        $code       =   $authcode(strtoupper($code_str));
        $secode     =   array();
        $secode['verify_code'] = $code; // 把校验码保存到session
        $secode['verify_time'] = NOW_TIME;  // 验证码创建时间
        session($key.$id, $secode);
        return $code_str;
    } 

    /* 检验验证码 */
    if (is_string($incode)) {
        $key = $authcode($config['seKey']).$id;
        // 验证码不能为空
        $secode = session($key);
        if (empty($incode) || empty($secode)) {
            return false;
        }
        // session 过期
        if (NOW_TIME - $secode['verify_time'] > $config['expire']) {
            session($key, null);
            return false;
        }

        if ($authcode(strtoupper($incode)) == $secode['verify_code']) {
            $config['reset'] && session($key, null);
            return true;
        }
        return false;
    }

    return false;
}

function urlsafe_b64encode($string) 
{
    $data = base64_encode($string);
    $data = str_replace(array('+','/','='),array('-','_',''),$data);
    return $data;
}

/**
 * 当前请求是否是https
 * @return type
 */
function is_https()
{
    return config('is_https');
}

/**
 * 获取当前时间戳
 */
function getTime()
{
    return time();
}

/**
 * 过滤前后空格等多种字符
 */
function trim_space($str, $arr = array())
{
    if (empty($arr)) {
        $arr = array(' ', '　');
    }
    foreach ($arr as $key => $val) {
        $str = preg_replace('/(^'.$val.')|('.$val.'$)/', '', $str);
    }

    return $str;
}

/**
 * 替换指定的符号
 */
function func_preg_replace($arr = array(), $replacement = ',', $str = '')
{
    if (empty($arr)) {
        $arr = array('，');
    }
    foreach ($arr as $key => $val) {
        $str = preg_replace('/('.$val.')/', $replacement, $str);
    }

    return $str;
}

/**
 * 创建像这样的查询: "IN('a','b')";
 *
 * @access   public
 * @param    mixed      $item_list      列表数组或字符串,如果为字符串时,字符串只接受数字串
 * @param    string   $field_name     字段名称
 * @author   wj
 *
 * @return   string
 */
function db_create_in($item_list, $field_name = '')
{
    if (empty($item_list))
    {
        return $field_name . " IN ('') ";
    }
    else
    {
        if (!is_array($item_list))
        {
            $item_list = explode(',', $item_list);
            foreach ($item_list as $k=>$v)
            {
                $item_list[$k] = intval($v);
            }
        }

        $item_list = array_unique($item_list);
        $item_list_tmp = '';
        foreach ($item_list AS $item)
        {
            if ($item !== '')
            {
                $item_list_tmp .= $item_list_tmp ? ",'$item'" : "'$item'";
            }
        }
        if (empty($item_list_tmp))
        {
            return $field_name . " IN ('') ";
        }
        else
        {
            return $field_name . ' IN (' . $item_list_tmp . ') ';
        }
    }
}

/**
 * 给静态文件追加版本号，实时刷新浏览器缓存
 * 参数 $filepath 为远程文件
 */
function static_version($filepath)
{
    $http_site_url = config('is_https') ? HTTPS_SITE_URL : SITE_URL;

    // ---判断本地文件是否存在，否则返回false，以免@get_headers方法导致崩溃
    if (is_http_url($filepath)) { // 判断http路径
        $ROOT_SITE_URL = str_replace('.', '\.', ROOT_SITE_URL);
        if (preg_match('/^http(s?):\/\/([^.]+)'.$ROOT_SITE_URL.'/', $filepath)) { // 判断当前域名的本地服务器文件(这仅用于单台服务器，多台稍作修改便可)
            $pattern = '/^http(s?):\/\/([^.]+)\.([^.]+)\.([^\/]+)\/(.*)$/';
            preg_match_all($pattern, $filepath, $matches);//正则表达式
            if (!empty($matches)) {
                $filename = $matches[count($matches) - 1][0];
                if (!file_exists(ROOT_PATH.$filename)) {
                    return false;
                } else {
                    $http_url = $filepath;
                }
            }
        } else { // 不是本地文件禁止使用该方法
            return false;
        }
        
    } else {
        if (!file_exists(ROOT_PATH.ltrim($filepath, '/'))) {
            return false;
        }
        $http_url = $http_site_url . $filepath;
    }
    // -------------end---------------

    $parseStr = '';
    $headInf = @get_headers($http_url,1); 
    if (is_array($headInf)) {
        $update_time = strtotime($headInf['Last-Modified']); 
        $type = strtolower(substr(strrchr($http_url, '.'), 1));
        $http_url = str_replace($http_site_url, '', $http_url);
        switch ($type) {
            case 'js':
                $parseStr .= '<script type="text/javascript" src="' . $http_url . '?ver='.$update_time.'"></script>';
                break;
            case 'css':
                $parseStr .= '<link rel="stylesheet" type="text/css" href="' . $http_url . '?ver='.$update_time.'" />';
                break;
            case 'ico':
                $parseStr .= '<link rel="shortcut icon" href="' . $http_url . '?ver='.$update_time.'" />';
                break;
        }
    }

    return $parseStr;
}

/* 获取明天最起初的时间戳 */
function get_tomorrow()
{
    return strtotime(date('Y-m-d 00:00:00', strtotime("+1 day", getTime())));
}

/* 获取今天的剩余时间戳，不包括00时00分00秒 */
function get_today_surplus_time()
{
    $end = strtotime(date('Y-m-d 23:59:59', getTime()));
    $begin = getTime();
    return $end - $begin;
}

/**
 * 递归创建目录 
 */  
function tp_mkdir($path, $purview = 0777)
{
    if (!is_dir($path)) {
        tp_mkdir(dirname($path), $purview);
        if (!mkdir($path, $purview)) {
            return false;
        }
    }
    return true;
}

/**
 * 格式化字节大小
 * @param  number $size      字节数
 * @param  string $delimiter 数字和单位分隔符
 * @return string            格式化后的带单位的大小
 * @author 麦当苗儿 <zuojiazi@vip.qq.com>
 */
function format_bytes($size, $delimiter = '') {
    $units = array('B', 'KB', 'MB', 'GB', 'TB', 'PB');
    for ($i = 0; $size >= 1024 && $i < 5; $i++) $size /= 1024;
    return round($size, 2) . $delimiter . $units[$i];
}

/**
 * 随机生成背景颜色 
 */  
function rand_rgb()  
{  
    $str = '0123456789ABCDEF';  
    $estr = '#';  
    $len=strlen($str);  
    for ($i = 1; $i <= 6; $i++)  
    {  
        $num = rand(0, $len-1);    
        $estr = $estr . $str[$num];   
    } 

    return $estr;  
} 

/**
 * 判断url是否完整的链接
 */
function is_http_url($url)
{
    preg_match("/^(http:\/\/|https:\/\/).*$/", $url, $match);
    if (empty($match)) {
        return false;
    } else {
        return true;
    }
}

/**
 * 填充完整的URL
 */
function fill_url($path = '', $isfill = true)
{
    if (!empty($path) && !is_http_url($path) && $isfill) {
        if (preg_match("/^\//", $path) == 0) {
            $path = '/'.$path;
        }
        $path = SITE_URL.$path;
    }

    return $path;
}

/**
 * 获取文章内容html中第一张图片地址
 */
function get_html_first_imgurl($html){
    $pattern = '~<img [^>]*[\s]?[\/]?[\s]?>~';
    preg_match_all($pattern, $html, $matches);//正则表达式把图片的整个都获取出来了
    $img_arr = $matches[0];//图片
    $first_img_url = "";
    if (!empty($img_arr)) {
        $first_img = $img_arr[0];
        $p="#src=('|\")(.*)('|\")#isU";//正则表达式
        preg_match_all ($p, $first_img, $img_val);
        if(isset($img_val[2][0])){
            $first_img_url = $img_val[2][0]; //获取第一张图片地址
        }
    }

    return $first_img_url;
}

/**
 * 反序列化
 */
function func_unserialize($str = '')
{
    $arr = array($str);
    $pattern = '/^a:(\d+):{(.*);}$/';
    if (preg_match($pattern, $str) == 1) {
        $arr = unserialize($str);
    }

    return $arr;
}

/**
 * 隐藏手机中间4位号码
 */
function mobile_hide($mobile){
    return substr_replace($mobile,'****',3,4);
}

/**
 *  删除非站内链接
 *
 * @access    public
 * @param     string  $body  内容
 * @param     array  $allow_urls  允许的超链接
 * @return    string
 */
function Replace_Links( $body = '', $allow_urls=array() )
{
    if (empty($allow_urls)) {
        $allow_urls = config('global.allow_urls');
    }
    $host_rule = join('|', $allow_urls);
    $host_rule = preg_replace("#[\n\r]#", '', $host_rule);
    $host_rule = str_replace('.', "\\.", $host_rule);
    $host_rule = str_replace('/', "\\/", $host_rule);
    $arr = '';
    preg_match_all("#<a([^>]*)>(.*)<\/a>#iU", $body, $arr);
    if( is_array($arr[0]) )
    {
        $rparr = array();
        $tgarr = array();
        foreach($arr[0] as $i=>$v)
        {
            if( $host_rule != '' && preg_match('#'.$host_rule.'#i', $arr[1][$i]) )
            {
                continue;
            } else {
                $rparr[] = $v;
                $tgarr[] = $arr[2][$i];
            }
        }
        if( !empty($rparr) )
        {
            $body = str_replace($rparr, $tgarr, $body);
        }
    }
    $arr = $rparr = $tgarr = '';
    return $body;
}

/**
 *  自动获取关键字
 *
 * @access    public
 * @param     string  $title  标题
 * @param     array  $body  内容
 * @return    string
 */
function get_split_word($title = '', $body = '' )
{
    vendor('splitword.autoload');
    $keywords = '';
    $kw = new keywords();
    $keywords = $kw->GetSplitWord($title, $body);

    return $keywords;
}

/**
 * 压缩内容
 */
function func_gzcompress($str, $level = 9)
{
    if (!func_is_base64($str)) {
        return base64_encode(gzcompress($str, $level));
    }
    return $str;
}

/**
 * 解压内容
 */
function func_gzuncompress($str)
{
    if (func_is_base64($str)) {
        return gzuncompress(base64_decode($str));
    }
    return $str;
}

/**
 * 判断字符串是否base64编码
 */
function func_is_base64($str)
{  
    return $str == base64_encode(base64_decode($str)) ? true : false;  
}  

/*
 * 过滤Html标签
 */
function checkStrHtml($string){
    $string = trim_space($string);

    if(is_numeric($string)) return $string;
    if(!isset($string) or empty($string)) return '';

    $string = preg_replace('/[\\x00-\\x08\\x0B\\x0C\\x0E-\\x1F]/','',$string);
    $string  = ($string);

    $string = strip_tags($string,""); //清除HTML如<br />等代码
    $string = str_replace("\n", "", str_replace(" ", "", $string));//去掉空格和换行
    $string = str_replace("\n", "", $string);//去掉空格和换行
    $string = str_replace("\t","",$string); //去掉制表符号
    $string = str_replace(PHP_EOL,"",$string); //去掉回车换行符号
    $string = str_replace("\r","",$string); //去掉回车
    $string = str_replace("'","‘",$string); //替换单引号
    $string = str_replace("&amp;","&",$string);
    $string = str_replace("=★","",$string);
    $string = str_replace("★=","",$string);
    $string = str_replace("★","",$string);
    $string = str_replace("☆","",$string);
    $string = str_replace("√","",$string);
    $string = str_replace("±","",$string);
    $string = str_replace("‖","",$string);
    $string = str_replace("×","",$string);
    $string = str_replace("∏","",$string);
    $string = str_replace("∷","",$string);
    $string = str_replace("⊥","",$string);
    $string = str_replace("∠","",$string);
    $string = str_replace("⊙","",$string);
    $string = str_replace("≈","",$string);
    $string = str_replace("≤","",$string);
    $string = str_replace("≥","",$string);
    $string = str_replace("∞","",$string);
    $string = str_replace("∵","",$string);
    $string = str_replace("♂","",$string);
    $string = str_replace("♀","",$string);
    $string = str_replace("°","",$string);
    $string = str_replace("¤","",$string);
    $string = str_replace("◎","",$string);
    $string = str_replace("◇","",$string);
    $string = str_replace("◆","",$string);
    $string = str_replace("→","",$string);
    $string = str_replace("←","",$string);
    $string = str_replace("↑","",$string);
    $string = str_replace("↓","",$string);
    $string = str_replace("▲","",$string);
    $string = str_replace("▼","",$string);

    // --过滤微信表情
    $string = preg_replace_callback('/[\xf0-\xf7].{3}/', function($r) { return '';}, $string);

    return $string;
}

//抓取远程图片
function saveRemote($fieldName, $savePath = 'temp/'){
    $allowFiles = [".png", ".jpg", ".jpeg", ".gif", ".bmp", "webp"];

    $imgUrl = htmlspecialchars($fieldName);
    $imgUrl = str_replace("&amp;","&",$imgUrl);

    //http开头验证
    if(strpos($imgUrl,"http") !== 0){
        $data=array(
            'state' => '链接不是http链接',
        );
        return json_encode($data);
    }
    //获取请求头并检测死链
    $heads = get_headers($imgUrl);
    if(!(stristr($heads[0],"200") && stristr($heads[0],"OK"))){
        $data=array(
            'state' => '链接不可用',
        );
        return json_encode($data);
    }
    //格式验证(扩展名验证和Content-Type验证)
    if(preg_match("/^http(s?):\/\/(mmbiz.qpic.cn|qimg.91ud.com)\/(.*)/", $imgUrl) != 1){
        $fileType = strtolower(strrchr($imgUrl,'.'));
        if(!in_array($fileType,$allowFiles) || stristr($heads['Content-Type'],"image")){
            $data=array(
                'state' => '链接contentType不正确',
            );
            return json_encode($data);
        }
    }

    //打开输出缓冲区并获取远程图片
    ob_start();
    $context = stream_context_create(
        array('http' => array(
            'follow_location' => false // don't follow redirects
        ))
    );
    readfile($imgUrl,false,$context);
    $img = ob_get_contents();
    ob_end_clean();
    preg_match("/[\/]([^\/]*)[\.]?[^\.\/]*$/",$imgUrl,$m);

    $dirname = './'.UPLOAD_PATH.'remote/'.date('Y/m/d').'/';
    $file['oriName'] = $m ? $m[1] : "";
    $file['filesize'] = strlen($img);
    $file['ext'] = strtolower(strrchr('remote.png','.'));
    $file['name'] = uniqid().$file['ext'];
    $file['fullName'] = $dirname.$file['name'];
    $fullName = $file['fullName'];

    //检查文件大小是否超出限制
    if($file['filesize'] >= 10240000){
        $data=array(
            'state' => '文件大小超出网站限制',
        );
        return json_encode($data);
    }

    //创建目录失败
    if(!file_exists($dirname) && !mkdir($dirname,0777,true)){
        $data=array(
            'state' => '目录创建失败',
        );
        return json_encode($data);
    }else if(!is_writeable($dirname)){
        $data=array(
            'state' => '目录没有写权限',
        );
        return json_encode($data);
    }

    //移动文件
    if(!(file_put_contents($fullName, $img) && file_exists($fullName))){ //移动失败
        $data=array(
            'state' => '写入文件内容错误',
        );
        return json_encode($data);
    }else{ //移动成功
        $data=array(
            'state' => 'SUCCESS',
            'url' => substr($file['fullName'],1),
            'title' => $file['name'],
            'original' => $file['oriName'],
            'type' => $file['ext'],
            'size' => $file['filesize'],
        );

        $ossConfig = tpCache('oss');
        if ($ossConfig['oss_switch']) {
            //图片可选择存放在oss
            $savePath = $savePath.date('Y/m/d/');
            $object = UPLOAD_PATH.$savePath.md5(getTime().uniqid(mt_rand(), TRUE)).'.'.pathinfo($data['url'], PATHINFO_EXTENSION);
            $getRealPath = ltrim($data['url'], '/');
            $ossClient = new \app\common\logic\OssLogic;
            $return_url = $ossClient->uploadFile($getRealPath, $object);
            if (!$return_url) {
                $state = "ERROR" . $ossClient->getError();
                $return_url = '';
            } else {
                $state = "SUCCESS";
            }
            @unlink($getRealPath);
            $data['url'] = $return_url;
        }
    }
    return json_encode($data);
}
    
/**
----------------------
* 自定义上传
----------------------
*/
function func_common($fileElementId = 'uploadImage', $path = 'temp', $file_ext = "gif|jpg|png|jpeg"){
    $file = request()->file($fileElementId);

    if (empty($file)) {
        return ['errcode'=>1,'errmsg'=>'请选择上传图片'];
    }
    
    $validate = array();
    /*文件大小限制*/
    $validate_size = tpCache('basic.file_size');
    if (!empty($validate_size)) {
        $validate['size'] = $validate_size * 1024 * 1024; // 单位为b
    }
    /*--end*/
    /*文件扩展名限制*/
    $validate_ext = tpCache('basic.image_type');
    if (!empty($validate_ext)) {
        $validate['ext'] = explode('|', $validate_ext);
    }
    /*--end*/
    /*上传文件验证*/
    if (!empty($validate)) {
        $is_validate = $file->check($validate);
        if ($is_validate === false) {
            return ['errcode'=>1,'errmsg'=>$file->getError()];
        }   
    }
    /*--end*/     
    
    $ext    =   pathinfo($_FILES[$fileElementId]['name'], PATHINFO_EXTENSION);/* 获取上传文件后缀 */
    $savePath =  $path .'/'.date('Y') . '/' . date('m') . '/' . date('d').'/';
    $return_url = "";

    $ossConfig = tpCache('oss');
    if ($ossConfig['oss_switch']) {
        //图片可选择存放在oss
        $object = UPLOAD_PATH.$savePath.md5(getTime().uniqid(mt_rand(), TRUE)).'.'.$ext;
        $ossClient = new \app\common\logic\OssLogic;
        $return_url = $ossClient->uploadFile($file->getRealPath(), $object);
        if (!$return_url) {
            $state = "ERROR" . $ossClient->getError();
            $return_url = '';
        } else {
            $state = "SUCCESS";
        }
        @unlink($file->getRealPath());
    } else { // 使用自定义的文件保存规则
        $info = $file->rule(function($file){return md5(mt_rand());})->move(UPLOAD_PATH.$savePath);
        if($info){
            $return_url =  '/'.UPLOAD_PATH.$savePath.$info->getSaveName();
        }
    }
    
    if($return_url){
        return ['errcode'=>0,'errmsg'=>'上传成功','img_url'=>$return_url];
    }else{
        return ['errcode'=>1,'errmsg'=>'上传失败'];
    }
}

/**
* 根据手机号码获取归属地
*/
function get_mobile_area($mobile){
    $sms = array('province'=>'','city'=>'');    //初始化变量
    //根据百度的数据库调用返回值
    header("Content-type:text/html;charset=utf-8");
    $url = "https://sp0.baidu.com/8aQDcjqpAAV3otqbppnN2DJv/api.php?query={$mobile}&resource_id=6004&ie=utf8&oe=utf8&format=json";
    $result = $this->curl_https($url);
    $result = (array)json_decode($result);
    if (!empty($result['data'])) {
        $result = (array)$result['data'][0];
        $sms['city'] = empty($result['city'])?'':$result['city'];
        $sms['province'] = empty($result['prov'])?$sms['city']:$result['prov'];
    }
    return $sms;
    /*$url = "http://tcc.taobao.com/cc/json/mobile_tel_segment.htm?tel=15201655587&t=".time();
    preg_match_all("/(\w+):'([^']+)/", $content, $matches);
    $sms = array_combine($matches[1], $matches[2]);
    print_r($sms); 
    exit;*/       
}

// 隐藏部分字符串
function func_substr_replace($str, $replacement = '*', $start = 1, $length = 3)
{
    $len = mb_strlen($str,'utf-8');
    if ($len > intval($start+$length)) {
        $str1 = msubstr($str,0,$start);
        $str2 = msubstr($str,intval($start+$length),NULL);
    } else {
        $str1 = msubstr($str,0,1);
        $str2 = msubstr($str,$len-1,1);    
        $length = $len - 2;        
    }
    $new_str = $str1;
    for ($i = 0; $i < $length; $i++) { 
        $new_str .= $replacement;
    }
    $new_str .= $str2;

    return $new_str;
}

// 过滤[url=]aa[/url]等类似的标签，包括里面的内容
function filter_htmlbbs_tags($content = '')
{
    // $content = strip_tags($val['content']);
    $content = preg_replace('/(\[([^\]]*)\])([^\[]*)(\[\/([^\]]*)\])/', '', $content); //调用preg_replace函数进行正则替换
    return $content;
}

// 微信的JS-SDK网页接口，用于微信分享
function getSignPackage($appid, $appSecret, $url)
{
    //判断是否过了缓存期
    $map = array(
        'appid' => $appid,
    );
    $wechat = M('wx_config')->where($map)->find();
    $expire_time = $wechat['web_expires'];
    if ($expire_time > getTime()) {
        $access_token = $wechat['web_access_token'];
    } else {
        $token_url = "https://api.weixin.qq.com/cgi-bin/token?grant_type=client_credential&appid={$appid}&secret={$appSecret}";
        $response = httpRequest($token_url);
        $msg = json_decode($response);
        if (isset($msg->errcode))
        {
            echo "<h3>errcode:</h3>" . $msg->errcode;
            echo "<h3>errmsg  :</h3>" . $msg->errmsg;
            exit;
        }
        $access_token = $msg->access_token;

        if ($access_token) {
            $web_expires = getTime() + $wechat['web_expires_in']; // 提前200秒过期
            $data = array(
                'web_access_token'  => $access_token,
                'web_expires'       => $web_expires,
                'update_time'       => getTime(),
            );
            M('wx_config')->where(array('appid'=>$appid))->update($data);
        } 
    }

    $graph_url = "https://api.weixin.qq.com/cgi-bin/ticket/getticket?access_token=".$access_token."&type=jsapi";
    $response = httpRequest($graph_url);
    $res = json_decode($response);
    if ($res->errcode > 0)
    {
        echo "<h3>errcode:</h3>" . $res->errcode;
        echo "<h3>errmsg  :</h3>" . $res->errmsg;
        exit;
    }

    $noncestr = get_rand_str(16);
    $jsapi_ticket = $res->ticket;
    $timestamp = time();

    $string = "jsapi_ticket=$jsapi_ticket&noncestr=$noncestr&timestamp=$timestamp&url=$url";
    $signature = sha1($string);

    $signPackage = array(
      "appid"     => $appid,
      "noncestr"  => $noncestr,
      "timestamp" => $timestamp,
      "url"       => $url,
      "signature" => $signature,
    );
    
    return $signPackage; 
}

/**
 * 字符串加密解密
 * @param unknown $string   明文或密文
 * @param string $operation   DECODE表示解密,其它表示加密
 * @param string $key   密匙
 * @param number $expiry 密文有效期
 * @return string
 */
function func_authcode($string, $operation = 'DECODE', $key = '', $expiry = 0) {
    $ckey_length = 4;
    $key = md5($key != '' ? $key : 'zxsdcrtkbrecxm');
    $keya = md5(substr($key, 0, 16));
    $keyb = md5(substr($key, 16, 16));
    $keyc = $ckey_length ? ($operation == 'DECODE' ? substr($string, 0, $ckey_length): substr(md5(microtime()), -$ckey_length)) : '';

    $cryptkey = $keya.md5($keya.$keyc);
    $key_length = strlen($cryptkey);

    $string = $operation == 'DECODE' ? base64_decode(substr($string, $ckey_length)) : sprintf('%010d', $expiry ? $expiry + time() : 0).substr(md5($string.$keyb), 0, 16).$string;
    $string_length = strlen($string);

    $result = '';
    $box = range(0, 255);

    $rndkey = array();
    for($i = 0; $i <= 255; $i++) {
        $rndkey[$i] = ord($cryptkey[$i % $key_length]);
    }

    for($j = $i = 0; $i < 256; $i++) {
        $j = ($j + $box[$i] + $rndkey[$i]) % 256;
        $tmp = $box[$i];
        $box[$i] = $box[$j];
        $box[$j] = $tmp;
    }

    for($a = $j = $i = 0; $i < $string_length; $i++) {
        $a = ($a + 1) % 256;
        $j = ($j + $box[$a]) % 256;
        $tmp = $box[$a];
        $box[$a] = $box[$j];
        $box[$j] = $tmp;
        $result .= chr(ord($string[$i]) ^ ($box[($box[$a] + $box[$j]) % 256]));
    }

    if($operation == 'DECODE') {
        if((substr($result, 0, 10) == 0 || substr($result, 0, 10) - time() > 0) && substr($result, 10, 16) == substr(md5(substr($result, 26).$keyb), 0, 16)) {
            return substr($result, 26);
        } else {
            return '';
        }
    } else {
        return $keyc.str_replace('=', '', base64_encode($result));
    }

}

/**
 * 多语言切换（默认中文）
 */
function switch_lang($lang = null) 
{
    if (empty($lang)) {
        $lang = I('param.lang/s', '');
        if (empty($lang)) {
            $lang = \think\Lang::detect();
        }
    }

    $lang_var = cookie('eyou_lang_var');
    if (empty($lang_var) || $lang_var != $lang) {
        cookie('eyou_lang_var', $lang);
    }
}

/**
 *  获取拼音以gbk编码为准
 *
 * @access    public
 * @param     string  $str     字符串信息
 * @param     int     $ishead  是否取头字母
 * @param     int     $isclose 是否关闭字符串资源
 * @return    string
 */
if ( ! function_exists('get_pinyin'))
{
    function get_pinyin($str, $ishead=0, $isclose=1)
    {
        // return SpGetPinyin(utf82gb($str), $ishead, $isclose);

        $s1 = iconv("UTF-8","gb2312", $str);
        $s2 = iconv("gb2312","UTF-8", $s1);
        if($s2 == $str){$str = $s1;}
        
        $pinyins = array();
        $restr = '';
        $str = trim($str);
        $slen = strlen($str);
        if($slen < 2)
        {
            return $str;
        }
        if(empty($pinyins))
        {
            $fp = fopen(DATA_PATH.'conf/pinyin.dat', 'r');
            while(!feof($fp))
            {
                $line = trim(fgets($fp));
                $pinyins[$line[0].$line[1]] = substr($line, 3, strlen($line)-3);
            }
            fclose($fp);
        }
        for($i=0; $i<$slen; $i++)
        {
            if(ord($str[$i])>0x80)
            {
                $c = $str[$i].$str[$i+1];
                $i++;
                if(isset($pinyins[$c]))
                {
                    if($ishead==0)
                    {
                        $restr .= $pinyins[$c];
                    }
                    else
                    {
                        $restr .= $pinyins[$c][0];
                    }
                }else
                {
                    $restr .= "_";
                }
            }else if( preg_match("/[a-z0-9]/i", $str[$i]) )
            {
                $restr .= $str[$i];
            }
            else
            {
                $restr .= "_";
            }
        }
        if($isclose==0)
        {
            unset($pinyins);
        }
        return $restr;
    }
}

/**
 *  过滤换行回车符
 *
 * @access    public
 * @param     string  $str     字符串信息
 * @return    string
 */
function filter_line_return($str = '', $replace = '')
{
    return str_replace(PHP_EOL, $replace, $str);
}

function MyDate($format = 'Y-m-d', $t = '')
{
    $t = !empty($t) ? $t : getTime();
    return date($format, $t);
}

/**
 * 过滤和排序所有文章栏目，返回一个带有缩进级别的数组
 *
 * @access  private
 * @param   int     $id     上级栏目ID
 * @param   array   $arr        含有所有栏目的数组
 * @param   string     $id_alias      id键名
 * @param   string     $pid_alias      父id键名
 * @return  void
 */
function arctype_options($spec_id, $arr, $id_alias, $pid_alias)
{
    $cat_options = array();

    if (isset($cat_options[$spec_id]))
    {
        return $cat_options[$spec_id];
    }

    if (!isset($cat_options[0]))
    {
        $level = $last_id = 0;
        $options = $id_array = $level_array = array();
        while (!empty($arr))
        {
            foreach ($arr AS $key => $value)
            {
                $id = $value[$id_alias];
                if ($level == 0 && $last_id == 0)
                {
                    if ($value[$pid_alias] > 0)
                    {
                        break;
                    }

                    $options[$id]          = $value;
                    $options[$id]['level'] = $level;
                    $options[$id][$id_alias]    = $id;
                    // $options[$id]['typename']  = $value['typename'];
                    unset($arr[$key]);

                    if ($value['has_children'] == 0)
                    {
                        continue;
                    }
                    $last_id  = $id;
                    $id_array = array($id);
                    $level_array[$last_id] = ++$level;
                    continue;
                }

                if ($value[$pid_alias] == $last_id)
                {
                    $options[$id]          = $value;
                    $options[$id]['level'] = $level;
                    $options[$id][$id_alias]    = $id;
                    // $options[$id]['typename']  = $value['typename'];
                    unset($arr[$key]);

                    if ($value['has_children'] > 0)
                    {
                        if (end($id_array) != $last_id)
                        {
                            $id_array[] = $last_id;
                        }
                        $last_id    = $id;
                        $id_array[] = $id;
                        $level_array[$last_id] = ++$level;
                    }
                }
                elseif ($value[$pid_alias] > $last_id)
                {
                    break;
                }
            }

            $count = count($id_array);
            if ($count > 1)
            {
                $last_id = array_pop($id_array);
            }
            elseif ($count == 1)
            {
                if ($last_id != end($id_array))
                {
                    $last_id = end($id_array);
                }
                else
                {
                    $level = 0;
                    $last_id = 0;
                    $id_array = array();
                    continue;
                }
            }

            if ($last_id && isset($level_array[$last_id]))
            {
                $level = $level_array[$last_id];
            }
            else
            {
                $level = 0;
                break;
            }
        }
        $cat_options[0] = $options;
    }
    else
    {
        $options = $cat_options[0];
    }

    if (!$spec_id)
    {
        return $options;
    }
    else
    {
        if (empty($options[$spec_id]))
        {
            return array();
        }

        $spec_id_level = $options[$spec_id]['level'];

        foreach ($options AS $key => $value)
        {
            if ($key != $spec_id)
            {
                unset($options[$key]);
            }
            else
            {
                break;
            }
        }

        $spec_id_array = array();
        foreach ($options AS $key => $value)
        {
            if (($spec_id_level == $value['level'] && $value[$id_alias] != $spec_id) ||
                ($spec_id_level > $value['level']))
            {
                break;
            }
            else
            {
                $spec_id_array[$key] = $value;
            }
        }
        $cat_options[$spec_id] = $spec_id_array;

        return $spec_id_array;
    }
}

/**
 * 图片地址替换成压缩URL
 * @param string $content 内容
 * @param string $imgurl 远程图片url
 */
function img_replace_url($content='', $imgurl = '')
{
    $pregRule = "/<img(.*?)src(\s*)=(\s*)[\'|\"](.*?(?:[\.jpg|\.jpeg|\.png|\.gif|\.bmp|\.ico]))[\'|\"](.*?)[\/]?(\s*)>/i";
    $content = preg_replace($pregRule, '<img ${1} src="'.$imgurl.'" ${5} />', $content);

    return $content;
}

/**
 * 获取当前CMS版本号
 */
function getCmsVersion()
{
    $ver = 'v1.0';
    $version_txt_path = ROOT_PATH.'data/conf/version.txt';
    if(file_exists($version_txt_path)) {
        $fp = fopen($version_txt_path, 'r');
        $content = fread($fp, filesize($version_txt_path));
        fclose($fp);
        $ver = $content ? $content : $ver;
    } else {
        $r = tp_mkdir(dirname($version_txt_path));
        if ($r) {
            $fp = fopen($version_txt_path, "w+") or die("请设置".$version_txt_path."的权限为777");
            if (fwrite($fp, $ver)) {
                fclose($fp);
            }
        }
    }
    return $ver;
}

/**
 * 获取当前插件版本号
 */
function getWeappVersion($code)
{
    $ver = 'v1.0';
    $config_path = WEAPP_PATH.$code.DS.'config.php';
    if(file_exists($config_path)) {
        $config = include $config_path;
        $ver = !empty($config['version']) ? $config['version'] : $ver;
    } else {
        die($code."插件缺少".$config_path."配置文件");
    }
    return $ver;
}

if (!function_exists('read_bidden_inc')) {
/**
 * 读取被禁止外部访问的配置文件
 * @param string $filename 文件路径
 * @param mixed $value 配置值
 * @param mixed $default 默认值
 * @return mixed
 */
    function read_bidden_inc($filename)
    {
        $data = @file($filename);
        if ($data) {
            $data = json_decode($data[1]);
        }
        return $data;
    }
}

if (!function_exists('write_bidden_inc')) {
/**
 * 写入被禁止外部访问的配置文件
 * @param array $name 配置变量
 * @param mixed $value 配置值
 * @param mixed $default 默认值
 * @return mixed
 */
    function write_bidden_inc($data, $filename, $is_append = false)
    {
        if (!empty($filename)) {
            tp_mkdir(dirname($filename));

            // 追加
            if ($is_append) {
                $inc = read_bidden_inc($filename);
                if ($inc) {
                    $oldarr = (array)$inc;
                    $data = array_merge($oldarr, $data);
                }
            }

            $setting = "<?php die('forbidden'); ?>\n";
            $setting .= json_encode($data);
            $setting = str_replace("\/", "/",$setting);
            $incFile = fopen($filename, "w+") or die("请设置{$filename}的权限为777");
            if (fwrite($incFile, $setting)) {
                fclose($incFile);
                return true;
            }
        }

        return false;
    }
}

if (!function_exists('uncamelize')) {
/**
 * 驼峰命名转下划线命名
 * 思路:
 * 小写和大写紧挨一起的地方,加上分隔符,然后全部转小写
 */
    function uncamelize($camelCaps, $separator = '_')
    {
        return strtolower(preg_replace('/([a-z])([A-Z])/', "$1" . $separator . "$2", $camelCaps));
    }
}

if (!function_exists('camelize')) {
/**
 * 下划线转驼峰
 * 思路:
 * step1.原字符串转小写,原字符串中的分隔符用空格替换,在字符串开头加上分隔符
 * step2.将字符串中每个单词的首字母转换为大写,再去空格,去字符串首部附加的分隔符.
 */
    function camelize($uncamelized_words, $separator = '_')
    {
        $uncamelized_words = $separator. str_replace($separator, " ", strtolower($uncamelized_words));
        return ltrim(str_replace(" ", "", ucwords($uncamelized_words)), $separator );
    }
}

if (!function_exists('format_class')) {
/**
 * 将$name中的下划线转换成类名   全如  aa_aa   变成 AaAa
 * @access public
 * @return string
 */
    function format_class($name, $separator = '_')
    {
        $name = camelize($name, $separator);
        $name = ucwords($name);
        return $name;
    }
}

/**
 * 转换SQL关键字
 *
 * @param unknown_type $string
 * @return unknown
 */
function strip_sql($string) {
    $pattern_arr = array(
            "/\bunion\b/i",
            "/\bselect\b/i",
            "/\bupdate\b/i",
            "/\bdelete\b/i",
            "/\boutfile\b/i",
            "/\bor\b/i",
            "/\bchar\b/i",
            "/\bconcat\b/i",
            "/\btruncate\b/i",
            "/\bdrop\b/i",            
            "/\binsert\b/i", 
            "/\brevoke\b/i", 
            "/\bgrant\b/i",      
            "/\breplace\b/i", 
            "/\balert\b/i", 
            "/\brename\b/i",            
            // "/\bmaster\b/i",
            "/\bdeclare\b/i",
            // "/\bsource\b/i",
            "/\bload\b/i",
            "/\bcall\b/i", 
            "/\bexec\b/i",         
            "/\bdelimiter\b/i",            
    );
    $replace_arr = array(
            'ｕｎｉｏｎ',
            'ｓｅｌｅｃｔ',
            'ｕｐｄａｔｅ',
            'ｄｅｌｅｔｅ',
            'ｏｕｔｆｉｌｅ',
            'ｏｒ',
            'ｃｈａｒ',
            'ｃｏｎｃａｔ',
            'ｔｒｕｎｃａｔｅ',
            'ｄｒｏｐ',            
            'ｉｎｓｅｒｔ',
            'ｒｅｖｏｋｅ',
            'ｇｒａｎｔ',
            'ｒｅｐｌａｃｅ',
            'ａｌｅｒｔ',
            'ｒｅｎａｍｅ',
            // 'ｍａｓｔｅｒ',
            'ｄｅｃｌａｒｅ',
            // 'ｓｏｕｒｃｅ',
            'ｌｏａｄ',
            'ｃａｌｌ',                     
            'ｅｘｅｃ',         
            'ｄｅｌｉｍｉｔｅｒ',
    );
 
    return is_array($string) ? array_map('strip_sql', $string) : preg_replace($pattern_arr, $replace_arr, $string);
}

/**
 * 获取完整URL
 */
function curPageURL() 
{
    $pageURL = 'http';

    if ($_SERVER["HTTPS"] == "on") 
    {
        $pageURL .= "s";
    }
    $pageURL .= "://";

    if ($_SERVER["SERVER_PORT"] != "80") 
    {
        $pageURL .= $_SERVER["SERVER_NAME"] . ":" . $_SERVER["SERVER_PORT"] . $_SERVER["REQUEST_URI"];
    } 
    else
    {
        $pageURL .= $_SERVER["SERVER_NAME"] . $_SERVER["REQUEST_URI"];
    }
    
    return $pageURL;
}

/**
 * 获取插件类的类名
 * @param strng $name 插件名
 */
function get_weapp_class($name){
    $weappClass = format_class($name);
    $class = WEAPP_DIR_NAME."\\{$name}\\controller\\{$weappClass}";
    return $class;
}