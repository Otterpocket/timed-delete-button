class TDB

  constructor: ->
    attachEvents()

  attachEvents = ->
    button = $ '.tdb'
    pressTimer = 0
    $(button).mouseup ->
      clearTimeout pressTimer
      button.removeClass('deleting')

    $(button).mousedown ->
      btn_instance = @
      time_until_delete = getImportance(@)

      deleteAnimation(time_until_delete, btn_instance)
      pressTimer = setTimeout ->
        deleteOwner(btn_instance)
      ,time_until_delete

  deleteOwner = (button) ->
    $(button).parent('.tdb-object').fadeOut();

  getImportance = (button) ->
    importance = $(button).data('importance')
    return 200 unless importance
    $(button).data('importance') * 400

  deleteAnimation = (time, button) ->
    $(button).addClass 'deleting'

  getTimeLeft = (timeout) ->
    Math.ceil (timeout._idleStart + timeout._idleTimeout - Date.now()) / 1000

$ ->
  new TDB
