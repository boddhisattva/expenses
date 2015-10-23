class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  include SessionsHelper

  private
    def authenticate_user
      unless logged_in?
        flash[:danger] = "Please log in to continue"
        redirect_to login_url
      end
    end
end
