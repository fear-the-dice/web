$ ((app) ->
  app.Collections.Monster = Backbone.Collection.extend
    model: app.Models.Monster
    url: app.Config.api_server[app.Config.enviroment] + '/monsters'
    comparator: (model) ->
      model.get("monster")

  this
)(window.LKT)
