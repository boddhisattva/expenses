class Expense < ActiveRecord::Base
  validates :user, presence: true
  validates :cost, presence: true, numericality: true
  validates :name, presence: true
  validates :date, presence: true

  belongs_to :user

  scope :order_by_most_recent, -> (user_id) { where(user_id: user_id).order(date: :desc) }
  scope :made_between, -> (from_date, to_date) { where(date: from_date..to_date) }

  def self.total_between(from_date, to_date)
    made_between(from_date, to_date).collect(&:cost).sum
  end
end
