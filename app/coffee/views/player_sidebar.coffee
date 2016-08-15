$ ((app) ->
  app.Views.PlayerSidebar = Backbone.View.extend
    tagName: "div"
    className: "sidebar__player"

    events:
      "click .player-sidebar__remove": "deletePlayer"
      "click .player-sidebar__add": "addPlayer"
      "click .player-sidebar__edit": "editPlayer"

    initialize: (model) ->
      this.template = app.Templates.player_sidebar
      this.model = model
      this.render()

      this

    render: ->
      this.$el.html Mustache.render this.template, this.model.toJSON()
      this.$el.addClass "text-center col-xs-12 col-md-5"
      this.$el

    editPlayer: ->
      view = new app.Views.NewPlayer this.model
      $(".base").prepend view.$el
      view.postRender()

      this.model

    addPlayer: ->
      this.model.set "playing", true
      app.socket.emit "NewPlayer", JSON.stringify this.model.toJSON()
      new app.Views.PlayerDM this.model
      app.Collections.Player.add this.model
      app.Collections.Game.add this.model

      PubSub.publish "PlayersModal.add"

      this.model

    deletePlayer: ->
      this.model.destroy()

  this
)(window.LKT)
