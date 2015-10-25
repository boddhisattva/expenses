require "rails_helper"

describe "Expense pages", type: :request do

  subject { page }

  let(:user) { FactoryGirl.create(:user) }
  before { log_in user }

  describe "expense creation" do
    context "user is creating their first expense" do
      before do
        click_link "create a new expense"
      end

      describe "with invalid information" do

        it "should not create an expense" do
          expect { click_button "Create expense" }.not_to change(Expense, :count)
        end

        describe "error messages" do
          before { click_button "Create expense" }
          it { should have_content('error') }
        end
      end

      describe "with valid information" do

        before do
          fill_in 'expense_name', with: "Sunglasses"
          fill_in 'expense_cost', with: "1000"
          fill_in 'expense_date', with: Time.zone.today
        end
        it "should create a expense" do
          expect { click_button "Create expense" }.to change(Expense, :count).by(1)
        end
      end
    end

    context "user has atleast one expense created" do
      before do
        FactoryGirl.create(:expense, user: user)
        visit root_path
        click_link "Create a new expense"
      end

      it { expect(page).to have_selector(:link_or_button, 'Create expense') }
    end
  end
end