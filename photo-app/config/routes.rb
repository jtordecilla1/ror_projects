Rails.application.routes.draw do
  resources :images
  get "my_photos", to: "images#show_user_images", as: :show_user_images
  devise_for :users, controllers: {
    registrations: 'registrations'
  }
  root 'welcome#index'
end
