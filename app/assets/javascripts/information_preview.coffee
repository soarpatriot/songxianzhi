$(window).bind 'page:change', ->
   $(".information-preview").click ->
      id = $(this).attr("id")
      url = "/information/" + id
      $("#inforamtion-detail").load(url);
      $('#information-detail-modal').modal()