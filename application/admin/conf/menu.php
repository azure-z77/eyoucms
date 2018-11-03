<?php

$icon_arr = array(
    'article' => 'fa fa-file-text',
    'product'  => 'fa fa-cubes',
    'images'  => 'fa fa-file-picture-o',
    'download'  => 'fa fa-cloud-download',
    'single'  => 'fa fa-bookmark-o',
    'about'  => 'fa fa-minus',
    'job'  => 'fa fa-minus',
    'guestbook'  => 'fa fa-file-text-o',
    'feedback'  => 'fa fa-file-text-o',
);

$default_words = array();
$default_addcontent = array();

// 获取有栏目的模型列表
$channel_list = model('Channeltype')->getArctypeChannel('yes');
foreach ($channel_list as $key => $val) {
    $default_words[] = array(
        'name'  => $val['ntitle'],
        'act'  => 'index',
        'op'  => $val['ctl_name'],
        'url'  => $val['typelink'],
        'icon'  => $icon_arr[$val['nid']],
    );
    if (!in_array($val['nid'], array('single','guestbook','feedback'))) {
        $default_addcontent[] = array(
            'name'  => $val['ntitle'],
            'act'  => 'add',
            'op'  => $val['ctl_name'],
            'url'  => $val['typelink'],
            'icon'  => $icon_arr[$val['nid']],
        );
    }
}

/*PC端可视编辑URl*/
$uiset_pc_url = '';
if (file_exists(ROOT_PATH.'template/pc/uiset.txt')) {
    $uiset_pc_url = url('Uiset/pc', array(), true, SITE_URL);
}
/*--end*/

/*手机端可视编辑URl*/
$uiset_mobile_url = '';
if (file_exists(ROOT_PATH.'template/mobile/uiset.txt')) {
    $uiset_mobile_url = url('Uiset/mobile', array(), true, SITE_URL);
}
/*--end*/

/*清理数据URl*/
$uiset_data_url = '';
if (!empty($uiset_pc_url) || !empty($uiset_mobile_url)) {
    $uiset_data_url = url('Uiset/ui_index', array(), true, SITE_URL);
}
/*--end*/

/*可视编辑URL*/
$uiset_index_url = '';
if (!empty($uiset_pc_url) || !empty($uiset_mobile_url)) {
    $uiset_index_url = url('Uiset/index', array(), true, SITE_URL);
}
/*--end*/

/*插件应用URl*/
$weapp_index_url = '';
// $weappDirList = glob(ROOT_PATH.'weapp/*');
if (1 == tpCache('web.web_weapp_switch') && file_exists(ROOT_PATH.'weapp')) {
    $weapp_index_url = url('Weapp/index', array(), true, SITE_URL);
}
/*--end*/

return  array(
    'default'=>array('name'=>'','act'=>'','op'=>'','url'=>'', 'target'=>'workspace','child'=>array(
        array('name' => '栏目管理','act'=>'index','op'=>'Arctype','url'=>'', 'target'=>'workspace','icon'=>'fa fa-sitemap',
            'child' => array()
        ),
        array('name' => '内容管理','act'=>'index','op'=>'Archives','url'=>'', 'target'=>'workspace','icon'=>'fa fa-list',
            'child' => array()
        ),
        array('name' => '广告管理','act'=>'index','op'=>'Other','url'=>'', 'target'=>'workspace','icon'=>'fa fa-image',
            'child' => array()
        ),
    )),
        
    'set'=>array('name'=>'设置','act'=>'','op'=>'','url'=>'', 'target'=>'workspace','child'=>array(
        array('name' => '基本信息','act'=>'index','op'=>'System','url'=>U('System/index', array('inc_type'=>'web')), 'target'=>'workspace','icon'=>'fa fa-cog',
            'child' => array()
        ),
        array('name' => '可视编辑','act'=>'','op'=>'','url'=>$uiset_index_url, 'target'=>'workspace','icon'=>'fa fa-tachometer',
            'child'=>array(
                array('name' => '电脑版','act'=>'','op'=>'','url'=>$uiset_pc_url, 'target'=>'_blank','icon'=>'fa fa-desktop'
                ),
                array('name' => '手机版','act'=>'','op'=>'','url'=>$uiset_mobile_url, 'target'=>'_blank','icon'=>'fa fa-mobile'
                ),
                array('name' => '数据清理','act'=>'','op'=>'','url'=>$uiset_data_url, 'target'=>'workspace','icon'=>'fa fa-undo'
                ),
            )
        ),
        array('name' => '营销设置','act'=>'index','op'=>'Ad','url'=>'', 'target'=>'workspace','icon'=>'fa fa-paper-plane',
            'child'=>array(
                array('name' => 'SEO优化', 'act'=>'index', 'op'=>'Seo','url'=>U('Seo/index', array('inc_type'=>'seo')), 'target'=>'workspace','icon'=>'fa fa-newspaper-o'),
                array('name' => '友情链接', 'act'=>'index', 'op'=>'Links','url'=>'', 'target'=>'workspace','icon'=>'fa fa-link'),
            )
        ),
        array('name' => '高级选项','act'=>'','op'=>'Senior','url'=>'', 'target'=>'workspace','icon'=>'fa fa-code',
            'child' => array(
                array('name' => '管理员', 'act'=>'index', 'op'=>'Admin','url'=>'', 'target'=>'workspace','icon'=>'fa fa-user'),
                array('name' => '备份还原', 'act'=>'index', 'op'=>'Tools','url'=>'', 'target'=>'workspace','icon'=>'fa fa-database'),
                array('name' => '模板管理', 'act'=>'index', 'op'=>'Filemanager','url'=>'', 'target'=>'workspace','icon'=>'fa fa-folder-open'),
                array('name' => '字段管理', 'act'=>'channel_index', 'op'=>'Field','url'=>'', 'target'=>'workspace','icon'=>'fa fa-cogs'),
                array('name' => '清除缓存','act'=>'clearCache', 'op'=>'System','url'=>'', 'target'=>'workspace','icon'=>'fa fa-undo'),
            )
        ),
        array('name' => '插件应用','act'=>'','op'=>'','url'=>$weapp_index_url, 'target'=>'workspace','icon'=>'fa fa-recycle',
            'child'=>array()
        ),
    )),
);