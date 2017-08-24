class UsersController < ApplicationController
  def new
    render :new
  end


  def create
    @user = User.new(user_params)

    if @user.save
      render json: @user
    else
      flash.now[:errors] = @user.errors.full_messages
      redirect_to :new
    end
  end

private

  def user_params
      params.require(:user).permit(:user_name, :password)
  end
end
