Meteor.startup ->
  Trashes.remove {}
  Trashes._ensureIndex
    "geometry": "2dsphere"
  
  setFixture()