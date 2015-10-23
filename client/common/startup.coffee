Meteor.startup ->
  # initialize geolocation coords
  Geolocation.currentLocation()