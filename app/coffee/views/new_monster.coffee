$ ((app) ->
  app.Views.NewMonster = app.Views.Monster.extend
    tagName: "div"
    className: "new-monster"
    existing: false

    events:
      "click .glyphicon-floppy-save": "saveNewMonster"
      "click .glyphicon-remove": "removeModal"

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

      this

    removeModal: (e) ->
      this.$el.remove()

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
