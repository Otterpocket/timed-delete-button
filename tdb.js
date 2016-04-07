var TDB;

TDB = (function() {
  var attachEvents, deleteAnimation, deleteOwner, getImportance, getTimeLeft;

  function TDB() {
    attachEvents();
  }

  attachEvents = function() {
    var button, pressTimer;
    button = $('.tdb');
    pressTimer = 0;
    $(button).mouseup(function() {
      clearTimeout(pressTimer);
      return button.removeClass('deleting');
    });
    return $(button).mousedown(function() {
      var btn_instance, time_until_delete;
      btn_instance = this;
      time_until_delete = getImportance(this);
      deleteAnimation(time_until_delete, btn_instance);
      return pressTimer = setTimeout(function() {
        return deleteOwner(btn_instance);
      }, time_until_delete);
    });
  };

  deleteOwner = function(button) {
    return $(button).parent('.tdb-object').fadeOut();
  };

  getImportance = function(button) {
    var importance;
    importance = $(button).data('importance');
    if (!importance) {
      return 200;
    }
    return $(button).data('importance') * 400;
  };

  deleteAnimation = function(time, button) {
    return $(button).addClass('deleting');
  };

  getTimeLeft = function(timeout) {
    return Math.ceil((timeout._idleStart + timeout._idleTimeout - Date.now()) / 1000);
  };

  return TDB;

})();

$(function() {
  return new TDB;
});
