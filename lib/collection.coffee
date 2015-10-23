@Trashes = new Mongo.Collection 'trashes'

@Schemas = {}

@Schemas.Coordinate = new SimpleSchema
  "type":
    type: String
    autoValue: ->
      "Point"
  "coordinates":
    type: [Number]
  "timestamp":
    type: Number
@Schemas.Trashes = new SimpleSchema
  "description":
    type: String
    label: "description"
    max: 200
  "imageUrl":
    type: String
    label: "imageUrl"
  "geometry":
    type: Schemas.Coordinate
  "createdAt":
    type: Date
    denyUpdate: true
    autoValue: ->
      if @isInsert?
        new Date
  "createdUserId":
    type: String
    denyUpdate: true
    autoValue: ->
      if @isInsert and not @value
        @userId
  "createdUserName":
    type: String
    autoValue: ->
      if @isInsert and not @value
        Meteor.users.findOne(@userId).username
    denyUpdate: true
  # comments array
  "comments":
    type: [Object]
    optional: true
  "comments.$.description":
    type: String
    max: 200
    optional: true
  "comments.$.imageUrl":
    type: String
    optional: true
  "comments.$.geometry":
    type: SimpleSchema.Coordinate
    optional: true
  "comments.$.createdUserId":
    type: String
    denyUpdate: true
    autoValue: ->
      if @isInsert and not @value
        @userId
  "comments.$.createdUserName":
    type: String
    autoValue: ->
      if @isInsert and not @value
        Meteor.users.findOne(@userId).username
    denyUpdate: true