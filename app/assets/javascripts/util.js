/**
 * Window Modal handlers
 */
function showModal() {
  $('#main-window').hide();
  $('#modal-window').show();
  $('#notice').hide();
}
function hideModal() {
  $('#modal-window').hide();
  $('#main-window').show();
}

function highlight(id) {
  $("#myTopnav a").removeClass("active");
  $("a#" + id).addClass("active");
}

