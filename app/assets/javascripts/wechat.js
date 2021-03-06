
$(function() {
  var postShow = $("#posts-show")[0] 
  if(postShow){
    var shareData = {
        imgUrl: $("#share-image-url").val(),
        title: $("#share-title").val(),
        content: $("#share-content").val(),
        link: $("#share-url").val()
    };
    var appId = $("#app-id").val();
    var timestamp = $("#timestamp").val();
    var nonceStr = $("#noncestr").val();
    var signature = $("#sign").val();
    wx.config({
        debug: false,
        appId: appId,
        timestamp: timestamp,
        nonceStr:  nonceStr,
        signature: signature,
        jsApiList:['onMenuShareTimeline','onMenuShareAppMessage','onMenuShareQQ','onMenuShareWeibo','onMenuShareQZone'] 
    });
    wx.ready(function(){
        wx.onMenuShareTimeline({
          title: shareData.title,
          link: shareData.link,
          imgUrl: shareData.imgUrl 
        }) 
        wx.onMenuShareAppMessage({
          title: shareData.title,
          desc: shareData.content,
          link: shareData.link,
          imgUrl: shareData.imgUrl 
        }) 
    })
  }
});
