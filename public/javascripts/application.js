// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

$(document).ready(function(){
  
  // Prevent links from opening MobileSafari
  $('a').click(function(){
    window.location = $(this).attr('href');
    return false;
  });
  
  $('#dots a').click(function(){
    clear_selected = function(){
      $('#dots a.selected').removeClass('selected');
    }
    
    widget = $(this).attr('href').replace("#", "");
    $('#track').animate({marginLeft:-1*320*widget}, 500);
    clear_selected();
    $('#widget-' + widget).addClass('selected');
    return false;
  });
  // select widget 1 by default
  init_track = function(){
    $('#widget-1').addClass('selected');
    $('#track').animate({marginLeft:-1*320*1}, 0);
  }
  
  // Prevent touchmove normally
  $('body').bind("touchmove", function(event){
    event.preventDefault();
  });
  
});