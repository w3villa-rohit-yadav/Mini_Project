# app/mailers/previews/user_mailer_preview.rb
class UserMailerPreview < ActionMailer::Preview
    # Preview email for confirmation instructions
    def confirmation_instructions
      user = User.first # Fetch the first user from the database
      token = "sample-token" # Use a sample token for preview
      UserMailer.confirmation_instructions(user, token)
    end
  end
  