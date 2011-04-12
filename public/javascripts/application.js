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
    
    $.ajax({
      url: "/api/set_current_screen",
      method: "POST",
      data: {screen: widget}
    });
    
    $('#track').animate({marginLeft:-1*320*widget}, 500);
    clear_selected();
    $('#widget-' + widget).addClass('selected');
    return false;
  });
  // select widget 1 by default
  init_track = function(current_screen){
    scrn = 1;
    
    if (typeof(current_screen) == "number") {
      scrn = current_screen;
    }
    
    $('#widget-' + scrn).addClass('selected');
    $('#track').animate({marginLeft:-1*320*scrn}, 0);
  }
  
  // handle "edit" press
  toggle_time = 220;
  $('a#settings_edit').toggle(function(){
    $(this).addClass('pressed');
    $(this).parent().parent().find('.button.delete').removeClass('hidden');
  }, function(){
    $(this).removeClass('pressed');
    $(this).parent().parent().find('.button.delete').addClass('hidden');
  });
  
  // Prevent touchmove normally
  $('body').bind("touchmove", function(event){
    event.preventDefault();
  });
  
});