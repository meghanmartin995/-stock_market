Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  post "/", to: 'pages#home'
  resources :stocks, only: [:index, :show, :create]
  get "/dashboard", to: 'pages#dashboard'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
