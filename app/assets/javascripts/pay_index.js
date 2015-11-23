
 $(function() {
  if($("body").data("controller")==="pay" && $("body").data("action")==="index"){
    console.log("fff");
    var appId = $("#app-id").val();
    var timestamp = $("#timestamp").val();
    var nonceStr = $("#noncestr").val();
    var signature = $("#sign").val();
    var package = $("#package").val();
    wx.config({
        debug: false,
        appId: appId,
        timestamp: timestamp,
        nonceStr:  nonceStr,
        signature: signature,
        jsApiList:['onMenuShareTimeline','onMenuShareAppMessage','onMenuShareQQ','onMenuShareWeibo','onMenuShareQZone'] 
    });
    $("#pay-btn").click(function(){
       pay();
    });
    function pay(){
      if((typeof WeixinJSBridge!= "undefined")){
        WeixinJSBridge.invoke(
          'getBrandWCPayRequest', {
             "appId": appid,     //公众号名称，由商户传入     
             "timeStamp": timestamp,         //时间戳，自1970年以来的秒数     
             "nonceStr": nonceStr, //随机串     
             "package": package,    
             "signType": "MD5",         //微信签名方式：     
             "paySign": paySign//微信签名 
          },
          function(res){     
             alert(res);
             if(res.err_msg == "get_brand_wcpay_request: ok" ) {
                alert("ok");
             }     // 使用以上方式判断前端返回,微信团队郑重提示：res.err_msg将在用户支付成功后返回    ok，但并不保证它绝对可靠。 
          }
        );   
      }else{
        alert("weixin js bridge undefined");
      }
    }
  }
}); 
