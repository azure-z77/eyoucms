<?php

// 应用行为扩展定义文件
return array(
    // 应用初始化
    'app_init'     => array(),
    // 应用开始
    'app_begin'    => array(),
    // 模块初始化
    'module_init'  => array(
        'app\\admin\\behavior\\CoreProgramBehavior',
        'app\\admin\\behavior\\TestingBehavior',
    ),
    // 操作开始执行
    'action_begin' => array(
        'app\\admin\\behavior\\AfterSaveBehavior',
    ),
    // 视图内容过滤
    'view_filter'  => array(),
    // 日志写入
    'log_write'    => array(),
    // 应用结束
    'app_end'      => array(
        'app\\admin\\behavior\\AppEndBehavior',
    ),
);
