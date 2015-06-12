$ ((app) ->
  app.Views.NewMonster = app.Views.Monster.extend
    tagName: "div"
    className: "new-monster"

    events:
      "click .glyphicon-floppy-save": "saveMonster"
      "click .glyphicon-remove": "removeModal"

    initialize: (model) ->
      console.log app.Templates
      this.template = app.Templates.new_monster
      console.log this.template
      this.model = model
      this.model.view = this
      this.open = false

      _.bindAll this, "render"
      this.model.bind "change", $.proxy(this.change, this)
      this.render()

      this.$el.find(".monster__stat--edit").show()
      this.$el.find(".monster__name--edit").show()

      this

    removeModal: () ->
      this.$el.remove()

    saveMonster: () ->
      # get values from each input

      this.model.set "monster", this.$el.find(".input__monster").val()
      this.model.set "initiative", this.$el.find(".input__stat[stat='initiative']").val()
      this.model.set "ac", parseInt this.$el.find(".input__stat[stat='ac']").val()
      this.model.set "hp", parseInt this.$el.find(".input__stat[stat='hp']").val()
      this.model.set "speed", this.$el.find(".input__stat[stat='speed']").val()
      this.model.set "xp", parseInt this.$el.find(".input__stat[stat='xp']").val()
      this.model.set "str", this.$el.find(".input__stat[stat='str']").val()
      this.model.set "dex", this.$el.find(".input__stat[stat='dex']").val()
      this.model.set "con", this.$el.find(".input__stat[stat='con']").val()
      this.model.set "int", this.$el.find(".input__stat[stat='int']").val()
      this.model.set "wis", this.$el.find(".input__stat[stat='wis']").val()
      this.model.set "cha", this.$el.find(".input__stat[stat='cha']").val()

      console.log this.model

      this.model.save()
      this.removeModal()

      app.Collections.Monster.push this.model
      app.Collections.Monster.sort()

  this
)(window.LKT)
