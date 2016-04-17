var TDB;

TDB = (function() {
  var attachEvents, deleteAnimation, deleteOwner, getDeleteTime, getTimeLeft, progress;

  function TDB() {
    attachEvents();
  }

  attachEvents = function() {
    var $button, pressTimer;
    $button = $('.td-button');
    pressTimer = 0;
    $button.mouseup(function() {
      clearTimeout(pressTimer);
      $button.removeClass('deleting');
      return $('#progress_bar').remove();
    });
    return $button.mousedown(function() {
      var btn_instance, time_until_delete;
      btn_instance = this;
      time_until_delete = getDeleteTime(this);
      deleteAnimation(time_until_delete, btn_instance);
      return pressTimer = setTimeout(function() {
        return deleteOwner(btn_instance);
      }, time_until_delete);
    });
  };

  deleteOwner = function(button) {
    return $(button).parent('.td-object').fadeOut();
  };

  getDeleteTime = function(button) {
    var importance;
    importance = $(button).data('importance');
    if (!importance) {
      return 200;
    }
    return $(button).data('importance') * 400;
  };

  deleteAnimation = function(time, button) {
    $(button).addClass('deleting');
    $(button).before('<div id="progress_bar"><div></div></div>');
    return progress(time, $(button).prev('#progress_bar'), 100);
  };

  getTimeLeft = function(timeout) {
    return Math.ceil((timeout._idleStart + timeout._idleTimeout - Date.now()) / 1000);
  };

  progress = function(time, $element, percent) {
    var progress_barWidth;
    progress_barWidth = percent * $element.width() / percent;
    return $element.find('div').animate({
      width: progress_barWidth
    }, time, "linear");
  };

  return TDB;

})();

$(function() {
  return new TDB;
});
