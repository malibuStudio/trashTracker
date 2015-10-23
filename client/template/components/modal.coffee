##########################################################################
#
#
# modal.coffee
#
#
##########################################################################

# ========================================================================
# Delegate modal trigger click
# ========================================================================

$(document).delegate '[data-action=modal]', 'click', (e)->
  $el = $(e.target).attr('data-target')
  MODAL($el)

# modals = document.querySelectorAll('[data-action="modal"]')
# i = 0
# while i < modals.length
#   modals[i].addEventListener 'click', ( (e)->
#     el = modals[i].getAttribute 'data-target'
#     console.log el
#     MODAL(el)
#   ), false
# i++


# ========================================================================
# MODAL Object
# ========================================================================
@MODAL = (el, obj)->
  init =
    modal: el
    settings:
      overlay: true
      # Duation Time Set
      duration:
        open: 0.15
        close: 0.3

  # Get Modal
  modal = document.getElementById(el)
  init.modal = modal

  # openD = open duration time
  # closeD = close duration time
  openD = init.settings.duration.open
  closeD = init.settings.duration.close


  # Create overlay
  if document.querySelectorAll('.modal-overlay').length is 0
    overlay = '<div class="modal-overlay"></div>'
    # overlay.classList.add('modal-overlay')
    # Appen modal-overlay to #viewport
    modal.insertAdjacentHTML('afterend', overlay)

    # Override init.settings.overlay if necessary
    if obj and obj.overlay is false
      init.settings.overlay = false

    # Overlay Opacity 0 false, 1 true
    overlayOpacity = 0 if init.settings.overlay is false
    overlayOpacity = 1 if init.settings.overlay is true

    overlay = document.querySelector('.modal-overlay')

    # Open Modal Overlay
    TweenMax.to '.modal-overlay', openD,
      opacity: overlayOpacity
      onComplete: ->
        overlay.style.pointerEvents = 'auto'

  # Set modal to 'block'
  modal.style.display = 'block'

  # Open Modal
  TweenMax.to modal, openD,
    scale: 1
    opacity: 1


  closeModal = ()->
      # Close GSAP
      TweenMax.to modal, closeD,
        scale: 1.1
        opacity: 0
        display: 'none'
        clearProps: 'all'

      # Close Modal Overlay GSAP
      # if $('.modal-overlay').length isnt 0
      TweenMax.to '.modal-overlay', closeD,
        opacity: 0,
        clearProps: 'all'
        onComplete: ->
          $('.modal-overlay').remove()



  # Close (.close)
  closeEl = document.querySelectorAll('.close', modal)
  i = 0
  while i < closeEl.length
    closeEl[i].addEventListener 'click', ((e) ->
      e.preventDefault()
      closeModal()
    ), false
    i++


  # Close (.modal-overlay)
  modalOverlay = document.querySelector('.modal-overlay')
  modalOverlay.addEventListener 'click', ( (e)->
    e.preventDefault()
    closeModal()
  ), false




