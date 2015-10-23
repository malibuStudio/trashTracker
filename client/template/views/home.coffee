
Template.home.events
  # ========================================================
  # Events
  # -> Accounts
  # ========================================================
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

