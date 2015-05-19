$ ((app) ->
  app.Collections.Game = Backbone.Collection.extend
    comparator: (model) ->
      parseInt -model.get("initiative")

  this
)(window.LKT)
