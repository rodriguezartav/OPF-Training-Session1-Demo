Spine = require('spine')

class SocketManager

  constructor: (@url) ->
    @connect() if navigator.onLine

  connect: =>
    @pusher = new Pusher(Spine.pusherKey) 
    
    @channel = @pusher.subscribe('data_push')

    for m in Spine.socketModels
      if m.autoPush
        className = m.className         
        @channel.bind "#{className}" , m.updateFromSocket


module.exports = SocketManager