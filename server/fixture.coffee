@setFixture = ->
  fixtures = [
    description: "쓰레기 돌 샌드위치"
    imageUrl: "./img/fixtures/IMG_2763.JPG"
    geometry:
      type: "Point"
      coordinates: [ 126.7592, 33.5585 ]
      timestamp: 1445613400511
  ,
    description: "모래 은닉자"
    imageUrl: "./img/fixtures/IMG_2765.JPG"
    geometry:
      type: "Point"
      coordinates: [ 126.7594, 33.558 ]
      timestamp: 1445613410511
  ,
    description: "어른이 흘리지 말아야할 것은 눈물뿐만이 아닙니다"
    imageUrl: "./img/fixtures/IMG_2768.JPG"
    geometry:
      type: "Point"
      coordinates: [ 126.7603, 33.5575 ]
      timestamp: 1445613420511
  ,
    description: "쓰레기도 돈이다"
    imageUrl: "./img/fixtures/IMG_2768.JPG"
    geometry:
      type: "Point"
      coordinates: [ 126.5297, 33.5063 ]
      timestamp: 1445613430511

  ]
  Trashes.insert _.extend fixture, createdAt: Date(fixture.geometry.timestamp) for fixture in fixtures