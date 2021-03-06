Rails.application.routes.draw do

  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :registrations, :controllers => {
    registrations: "registrations/registrations",
    omniauth_callbacks: 'registrations/omniauth_callbacks'
  }

  resources :users, only: [ :show, :edit, :update ]

  resources :items, only: [ :new, :edit, :update, :create, :destroy ]

  get '/user_dashboard', to: 'items#user_items'

  get '/wish_list', to: 'items#wish_list'

  post '/toggle_favorite', to: "items#toggle_favorite"


  get '/facebook_login', to: "items#facebook_login"

  post "/update_new_notifications", to: "items#update_new_notifications", as: "update_new_notifications"

  post "/update_notification", to: "items#update_notification", as: "update_notification"

  root to: 'pages#home'
  resources :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

