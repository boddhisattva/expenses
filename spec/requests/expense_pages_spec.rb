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

  describe "expense updation" do
    let!(:expense) { FactoryGirl.create(:expense, user: user) }

    before do
      visit root_path
      click_link "Edit"
    end

    describe "with invalid information" do
      describe "error messages" do
        context "name is empty" do
          before do
            fill_in 'expense_name', with: ""
            click_button "Update expense"
          end

          it { should have_content("The form contains 1 error.") }
          it { should have_content("Name can\'t be blank") }
        end
      end
    end

    describe "with valid information" do
        let(:new_expense_cost)  { 15 }
        let(:new_expense_name)  { "Coffee" }
        before do
          fill_in 'expense_cost', with: new_expense_cost
          fill_in 'expense_name', with: new_expense_name
          click_button "Update expense"
        end

        it { should have_content("Expense updated") }
        it "should update the expense with the correct cost" do
          expect(expense.reload.cost).to  eq new_expense_cost
        end
        it "should update the expense with the correct name" do
          expect(expense.reload.name).to  eq new_expense_name
        end
    end
  end
end