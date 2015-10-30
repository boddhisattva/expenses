class DateValidator
  include ActiveModel::Validations

  attr_accessor :from_date, :to_date

  validates :from_date, presence: true
  validates :to_date, presence: true
end