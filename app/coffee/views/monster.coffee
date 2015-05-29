$ ((app) ->
  app.Views.Monster = Backbone.View.extend
    tagName: "div"
    className: "row"
    events:
      "click .monster__hit": "hit"
      "click .monster__hit--edit .glyphicon-check": "saveDamage"

    initialize: (model) ->
      this.template = app.Templates.monster
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

      PubSub.publish "MonsterUpdate", JSON.stringify this.model.toJSON()
      app.socket.emit "MonsterUpdate", JSON.stringify this.model.toJSON()
      this.render()

    render: ->
      this.$el.html Mustache.render this.template, this.model.toJSON()
      this.$el.addClass "monster"
      this.$el

    startTurn: ->
      this.model.set "turn", true
      this.$el.addClass "turn"
      this.$el

    endTurn: ->
      this.model.set "turn", false
      this.$el.removeClass "turn"
      this.$el

    postRender: () ->
      this.reRender()

      if this.open is false
        this.$el.slideDown()
        this.open = true

      this.delegateEvents()
      this.$el

    reRender: ->
      if this.model.get("health") <= 0
        this.$el.find(".monster__hit").hide()
        this.$el.addClass "dead"
      else
        this.$el.removeClass "dead"

      this.$el

    hit: (e) ->
      this.$el.find(".monster__hit").hide()
      this.$el.find(".monster__hit--edit").show()
      this.$el.find(".monster__hit--edit input").focus()

    saveDamage: (e) ->
      value = parseInt this.$el.find(".monster__hit--edit input").val()

      this.$el.find(".monster__hit--edit").hide()
      this.$el.find(".monster__hit--edit").val 0
      this.$el.find(".monster__hit").show()

      stats =
        damage: this.model.get("damage") + value
        health: this.model.get("health") - value

      this.model.set stats

      this.reRender()

  this
)(window.LKT)
