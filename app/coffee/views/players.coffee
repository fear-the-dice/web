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

      this.pubSub =
        playerCollection:
          add: ''
          destroy : ''
        playerModal:
          init: ''
          hide: ''
        monsterModal:
          init: ''

      this.pubsub_remove()
      this.pubsub_init()

      PubSub.publish "PlayersModal.init"

      this

    render: ->
      this.$el.html Mustache.render this.template

      _.each app.Collections.Player.models, $.proxy((member) ->
        view = new app.Views.PlayerSidebar member
        this.$el.find(".players").append view.$el
      , this)
      
      this.$el

    postRender: () ->
      if this.open is false
        this.$el.slideDown()
        this.open = true

      this.$el

    pubsub_init: ->
      this.pubSub.playerCollection.add = PubSub.subscribe "PlayerCollection.add", $.proxy(this.render, this)
      this.pubSub.playerCollection.destroy = PubSub.subscribe "PlayerCollection.destroy", $.proxy(this.render, this)
      this.pubSub.playerModal.init = PubSub.subscribe "PlayerModal.init", $.proxy(this.removeModal, this)
      this.pubSub.monsterModal.init = PubSub.subscribe "MonsterModal.init", $.proxy(this.removeModal, this)

      this

    pubsub_remove: ->
      PubSub.unsubscribe this.pubSub.playerCollection.add
      PubSub.unsubscribe this.pubSub.playerCollection.destroy
      PubSub.unsubscribe this.pubSub.playerModal.init
      PubSub.unsubscribe this.pubSub.monsterModal.init

      this

    newPlayer: (e) ->
      model = new app.Models.Player()
      view = new app.Views.NewPlayer model
      $(".base").prepend view.$el
      view.postRender()

      model

    removeModal: (e) ->
      this.pubsub_remove()

      if this.open is true
        this.open = false
        this.$el.slideUp $.proxy((e) ->
          this.$el.remove()
        , this)
      else
        this.$el.remove()

      PubSub.publish "PlayersModal.hide"

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

