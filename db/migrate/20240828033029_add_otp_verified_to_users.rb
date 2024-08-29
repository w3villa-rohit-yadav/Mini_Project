class AddOtpVerifiedToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :otp_verified, :boolean
  end
end
