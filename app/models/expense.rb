class Expense < ActiveRecord::Base
  validates :user, presence: true
  validates :cost, presence: true, numericality: true
  validates :name, presence: true
  validates :date, presence: true

  belongs_to :user

  def self.get_all_by_user(user_id)
    where(user_id: user_id).order(date: :desc)
  end
end
