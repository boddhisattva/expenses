require "rails_helper"

RSpec.describe "HomePage", type: :request do
  describe "Home page" do
    it "should have the name of the app" do
      visit root_path
      expect(page).to have_content("Expenses App")
    end
  end

  describe "Sign up now! link" do
    it "should go to the sign up page" do
      visit root_path
      click_link "Sign up now!"
      expect(page).to have_content("Sign up")
      expect(page).to have_content("Password Confirmation")
    end
  end

  describe "login" do
    before { visit login_path }
    let(:submit) { "Log in" }
    # let(:user) { FactoryGirl.create(:user) }
    @user = FactoryGirl.create(:user)

    describe "with valid information" do
      before do
        fill_in "Email",        with: "t1@test.com"
        fill_in "Password",     with: "foo"
      end
      it "should login the user and display his email on the logged in page" do
        click_button submit
        expect(page).to have_content("Hello t1@test.com")
      end
    end

    describe "with invalid information" do
      before do
        fill_in "Email",        with: "t1@test.com"
        fill_in "Password",     with: "fo"
      end
      it "should display appropriate login error message" do
        click_button submit
        expect(page).to have_content("Invalid email and/or password combination")
      end
    end
  end
end
