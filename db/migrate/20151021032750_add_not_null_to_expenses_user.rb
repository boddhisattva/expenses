class AddNotNullToExpensesUser < ActiveRecord::Migration
  def change
    change_column_null :expenses, :user_id, false
  end
end
