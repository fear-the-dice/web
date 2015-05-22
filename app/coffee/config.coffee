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
      production: 'fear-the-dice-socket.herokuapp.com'
    api_server:
      local: 'localhost:3000'
      production: 'fear-the-dice-api.herokuapp.com'
