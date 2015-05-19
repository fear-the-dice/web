$ ((app) ->
  app.Models.Monster = Backbone.Model.extend
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

    initialize: (args) ->
      if typeof(args) == 'undefined'
        this.id = app.Utils.guid()

      return this
    this

  this
)(window.LKT)
