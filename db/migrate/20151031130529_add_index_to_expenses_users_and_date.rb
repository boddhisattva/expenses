class AddIndexToExpensesUsersAndDate < ActiveRecord::Migration
  def change
    add_index :expenses, [:user_id, :date]
  end
end
