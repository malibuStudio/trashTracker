@setFixture = ->
  fixtures = [
    description: "1쓰레기 돌 샌드위치"
    imageUrl: "http://placehold.jp/3d4070/ffffff/300x300.png?text=1"
#    imageUrl: "./img/fixtures/IMG_2763.JPG"
    geometry:
      type: "Point"
      coordinates: [ 126.7592, 33.5585 ]
      timestamp: 1445613400511
  ,
    description: "2모래 은닉자"
    imageUrl: "http://placehold.jp/3d4070/ffffff/300x300.png?text=2"
#    imageUrl: "./img/fixtures/IMG_2765.JPG"
    geometry:
      type: "Point"
      coordinates: [ 126.7594, 33.558 ]
      timestamp: 1445623410511
  ,
    description: "3어른이 흘리지 말아야할 것은 눈물뿐만이 아닙니다"
    imageUrl: "http://placehold.jp/3d4070/ffffff/300x300.png?text=3"
#    imageUrl: "./img/fixtures/IMG_2768.JPG"
    geometry:
      type: "Point"
      coordinates: [ 126.7603, 33.5575 ]
      timestamp: 1445633420511
  ,
    description: "4쓰레기도 돈이다"
    imageUrl: "http://placehold.jp/3d4070/ffffff/300x300.png?text=4"
#    imageUrl: "./img/fixtures/IMG_2778.JPG"
    geometry:
      type: "Point"
      coordinates: [ 126.5297, 33.5063 ]
      timestamp: 1445643430511
  ]
  Trashes.insert _.extend fixture, createdAt: new Date(fixture.geometry.timestamp) for fixture in fixtures