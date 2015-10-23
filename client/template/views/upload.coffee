Template.upload.events
  'touchend .btn-upload-cropped': (e)->
    e.preventDefault()

    $('.btn-upload-cropped').addClass('loading')

    croppedImg = $('img.crop-target').cropper('getCroppedCanvas', {width: 800, height: 800})

    Session.set('croppedImg', croppedImg.toDataURL())

    Cloudinary._upload_file cropped, {}, (err, res) ->
      if err
        # Show Error in console, then remove loading state
        console.log err
        $('.btn-upload-cropped').removeClass('loading')
      else
        $('.btn-upload-cropped').removeClass('loading')


