$ ((app) ->
  app.Collections.Player = Backbone.Collection.extend
    model: app.Models.Player
    url: 'http://' + app.Config.api_server[app.Config.enviroment] + '/players'
    comparator: (model) ->
      parseInt -model.get("initiative")

  this
)(window.LKT)
