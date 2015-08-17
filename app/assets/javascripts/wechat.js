
$(function() {
  
  var shareDate = {
      imgUrl: $("#share-image-url").val(),
      title: $("#share-title").val(),
      content: $("#share-content").val(),
      link: $("#share-link").val()
  };
  var appId = $("#app-id").val();
  var timestamp = $("#timestamp").val();
  var nonceStr = $("#noncestr").val();
  var signature = $("#sign").val();
  console.log("appId"+ appId);
  console.log("appId"+ timestamp);
  console.log("appId" + nonceStr);
  console.log("appId" + signature);
  if(wx){
      wx.confg({
        debug: true,
        appId: appId,
        timestamp: timestamp,
        nonceStr:  nonceStr,
        signature: signature,
        jsApiList:['onMenuShareTimeline','onMenuShareAppMessage','onMenuShareQQ','onMenuShareWeibo','onMenuShareQZone'] 
      });
   }
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
});
