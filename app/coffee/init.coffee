$ ((app) ->
  # utils
  app.Utils.guid = () ->
    # http://stackoverflow.com/a/105074
    s4 = () ->
      Math.floor((1 + Math.random()) * 0x10000).toString(16).substring(1)

    s4() + s4() + '-' + s4() + '-' + s4() + '-' +
      s4() + '-' + s4() + s4() + s4()

  # http://backbonejs.org/#Sync-emulateHTTP
  # this is only until we have a real REST server
  Backbone.emulateHTTP = true

  # http://naleid.com/blog/2012/10/29/overriding-backbone-js-sync-to-allow-cross-origin-resource-sharing-cors/
  proxiedSync = Backbone.sync

  Backbone.sync = (method, model, options) ->
    if typeof(options) == 'undefined'
      options = {}

    if !options.crossDomain
      options.crossDomain = true

    proxiedSync method, model, options

  # Define array of all template files
  templates = new Array "player", "monster", "base", "dm", "player_dm", "monster_dm",
    "player_sidebar", "monster_sidebar"

  # Load all template files into LKT.Templates
  _.each templates, (template) ->
    url = app.Config.templates_path + template + "." + app.Config.templates_type

    $.ajax
      url: url
      async: false
      dataType: "text"
      success: (data) ->
        app.Templates[template] = data
        this

  # Connect to our socket.io server
  app.socket = io "http://" + app.Config.socketio_server[app.Config.enviroment]
  this

)(window.LKT)
