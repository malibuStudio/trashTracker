Template.registerHelper 'pointDistance', (a, b)->
  GeoJSON.pointDistance
    type: 'Point'
    coordinates: a
  ,
    type: 'Point'
    coordinates: b