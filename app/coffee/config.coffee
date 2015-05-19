@LKT =
  Router: {}
  Views: {}
  Utils: {}
  Models: {}
  Collections: {}
  Templates: {}
  Players: []
  Config:
    enviroment: 'production'
    templates_path: 'templates/'
    templates_type: 'html'
    socketio_server:
      local: 'localhost:1347'
      production: 'keepiteasy.net:1347'
    api_server:
      local: 'localhost:3000'
      production: 'keepiteasy.net:3000'
