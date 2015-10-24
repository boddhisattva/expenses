require 'rails_helper'

RSpec.describe Expense, type: :model do

  before do
    @user = FactoryGirl.create(:user)
    @expense = FactoryGirl.create(:expense, user: @user)
  end

  subject { @expense }

  it { should respond_to(:name) }
  it { should respond_to(:cost) }
  it { should respond_to(:date) }
  it { should respond_to(:user) }

  it { should be_valid }

  describe "user assocation of an expense" do
    it "should match with the correct user" do
      expect(@expense.user).to eq @user
    end
  end

  describe "when expense cost is not present" do
    before { @expense.cost = nil }
    it { should_not be_valid }
  end

  describe "when expense name is not present" do
    before { @expense.name = nil }
    it { should_not be_valid }
  end

  describe "when expense date is not present" do
    before { @expense.date = nil }
    it { should_not be_valid }
  end

  describe "when user_id is not present" do
    before { @expense.user_id = nil }
    it { should_not be_valid }
  end

  describe "when cost is not a number" do
    before { @expense.cost = "12a3" }
    it { should_not be_valid }
  end

end
