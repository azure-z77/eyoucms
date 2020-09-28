// 文档阅读AJAX
function ey_1564127378() {
    var JsonData  = ey_1564127251;
    var get_url   = JsonData.get_url;
    var ClosePage = JsonData.ClosePage;

    // 步骤一:创建异步对象
    var ajax = new XMLHttpRequest();
    //步骤二:设置请求的url参数,参数一是请求的类型,参数二是请求的url,可以带参数,动态的传递参数starName到服务端
    ajax.open("post", get_url, true);
    // 给头部添加ajax信息
    ajax.setRequestHeader("X-Requested-With","XMLHttpRequest");
    // 如果需要像 HTML 表单那样 POST 数据，请使用 setRequestHeader() 来添加 HTTP 头。然后在 send() 方法中规定您希望发送的数据：
    ajax.setRequestHeader("Content-type","application/x-www-form-urlencoded");
    //步骤三:发送请求+数据
    ajax.send('_ajax=1');
    //步骤四:注册事件 onreadystatechange 状态改变就会调用
    ajax.onreadystatechange = function () {
        //步骤五 请求成功，处理逻辑
        if (ajax.readyState==4 && ajax.status==200) {
            var json = ajax.responseText;  
            var res  = JSON.parse(json);
            if (0 == res.code) {
                // 不可以查看
                document.body.innerHTML = "";
                setTimeout(function(){
                    confirm(res.msg);
                    if (ClosePage) {
                        window.close();
                    }else{
                        var return_url = document.referrer;
                        window.location.href = return_url; 
                    }
                },600);
            }
      　}
    };
}
ey_1564127378();

// 视频播放逻辑AJAX
function ey_1592981821() {
    var JsonData  = ey_1564127251;
    var VideoLogicUrl = JsonData.VideoLogicUrl;
    var aid = JsonData.aid;

    // 步骤一:创建异步对象
    var ajax = new XMLHttpRequest();
    //步骤二:设置请求的url参数,参数一是请求的类型,参数二是请求的url,可以带参数,动态的传递参数starName到服务端
    ajax.open("post", VideoLogicUrl, true);
    // 给头部添加ajax信息
    ajax.setRequestHeader("X-Requested-With","XMLHttpRequest");
    // 如果需要像 HTML 表单那样 POST 数据，请使用 setRequestHeader() 来添加 HTTP 头。然后在 send() 方法中规定您希望发送的数据：
    ajax.setRequestHeader("Content-type","application/x-www-form-urlencoded");
    //步骤三:发送请求+数据
    ajax.send('aid=' + aid);
    //步骤四:注册事件 onreadystatechange 状态改变就会调用
    ajax.onreadystatechange = function () {
        //步骤五 请求成功，处理逻辑
        if (ajax.readyState==4 && ajax.status==200) {
            var json = ajax.responseText;  
            var res  = JSON.parse(json);
            if (1 == res.code) {
                if (res.data.MsgOnclick) {
                    if (document.getElementById("VideoDiv13579")) {
                        document.getElementById("VideoDiv13579").setAttribute("style", "display: block; width: 100%;");
                    }
                    if (document.getElementById("MsgTitle13579")) {
                        document.getElementById('MsgTitle13579').innerHTML = res.data.MsgTitle;
                    }
                    if (document.getElementById("MsgOnclick13579")) {
                        document.getElementById('MsgOnclick13579').innerHTML = res.data.MsgName;
                        document.getElementById("MsgOnclick13579").setAttribute("onclick", res.data.MsgOnclick);
                    }
                }

                if (res.data.VideoButton) {
                    var videoButton = document.getElementsByClassName('VideoButton13579');
                    for (var i = 0; i < videoButton.length; i++) {
                        videoButton[i].innerHTML = res.data.VideoButton;
                    }
                }

                if (res.data.BuyOnclick) {
                    if (document.getElementById("BuyOnclick13579")) {
                        document.getElementById("BuyOnclick13579").setAttribute("style", "display: block");
                        document.getElementById('BuyOnclick13579').innerHTML = res.data.BuyName;
                        document.getElementById("BuyOnclick13579").setAttribute("onclick", res.data.BuyOnclick);
                    }
                }

                if (1 == res.data.DelVideoUrl) {
                    if (document.getElementById("video_play_20200520_"+aid)) {
                        document.getElementById("video_play_20200520_"+aid).setAttribute("src", "");
                    }
                }
            }
      　}
    };
}

// 视频购买
function MediaOrderBuy_1592878548(aid) {
    var JsonData = ey_1564127251;
    var BuyUrl = JsonData.buy_url;
    var aid = JsonData.aid;

    // 步骤一:创建异步对象
    var ajax = new XMLHttpRequest();
    //步骤二:设置请求的url参数,参数一是请求的类型,参数二是请求的url,可以带参数,动态的传递参数starName到服务端
    ajax.open("post", BuyUrl, true);
    // 给头部添加ajax信息
    ajax.setRequestHeader("X-Requested-With","XMLHttpRequest");
    // 如果需要像 HTML 表单那样 POST 数据，请使用 setRequestHeader() 来添加 HTTP 头。然后在 send() 方法中规定您希望发送的数据：
    ajax.setRequestHeader("Content-type","application/x-www-form-urlencoded");
    //步骤三:发送请求+数据
    ajax.send('aid=' + aid);
    //步骤四:注册事件 onreadystatechange 状态改变就会调用
    ajax.onreadystatechange = function () {
        //步骤五 请求成功，处理逻辑
        if (ajax.readyState==4 && ajax.status==200) {
            var json = ajax.responseText;  
            var res  = JSON.parse(json);
            if (1 == res.code && res.url) {
                window.location.href = res.url;
            } else if (0 == res.code && res.url) {
                window.location.href = res.url;
            } else {
                alert(res.msg);
            }
      　}
    };
}

// 跳转至会员升级页面
function LevelCentre_1592878548() {
    var JsonData = ey_1564127251;
    window.location.href = JsonData.LevelCentreUrl;
}

// 点击隐藏遮幕层并播放视频
function PlayVideo(id) {
    document.getElementsByClassName("jw-video-expense")[0].setAttribute("style", "display: none");
    document.getElementById(id).play();
}