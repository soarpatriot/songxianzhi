$(window).bind 'page:change', ->
  $('#fileupload').fileupload({
    url:'/pictures',

    dataType: 'json',
    autoUpload: true,

    acceptFileTypes: /(\.|\/)(gif|jpg|jpeg|png)$/i,
    maxFileSize: 5000000,
    disableImageResize: /Android(?!.*Chrome)|Opera/.test(window.navigator.userAgent),
    previewMaxWidth: 140,
    previewMaxHeight: 140,
    previewCrop: true
  }).on('fileuploadadd',  (e, data) ->

    console.log "aaa"
    $.each(data.files,  (index, file) ->
      _id = _.uniqueId('file_')
      file._id =_id
      file.name = _id



    );


  ).on('fileuploadprocessalways', (e, data) ->
    console.log "ss"
  ).on('fileuploadprogress', (e, data) ->
    progress = Math.floor(data.loaded / data.total * 100)
    console.log progress

  ).on('fileuploaddone', (e, data) ->

    console.log('fileuploaddone')
    data.context.remove()
    console.log data
    console.log data.result
    $.each(data.files, (index, file) ->

      if( file.url )
        console.log("result complete: "+JSON.stringify(file))



    )

  ).on('fileuploadfail', (e, data) ->


  ).prop('disabled', !$.support.fileInput).parent().addClass($.support.fileInput ? undefined : 'disabled')