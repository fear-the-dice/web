$ ((app) ->
  app.Views.Player = Backbone.View.extend
    tagName: "div"
    className: "row"
    events:
      "click .player__hit": "hitPlayer"
      "click .player__control": "takeControl"
      "click .player__hit--edit .glyphicon-check": "saveDamage"

    initialize: (model) ->
      this.template = app.Templates.player
      this.model = model
      this.model.view = this
      this.model.set "id", this.model.id
      this.open = false

      _.bindAll this, "render"
      this.model.bind "change", $.proxy(this.change, this)
      this.render()

      this

    change: ->
      PubSub.publish "PlayerUpdate", JSON.stringify this.model.toJSON()
      app.socket.emit "PlayerUpdate", JSON.stringify this.model.toJSON()
      this.render()

    render: ->
      this.$el.html Mustache.render this.template, this.model.toJSON()
      this.$el.addClass "player"
      this.$el

    startTurn: ->
      this.turn = true
      this.$el.addClass "turn"
      this.$el

    endTurn: ->
      this.turn = false
      this.$el.removeClass "turn"
      this.$el

    postRender: () ->
      this.reRender()

      if this.open == false
        this.$el.slideDown()
        this.open = true

      this.delegateEvents()
      this.$el

    reRender: ->
      if this.model.get("damage") >= this.model.get("hp")
        this.$el.find(".player__hit").hide()
        this.$el.addClass "dead"
      else
        this.$el.removeClass "dead"

      this.$el

    hitPlayer: (e) ->
      this.$el.find(".player__hit").hide()
      this.$el.find(".player__hit--edit").show()

    saveDamage: (e) ->
      value = parseInt this.$el.find(".player__hit--edit input").val()

      this.$el.find(".player__hit--edit").hide()
      this.$el.find(".player__hit--edit").val 0
      this.$el.find(".player__hit").show()

      stats =
        damage: this.model.get("damage") + value
        health: this.model.get("health") - value

      this.model.set stats

      this.reRender()

    takeControl: (e) ->
      this.$el.addClass "active-player"
      PubSub.publish "ActivePlayer", this.model.id

  this
)(window.LKT)
