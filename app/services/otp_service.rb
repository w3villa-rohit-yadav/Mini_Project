class OtpService
    def initialize(phone_number, otp_code)
      @phone_number = phone_number
      @otp_code = otp_code
    end
  
    def send_otp
      client = Twilio::REST::Client.new
  
      client.messages.create(
        from: ENV['TWILIO_PHONE_NUMBER'],  # Your Twilio phone number
        to: @phone_number,
        body: "Your OTP code is #{@otp_code}"
      )
    end

#     def create
#         @user = User.find_by(id: params[:user_id])
#         if @user&.verify_otp_code(params[:otp_code])
#           @user.update(otp_code: nil, otp_verified: true)
#           flash[:notice] = 'Phone number verified successfully.'
#         #   redirect_to root_path, notice: 'Welcome!' # Redirect to the desired path after successful verification
#         else
#           flash[:alert] = 'Invalid OTP. Please try again.'
#           render :new
#         end
#       end
#   end
  