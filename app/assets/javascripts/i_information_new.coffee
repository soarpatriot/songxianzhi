$(window).bind 'page:change', ->

    $contact_link = $('#information_contact_link')
    if  $contact_link
      $contact_link.click ->
         if $("#information_contact_info").hasClass("hidden")
            $("#information_contact_info").removeClass 'hidden'
            $("#information_contact_info").addClass 'show'
         else
            $("#information_contact_info").removeClass 'show'
            $("#information_contact_info").addClass 'hidden'

        #$("#information_contact_info").removeClass 'hidden'
        #$("#information_contact_info").toggle(700)

