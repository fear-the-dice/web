$ ((app) ->
  # Allow immediate exceptions in pubsub, lets remove this once we go live
  PubSub.immediateExceptions = true

  # Configure router
  AppRouter = Backbone.Router.extend
    routes:
      "": "home"
      "dm": "dm"

    home: ->
      view = new app.Views.Base()
      $("body .base").html view.$el

    dm: ->
      view = new app.Views.Dm()
      $("body .base").html view.$el

    pubsub_init: ->
      PubSub.subscribe "PlayerCollection.change", $.proxy(() ->
        app.Collections.Player.sort()
      , this)

      PubSub.subscribe "MonsterCollection.change", $.proxy(() ->
        app.Collections.Monster.sort()
      , this)

    initialize: ->
      app.Collections.Player = new app.Collections.Player()
      app.Collections.Monster = new app.Collections.Monster()
      app.Collections.Game = new app.Collections.Game()

      this.pubsub_init()

      # Player collection bindings
      app.Collections.Player.bind "add", (model) ->
        PubSub.publish "PlayerCollection.add"

      app.Collections.Player.bind "change", () ->
        PubSub.publish "PlayerCollection.change"

      app.Collections.Player.bind "update", () ->
        PubSub.publish "PlayerCollection.update"

      app.Collections.Player.bind "destroy", () ->
        PubSub.publish "PlayerCollection.destroy"

      # Monster collection bindings
      app.Collections.Monster.bind "add", (model) ->
        PubSub.publish "MonsterCollection.add"

      app.Collections.Monster.bind "change", () ->
        PubSub.publish "MonsterCollection.change"

      app.Collections.Monster.bind "update", () ->
        PubSub.publish "MonsterCollection.update"

      app.Collections.Monster.bind "destroy", () ->
        PubSub.publish "MonsterCollection.destroy"

      # Game collection bindings
      app.Collections.Game.bind "add", () ->
        app.Collections.Game.sort()
        PubSub.publish "GameCollection.add"

      app.Collections.Game.bind "change", () ->
        app.Collections.Game.sort()
        PubSub.publish "GameCollection.change"

      app.Collections.Game.bind "sort", () ->
        PubSub.publish "GameCollection.sort"

  # Light the fuse!
  new AppRouter()
  Backbone.history.start()
  this

)(window.LKT)
