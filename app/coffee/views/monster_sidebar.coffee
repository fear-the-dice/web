$ ((app) ->
  app.Views.MonsterSidebar = Backbone.View.extend
    tagName: "div"
    className: "sidebar__monster"

    events:
      "click .glyphicon-remove": "deleteMonster"
      "click .glyphicon-pencil": "editMonster"
      "click .glyphicon-chevron-right": "addMonster"

    initialize: (model) ->
      this.template = app.Templates.monster_sidebar
      this.model = model
      this.render()
      this

    render: ->
      this.$el.html Mustache.render this.template, this.model.toJSON()
      this.$el.addClass "text-center row"
      this.$el

    editMonster: ->
      view = new app.Views.NewMonster this.model
      $(".base").prepend view.$el
      view.postRender()

      this.model

    addMonster: ->
      model = this.model.clone()
      model.set "id", app.Utils.guid()
      model.set "duplicate", true
      model.set "playing", true
      app.socket.emit "NewMonster", JSON.stringify model.toJSON()
      new app.Views.MonsterDM model
      app.Collections.Game.add model

    deleteMonster: ->
      this.model.destroy()

  this
)(window.LKT)
