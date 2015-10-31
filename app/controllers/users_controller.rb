class UsersController < ApplicationController
  before_action :authenticate_user, only: [:show, :edit, :update]

  def new
    if logged_in?
      redirect_to root_url, flash: { danger: "You have already signed up" }
    else
      @user = User.new
    end
  end

  def show
    @user = User.find(params[:id])
  end

  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user
      flash[:success] = "Welcome aboard"
      redirect_to root_url
    else
      render "new"
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = "Profile updated"
      redirect_to @user
    else
      render "edit"
    end
  end

private

  def user_params
    params.require(:user).permit(:email, :name, :password,
                                 :password_confirmation)
  end

end
