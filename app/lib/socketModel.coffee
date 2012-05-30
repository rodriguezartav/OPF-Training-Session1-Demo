Spine ?= require('spine')
Spine.socketModels = [] if !Spine.socketModels

Spine.Model.SocketModel =

  extended: ->
    @change @saveLocal
    @bind "query_success" , @saveLocal
    @fetch @loadLocal
    Spine.socketModels.push @
    
    @extend
      autoPush             :   false
      
      ##SOCKETS ***************************

      updateFromSocket: (message) =>
        message = @parsePushMessage(message) if @parsePushMessage
        @refresh message
        @trigger "push_success" 
        return false

      beforeSaveLocal: ->
        return false;
      
      afterLoadLocal: ->
        return false;
    
      recordLastUpdate: =>
        Spine.session.setLastUpdate(@name)

  saveLocal: ->
    @beforeSaveLocal()
    result = JSON.stringify(@)
    localStorage[@className] = result

  loadLocal: ->
    result = localStorage[@className]
    @refresh(result or [], clear: true)
    @afterLoadLocal()

module?.exports = Spine.Model.SocketModel
