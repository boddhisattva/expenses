require "rails_helper"

RSpec.describe "UserPages", type: :request do

  describe "User pages" do

    subject { page }

    describe "signup page" do
      before { visit signup_path }

      it { should have_content("Sign up") }
      it { should have_title("Expenses | Sign up") }
    end

    describe "signup" do

      before { visit signup_path }

      let(:submit) { "Create my account" }

      describe "with invalid information" do
        before do
          fill_in "Email",        with: "user@example.com"
          fill_in "Password",     with: "foobar"
          fill_in "Password Confirmation", with: "foo"
        end

        it "should not create a user" do
          expect { click_button submit }.not_to change(User, :count)
        end

        it "should display error message for matching password not matching password confirmation" do
          click_button submit
          expect(page).to have_content('Password confirmation doesn\'t match Password')
        end

        it "should render the sign up page again" do
          click_button submit
          expect(page).to have_content("Password confirmation")
        end
      end

      describe "with valid information" do
        before do
          fill_in "Email",        with: "user@example.com"
          fill_in "Name",         with: "John Doe"
          fill_in "Password",     with: "foobar"
          fill_in "Password Confirmation", with: "foobar"
        end

        it "should create a user" do
          expect { click_button submit }.to change(User, :count).by(1)
        end

        it "should redirect to a login page with an appropriate welcome message" do
          click_button submit
          expect(page).to have_content("Welcome aboard")
        end

        it "should redirect to a login page that should contain a users name" do
          click_button submit
          expect(page).to have_content("John Doe")
        end

        it "should redirect to a login page with a logout link" do
          click_button submit
          expect(page).to have_content("Log out")
        end

        describe "after saving the user" do
          before { click_button submit }
          let(:user) { User.find_by(email: 'user@example.com') }

          it { should have_link('Log out') }
          it { should have_title(user.name) }
          it { should have_selector('div.alert.alert-success', text: 'Welcome') }
        end
      end
    end

    describe "logout" do

      before do
        visit login_path
        @user = FactoryGirl.create(:user)
      end

      let(:submit) { "Log in" }

      describe "for a logged in user" do
        before do
          fill_in "Email",        with: @user.email
          fill_in "Password",     with: @user.password
        end

        it "should redirect to home page" do
          click_button submit
          click_link "Log out"
          expect(page).to have_content("New user? Sign up now!")
        end
      end

    end
  end
end
