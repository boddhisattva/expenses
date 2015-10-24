require 'rails_helper'

describe "Authentication" do

  subject { page }

  describe "signin page" do
    before { visit login_path }

    it { should have_content('Log in') }
    it { should have_title('Log in') }
  end

  describe "signin" do
    before { visit login_path }

    describe "with invalid information" do
      before { click_button "Log in" }

      it { should have_title('Log in') }
      it { should have_selector('div.alert.alert-danger') }

      describe "after visiting another page" do
        before { click_link "Home" }
        it { should_not have_selector('div.alert.alert-danger') }
      end
    end

    describe "with valid information" do
      let(:user) { FactoryGirl.create(:user) }
      before do
        log_in user
      end

      it { should have_content(user.name) }
      it { should have_link('Profile',     href: user_path(user)) }
      it { should have_link('Log out',    href: logout_path) }
      it { should_not have_link('Log in', href: login_path) }
    end
  end

  describe "authorization" do

    describe "for non-signed-in users" do
      let(:user) { FactoryGirl.create(:user) }

      describe "in the Expenses controller" do

        describe "submitting to the create action" do
          before { post expenses_path }
          specify { expect(response).to redirect_to(login_path) }
        end

        describe "submitting to the edit action" do
          before { get edit_expense_path(FactoryGirl.create(:expense, user: user)) }
          specify { expect(response).to redirect_to(login_path) }
        end

        describe "submitting to the update action" do
          before { patch expense_path(FactoryGirl.create(:expense, user: user)) }
          specify { expect(response).to redirect_to(login_path) }
        end

        describe "submitting to the destroy action" do
          before { delete expense_path(FactoryGirl.create(:expense, user: user)) }
          specify { expect(response).to redirect_to(login_path) }
        end
      end
    end
  end

end
