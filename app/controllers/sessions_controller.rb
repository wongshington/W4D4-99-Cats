class SessionsController < ApplicationController

before_action :require_no_user, only: [:new, :create]

  def new
    render :new
  end

  def create
    user = User.find_by_credentials(
      params[:user][:user_name],
      params[:user][:password]
    )
    if user.nil?
      flash.now[:errors] = ['Incorrect credentials']
    else
      login_user(user)
      redirect_to cats_url
    end
  end

  def destroy
    if current_user
    current_user.reset_session_token!
    session[:session_token] = nil
    end
  end


end
