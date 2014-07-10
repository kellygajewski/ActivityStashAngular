class SessionsController < ApplicationController
  def new
  end

  def create
  	@user = User.where(:email => params[:session][:email]).first
  	if @user && @user.authenticate(params[:session][:password])
  		flash.now[:success] = "Hello " + @user.name + "!"
  		session[:remember_token] = @user.id
  		@current_user = @user
  		redirect_to activities_path
  	else
  		flash.now[:danger] = "Invalid email/password combination"
  		render 'new'
  	end
  end

  def destroy
  	session.delete(:remember_token)
  	redirect_to root_path
  end
  
end