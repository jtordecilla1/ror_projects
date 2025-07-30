// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"
import "jquery"

// Add this for Rails UJS to work with remote: true
import Rails from "@rails/ujs"
Rails.start()

