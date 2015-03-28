class SessionsController < ApplicationController
  skip_before_action :require_login, :only => [:new, :create]

  def create
    @user = User.find_by_email(params[:email])
    #Authenticate via has_secure_password
    if @user && @user.authenticate(params[:password])

      #Helper method
      sign_in(@user)
      flash[:success] = "You've successfully signed in!"
      redirect_to root_url
    else
      flash.now[:error] = "We couldn't sign you in!"
      render :new
    end
  end

  def new
  end

  def destroy

    #Helper method
    sign_out
    flash[:success] = "You've successfully signed out"
    redirect_to root_url
  end
end
