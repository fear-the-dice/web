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

      this.pubsub_init()
      this.socket_init()

      this.loadPlayers()
      this.loadMonsters()

    pubsub_init: ->
      PubSub.subscribe "GameCollection.sort", $.proxy(this.reRender, this)

      PubSub.subscribe "PlayerCollection.add", $.proxy(this.addSidebarPlayer, this)
      PubSub.subscribe "MonsterCollection.add", $.proxy(this.addSidebarMonster, this)

      PubSub.subscribe "PlayerCollection.change", $.proxy(this.addSidebarPlayer, this)
      PubSub.subscribe "MonsterCollection.change", $.proxy(this.addSidebarMonster, this)
      PubSub.subscribe "GameCollection.change", $.proxy(this.addSidebarMonster, this)

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
      model = new app.Models.Player()
      model.set "playing", true
      new this.playerView model
      app.socket.emit "NewPlayer", JSON.stringify model.toJSON()
      app.Collections.Player.push model
      app.Collections.Player.sort()
      app.Collections.Game.push model
      model.save()
      model

    addMonster: (e) ->
      model = new app.Models.Monster()
      model.set "playing", true
      new this.monsterView model
      app.socket.emit "NewMonster", JSON.stringify model.toJSON()
      app.Collections.Monster.push model
      app.Collections.Monster.sort()
      app.Collections.Game.push model
      model.save()
      model

  this
)(window.LKT)
