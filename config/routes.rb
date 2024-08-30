Rails.application.routes.draw do
  # Devise routes for user authentication
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations',
    confirmations: 'users/confirmations',
    omniauth_callbacks: 'users/omniauth_callbacks'
  }

  # OmniAuth callback routes
  get '/users/auth/:provider/callback', to: 'users/omniauth_callbacks#handle_callback', as: :omniauth_callback

  # Devise scope for custom OTP routes
  devise_scope :user do
    get 'verify_otp/:id', to: 'users/registrations#verify_otp', as: :verify_otp_user_registration
    post 'confirm_otp/:id', to: 'users/registrations#confirm_otp', as: :confirm_otp_user_registration
  end

  # Health check route
  get "up" => "rails/health#show", as: :rails_health_check

  # Define additional application routes here
  resources :profiles, only: [:index, :show, :edit, :update]

  # Add the route for the Buy Premium page
  get 'buy_premium', to: 'premium#buy', as: 'buy_premium'

  # Payment routes
  resources :payments, only: [:new, :create]
  get 'payments/success', to: 'payments#success', as: 'payment_success'

  # Root path
  root "home#index"
end
