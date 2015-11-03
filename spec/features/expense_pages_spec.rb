require "rails_helper"

feature "Expense pages", type: :feature do

  subject { page }

  let(:user) { FactoryGirl.create(:user) }
  before { log_in user }

  feature "expense creation" do
    context "user is creating their first expense" do
      before do
        click_link "create a new expense"
      end

      feature "with invalid information" do

        scenario "should not create an expense" do
          expect { click_button "Create expense" }.not_to change(Expense, :count)
        end

        feature "error messages" do
          before { click_button "Create expense" }
          scenario { should have_content("error") }
        end
      end

      feature "with valid information" do

        before do
          fill_in "expense_name", with: "Sunglasses"
          fill_in "expense_cost", with: 1000
          fill_in "expense_date", with: Time.zone.today
        end
        scenario "should create a expense" do
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

      scenario { expect(page).to have_selector(:link_or_button, "Create expense") }
    end
  end

  feature "expense updation" do
    let!(:expense) { FactoryGirl.create(:expense, user: user) }

    before do
      visit root_path
      click_link "Edit"
    end

    feature "with invalid information" do
      feature "error messages" do
        context "name is empty" do
          before do
            fill_in "expense_name", with: ""
            click_button "Update expense"
          end

          scenario { should have_content("The form contains 1 error.") }
          scenario { should have_content("Name can\'t be blank") }
        end
      end
    end

    feature "with valid information" do
      let(:new_expense_cost)  { 15 }
      let(:new_expense_name)  { "Coffee" }
      before do
        fill_in "expense_cost", with: new_expense_cost
        fill_in "expense_name", with: new_expense_name
        click_button "Update expense"
      end

      scenario { should have_content("Expense updated") }
      scenario "should update the expense with the correct cost" do
        expect(expense.reload.cost).to eq new_expense_cost
      end
      scenario "should update the expense with the correct name" do
        expect(expense.reload.name).to eq new_expense_name
      end
    end
  end

  feature "expense deletion" do
    let!(:expense) { FactoryGirl.create(:expense, user: user) }

    before do
      visit root_path
    end

    scenario "should decrease the total number of expense records by 1" do
      expect { click_link "Delete" }.to change(Expense, :count).by(-1)
    end

    scenario "should show the appropriate flash message on successful delete", js: true do
      click_link "Delete"

      expect(page).to have_content("Expense deleted successfully")
    end
  end

  feature "total expenses calculation" do
    feature "with invalid information" do
      let!(:expense) { FactoryGirl.create(:expense, user: user) }

      before do
        visit root_path
        click_link "Calculate total expenses"
        fill_in "to_date", with: Time.zone.tomorrow
        click_button "Calculate total"
      end

      scenario "should have the appropriate error related message", js: true do
        expect(page).to have_content("The form contains 1 error.")
      end

      scenario "should show the appropriate error message", js: true do
        expect(page).to have_content("From date can\'t be blank")
      end
    end

    feature "with valid information" do
      context "there are incurred expenses with the specififed period" do
        scenario "should calculate the total expenses accurately", js: true do
          FactoryGirl.create(:expense, user: user)
          FactoryGirl.create(:expense, user: user, name: "Petrol", cost: 68.50, date: Time.zone.yesterday)
          FactoryGirl.create(:expense, user: user, name: "Mug", cost: 50, date: Time.zone.tomorrow)

          visit root_path
          click_link "Calculate total expenses"
          fill_in "from_date", with: Time.zone.yesterday
          fill_in "to_date",   with: Time.zone.tomorrow
          click_button "Calculate total"

          expect(page).to have_content("128.5")
        end
      end

      context "there are no expenses made within the specified period" do
        scenario "should display an appropriate message about no expenses incurred", js: true do
          FactoryGirl.create(:expense, user: user, name: "Petrol", cost: 68.50, date: Time.zone.tomorrow)

          visit root_path
          click_link "Calculate total expenses"
          fill_in "from_date", with: Time.zone.now.beginning_of_year
          fill_in "to_date",   with: Time.zone.today
          click_button "Calculate total"

          expect(page).to have_content("There were no expenses incurred")
        end
      end
    end
  end
end
