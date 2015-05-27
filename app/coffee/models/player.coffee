$ ((app) ->
  app.Models.Player = Backbone.Model.extend
    urlRoot: 'http://' + app.Config.api_server[app.Config.enviroment] + '/players'
    defaults:
      name: "John"
      character: "Sir Stabington"
      turn: false
      initiative: 1
      ac: 12
      speed: "30"
      hp: 10
      health: 10
      damage: 0
      thumb: "//placekitten.com.s3.amazonaws.com/homepage-samples/200/140.jpg"
      playling: false
  this
)(window.LKT)
