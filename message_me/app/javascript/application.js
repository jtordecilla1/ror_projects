// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"
import "jquery"
import "semantic-ui-sass"
import "channels"

// Initialize Semantic UI components on page load and Turbo navigation
document.addEventListener('DOMContentLoaded', initializeSemanticUI)
document.addEventListener('turbo:load', initializeSemanticUI)

window.scroll_bottom = function() {
  setTimeout(() => {
    const container = document.getElementById("message-container");
    if (container) {
      container.scrollTop = container.scrollHeight;
    }
  }, 100);
}

function initializeSemanticUI() {
  
  // Check if jQuery is available
  if (typeof $ !== 'undefined') {
    // Initialize dropdowns
    $('.ui.dropdown').dropdown()
    
    // Initialize other Semantic UI components as needed
    $('.ui.modal').modal()
    $('.ui.accordion').accordion()
    $('.ui.popup').popup()
    $('.ui.checkbox').checkbox()
    $('.ui.progress').progress()
  }
  
  // Always try to scroll to bottom
  window.scroll_bottom();
}