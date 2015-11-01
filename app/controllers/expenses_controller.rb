class ExpensesController < ApplicationController
  before_action :authenticate_user
  before_action :authorize_user, only: [:edit, :update, :destroy]

  def new
    @expense = Expense.new
  end

  def create
    @expense = current_user.expenses.build(expense_params)
    if @expense.save
      redirect_to root_url
      flash[:success] = "Expense was successfully created"
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if @expense.update_attributes(expense_params)
      flash[:success] = "Expense updated"
      redirect_to root_url
    else
      render "edit"
    end
  end

  def total
  end

  def calculate_total
    if dates_are_present?(params[:from_date], params[:to_date])
      @total_expenses = current_user.expenses.total_between(params[:from_date], params[:to_date])
    end
    respond_to do |format|
      format.js
    end
  end

  def destroy
    get_user_expenses if @expense.destroy
    rescue ActiveRecord::RecordNotFound => e
      @error_msg = "The record that you're trying to delete does not exist. " \
                   "It may have been already deleted. Please refresh the page " \
                   "to see an updated list of available expenses."
    respond_to do |format|
      format.js
    end
  end

  private

    def expense_params
      params.require(:expense).permit(:name, :cost, :date)
    end

    def get_user_expenses
      @expenses = Expense.order_by_most_recent(current_user.id)
    end

    def dates_are_present?(from_date, to_date)
      @date_validator = DateValidator.new
      @date_validator.from_date = Date.parse(from_date) if from_date.present?
      @date_validator.to_date = Date.parse(to_date) if to_date.present?
      @date_validator.valid?
    end

    def authorize_user
      @expense = current_user.expenses.find_by(id: params[:id])
      if @expense.nil?
        redirect_to root_url, flash: {danger: "Your are not authorized to perform this action" }
      end
    end
end
