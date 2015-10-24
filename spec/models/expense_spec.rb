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

end
