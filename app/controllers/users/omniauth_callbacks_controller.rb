class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController

    skip_before_action :verify_authenticity_token
    skip_forgery_protection



    def google_oauth2

    auth = request.env['omniauth.auth']
    user = User.find_by(email: auth.info.email)
    if user.present?
      @user=user
    else
      @user = User.from_omniauth(auth)
    end
  
      Rails.logger.debug("OmniAuth state: #{request.env['omniauth.params']['state']}")
    Rails.logger.debug("Session state: #{session['omniauth.state']}")
      if @user.persisted?
        # Sign in and redirect the user
        sign_in_and_redirect @user, event: :authentication
        # Set flash message if navigational format
        set_flash_message(:notice, :success, kind: 'Google') if is_navigational_format?
        # Redirect to the sign-out route
        # redirect_to destroy_user_session_path
      else
        # Store data in session for re-use
        session['devise.google_data'] = request.env['omniauth.auth'].except('extra')
        # Redirect to the registration page with error message
        redirect_to new_user_registration_url, alert: @user.errors.full_messages.join("\n")
      end
    end
    
    def failure
      # Handle failure
      Rails.logger.error("OmniAuth failure: #{request.env['omniauth.error.type']}")

      redirect_to root_path
    end
  end
  