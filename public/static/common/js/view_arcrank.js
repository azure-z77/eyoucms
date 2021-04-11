// 文档阅读AJAX
function ey_1564127378() {
    var JsonData = ey_1564127251;
    var get_url = JsonData.get_url;
    var ClosePage = JsonData.ClosePage;

    // 步骤一:创建异步对象
    var ajax = new XMLHttpRequest();
    //步骤二:设置请求的url参数,参数一是请求的类型,参数二是请求的url,可以带参数,动态的传递参数starName到服务端
    ajax.open("post", get_url, true);
    // 给头部添加ajax信息
    ajax.setRequestHeader("X-Requested-With", "XMLHttpRequest");
    // 如果需要像 HTML 表单那样 POST 数据，请使用 setRequestHeader() 来添加 HTTP 头。然后在 send() 方法中规定您希望发送的数据：
    ajax.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
    //步骤三:发送请求+数据
    ajax.send('_ajax=1');
    //步骤四:注册事件 onreadystatechange 状态改变就会调用
    ajax.onreadystatechange = function () {
        //步骤五 请求成功，处理逻辑
        if (ajax.readyState == 4 && ajax.status == 200) {
            var json = ajax.responseText;
            var res = JSON.parse(json);
            if (0 == res.code) {
                if (res.data && res.data.is_login == 0) {
                    window.location.href = res.data.gourl;
                } else {
                    // 不可以查看
                    document.body.innerHTML = "";
                    setTimeout(function () {
                        confirm(res.msg);
                        if (ClosePage) {
                            window.close();
                        } else {
                            var return_url = document.referrer;
                            window.location.href = return_url;
                        }
                    }, 600);
                }
            } else if (1 == res.code) {
                if (res.data.is_admin && 1 == res.data.is_admin) {
                    setTimeout(function () {
                        alert(res.data.msg);
                    }, 1000);
                }
            }
        }
    };
}

ey_1564127378();

