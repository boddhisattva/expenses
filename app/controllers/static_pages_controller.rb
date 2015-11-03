class StaticPagesController < ApplicationController
  def home
    @user_expenses = current_user.expenses_feed if logged_in?
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
