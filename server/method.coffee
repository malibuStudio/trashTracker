Meteor.methods
  'insertAnyLocation': (loc)->
    ## Test location
    # navigator.geolocation.getCurrentPosition(function(result) {
    #   console.log(result.coords.longitude);
    #   Meteor.call('insertAnyLocation',{
    #     coords:{
    #       longitude:result.coords.longitude,
    #       latitude:result.coords.latitude
    #     },
    #     timestamp:result.timestamp
    #   });
    # }, function(result) { console.log("error", result) });
    Trashes.insert
      "description": "테스트 위치 Insert"
      "imageUrl": "http://news.kbs.co.kr/data/news/2013/06/28/2682274_250.jpg"
      "geometry":
        "type": "Point"
        "coordinates": [loc.coords.longitude, loc.coords.latitude]
        "timestamp": +new Date()