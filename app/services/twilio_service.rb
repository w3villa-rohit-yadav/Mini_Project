# app/services/twilio_service.rb
require 'twilio-ruby'

class TwilioService
  def initialize
    @client = Twilio::REST::Client.new(
      ENV['TWILIO_ACCOUNT_SID'],
      ENV['TWILIO_AUTH_TOKEN']
    )
  end

  def send_otp(phone_number, otp_code)

    formatted_phone_number = format_phone_number(phone_number)
    @client.messages.create(
      from: ENV['TWILIO_PHONE_NUMBER'],
      to: "+917985548852",
      body: "Your OTP code is #{otp_code}"
    )
  rescue Twilio::REST::RestError => e
    Rails.logger.error "Twilio error: #{e.message}"
  end

  private

  def format_phone_number(phone_number)
    # Use a basic formatting approach if PhonyRails is not working
    phone_number.gsub(/\D/, '') # Remove all non-digit characters
  end
end
