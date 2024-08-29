class AddOtpCodeToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :otp_code, :string
  end
end
