Rails.application.routes.draw do
  root "courses#index"
  get "courses/new", to: "courses#new", as: "new_course"
  get 'about', to: 'pages#about'
  resources :students, except: [:destroy]
end
