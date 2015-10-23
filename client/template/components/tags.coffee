##########################################################################
#
#
# tags.coffee
#
#
##########################################################################

# ========================================================================
# Tags
# ========================================================================


@TAGS = (el, obj)->
  init =
    tags  : el
    input : ''
    cont   : ''
    select: ''
    settings:                       # DEFAULT SETTINGS
      max   : 5                     # Max Tags
      delimiter: [13, 32, 188]      # Enter, Space, Comma
      placeholder: ''               # Placeholder
      clickDelete: true             # Click tag to delete

  obj = '' if not obj

  # Override settings.max if necessary
  if obj.max and typeof Number(obj.max) is parsetInt(obj.max, 10)
    init.settings.max = Number(obj.max)

    # Override settings.delimiter if necessary
  if obj.delimiter and typeof obj.delimeter is 'array'
    init.settings.delimiter = obj.delimiter

  if obj.placeholder and typeof obj.placeholder is 'string'
    init.settings.placeholder = obj.placeholder.trim()

  if obj.clickDelete and typeof obj.clickDelete is 'boolean'
    init.settings.clickDelete = obj.clickDelete

  # Get Element and add class .tags-wrapper
  tags = document.getElementById(init.tags)
  tags.classList.add('tags-wrapper')

  # Create <input>
  input = document.createElement('input')
  input.setAttribute('placeholder', init.settings.placeholder)


  # Create Hidden <select> to contain tags value
  selectHidden = document.createElement('select')
  selectHidden.classList.add('select-hidden')
  selectHidden.setAttribute('multiple', 'multiple')

  # Create <div> to hold visual tags
  tagsCont = document.createElement('div')
  tagsCont.classList.add('tags-container')

  init.select = selectHidden
  init.cont = tagsCont
  init.input = input

  # Append created elements
  tags.appendChild(selectHidden)
  tags.appendChild(tagsCont)
  tags.appendChild(input)

  # TODOS : CLICK SPAN.TAG TO DELETE TAG
  # Click to delete
  # if init.settings.clickDelete is true


  # Keydown
  document.addEventListener('keydown', (e)->

    # If tag input is focused
    if init.input is document.activeElement
      input = init.input
      select = init.select
      cont = init.cont
      del = init.settings.delimiter
      max = init.settings.max
      key = e.keyCode or e.which
      tagCount = cont.children.length

      # If input is empty, delete recent tag
      if input.value.trim().length is 0 and key is 8
        e.preventDefault()

        # If there is no tag, return false
        if tagCount is 0
          return false

        # Get last span and opt
        lastSpan = cont.lastElementChild
        lastOpt = select.lastElementChild

        # Remove recent tag visually and datawise
        lastSpan.parentNode.removeChild(lastSpan)
        lastOpt.parentNode.removeChild(lastOpt)

      # If delimiter is pressed
      if key in del
        e.preventDefault()

        # If input is empty, do nothing
        if input.value.trim().length is 0
          return false

        # If maximum count is reached do nothing
        if tagCount is max
          return false

        # Get input value and trim before add
        val = input.value.trim()

        # Create <option> to add to hidden select
        opt = document.createElement('option')
        opt.setAttribute('selected', 'selected')
        opt.setAttribute('name', val)
        opt.value = val

        # Add opt to select
        select.appendChild(opt)

        # Create Visual Tag
        span = document.createElement('span')
        span.classList.add('tag')
        span.value = val
        label = document.createTextNode(val)
        span.appendChild(label)

        cont.appendChild(span)

        # Clear Input
        input.value = ''
  )



