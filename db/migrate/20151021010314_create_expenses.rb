class CreateExpenses < ActiveRecord::Migration
  def change
    create_table :expenses do |t|
      t.string :name, null: false
      t.float :cost, null: false
      t.datetime :date, null: false
      t.references :user, index: true

      t.timestamps null: false
    end
    add_foreign_key :expenses, :users
  end
end
