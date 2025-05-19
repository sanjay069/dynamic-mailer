Rails.application.routes.draw do
  # Mount Devise for AdminUser once with ActiveAdmin config
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  # Devise for regular users
  devise_for :users

  # Health check route
  get "up" => "rails/health#show", as: :rails_health_check

  # API routes
  namespace :api do
    post 'signup', to: 'auth#signup'
    post 'login', to: 'auth#login'

    resources :templates, only: [:index]
    resources :languages, only: [:index]
    post 'send_email', to: 'email#send_email'
  end

  # Defines the root path route ("/")
  # root "posts#index"
end
