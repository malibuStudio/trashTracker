Template.page.onCreated ->
  @pageIndex = new ReactiveVar 1
  navigator.geolocation.getCurrentPosition (loc)=>
    @locationSubs and @locationSubs.stop()
    @locationSubs = @subscribe 'getTrashLocations', [
      loc.coords.longitude,
      loc.coords.latitude
    ]
  @touchstart =
    x: 0
    y: 0

Template.page.helpers
  "Trashes": ->
    t = Template.instance()
    idx = t.pageIndex.get()
    Trashes.find {},
      skip: idx - 1
      limit: idx > 0 and 3 or 2
      sort:
        createdAt: -1
  "gestures":
    'swiperight .page-container': (e, tmpl)->
      e.preventDefault()
      tmpl.view.template.swipeH -1, tmpl
    'swipeleft .page-container': (e, tmpl)->
      e.preventDefault()
      tmpl.view.template.swipeH 1, tmpl


Template.page.swipeH = (d, tmpl)->
  console.log d

  idx = tmpl.pageIndex.get()

  # if scrollabe
  if Trashes.find().count()>1
    wrapper = document.querySelector('.page-wrapper')
    currentItem = document.querySelector('.page-item')

    TweenMax.fromTo wrapper, 0.5,
      x: -currentItem.offsetWidth
    ,
      x: (-d * currentItem.offsetWidth) - currentItem.offsetWidth
      clearProps: "all"
      ease: Power2.easeIn
      onComplete: ->
        tmpl.pageIndex.set idx+d
Template.page.events
  # ========================================================
  # Events
  # -> Layout Control
  # ========================================================
  'touchstart .page-container': (e)->
    firstTouch = e.originalEvent.touches[0]

    Template.instance().touchstart =
      x: firstTouch.pageX
      y: firstTouch.pageY

# console.log Template.instance().touchstart
  'touchend .page-container': (e)->
    lastTouch = e.originalEvent.changedTouches[e.originalEvent.changedTouches.length-1]

    touchend =
      x: lastTouch.pageX
      y: lastTouch.pageY

    touchstart = Template.instance().touchstart

    uiWrapper = document.getElementById('ui-wrapper')

    console.log 'touchstart', touchstart
    console.log 'touchend', touchend

    if _.isEqual(touchstart, touchend)
      console.log 'tap not move'
      if 'active' in uiWrapper.classList
        console.log 'menu visible'
        TweenMax.to uiWrapper, 0.5,
          opacity: 0
          onComplete: ->
            uiWrapper.classList.remove 'active'
            uiWrapper.style.pointerEvents = 'none'
      else
        console.log 'menu hidden'
        TweenMax.to uiWrapper, 0.5,
          opacity: 1
          onComplete: ->
            uiWrapper.classList.add 'active'
            uiWrapper.style.pointerEvents = 'auto'

# ========================================================
# Events
# -> Upload Photo
# ========================================================
  'touchend #upload-photo': (e)->
    if not Meteor.userId()
      console.log 'Sign in required'

      MODAL('modal-account')

  'change #upload-photo input': (e)->
    e.preventDefault
    e = e.originalEvent
    target = e.dataTransfer or e.target
    file = target and target.files and target.files[0]
    options =
      canvas: true
      maxWidth: 800

    if not file
      return
    else
      console.log 'File: ', file
      # if file.size > 4194304
      #   return false

      # Use the "JavaScript Load Image" functionality to parse the file data
      loadImage.parseMetaData file, (data) ->

# Get the correct orientation setting from the EXIF Data
        if data.exif
          options.orientation = data.exif.get('Orientation')
          if data.exif.map
            console.log 'Exif.map: ',data.exif.map
          else
            console.log 'Location Data does not Exist'

        # Load the image from disk and inject it into the DOM with the correct orientation
        loadImage file, ((canvas) ->
          imgDataURL = canvas.toDataURL('img/jpg')

          Session.set('currentImg', imgDataURL)

          $('img.crop-target').attr(
            'src': Session.get('currentImg')
          )

          Meteor.setTimeout (->
# $('.upload-container').removeClass('active')
            TweenMax.to '.upload-container', 0.5,
              opacity: 1
              y: 0
# $('.crop-container').addClass('active')
          ), 500

          $('img.crop-target').imagesLoaded().done (instance)->
            console.log 'Image Done'
            Meteor.setTimeout (->
              $('img.crop-target').cropper
                aspectRatio: 1/1
                guides: false
                strict: true
                dragCrop: false
                cropBoxMovable: true
                cropBoxResizable: true
                responsive: true
                mouseWheelZoom: true
                built: ->
                  TweenMax.to '.malibu-crop-wrapper', 0.5,
                    opacity: 1
                    onComplete: ->
                      console.log 'Tween'
            ), 1000

        ), options




# Template.home.events
# 'change #upload-photo input': (e)->
#   e.preventDefault
#   e = e.originalEvent
#   target = e.dataTransfer or e.target
#   file = target and target.files and target.files[0]
#   options =
#     canvas: true
#     maxWidth: 800

#   if not file
#     return
#   else
#     console.log 'File: ', file
#     # if file.size > 4194304
#     #   return false

#     # Use the "JavaScript Load Image" functionality to parse the file data
#     loadImage.parseMetaData file, (data) ->

#         # Get the correct orientation setting from the EXIF Data
#         if data.exif
#             options.orientation = data.exif.get('Orientation')
#             if data.exif.map
#               console.log 'Exif.map: ',data.exif.map
#             else
#               console.log 'Location Data does not Exist'

#         # Load the image from disk and inject it into the DOM with the correct orientation
#         # loadImage file, ((canvas) ->
#           # imgDataURL = canvas.toDataURL('img/jpg')
#           # console.log(imgDataURL)
#           # Session.set('currentImg', imgDataURL)


#           # console.log 'Done!'
#         # ), options

# Template.home.onRendered ->
