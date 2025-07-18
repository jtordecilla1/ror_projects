Rails.application.routes.draw do
  resources :users
  resources :articles
  #root 'application#hello'
  root 'pages#home'
  get 'about', to: 'pages#about'
end
