Rails.application.routes.draw do
  resources :user_stocks, only: [:create, :destroy]
  devise_for :users
  root "pages#home"
  get "my_portfolio", to: "users#my_portfolio"
  get "search_stock", to: "stocks#search"
  get "my_friends", to: "users#my_friends"
  get "search_friend", to: "users#search_friend"
  post "add_friend", to: "friendship#add_friend"
  delete "remove_friend", to: "friendship#remove_friend"
  get "users/:id", to: "users#show", as: "user_profile"

end