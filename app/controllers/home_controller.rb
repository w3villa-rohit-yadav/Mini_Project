class HomeController < ApplicationController
  def index
    if user_signed_in?
      @user_subscription = current_user.subscriptions.last
    end
  end
end
