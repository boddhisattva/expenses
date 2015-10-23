class StaticPagesController < ApplicationController
  def home
    if logged_in?
      @user_expenses  = current_user.expenses_feed
    end
  end

  def help
  end

  def about
  end

  def contact
  end

  def faq
  end
end
