$(window).bind 'page:change', ->

  addtohome = addToHomescreen({
      autostart: true,
      onAdd: ->
        alert('Welcome to the homescreen!')

  })
  #addtohome.show()