$ ((app) ->
  app.Collections.Player = Backbone.Collection.extend
    model: app.Models.Player
    url: 'http://' + app.Config.api_server[app.Config.enviroment] + '/players'
    comparator: (model) ->
      model.get("character")

  this
)(window.LKT)
