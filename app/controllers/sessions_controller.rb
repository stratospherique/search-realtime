class SessionsController < ApplicationController
  def new
    if current_user
      flash[:alert] = "You're already signed in!"
      redirect_to root_path
    end
  end

  def create
    @user = User.authenticate(params[:username], params[:password])
    if @user
      flash[:notice] = "You've signed in."
      session[:user_id] = @user.id
      redirect_to "/"
    else
      flash[:alert] = "There was a problem signing in. Please try again."
      redirect_to signin_path
    end
  end
  
  def destroy
    session[:user_id] = nil
    flash[:notice] = "You've signed out."
    redirect_to "/"
  end
end