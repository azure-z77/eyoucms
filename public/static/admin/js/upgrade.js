// 系统升级 js 文件


$(document).ready(function(){
    $("#a_upgrade").click(function(){
        btn_upgrade(this, 0);  
    });
});

function btn_upgrade(obj, type)
{
    var v = $("#textarea_filelist").val();    
    var intro = $("#textarea_intro").val();
    var notice = $("#textarea_notice").val();
    // v = v.replace(/\n/g,"<br/>");
    v = notice + intro + '<br/>' + v;
    var version = $(obj).attr('data-version');  
    var title = '检测系统最新版本：'+version;

    if (0 == type) {
        var btn = ['升级','忽略'];
    } else if (1 == type) {
        var btn = ['升级','忽略','不再提醒'];
    }

    //询问框
    layer.confirm(v, {
            title: title
            ,area: ['580px','400px']
            ,btn: btn //按钮
            ,btn3: function(index){
                var url = $(obj).data('tips_url');
                $.getJSON(url, {show_popup_upgrade:-1}, function(){});
                layer.msg('【核心设置】里可以开启该提醒', {
                    btnAlign: 'c',
                    time: 20000, //20s后自动关闭
                    btn: ['知道了']
                });
                return false;
            }

        }, function(){
            layer_loading('升级中');
            upgrade(obj); // 请求后台
            
        }, function(){  
            layer.msg('不升级可能有安全隐患', {
                btnAlign: 'c',
                time: 20000, //20s后自动关闭
                btn: ['明白了']
            });
            return false;

        }
    );   
}

function upgrade(obj){
    var url = $(obj).data('upgrade_url');
    $.ajax({
        type : "GET",
        url  :  url,
        timeout : 360000, //超时时间设置，单位毫秒 设置了 1小时
        data : {},
        error: function(request) {
            layer.alert("网络请求失败", {icon: 2}, function(){
                top.location.reload();
            });
        },
        success: function(v) {
            if(v=='1'){
                layer.alert('已升级最新版本!', {icon: 1}, function(){
                    // top.location.href = eyou_basefile + "?m="+module_name+"&c=Admin&a=logout";
                    top.location.reload();
                });
            }
            else{
                layer.alert(v, {icon: 2}, function(){
                    top.location.reload();
                });
            }
        }
    });                 
}

function layer_loading(msg){
    var loading = layer.msg(
    msg+'...&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;请勿刷新页面', 
    {
        icon: 1,
        time: 3600000, //1小时后后自动关闭
        shade: [0.2] //0.1透明度的白色背景
    });
    //loading层
    var index = layer.load(3, {
        shade: [0.1,'#fff'] //0.1透明度的白色背景
    });

    return loading;
}

/*
$('#').click(funcion(){

});


 
*/