require('lib/setup')
Spine = require('spine')
Product = require("models/product")
ProductBar = require('controllers/productBar')
SocketManager = require('lib/socketManager')

class App extends Spine.Controller

  constructor: ->
    super
    new SocketManager()
    Product.mock() #for productos
    @append new ProductBar()

module.exports = App
    