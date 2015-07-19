$(window).bind 'page:change', ->

  isIE7 = (navigator.appName == "Microsoft Internet Explorer" && navigator.appVersion.match(/7./i)=="7.")
  isIE8 = (navigator.appName == "Microsoft Internet Explorer" && navigator.appVersion.match(/8./i)=="8.")
  isIE6 = (navigator.appName == "Microsoft Internet Explorer")
  isLtIE9 = isIE7 || isIE8 || isIE6

  $container = $('#information-container')
  if  $container.length>0 && !isLtIE9
   $container.imagesLoaded( ->
     $container.masonry({
          itemSelector: '.item'
     })
   )





