class Users::RegistrationsController < Devise::RegistrationsController
  before_action :configure_sign_up_params, only: [:create]

  # Override Devise's create action
  def create
    build_resource(sign_up_params)

    otp_code = rand(100000..999999).to_s
    resource.otp = otp_code
    resource.send_otp_code     # Send OTP code to the user's phone number

    if resource.save
      resource.update(otp_verified: false, otp: otp_code) # Mark OTP as not verified yet
      redirect_to verify_otp_user_registration_path(resource) # Redirect to OTP verification page
    else
      clean_up_passwords resource
      set_minimum_password_length
      respond_with resource
    end
  end

  # Display OTP verification form
  def verify_otp
    @user = User.find(params[:id])
    # Render the verification form
  end

  # Handle OTP confirmation
  def confirm_otp
    @user = User.find(params[:id])
    if @user.otp == params[:otp_code]
      @user.update(otp_verified: true) # Ensure you have this attribute in the User model
      sign_in_and_redirect @user
    else
      flash[:alert] = 'Invalid OTP code'
      render :verify_otp
    end
  end

  protected

  # Redirect after sign up
  def after_sign_up_path_for(resource)
    verify_otp_user_registration_path(resource) # Redirect to OTP verification after signup
  end

  # Permit additional parameters for sign up
  def configure_sign_up_params
    devise_parameter_sanitizer.permit(:sign_up, keys: [:profile_picture, :phone_number, :otp_code])
  end

  private

  # Permit additional parameters for OTP confirmation
  def otp_params
    params.require(:user).permit(:otp_code)
  end
end
