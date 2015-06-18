$ ((app) ->
  app.Views.NewMonster = app.Views.Monster.extend
    tagName: "div"
    className: "new-monster"
    existing: false

    events:
      "click .new-monster__save": "saveNewMonster"
      "click .new-monster__cancel": "removeModal"

    initialize: (model) ->
      this.template = app.Templates.new_monster
      this.model = model
      this.model.view = this
      this.open = false

      if typeof this.model.get("id") != "undefined"
        this.template = app.Templates.existing_monster
        this.existing = true

      _.bindAll this, "render"
      this.model.bind "change", $.proxy(this.change, this)
      this.render()

      this.$el.find(".monster__stat--edit").show()
      this.$el.find(".monster__name--edit").show()

      this.pubSub =
        playersModal:
          init: ''
        playerModal:
          init: ''

      this.pubsub_remove()
      this.pubsub_init()

      PubSub.publish "MonsterModal.init"

      this

    pubsub_init: ->
      this.pubSub.playersModal.init = PubSub.subscribe "PlayersModal.init", $.proxy(this.removeModal, this)
      this.pubSub.playerModal.init = PubSub.subscribe "PlayerModal.init", $.proxy(this.removeModal, this)

      this

    pubsub_remove: ->
      PubSub.unsubscribe this.pubSub.playersModal.init
      PubSub.unsubscribe this.pubSub.playerModal.init

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

      PubSub.publish "MonsterModal.hide"
      
      this.$el

    saveNewMonster: (e) ->
      stats =
        "monster": this.$el.find(".input__monster").val()
        "ac": parseInt this.$el.find(".input__stat[stat='ac']").val()
        "hp": parseInt this.$el.find(".input__stat[stat='hp']").val()
        "speed": this.$el.find(".input__stat[stat='speed']").val()
        "xp": parseInt this.$el.find(".input__stat[stat='xp']").val()
        "str": this.$el.find(".input__stat[stat='str']").val()
        "dex": this.$el.find(".input__stat[stat='dex']").val()
        "con": this.$el.find(".input__stat[stat='con']").val()
        "int": this.$el.find(".input__stat[stat='int']").val()
        "wis": this.$el.find(".input__stat[stat='wis']").val()
        "cha": this.$el.find(".input__stat[stat='cha']").val()

      this.model.set stats

      this.model.save()
      this.removeModal()

      if this.existing == false
        app.Collections.Monster.push this.model
        app.Collections.Monster.sort()

  this
)(window.LKT)
