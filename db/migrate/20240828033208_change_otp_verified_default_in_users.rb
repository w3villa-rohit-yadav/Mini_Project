class ChangeOtpVerifiedDefaultInUsers < ActiveRecord::Migration[7.1]
  def change
    change_column_default :users, :otp_verified, false
  end
end
