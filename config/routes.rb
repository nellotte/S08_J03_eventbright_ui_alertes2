Rails.application.routes.draw do

  root 'events#index'
  get 'static_pages/secret'
  resources :events
  devise_for :users
  resources :users, only: [:show]

  resources :charges

  #root 'orders#new'
  resources :orders, only: [:new, :create]

  scope '/checkout' do
    post 'create', to: 'checkout#create', as: 'checkout_create'
    get 'success', to: 'checkout#success', as: 'checkout_success'
    get 'cancel', to: 'checkout#cancel', as: 'checkout_cancel'
end

namespace :website_administrator do
  resources :users
  root to: 'users#index'
end

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  #root to: 'static_pages#index'
end
