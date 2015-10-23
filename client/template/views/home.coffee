Template.home.onCreated ->
  @touchstart =
    x: 0
    y: 0

Template.home.helpers
  "gestures":
    'swiperight .page-container': (e, tmpl)->
      e.preventDefault()
      tmpl.view.template.swipeH -1
    'swipeleft .page-container': (e, tmpl)->
      e.preventDefault()
      tmpl.view.template.swipeH 1


Template.home.swipeH = (d)->
  activePage = document.querySelector('.page-wrapper.active')
  nextPage = activePage.nextElementSibling

  if not nextPage
    nextPage = document.querySelector('.page-wrapper')

  console.log 'swiped'

  TweenMax.fromTo nextPage, 0.5,
    x: d * nextPage.offsetWidth
    opacity: 0
    zIndex: 99
  ,
    x: 0
    opacity: 1
    clearProps: 'all'
    ease: Power2.easeIn
    onComplete: ->
      console.log 'swiped page'
      activePage.classList.remove 'active'
      nextPage.classList.add 'active'

Template.home.events
  'touchend .goto-register': (e)->
    e.preventDefault()

    TweenMax.to '#signin', 0.15,
      opacity: 0
      display: 'none'

    TweenMax.to '#register', 0.33,
      opacity: 1
      display: 'block'

  'touchend .goto-signin': (e)->
    e.preventDefault()

    TweenMax.to '#register', 0.15,
      opacity: 0
      display: 'none'

    TweenMax.to '#signin', 0.33,
      opacity: 1
      display: 'block'

  'submit form#form-signin': (e)->
    e.preventDefault()

    $('button.btn-signin').addClass('loading')

    obj =
      user: $.trim($('[name=signin-user]').val())
      password: $.trim($('[name=signin-password]').val())

    Meteor.loginWithPassword obj.user, obj.password, (err, res) ->
      if err
        # throwError err.reason
        $('button.btn-signin').removeClass('loading')
      else
        $('button.btn-signin').removeClass('loading')
        # Close GSAP
        modal = document.getElementById('modal-account')

        TweenMax.to modal, 0.3,
          scale: 1.1
          opacity: 0
          display: 'none'
          clearProps: 'all'

        # Close Modal Overlay GSAP
        # if $('.modal-overlay').length isnt 0
        TweenMax.to '.modal-overlay', 0.3,
          opacity: 0,
          clearProps: 'all'
          onComplete: ->
            $('.modal-overlay').remove()

  'submit form#form-register': (e, t)->
    e.preventDefault()
    $('button.btn-register').addClass('loading')
    obj =
      username: $.trim($('[name=register-user]').val())
      email: $.trim($('[name=register-email]').val())
      password: $.trim($('[name=register-password]').val())

    Accounts.createUser obj, (err, result) ->
      if err
        $('button.btn-register').removeClass('loading')
        console.log err.reason
      else
        $('button.btn-register').removeClass('loading')
        modal = document.getElementById('modal-account')

        TweenMax.to modal, 0.3,
          scale: 1.1
          opacity: 0
          display: 'none'
          clearProps: 'all'

        # Close Modal Overlay GSAP
        # if $('.modal-overlay').length isnt 0
        TweenMax.to '.modal-overlay', 0.3,
          opacity: 0,
          clearProps: 'all'
          onComplete: ->
            $('.modal-overlay').remove()

  'touchend .upload-photo': (e)->
    if not Meteor.userId()
      console.log 'Sign in required'

      MODAL('modal-account')


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





# Template.home.events
#   'change #upload-photo input': (e)->
#     e.preventDefault
#     e = e.originalEvent
#     target = e.dataTransfer or e.target
#     file = target and target.files and target.files[0]
#     options =
#       canvas: true
#       maxWidth: 800

#     if not file
#       return
#     else
#       console.log 'File: ', file
#       # if file.size > 4194304
#       #   return false

#       # Use the "JavaScript Load Image" functionality to parse the file data
#       loadImage.parseMetaData file, (data) ->

#           # Get the correct orientation setting from the EXIF Data
#           if data.exif
#               options.orientation = data.exif.get('Orientation')
#               if data.exif.map
#                 console.log 'Exif.map: ',data.exif.map
#               else
#                 console.log 'Location Data does not Exist'

#           # Load the image from disk and inject it into the DOM with the correct orientation
#           # loadImage file, ((canvas) ->
#             # imgDataURL = canvas.toDataURL('img/jpg')
#             # console.log(imgDataURL)
#             # Session.set('currentImg', imgDataURL)


#             # console.log 'Done!'
#           # ), options

# Template.home.onRendered ->
