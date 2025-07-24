Rails.application.routes.draw do
  root 'pages#home'
  get 'about', to: 'pages#about'
  resources :articles
  #resources :articles, only: [:show, :index, :new, :create, :edit, :update, :destroy]
  get 'signup', to: 'users#new'
  resources :users, except: [:new]
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  # delete method doesnt works! it says: No route matches [GET] "/logout"
  get 'logout', to: 'sessions#destroy'
  resources :categories, except: [:destroy]
end
