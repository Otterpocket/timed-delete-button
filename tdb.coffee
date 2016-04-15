class TDB

  constructor: ->
    attachEvents()

  attachEvents = ->
    $button = $ '.td-button'
    pressTimer = 0
    $button.mouseup ->
      clearTimeout pressTimer
      $button.removeClass('deleting')

    $button.mousedown ->
      btn_instance = @
      time_until_delete = getImportance(@)

      deleteAnimation(time_until_delete, btn_instance)
      pressTimer = setTimeout ->
        deleteOwner(btn_instance)
      ,time_until_delete

  deleteOwner = (button) ->
    $(button).parent('.td-object').fadeOut();

  getImportance = (button) ->
    importance = $(button).data('importance')
    return 200 unless importance
    $(button).data('importance') * 400

  deleteAnimation = (time, button) ->
    $(button).addClass 'deleting'
    progress_bar = $(button).prev('#progressBar')
    progress(time, progress_bar, 100)

  getTimeLeft = (timeout) ->
    Math.ceil (timeout._idleStart + timeout._idleTimeout - Date.now()) / 1000

  progress = (time, $element, percent) ->
    progressBarWidth = percent * $element.width() / percent
    $element.find('div').animate({ width: progressBarWidth }, time, "linear")

$ ->
  new TDB
