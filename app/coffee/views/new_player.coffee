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

      this

    removeModal: (e) ->
      if this.open is true
        this.open = false
        this.$el.slideUp (e) ->
          this.$el.remove()
          view = new app.Views.Players()
          $(".base").prepend view.$el
          view.postRender()
      else
        this.$el.remove()

      this.$el

    saveNewPlayer: (e) ->
      stats =
        "character": this.$el.find(".input__character").val()
        "name": this.$el.find(".input__player").val()
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
        app.Collections.Player.push this.model
        app.Collections.Player.sort()

  this
)(window.LKT)
