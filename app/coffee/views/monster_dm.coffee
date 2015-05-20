$ ((app) ->
  app.Views.MonsterDM = app.Views.Monster.extend
    events:
      "click .monster__stat": "editStat"
      "click .monster__stat--value": "editStat"
      "click .monster__stat--edit .glyphicon-check": "saveStat"

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

    saveName: (e) ->
      $stat = $(e.currentTarget).parent().parent()

      value = $stat.find(".monster__name--edit input").val()

      this.model.set "monster", value
      $stat.find(".monster__name--edit").hide()
      $stat.find(".monster__name").show()

    editStat: (e) ->
      $stat = $(e.currentTarget).parent()
      stat = $stat.find(".monster__stat").attr "stat"

      $stat.find(".monster__stat--value").hide()
      $stat.find(".monster__stat--edit input").val this.model.get stat
      $stat.find(".monster__stat--edit").show()

    saveStat: (e) ->
      $stat = $(e.currentTarget).parent().parent()
      stat = $stat.find(".monster__stat").attr "stat"

      value = parseInt $stat.find(".monster__stat--edit input").val()

      this.model.set stat, value
      $stat.find(".monster__stat--edit").hide()
      $stat.find(".monster__stat--value").show()

      if stat == "initiative"
        PubSub.publish "PlayerOrderChange"

      this.reRender()

    heal: (e) ->
      this.$el.find(".monster__heal").hide()
      this.$el.find(".monster__heal--edit").show()

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
