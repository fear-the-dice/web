$ ((app) ->
  app.Views.NewPlayer = app.Views.Monster.extend
    tagName: "div"
    className: "new-player"
    existing: false

    events:
      "click .new-player__save": "saveNewPlayer"
      "click .new-player__cancel": "removeModal"

    initialize: (model) ->
      this.template = app.Templates.new_player
      this.model = model
      this.model.view = this
      this.open = false

      if typeof this.model.get("id") != "undefined"
        this.template = app.Templates.existing_player
        this.existing = true

      _.bindAll this, "render"
      this.model.bind "change", $.proxy(this.change, this)
      this.render()

      this.$el.find(".player__stat--edit").show()
      this.$el.find(".player__name--edit").show()

      this.pubSub =
        monsterModal:
          init: ''

      this.pubsub_remove()
      this.pubsub_init()

      PubSub.publish "PlayerModal.init"

      this

    pubsub_init: ->
      this.pubSub.monsterModal.init = PubSub.subscribe "MonsterModal.init", $.proxy(this.removeModal, this)

      this

    pubsub_remove: ->
      PubSub.unsubscribe this.pubSub.monsterModal.init

      this

    removeModal: (e) ->
      this.pubsub_remove()

      if this.open is true
        this.open = false
        this.$el.slideUp $.proxy((e) ->
          this.$el.remove()
        , this)
      else
        this.$el.remove()

      PubSub.publish "PlayerModal.hide"

      this.$el

    saveNewPlayer: (e) ->
      stats =
        "character": this.$el.find(".input__character").val()
        "name": this.$el.find(".input__player").val()
        "ac": parseInt this.$el.find(".input__stat[stat='ac']").val()
        "hp": parseInt this.$el.find(".input__stat[stat='hp']").val()
        "speed": this.$el.find(".input__stat[stat='speed']").val()
        "xp": parseInt this.$el.find(".input__stat[stat='xp']").val()

      this.model.set stats

      this.model.save()
      this.removeModal()

      if this.existing == false
        app.Collections.Player.push this.model
        app.Collections.Player.sort()

  this
)(window.LKT)
