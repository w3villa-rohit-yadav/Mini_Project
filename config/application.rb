require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module YourAppName
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 7.0

    # Configuration for the application, engines, and railties goes here.
    # These settings can be overridden in specific environments using the files
    # in config/environments.

    # Enable asset pipeline
    config.assets.enabled = true

    # Add the path to the stylesheets directory
    config.assets.paths << Rails.root.join('app', 'assets', 'stylesheets')

    # Ensure the application uses Dart Sass
    config.sass.preferred_syntax = :scss
  end
end
