$ ((app) ->
  app.Views.PlayerDM = app.Views.Player.extend
    events:
      "click .player__stat": "editStat"
      "click .player__stat--value": "editStat"
      "click .player__stat--edit .glyphicon-check": "saveStatEvent"

      "click .character__name": "editCharacter"
      "click .character__name--edit .glyphicon-check": "saveCharacter"

      "click .player__name": "editName"
      "click .player__name--edit .glyphicon-check": "saveName"

      "click .player__hit": "hitPlayer"
      "click .player__hit--edit .glyphicon-check": "saveDamage"

      "click .player__heal": "healPlayer"
      "click .player__heal--edit .glyphicon-check": "saveHealing"

      "click .player__edit": "editAllStats"
      "click .player__delete": "deletePlayer"

    initialize: (model) ->
      this.template = app.Templates.player_dm
      this.model = model
      this.model.view = this
      this.model.set "id", this.model.id
      this.open = false

      _.bindAll this, "render"
      this.model.bind "change", $.proxy(this.change, this)
      this.render()

      this

    change: ->
      health = this.model.get("hp") - this.model.get("damage")
      this.model.set "health", health

      PubSub.publish "PlayerUpdate", JSON.stringify this.model.toJSON()
      app.socket.emit "PlayerUpdate", JSON.stringify this.model.toJSON()
      this.render()

    editName: (e) ->
      $stat = $(e.currentTarget).parent()

      $stat.find(".player__name").hide()
      $stat.find(".player__name--edit input").val this.model.get "name"
      $stat.find(".player__name--edit").show()

    saveName: (e) ->
      $stat = $(e.currentTarget).parent().parent()

      value = $stat.find(".player__name--edit input").val()

      this.model.set "name", value
      $stat.find(".player__name--edit").hide()
      $stat.find(".player__name").show()

      this.model.save()

    editCharacter: (e) ->
      $stat = $(e.currentTarget).parent()

      $stat.find(".character__name").hide()
      $stat.find(".character__name--edit input").val this.model.get "character"
      $stat.find(".character__name--edit").show()
      $stat.find(".character__name--edit input").focus()

    saveCharacter: (e) ->
      $stat = $(e.currentTarget).parent().parent()

      value = $stat.find(".character__name--edit input").val()

      this.model.set "character", value
      $stat.find(".character__name--edit").hide()
      $stat.find(".character__name").show()

      this.model.save()

    editAllStats: (e) ->
      $stats = this.$el.find(".player__stat")

      _.each $stats, $.proxy((stat) ->
        $stat = $(stat).parent()
        stat = $stat.find(".player__stat").attr "stat"

        $stat.find(".player__stat--value").hide()
        $stat.find(".player__stat--edit input").val this.model.get stat
        $stat.find(".player__stat--edit").show()
        $stat.find(".player__stat--edit input").focus()

        $stat.on "keypress", $.proxy((e) ->
          if e.which == 13
            this.saveStats($stats)
         , this)

      , this)

    editStat: (e) ->
      $stat = $(e.currentTarget).parent()
      stat = $stat.find(".player__stat").attr "stat"

      $stat.find(".player__stat--value").hide()
      $stat.find(".player__stat--edit input").val this.model.get stat
      $stat.find(".player__stat--edit").show()
      $stat.find(".player__stat--edit input").focus()

      $stat.on "keypress", "input", $.proxy((e) ->
        if e.which == 13
          this.saveStat($stat, false)
       , this)

    saveStatEvent: (e) ->
      $stat = $(e.currentTarget).parent().parent()
      this.saveStat($stat, false)

    saveStats: ($stats) ->
      _.each $stats, $.proxy((stat) ->
        $stat = $(stat).parent()
        this.saveStat $stat, false, false
      , this)

    saveStat: ($stat, save, render) ->
      $stat.off("keypress", "input")

      stat = $stat.find(".player__stat").attr "stat"
      $input = $stat.find(".player__stat--edit input")
      inputType = $input.attr "type"
      value = $input.val()

      if typeof(inputType) != 'undefined' && inputType == "number"
        console.log "number"
        value = parseInt value

      this.model.set stat, value
      $stat.find(".player__stat--edit").hide()
      $stat.find(".player__stat--value").show()

      if stat == "initiative"
        PubSub.publish "PlayerOrderChange"

      if typeof(save) == undefined || save == true
        this.model.save()

      if typeof(render) == undefined || render == true
        this.reRender()

    healPlayer: (e) ->
      this.$el.find(".player__heal").hide()
      this.$el.find(".player__heal--edit").show()
      this.$el.find(".player__heal--edit input").focus()

    saveHealing: (e) ->
      value = parseInt this.$el.find(".player__heal--edit input").val()

      this.$el.find(".player__heal--edit").hide()
      this.$el.find(".player__heal--edit").val 0
      this.$el.find(".player__heal").show()

      stats =
        damage: this.model.get("damage") - value
        health: this.model.get("health") + value

      stats.damage = if (stats.damage < 0) then 0 else stats.damage

      this.model.set stats

      this.reRender()

    deletePlayer: (e) ->
      app.socket.emit "PlayerRemoved", JSON.stringify this.model.toJSON()
      app.Collections.Game.remove this.model
      this.$el.remove()

  this
)(window.LKT)
