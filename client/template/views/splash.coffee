Template.splash.events
  'touchstart .splash-container': (e)->

    console.log 'hello! You\'ve found an easter egg'

    placement =
      left: e.clientX or e.originalEvent.touches[0].pageX
      top:  e.clientY or e.originalEvent.touches[0].pageY

    TweenMax.fromTo '.bullet', 0.8,
      opacity: 0
      left: placement.left
      top: placement.top
      scale: 4
      rotation: 360
    ,
      opacity: 1
      left: '50%'
      top: '50%'
      scale: 1
      ease: Power1.easeOut
      rotation: -720
      clearProps: 'all'


