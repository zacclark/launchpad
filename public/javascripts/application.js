// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

$(document).ready(function(){
  
  // Prevent links from opening MobileSafari
  $('a').click(function(){
    window.location = $(this).attr('href');
    return false;
  });
  
  // Prevent touchmove normally
  $('body').bind("touchmove", function(event){
    event.preventDefault();
  });
  
});