class DateValidator
  include ActiveModel::Validations

  attr_accessor :from_date, :to_date

  validates :from_date, presence: true
  validates :to_date, presence: true
  validate :from_date_before_to_date, if: :from_date_and_to_date_present?

  def from_date_and_to_date_present?
    from_date.present? && to_date.present?
  end

  def from_date_before_to_date
    if from_date > to_date
      errors.add(:from_date, "cannot be greater than to date")
    end
  end
end