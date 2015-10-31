class SessionsController < ApplicationController

  def new
    if logged_in?
      redirect_to root_url, flash: {danger: "You are already logged in"}
    end
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      log_in user
      redirect_to root_url
    else
      flash.now[:danger] = 'Invalid email and/or password combination'
      render 'new'
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_url
  end

end
