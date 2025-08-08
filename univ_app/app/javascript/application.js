// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
//import "@hotwired/turbo-rails"
import { Turbo } from "@hotwired/turbo-rails"
Turbo.session.drive = false
import "controllers"
import "jquery"
import "materialize"

$(document).ready(function() {
  // Initialize sidenav
  $('.sidenav').sidenav();
  
  // Initialize dropdown
  $('.dropdown-trigger').dropdown({
    constrainWidth: false,
    coverTrigger: false
  });
  
  function setupErrorMessages() {
    setTimeout(function() {
      $(".fade-out-target").fadeOut(500, function() {
        $(this).remove();
      });
    }, 5000);
    
    $(".fade-out-target button").on("click", function(e) {
      e.preventDefault();
      $(this).parent().fadeOut(500, function() {
        $(this).remove();
      });
    });
  }
  
  setupErrorMessages();
  
  $(document).on("turbo:load", function() {
    setupErrorMessages();
  });
});