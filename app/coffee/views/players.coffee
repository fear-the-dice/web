$ ((app) ->
  app.Views.Players = Backbone.View.extend
    tagName: "div"
    className: "players-modal"

    events:
      "click .players__save": "newPlayer"
      "click .players__cancel": "removeModal"

    initialize: (model) ->
      this.template = app.Templates.players
      this.render()
      this.open = false

      this

    render: ->
      this.$el.html Mustache.render this.template

      _.each app.Collections.Player.models, $.proxy((member) ->
        view = new app.Views.PlayerSidebar member
        this.$el.find(".players").append view.$el
      , this)

      this.pubsub_init()
      
      this.$el

    postRender: () ->
      if this.open is false
        this.$el.slideDown()
        this.open = true

      this.$el

    pubsub_init: ->
      PubSub.subscribe "PlayerCollection.add", $.proxy(this.render, this)
      PubSub.subscribe "PlayerCollection.destroy", $.proxy(this.render, this)

    newPlayer: (e) ->
      this.removeModal()

      model = new app.Models.Player()
      view = new app.Views.NewPlayer model
      $(".base").prepend view.$el
      view.postRender()

      model

    removeModal: (e) ->
      if this.open is true
        this.open = false
        this.$el.slideUp (e) ->
          this.$el.remove()
      else
        this.$el.remove()

      this.$el

    addPlayer: ->
      this.model.set "playing", true
      app.socket.emit "NewPlayer", JSON.stringify this.model.toJSON()
      new app.Views.PlayerDM this.model
      app.Collections.Player.add this.model
      app.Collections.Game.add this.model

    deletePlayer: ->
      this.model.destroy()

  this
)(window.LKT)

