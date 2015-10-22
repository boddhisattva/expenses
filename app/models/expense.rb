class Expense < ActiveRecord::Base
  validates :user, presence: true
  validates :cost, presence: true
  validates :name, presence: true
  validates :date, presence: true

  belongs_to :user
end
