require "rails_helper"

feature "Authentication" do

  subject { page }

  feature "signin page" do
    before { visit login_path }

    scenario { should have_content('Log in') }
    scenario { should have_title('Log in') }
  end

  feature "signin" do
    before { visit login_path }

    feature "with invalid information" do
      before { click_button "Log in" }

      scenario { should have_title('Log in') }
      scenario { should have_selector('div.alert.alert-danger') }

      feature "after visiting another page" do
        before { click_link "Home" }
        scenario { should_not have_selector('div.alert.alert-danger') }
      end
    end

    feature "with valid information" do
      let(:user) { FactoryGirl.create(:user) }
      before do
        log_in user
      end

      scenario { should have_content(user.name) }
      scenario { should have_link('Profile',     href: user_path(user)) }
      scenario { should have_link('Log out',    href: logout_path) }
      scenario { should_not have_link('Log in', href: login_path) }
    end
  end
end
