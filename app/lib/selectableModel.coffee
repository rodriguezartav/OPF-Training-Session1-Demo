#MAKES AN OBJECT BE SELECTABLE INDIVIDUALLY AND LOCKED IF NECESSARY
#FOR EXAMPLE, WHEN DOING OPERATIONS ON A CUSTOMER; IT NEEDS TO BE SELECTED IN A "SINGLETON" OF ITS CLASS AND BLOCKED SO IT NEEDS TO BE 
#RESET IN ORDER TO BE CHANGED

Spine ?= require('spine')

Spine.Model.SelectableModel =

  extended: ->

    @extend
    
      current: null

      set_current: (item,lock = false) =>
        result = false
        if lock == false and @locked == false
          @current = item
          @trigger('current_set' , @current)
          @locked = true if lock
          result = true
        return result

      reset: =>
        @reset_current()

      reset_current: =>
        @locked = false
        @current = null
        @trigger('current_reset' , @current)
      
      queryToRegex: (query) ->
        str = ""
        words = query.split(" ")
        for word in words
          str += word
          str += "|"
        str = str.slice(0, -1)

      filterFunction: (query,item) =>
        return false if item.Activo == false
        myRegExp =new RegExp( @queryToRegex(query),'gi')
        item.name.search(myRegExp) > -1

      filter: (query,filterFunction=@filterFunction ) =>
        return @all() unless query
        query = query.toLowerCase()
        @select (item) =>
          result = filterFunction(query,item)
          return result

module?.exports = Spine.Model.SelectableModel
