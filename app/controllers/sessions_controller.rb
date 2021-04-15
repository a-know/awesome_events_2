class SessionsController < ApplicationController
    skip_before_action :authenticate, only: :create

  def create
    user = User.find_or_create_from_auth_hash!(request.env["omniauth.auth"])
    session[:user_id] = user.id
    redirect_to root_path, notice: "Logged-in successfully."
  end

  def destroy
    reset_session # https://railsdoc.com/page/reset_session
    redirect_to root_path, notice: "Logged-out successfully."
  end
end
