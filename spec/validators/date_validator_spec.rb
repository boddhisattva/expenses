require "rails_helper"

RSpec.describe DateValidator do
  before do
    @date_validator = DateValidator.new
    @date_validator.from_date = Time.zone.yesterday
    @date_validator.to_date = Time.zone.today
  end

  subject { @date_validator }

  it { should respond_to(:from_date) }
  it { should respond_to(:to_date) }

  it { should be_valid }

  describe "when from_date is empty" do
    before { @date_validator.to_date = "" }

    it { should_not be_valid }
  end

  describe "when to_date is empty" do
    before { @date_validator.to_date = "" }

    it { should_not be_valid }
  end

  describe "when from date is greater than to date" do
    before { @date_validator.from_date = Time.zone.tomorrow }

    it { should_not be_valid }
  end

end
