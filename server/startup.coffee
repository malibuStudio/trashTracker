Meteor.startup ->
#  Trashes.remove {}
  unless Trashes.find().count()
    Trashes._ensureIndex
      "geometry": "2dsphere"
    setFixture()