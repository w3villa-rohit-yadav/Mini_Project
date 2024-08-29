# config/initializers/omniauth.rb
Rails.application.config.middleware.use OmniAuth::Builder do
  OmniAuth.config.allowed_request_methods = [:post, :get]
  provider :google_oauth2,ENV['GOOGLE_CLIENT_ID'],ENV['GOOGLE_CLIENT_SECRET'], {
    provider_ignores_state: true,
    scope: 'email, profile',
    prompt: 'select_account'
  }
end
