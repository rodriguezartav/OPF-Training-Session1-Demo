Product = require('models/product')
Spine = require('spine')

class Item extends Spine.Controller
  tag: "li"
  className: "span3"

  events:
    "click .btn_remove_todo" : "onRemoveTodo"
    
  elements: 
    ".popable" : "popable"

  constructor: ->
    super
    Product.bind "change update" , @render
    @render()
    
  render: =>
    @popable.popover('hide')
    @html require("views/productBar/item")(@product)
    @popable.popover()
    

class ProductBar extends Spine.Controller
  className: "productBar"

  elements:
    "input" : "txt_query"
    ".productos_list"  : "productos_list"

  events:
    "click .btn_add_todo" : "onAddTodo"
    "change .txt_query"   : "onChange"
    "click .search"       : "onClick"

  constructor: ->
    super
    Product.mock()
    @html require("views/productBar/layout")
    @productos_list.hide()

  onClick: (e) ->
    link = $(e.target)
    query = link.attr("data-query") 
    @txt_query.val query
    @search(query)

  onChange: (e) ->
    textbox = $(e.target)
    @search(textbox.val())

  search: (query) ->
    @productos_list.show()
    @productos_list.empty()
    productos = Product.filter query
    for product in productos
      @productos_list.append new Item(product: product).el


module.exports = ProductBar