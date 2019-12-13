/**
 * Window Modal handlers
 */
function showModal() {
  $('#main-window').hide();
  $('#modal-window').show();
  $('#notice').hide();
}

function hideModal() {
  console.log("hideModal()", $('#modal-window'));
  if ($('#modal-window').length > 0) {
	  $('#modal-window').hide();
	  $('#main-window').show();  
  } else {
  	window.history.back();
  }
}

function highlight(id) {
  $("#myTopnav a").removeClass("active");
  $("a#" + id).addClass("active");
}

