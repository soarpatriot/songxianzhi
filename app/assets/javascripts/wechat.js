
$(function() {
  
  var shareDate = {
      imgUrl: $("#share-image-url").val(),
      title: $("#share-title").val(),
      content: $("#share-content").val(),
      link: $("#share-link").val()
  };
  document.addEventListener('WeixinJSBridgeReady', function onBridgeReady() {
      // 发送给好友
      WeixinJSBridge.on('menu:share:appmessage', function (argv) {
          WeixinJSBridge.invoke('sendAppMessage', {
              "img_url": shareData.imgUrl,
              "link": shareData.link,
              "desc": shareData.content,
              "title": shareData.title
          }, function (res) {
              // _report('send_msg', res.err_msg);
          })
      });
      // 分享到朋友圈
      WeixinJSBridge.on('menu:share:timeline', function (argv) {
          WeixinJSBridge.invoke('shareTimeline', {
              "img_url": shareData.imgUrl,
              "link": shareData.link,
              "desc": shareData.content,
              "title":shareData.title + "\n" + window.shareData.content
          }, function (res) {
              // _report('timeline', res.err_msg);
          });
      });

  }, false)

});