// 视频播放逻辑AJAX
function ey_1592981821() {
    var JsonData = ey_1564127251;
    var VideoLogicUrl = JsonData.VideoLogicUrl;
    var aid = JsonData.aid;
    // 步骤一:创建异步对象
    var ajax = new XMLHttpRequest();
    //步骤二:设置请求的url参数,参数一是请求的类型,参数二是请求的url,可以带参数,动态的传递参数starName到服务端
    ajax.open("post", VideoLogicUrl, true);
    // 给头部添加ajax信息
    ajax.setRequestHeader("X-Requested-With", "XMLHttpRequest");
    // 如果需要像 HTML 表单那样 POST 数据，请使用 setRequestHeader() 来添加 HTTP 头。然后在 send() 方法中规定您希望发送的数据：
    ajax.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
    //步骤三:发送请求+数据
    ajax.send('aid=' + aid);
    //步骤四:注册事件 onreadystatechange 状态改变就会调用
    ajax.onreadystatechange = function () {
        //步骤五 请求成功，处理逻辑
        if (ajax.readyState == 4 && ajax.status == 200) {
            var json = ajax.responseText;
            var res = JSON.parse(json);
            if (1 == res.code) {
                if (res.data.status_name) {
                    if (document.getElementById("Mianfei13579")) {
                        document.getElementById("Mianfei13579").innerHTML = res.data.status_name;
                    }
                }
                if (res.data.status_value == 0){
                    document.getElementsByClassName('video-period')[0].innerHTML = '<div class="video-free-now button button-big bg-yellow text-center radius-rounded text-middle">免费</div>';
                }else if (res.data.status_value == 1){
                    if (document.getElementById("BuyOnclick13579")) {
                        document.getElementById("BuyOnclick13579").setAttribute("style", "display: block;");
                        document.getElementById("BuyOnclick13579").setAttribute("onclick", "MediaOrderBuy_1592878548();");
                        document.getElementById("BuyOnclick13579").innerHTML = '立即购买';
                    }
                }else if (res.data.status_value == 3){
                    document.getElementsByClassName('video-period')[0].innerHTML = '<a class="video-free-now button button-big bg-yellow text-center radius-rounded text-middle" href="'+res.data.button_url+'">res.data.button</a>';
                }else{
                    document.getElementsByClassName('video-period')[0].innerHTML = '<div class="video-free-now button button-big bg-yellow text-center radius-rounded text-middle">VIP</div>';
                }
                if (res.data.play_auth == 1) {
                    //有播放权限
                    if (document.getElementById("Xuexi20210201")) {
                        document.getElementById("Xuexi20210201").setAttribute("style", "display: block;");
                    }

                } else {
                    //没有播放权限
                    if (res.data.status_value != 2) {
                        if (res.data.status_value == 3 && 2 == res.data.vip_status) {

                        } else {
                            if (document.getElementById("BuyOnclick20210201")) {
                                document.getElementById("BuyOnclick20210201").setAttribute("style", "display: block;");
                            }
                        }
                    }
                    if (document.getElementById("video_play_20200520_" + aid)) {
                        document.getElementById("video_play_20200520_" + aid).setAttribute("src", "");
                    }
                }
                if (res.data.button) {
                    var videoButton = document.getElementsByClassName('VideoButton13579');
                    for (var i = 0; i < videoButton.length; i++) {
                        videoButton[i].innerHTML = res.data.button;
                    }
                    if('观看' == res.data.button){
                        document.getElementsByClassName('video-period')[0].innerHTML = '<a class="video-free-now button button-big bg-yellow text-center radius-rounded text-middle" href="'+res.data.button_url+'">立即播放</a>';
                    }
                }
            } else {
                if (document.getElementById("BuyOnclick20210201")) {
                    document.getElementById("BuyOnclick20210201").setAttribute("style", "display: block;");
                }

                // if (document.getElementById("VideoDiv13579")) {
                //     document.getElementById("VideoDiv13579").setAttribute("style", "display: block; width: 100%;");
                // }
                // if (document.getElementById("MsgOnclick13579")) {
                //     document.getElementById("MsgOnclick13579").setAttribute("style", "display: block");
                //     document.getElementById('MsgOnclick13579').innerHTML = res.msg;
                //     document.getElementById("MsgOnclick13579").setAttribute("onclick", "window.location.href='"+res.url+"';");
                // }
                // if (document.getElementsByClassName("VideoButton13579")) {
                //     var videoButton = document.getElementsByClassName('VideoButton13579');
                //     for (var i = 0; i < videoButton.length; i++) {
                //         videoButton[i].innerHTML = res.msg;
                //     }
                // }
            }
        }
    };
}

// 视频购买
function MediaOrderBuy_1592878548() {
    var JsonData = ey_1564127251;
    var BuyUrl = JsonData.buy_url;
    var aid = JsonData.aid;

    // 步骤一:创建异步对象
    var ajax = new XMLHttpRequest();
    //步骤二:设置请求的url参数,参数一是请求的类型,参数二是请求的url,可以带参数,动态的传递参数starName到服务端
    ajax.open("post", BuyUrl, true);
    // 给头部添加ajax信息
    ajax.setRequestHeader("X-Requested-With", "XMLHttpRequest");
    // 如果需要像 HTML 表单那样 POST 数据，请使用 setRequestHeader() 来添加 HTTP 头。然后在 send() 方法中规定您希望发送的数据：
    ajax.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
    //步骤三:发送请求+数据
    ajax.send('aid=' + aid);
    //步骤四:注册事件 onreadystatechange 状态改变就会调用
    ajax.onreadystatechange = function () {
        //步骤五 请求成功，处理逻辑
        if (ajax.readyState == 4 && ajax.status == 200) {
            var json = ajax.responseText;
            var res = JSON.parse(json);
            if (1 == res.code && res.url) {
                window.location.href = res.url;
            } else {
                // 没有登录
                if (document.getElementById('ey_login_id_1609665117')) { // 最新demo的弹窗登录
                    $('#ey_login_id_1609665117').trigger('click');
                } else { // 一般模板
                    var referurl = window.location.href;
                    var url = res.url;
                    if (url.indexOf('?') > -1) {
                        url += '&';
                    } else {
                        url += '?';
                    }
                    url += 'referurl=' + encodeURIComponent(referurl);
                    window.location.href = url;
                }

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