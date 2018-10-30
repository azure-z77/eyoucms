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

return [
    [
        'id' => 1,
        'menu_id' => 1001,
        'menu_id2' => 0,
        'name'  => '栏目管理',
        'auths' => 'Arctype@*',
    ],
    [
        'id' => 2,
        'menu_id' => 1002,
        'menu_id2' => 0,
        'name'  => '内容管理',
        'auths' => 'Archives@*',
    ],
    [
        'id' => 3,
        'menu_id' => 1003,
        'menu_id2' => 0,
        'name'  => '广告管理',
        'auths' => 'Other@*,AdPosition@*',
    ],
    [
        'id' => 4,
        'menu_id' => 2001,
        'menu_id2' => 0,
        'name'  => '基本信息',
        'auths' => 'System@index,System@web,System@web2,System@basic,System@water',
    ],
    // [
    //     'id' => 5,
    //     'menu_id' => 2001,
    //     'menu_id2' => 0,
    //     'name'  => '核心设置',
    //     'auths' => 'System@index,System@web2',
    // ],
    // [
    //     'id' => 6,
    //     'menu_id' => 2001,
    //     'menu_id2' => 0,
    //     'name'  => '附件设置',
    //     'auths' => 'System@index,System@basic',
    // ],
    // [
    //     'id' => 7,
    //     'menu_id' => 2001,
    //     'menu_id2' => 0,
    //     'name'  => '图片水印',
    //     'auths' => 'System@index,System@water',
    // ],
    [
        'id' => 8,
        'menu_id' => 2003,
        'menu_id2' => 2003001,
        'name'  => 'SEO优化',
        'auths' => 'Seo@*',
    ],
    [
        'id' => 9,
        'menu_id' => 2003,
        'menu_id2' => 2003002,
        'name'  => '友情链接',
        'auths' => 'Links@*',
    ],
    [
        'id' => 10,
        'menu_id' => 2004,
        'menu_id2' => 2004001,
        'name'  => '管理员',
        'auths' => 'Admin@*,AuthRole@*',
    ],
    [
        'id' => 11,
        'menu_id' => 2004,
        'menu_id2' => 2004002,
        'name'  => '备份还原',
        'auths' => 'Tools@*',
    ],
    [
        'id' => 12,
        'menu_id' => 2004,
        'menu_id2' => 2004003,
        'name'  => '模板管理',
        'auths' => 'Filemanager@*',
    ],
    [
        'id' => 13,
        'menu_id' => 2004,
        'menu_id2' => 2004004,
        'name'  => '字段管理',
        'auths' => 'Field@*',
    ],
    [
        'id' => 14,
        'menu_id' => 2004,
        'menu_id2' => 2004005,
        'name'  => '清除缓存',
        'auths' => 'System@clearCache',
    ],
    [
        'id' => 15,
        'menu_id' => 2005,
        'menu_id2' => 0,
        'name'  => '插件应用',
        'auths' => 'Weapp@index,Weapp@create,Weapp@pack,Weapp@upload,Weapp@disable,Weapp@install,Weapp@uninstall,Weapp@enable,Weapp@execute',
    ],
    [
        'id' => 16,
        'menu_id' => 2002,
        'menu_id2' => 0,
        'name'  => '允许操作',
        'auths' => 'Uiset@*',
    ],
];