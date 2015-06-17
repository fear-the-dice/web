$ ((app) ->
  app.Views.MonsterDM = app.Views.Monster.extend
    events:
      "click .monster__stat": "editStat"
      "click .monster__stat--value": "editStat"
      "click .monster__stat--edit .glyphicon-check": "saveStatEvent"

      "click .monster__name": "editName"
      "click .monster__name--edit .glyphicon-check": "saveName"

      "click .monster__hit": "hit"
      "click .monster__hit--edit .glyphicon-check": "saveDamage"

      "click .monster__heal": "heal"
      "click .monster__heal--edit .glyphicon-check": "saveHealing"

      "click .monster__delete": "deleteMonster"

    initialize: (model) ->
      this.template = app.Templates.monster_dm
      this.model = model
      this.model.view = this
      this.model.set "id", this.model.id
      this.open = false

      _.bindAll this, "render"
      this.model.bind "change", $.proxy(this.change, this)
      this.render()

      this

    editName: (e) ->
      $stat = $(e.currentTarget).parent()

      $stat.find(".monster__name").hide()
      $stat.find(".monster__name--edit input").val this.model.get "monster"
      $stat.find(".monster__name--edit").show()
      $stat.find(".monster__name--edit input").focus()

    saveName: (e) ->
      $stat = $(e.currentTarget).parent().parent()

      value = $stat.find(".monster__name--edit input").val()

      this.model.set "monster", value
      $stat.find(".monster__name--edit").hide()
      $stat.find(".monster__name").show()

      if this.model.get("duplicate") != true
        this.model.save()

    editStat: (e) ->
      $stat = $(e.currentTarget).parent()
      stat = $stat.find(".monster__stat").attr "stat"

      $stat.find(".monster__stat--edit input").val this.model.get stat
      $stat.find(".monster__stat--edit").show()
      $stat.find(".monster__stat--edit input").focus()

      $stat.on "keypress", "input", $.proxy((e) ->
        if e.which == 13
          this.saveStat($stat)
       , this)

    saveStatEvent: (e) ->
      $stat = $(e.currentTarget).parent().parent()
      this.saveStat($stat)

    saveStat: ($stat) ->
      $stat.off("keypress", "input")

      stat = $stat.find(".monster__stat").attr "stat"
      $input = $stat.find(".monster__stat--edit input")
      inputType = $input.attr "type"
      value = $input.val()

      if typeof(value) != 'undefined' && value == "number"
        value = parseInt value

      this.model.set stat, value
      $stat.find(".monster__stat--edit").hide()
      $stat.find(".monster__stat--value").show()

      if this.model.get("duplicate") != true
        this.model.save()

      if stat == "initiative"
        PubSub.publish "PlayerOrderChange"

      this.reRender()

    heal: (e) ->
      this.$el.find(".monster__heal").hide()
      this.$el.find(".monster__heal--edit").show()
      this.$el.find(".monster__heal--edit input").focus()

    saveHealing: (e) ->
      value = parseInt this.$el.find(".monster__heal--edit input").val()

      this.$el.find(".monster__heal--edit").hide()
      this.$el.find(".monster__heal--edit").val 0
      this.$el.find(".monster__heal").show()

      stats =
        damage: this.model.get("damage") - value
        health: this.model.get("health") + value

      stats.damage = if (stats.damage < 0) then 0 else stats.damage

      this.model.set stats

      this.reRender()

    deleteMonster: (e) ->
      app.socket.emit "MonsterRemoved", JSON.stringify this.model.toJSON()
      app.Collections.Game.remove this.model
      this.$el.remove()

  this
)(window.LKT)
