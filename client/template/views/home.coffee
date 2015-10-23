Template.home.swipe = (d)->
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

Template.home.helpers
  "gestures":
    'swiperight .page-container': (e, tmpl)->
      e.preventDefault()
      tmpl.view.template.swipe -1
    'swipeleft .page-container': (e, tmpl)->
      e.preventDefault()
      tmpl.view.template.swipe 1


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
