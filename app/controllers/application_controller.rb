class ApplicationController < ActionController::Base
    before_action :store_location, if: :storable_location?
    before_action :configure_permitted_parameters, if: :devise_controller?
  
    private
  
    def store_location
      # Store the location unless it's a Devise controller action
      store_location_for(:user, request.fullpath) if user_signed_in?
    end
  
    def storable_location?
      # Define which paths to store as storable locations
      request.get? && !request.xhr? && !devise_controller?
    end
  
    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up, keys: [:phone_number])
      devise_parameter_sanitizer.permit(:account_update, keys: [:phone_number])
    end
  end
  