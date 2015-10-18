require 'rails_helper'

RSpec.describe User, type: :model do

  before do
    @user = FactoryGirl.build(:user)
  end

  subject { @user }

  it { should respond_to(:name) }
  it { should respond_to(:email) }

  it { should be_valid }

  describe "when name is not present" do
    before { @user.name = " " }
    it { should_not be_valid }
  end

  describe "when name is too long" do
    before { @user.name = "a" * 51 }
    it { should_not be_valid }
  end

  context "given a new User instance" do
    it "should validate the presence of email" do
      expect(User.new(:email => "")).not_to be_valid
    end
  end

end
