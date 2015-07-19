function weiXinShareBtn(title,link,desc,img_url) {
    if (typeof WeixinJSBridge == "undefined") {
        alert("请使用微信扫描二维码");
    } else {
        WeixinJSBridge.invoke('shareTimeline', {
            "title": title,
            "link": link,
            "desc": desc,
            "img_url": img_url
        });
    }
}
$(window).bind('page:change',function(){
    $(".wixin-share-btn").click(function(){
        alert("ff");
        var title = "ss",
            link = "ff",
            desc = "fffs",
            img_url = "http://www.baidu.com/aa.jpg";

        WeixinJSBridge.invoke('shareTimeline', {
            "title": title,
            "link": link,
            "desc": desc,
            "img_url": img_url
        },function(res){
            alert(res);
            alert(JSON.stringify(res))
        });
    });
});
document.addEventListener('WeixinJSBridgeReady', function onBridgeReady() {

    //$(".wixin-share-btn").removeClass("hidden");



    WeixinJSBridge.on('menu:share:appmessage', function (argv) {
        WeixinJSBridge.invoke('sendAppMessage', {
            "img_url": "fff",
            "link": "ff",
            "desc": "ff",
            "title": "fff"
        }, function (res) {
            alert(JSON.stringify(res))
            // _report('send_msg', res.err_msg);
        })
    });


    WeixinJSBridge.on('menu:share:timeline', function (argv) {
        WeixinJSBridge.invoke('shareTimeline', {
            "img_url": window.shareData.imgUrl,
            "link": window.shareData.link,
            "desc": window.shareData.content,
            "title": window.shareData.title + "\n" + window.shareData.content
        }, function (res) {
            // _report('timeline', res.err_msg);
        });
    });

}, false);