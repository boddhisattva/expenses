class ExpensesController < ApplicationController
  before_action :authenticate_user

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
    @expense = Expense.find(params[:id])
  end

  def update
    @expense = Expense.find(params[:id])
    if @expense.update_attributes(expense_params)
      flash[:success] = "Expense updated"
      redirect_to root_url
    else
      render "edit"
    end
  end

  def destroy
    @expense = Expense.find(params[:id])
    get_user_expenses if @expense.destroy
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
end
