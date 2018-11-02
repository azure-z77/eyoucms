<?php

// 应用行为扩展定义文件
return array(
    // 模块初始化
    'module_init'  => array(
        'weapp\\Form\\behavior\\weapp\\FormBehavior',
    ),
    // 操作开始执行
    'action_begin' => array(
        'weapp\\Form\\behavior\\weapp\\FormBehavior',
    ),
    // 视图内容过滤
    'view_filter'  => array(
        'weapp\\Form\\behavior\\weapp\\FormBehavior',
    ),
    // 日志写入
    'log_write'    => array(
        'weapp\\Form\\behavior\\weapp\\FormBehavior',
    ),
    // 应用结束
    'app_end'      => array(
        'weapp\\Form\\behavior\\weapp\\FormBehavior',
    ),
);
