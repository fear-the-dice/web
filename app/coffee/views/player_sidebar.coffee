$ ((app) ->
  app.Views.PlayerSidebar = Backbone.View.extend
    tagName: "div"
    className: "sidebar__player"

    events:
      "click .glyphicon-remove": "deletePlayer"
      "click .glyphicon-chevron-right": "addPlayer"

    initialize: (model) ->
      this.template = app.Templates.player_sidebar
      this.model = model
      this.render()
      this

    render: ->
      this.$el.html Mustache.render this.template, this.model.toJSON()
      this.$el.addClass "text-center col-xs-12 col-md-5"
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
