class TDB

  constructor: ->
    attachEvents()

  attachEvents = ->
    $button = $ '.td-button'
    pressTimer = 0
    $button.mouseup ->
      clearTimeout pressTimer
      $button.removeClass('deleting')
      $('#progress_bar').remove()

    $button.mousedown ->
      btn_instance = @
      time_until_delete = getDeleteTime(@)

      deleteAnimation(time_until_delete, btn_instance)
      pressTimer = setTimeout ->
        deleteOwner(btn_instance)
      ,time_until_delete

  deleteOwner = (button) ->
    $(button).parent('.td-object').fadeOut()

  getDeleteTime = (button) ->
    importance = $(button).data('importance')
    return 200 unless importance
    $(button).data('importance') * 400

  deleteAnimation = (time, button) ->
    $(button).addClass 'deleting'
    $(button).before('<div id="progress_bar"><div></div></div>')
    progress(time, $(button).prev('#progress_bar'), 100)

  getTimeLeft = (timeout) ->
    Math.ceil (timeout._idleStart + timeout._idleTimeout - Date.now()) / 1000

  progress = (time, $element, percent) ->
    progress_barWidth = percent * $element.width() / percent
    $element.find('div').animate({ width: progress_barWidth }, time, "linear")

$ ->
  new TDB
