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
    $("a#connect").hide();
    $("a#search").hide();
  },
  new: function(){ 
    highlight('member');
    $("a#connect").hide();
    $("a#search").hide();
  },
  create: function(){ 
    highlight('member');
    $("a#connect").hide(); 
  },
  show: function(){ 
    highlight('member'); 
    $("a#connect").show();
    $("a#search").show();
  },
  edit: function(){ 
    highlight('member'); 
    $("a#connect").show();
    $("a#search").show();
  },
});

Paloma.controller('Friendships', {
  select: function(){ 
    highlight('connect');
  }
});

Paloma.controller('Search', {
  index: function(){ highlight('search'); },
  show: function(){ highlight('search'); },
  create: function(){ highlight('search'); },
  member: function(){ highlight('search'); }
});

