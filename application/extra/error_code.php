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

return array(
    'mysql' => array(
        '1049:0' => "数据库不存在，请仔细检查核对。",
        '42000:1055' => "数据库sql_mode模式对GROUP BY聚合操作\n请按照教程进行配置：<a href='http://www.eyoucms.com/bbs/744.html' target='_blank'>http://www.eyoucms.com/bbs/744.html</a>",
        '22001:1406' => "插入字段长度超过设定的长度，请联系技术处理。",
        '42S02:1146' => "数据表或视图不存在，请联系技术处理。",
        'HY000:1017' => "数据表或视图不存在，请联系技术处理。",
        'HY000:1045' => "数据库配置参数不对，请仔细检查核对。",
        'HY000:2002' => "你的主机不支持 localhost 连接数据，导致报错\n请按照教程进行配置：<a href='http://www.eyoucms.com/bbs/5711.html' target='_blank'>http://www.eyoucms.com/bbs/5711.html</a>",
        'HY000:1030' => "磁盘临时空间不够导致，请联系空间服务商，进行清空/tmp目录，或者修改my.cnf中的tmpdir参数，指向具有足够空间的目录。",
        'HY000:2013' => "可能MySQL服务器不支持127.0.0.1连接\n请按照教程尝试解决：<a href='http://www.eyoucms.com/bbs/5950.html' target='_blank'>http://www.eyoucms.com/bbs/5950.html</a>",
    ),
);
