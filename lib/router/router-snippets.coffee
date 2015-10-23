###
# Iron Router Example 1
Router.route '/route',
  name: 'templateName',
  yieldRegions:
    'templateName': to: 'yieldRegion'
  layoutTemplate: 'layoutTemplate'
  waitOn: ->
    return Meteor.subscribe('subName', filter, options)
  data: ->
    posts = Posts.find(filter, options)
    comments = Comments.find(filter, options)
    # The following can be used as helpers in blaze
    # {{#each posts}}, {{#with comments}}
    return [
      posts,
      comments
    ]

# Iron Router Example 2
Router.route '/someRoute/:_id', (->
  @layout 'layoutTemplate'
  @render 'TemplateName', to: 'yieldRegion'
  @subscribe('singleEvent', @params._id)
  # If sub is ready
  if @ready
    singleEvent = Events.findOne({_id: @params._id})
    # If single Event Exists, render template
    # Else, Render notFound Template
    if singleEvent
      @render 'adminEventSettings',
        data: ->
          return Events.findOne({_id: @params._id})
    else
      @render 'notFound'
  else
    # If sub is not ready, render loading template
    @render 'loading'
), name: 'adminEventSettings'
###
