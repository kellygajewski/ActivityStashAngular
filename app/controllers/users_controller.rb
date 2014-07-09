class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "You have signed up successfully."
      session[:remember_token] = @user.id
      redirect_to :root
    else
      render :new
    end
  end

  protected

  def user_params
    params.require(:user).permit(:name, :email, :password)
  end
end
