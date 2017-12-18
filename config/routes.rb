Rails.application.routes.draw do

  devise_for :registrations, :controllers => { registrations: "registrations"}
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :registrations, :controllers => {
    registrations: "registrations/registrations",
    omniauth_callbacks: 'registrations/omniauth_callbacks'
  }

  resources :users, only: [ :show, :edit, :update ]

  resources :items, only: [ :new, :edit, :update, :create, :destroy ]

  get '/user_dashboard', to: 'items#user_items'

  get '/wish_list', to: 'items#wish_list'

  get '/netaporter', to: "items#netaporter"

  get '/toggle_favorite', to: "items#toggle_favorite"

  root to: 'pages#home'
  resources :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

