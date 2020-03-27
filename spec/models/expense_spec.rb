require "rails_helper"

RSpec.describe Expense, type: :model do

  before do
    @user = FactoryGirl.create(:user)
    @expense = FactoryGirl.create(:expense, user: @user)
  end

  describe "user assocation of an expense" do
    it "should match with the correct user" do
      expect(@expense.user).to eq @user
    end
  end

  describe 'validations' do
    it { should validate_presence_of(:user) }
    it { should validate_presence_of(:cost) }
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:date) }
    it { should validate_numericality_of(:cost) }
  end
end
