$(function() {
//使用title内容作为tooltip提示文字
    $(document).tooltip({
        track: true
    });
    
    // 侧边导航展示形式切换
    $('#foldSidebar > i, #foldSidebar2').click(function(){
        var that = $('#foldSidebar').find('i');
        if ($('.admincp-container').hasClass('unfold')) {
            $(that).addClass('fa-in').removeClass('fa-out');
            $('.sub-menu').removeAttr('style');
            $('.admincp-container').addClass('fold').removeClass('unfold');
        } else {
            $(that).addClass('fa-out').removeClass('fa-in');
            $('.nav-tabs').each(function(i){
                $(that).find('dl').each(function(i){
                    $(that).find('dd').css('top', (-70)*i + 'px');
                    if ($(that).hasClass('active')) {
                        $(that).find('dd').show();
                    }
                });
            });
            $('.admincp-container').addClass('unfold').removeClass('fold');
        }
    });

    // 侧边导航三级级菜单点击
    $('.sub-menu').find('a').click(function(){
        if($(this).attr('data-param') != undefined){
            openItem($(this).attr('data-param'));
        }
    });
    
    if ($.cookie('workspaceParam') == null) {
        // 默认选择第一个菜单
        //$('.nc-module-menu').find('li:first > a').click();
        openItem('welcome|Index');
    } else {
        // openItem($.cookie('workspaceParam'));
        openItem('welcome|Index');
    }
});

// 点击菜单，iframe页面跳转
function openItem(param) {	
    $('.sub-menu').find('li').removeClass('active');
    data_str = param.split('|');
    $this = $('div[id^="admincpNavTabs_"]').find('a[data-param="' + param + '"]');
    if ($('.admincp-container').hasClass('unfold')) {
        $this.parents('dd:first').show();
    }
    $('li[data-param="' + data_str[1] + '"]').addClass('active');
    $this.parent().addClass('active').parents('dl:first').addClass('active').parents('div:first').show();
    var src = eyou_basefile + '?m='+module_name+'&c=' + data_str[1] + '&a=' + data_str[0];
    var lang = $.cookie('eyou_lang_var');
    if ($.trim(lang) != '' && $.trim(lang) != 'zh-cn') {
        src = src + '&lang=' + lang;
    }
    $('#workspace').attr('src', src);
    $.cookie('workspaceParam', data_str[0] + '|' + data_str[1], { expires: 1 ,path:"/"});
}

/* 显示Ajax表单 */
function ajax_form(id, title, url, width, model)
{
    if (!width)	width = 480;
    if (!model) model = 1;
    var d = DialogManager.create(id);
    d.setTitle(title);
    d.setContents('ajax', url);
    d.setWidth(width);
    d.show('center',model);
    return d;
}