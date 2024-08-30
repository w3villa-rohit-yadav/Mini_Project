# config/initializers/omniauth.rb
Rails.application.config.middleware.use OmniAuth::Builder do
  OmniAuth.config.allowed_request_methods = [:post, :get]

  # Google OAuth2 provider
  provider :google_oauth2, ENV['GOOGLE_CLIENT_ID'], ENV['GOOGLE_CLIENT_SECRET'], {
    provider_ignores_state: true,
    scope: 'email, profile',
    prompt: 'select_account'
  }

  # GitHub provider
  provider :github, ENV['GITHUB_CLIENT_ID'], ENV['GITHUB_CLIENT_SECRET']

  # Add other providers here as needed
  # provider :twitter, ENV['TWITTER_API_KEY'], ENV['TWITTER_API_SECRET']
end
