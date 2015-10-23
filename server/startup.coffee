Meteor.startup ->
  Trashes._ensureIndex
    "geometry": "2dsphere"