class ExpensesController < ApplicationController
  before_action :authenticate_user

  def index
    @expenses = Expense.get_all_by_user(current_user.id)
  end

  def new
    @expense = Expense.new
  end

  def create
    @expense = current_user.expenses.build(expense_params)
    if @expense.save
      redirect_to root_path
      flash[:success] = "Expense was successfully created"
    else
      render 'new'
    end
  end

  private

    def expense_params
      params.require(:expense).permit(:name, :cost, :date)
    end
end
