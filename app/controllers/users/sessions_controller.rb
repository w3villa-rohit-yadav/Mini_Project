# app/controllers/users/sessions_controller.rb

class Users::SessionsController < Devise::SessionsController
    # Override Devise's destroy action to set a flash message and redirect
    def destroy
      super do
        flash[:notice] = 'You have successfully signed out.'
        redirect_to new_user_session_path and return
      end
    end
  end
  