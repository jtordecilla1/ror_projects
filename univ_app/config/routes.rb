Rails.application.routes.draw do
  root "courses#index"
  resources :courses, except: [:destroy]
  resources :student_courses, only: [:create]
  get "about", to: "pages#about"
  get "login", to: "sessions#new"
  post "login", to: "sessions#create"
  delete "logout", to: "sessions#destroy", as: "logout"
  resources :students, except: [:destroy]
end
