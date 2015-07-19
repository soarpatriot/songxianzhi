$(window).bind 'page:change', ->
   $("#shop_url").keyup ->
       url = location.protocol+"//" + $(this).val() + "." + location.host
       $("#shop-url-show").text(url)