// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

$(document).ready(function(){
  
  // Prevent links from opening MobileSafari
  $('a').click(function(){
    window.location = $(this).attr('href');
    return false;
  });
  
  clear_selected = function(){
    $('#dots a.selected').removeClass('selected');
  }
  
  set_current_screen = function(screen) {
    $.ajax({
      url: "/api/set_current_screen",
      method: "POST",
      data: {screen: screen}
    });
    window.scrn = screen;
    clear_selected();
    $('#widget-' + screen).addClass('selected');
  }
  
  $('#dots a').click(function(){
    
    widget = $(this).attr('href').replace("#", "");
    
    set_current_screen(widget)
    
    $('#track').animate({left:-1*320*widget}, 500);
    return false;
  });
  // select widget 1 by default
  init_track = function(current_screen){
    scrn = 1;
    
    if (typeof(current_screen) == "number") {
      scrn = current_screen;
      window.scrn = current_screen;
    }
    
    $('#widget-' + scrn).addClass('selected');
    $('#track').animate({left:-1*320*scrn}, 0);
  }
  
  // handle "edit" press
  toggle_time = 220;
  $('a#settings_edit').toggle(function(){
    $(this).addClass('pressed');
    $(this).parent().parent().find('#my_widgets .buttonset').removeClass('hidden');
  }, function(){
    $(this).removeClass('pressed');
    $(this).parent().parent().find('#my_widgets .buttonset').addClass('hidden');
  });
  
  // if not installed do something
  check_installed = function() {
    uagent = navigator.userAgent.toLowerCase();
    mobile_safari = false;
    if (uagent.search("iphone") > -1) {
      mobile_safari = true;
    }
    if (window.navigator.standalone || !mobile_safari) {
      // installed
    } else {
      if (window.location.pathname != "/") {
        alert('Please return to installed version of the app');
      }
    }
  }
  check_installed();
  
  //Prevent touchmove normally
  if (typeof(ignore_prevent_default) == "undefined") {
    $('body').bind("touchmove", function(event){
      event.preventDefault();
    });
  }
  
});