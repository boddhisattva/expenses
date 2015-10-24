class AddIndexToExpensesUsersAndCreatedAt < ActiveRecord::Migration
  def change
    add_index :expenses, [:user_id, :created_at]
  end
end
