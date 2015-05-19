$ ((app) ->
  app.Views.MonsterSidebar = Backbone.View.extend
    tagName: "div"
    className: "sidebar__monster"

    events:
      "click i": "addMonster"

    initialize: (model) ->
      this.template = app.Templates.monster_sidebar
      this.model = model
      this.render()
      this

    render: ->
      this.$el.html Mustache.render this.template, this.model.toJSON()
      this.$el.addClass "text-center row"
      this.$el

    addMonster: ->
      this.model.set "playing", true
      app.socket.emit "NewMonster", JSON.stringify this.model.toJSON()
      new app.Views.MonsterDM this.model
      app.Collections.Game.add this.model

  this
)(window.LKT)
