// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require_tree .
//= require paloma
$(document).ready(function() {
  console.log('jQuery ready!');
  Paloma.start();
  /*
  $('#myTopnav a').click(function(e){
    e.preventDefault();
    e.stopPropagation();
  });
  */
})
$(document).on('page:restore', function(){
  Paloma.start();
});

Paloma.controller('Members', {
  index: function(){
    // Executes when Rails Members#index is executed.
    highlight('home');
  },
  new: function(){ highlight('member'); },
  create: function(){ highlight('member'); },
  show: function(){ highlight('member'); },
  edit: function(){ highlight('member'); },
});

Paloma.controller('Search', {
  index: function(){
    // Executes when Rails Members#index is executed.
    highlight('search');
  }
});

