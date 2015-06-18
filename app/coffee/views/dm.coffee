$ ((app) ->
  app.Views.Dm = app.Views.Base.extend
    events:
      "click .players__add_btn": "addPlayer"
      "click .monster__add_btn": "addMonster"
      "click .turn__next_btn": "nextTurn"

    initialize: ->
      this.template = app.Templates.dm
      this.render()

      this.playerModel = app.Models.Player
      this.playerView = app.Views.PlayerDM
      this.monsterModel = app.Models.Monster
      this.monsterView = app.Views.MonsterDM
      this.turn = 0

      this.pubSub =
        gameCollection:
          sort: ''
        playerCollection:
          add: ''
          destroy: ''
        monsterCollection:
          add: ''
          destroy: ''
        playerModal:
          hide: ''

      this.pubsub_remove()
      this.pubsub_init()
      this.socket_init()

      this.loadPlayers()
      this.loadMonsters()

    pubsub_init: ->
      this.pubSub.gameCollection.sort = PubSub.subscribe "GameCollection.sort", $.proxy(this.reRender, this)
      this.pubSub.playerCollection.add = PubSub.subscribe "PlayerCollection.add", $.proxy(this.addSidebarPlayer, this)
      this.pubSub.playerCollection.destroy = PubSub.subscribe "PlayerCollection.destroy", $.proxy(this.addSidebarPlayer, this)
      this.pubSub.monsterCollection.add = PubSub.subscribe "MonsterCollection.add", $.proxy(this.addSidebarMonster, this)
      this.pubSub.monsterCollection.destroy = PubSub.subscribe "MonsterCollection.destroy", $.proxy(this.addSidebarMonster, this)
      this.pubSub.playerModal.hide = PubSub.subscribe "PlayerModal.hide", $.proxy(this.addPlayer, this)

      this

    pubsub_remove: ->
      PubSub.unsubscribe this.pubSub.gameCollection.sort
      PubSub.unsubscribe this.pubSub.playerCollection.add
      PubSub.unsubscribe this.pubSub.playerCollection.destroy
      PubSub.unsubscribe this.pubSub.monsterCollection.add
      PubSub.unsubscribe this.pubSub.monsterCollection.destroy
      PubSub.unsubscribe this.pubSub.playerModal.hide

      this

    addSidebarMonster: ->
      this.$el.find(".monsters").html ""

      _.each app.Collections.Monster.models, $.proxy((member) ->
        view = new app.Views.MonsterSidebar member
        this.$el.find(".monsters").append view.$el
      , this)

    addSidebarPlayer: ->
      this.$el.find(".players").html ""

      _.each app.Collections.Player.models, $.proxy((member) ->
        view = new app.Views.PlayerSidebar member
        this.$el.find(".players").append view.$el
      , this)

    loadMonsters: ->
      app.Collections.Monster.fetch()
      app.Collections.Monster.sort()

    loadPlayers: ->
      app.Collections.Player.fetch()
      app.Collections.Player.sort()

    addPlayer: (e) ->
      view = new app.Views.Players()
      $(".base").prepend view.$el
      view.postRender()

    addMonster: (e) ->
      model = new app.Models.Monster()
      view = new app.Views.NewMonster model
      $(".base").prepend view.$el
      view.postRender()
      model

  this
)(window.LKT)
