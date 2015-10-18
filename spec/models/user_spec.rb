require 'rails_helper'

RSpec.describe User, type: :model do

  before do
    @user = FactoryGirl.build(:user)
  end

  subject { @user }

  it { should respond_to(:name) }
  it { should respond_to(:email) }
  it { should respond_to(:password_digest) }
  it { should respond_to(:password) }
  it { should respond_to(:password_confirmation) }

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

  describe "when email format is invalid" do
    it "should be invalid" do
      addresses = %w[user@foo,com user_at_foo.org example.user@foo.
                     foo@bar_baz.com foo@bar+baz.com]
      addresses.each do |invalid_address|
        @user.email = invalid_address
        expect(@user).not_to be_valid
      end
    end
  end

  describe "when email format is valid" do
    it "should be valid" do
      addresses = %w[user@foo.COM A_US-ER@f.b.org frst.lst@foo.jp a+b@baz.cn]
      addresses.each do |valid_address|
        @user.email = valid_address
        expect(@user).to be_valid
      end
    end
  end

  describe "when email address is already taken" do
    before do
      @user = FactoryGirl.create(:user)
      @user_with_same_email = @user.dup
    end

    it "does not allow another user with the same email from being saved" do
      expect(@user_with_same_email).not_to be_valid
    end

    it "does not allow another user with the same uppercased email from being saved" do
      @user_with_same_email.email = @user.email.upcase
      expect(@user_with_same_email).not_to be_valid
    end
  end

  describe "when password is incorrectly specified" do
    before do
      @user = User.new(name: "Example User", email: "user@example.com",
                       password: " ", password_confirmation: " ")
    end

    context "password is an empty string" do
      it "should not be valid" do
        expect(@user).not_to be_valid
      end
    end

    context "password is nil" do
      it "should not be valid" do
        @user.password_confirmation = nil
        expect(@user).not_to be_valid
      end
    end

    context "password doesn't match confirmation" do
      it "should not be valid" do
        @user.password_confirmation = "mismatch"
        expect(@user).not_to be_valid
      end
    end
  end

  describe "return value of authenticate method" do
    before { @user.save }
    let(:found_user) { User.find_by(email: @user.email) }

    describe "with valid password" do
      it "should return the user" do
        expect(found_user.authenticate(@user.password)).to eq(@user)
      end
    end

    describe "with invalid password" do
      it "should return the user" do
        expect(found_user.authenticate("an invalid password")).to be false
      end
    end
  end

end
