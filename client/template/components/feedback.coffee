$(document).delegate '[data-feedback=true]', 'click', (e)->
  target = $(e.target)
  FEEDBACK(target)

@FEEDBACK = (target)->
  target.addClass('feedback')
  target.one malibu.instance.animationEnd, ->
    target.removeClass('feedback')