Pusher = require('node-pusher');

class Pusherino

  constructor: ->
    @pusher = new Pusher
      appId: process.env.PUSHER_APPID
      key: process.env.PUSHER_KEY
      secret: process.env.PUSHER_SECRET

  mock: =>
    @pusher.trigger "data_push", "Product" , { amount: parseInt(Math.random() * 10 ) }  

module.exports = Pusherino
