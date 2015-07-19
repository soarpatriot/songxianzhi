$(function() {

    $("#download-app-link").click(function(e) {

        var isWX = Boolean(navigator.userAgent.match(/MicroMessenger/));
        if(isWX){
            e.preventDefault();
            var wxTipImg = 'http://www.yuxian.me/assets/wx-tip-android.png';
            var div = document.createElement('div');
            div.innerHTML = '<img style="margin: 30px auto; padding: 30px auto; width:80%" src="' + wxTipImg + '" />';
            div.style.cssText = 'background-color: rgba(0,0,0,0.7); position: fixed; top:0; bottom: 0; width:100%; text-align: center;z-index: 1100; padding: 30px 30px;';//
            document.body.appendChild(div);

            div.addEventListener('touchmove', function (event) {
                event.preventDefault();
                event.stopPropagation();
            }, false);

            div.onclick = function () {
                document.body.removeChild(div);
            };
            e.preventDefault();
        }

    })

});