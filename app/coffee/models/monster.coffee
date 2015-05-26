$ ((app) ->
  app.Models.Monster = Backbone.Model.extend
    url: 'http://' + app.Config.api_server[app.Config.enviroment] + '/monsters/'
    defaults:
      monster: "Bandit"
      turn: false
      initiative: 12
      ac: 12
      hp: 11
      speed: 30
      health: 11
      damage: 0
      xp: 25
      manual: 343
      thumb: "//www.fillmurray.com/g/200/140"
      playling: false
  this
)(window.LKT)
