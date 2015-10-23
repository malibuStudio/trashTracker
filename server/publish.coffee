Meteor.publish 'getTrashLocations', (coordinates)->
  ## Test Subs
  # Meteor.subscribe('getTrashLocations', [Geolocation.currentLocation().coords.longitude, Geolocation.currentLocation().coords.latitude]);
  Trashes.find
    'geometry':
      $near:
        $geometry:
          type: "Point"
          "coordinates": coordinates
        $maxDistance: 100000