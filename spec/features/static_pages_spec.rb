require "rails_helper"

RSpec.feature "StaticPages", type: :feature do
  feature "#home" do
    scenario "should have the title Home" do
      visit root_path

      expect(page).to have_title("Expenses | Home")
    end

    scenario "should have basic info about the app" do
      visit root_path

      expect(page).to have_content("Welcome to the Expenses App where tracking your expenses is made easy")
    end

    feature "for signed-in users" do
      let(:user) { FactoryGirl.create(:user) }
      before do
        FactoryGirl.create(:expense, user: user, name: "Shampoo")
        FactoryGirl.create(:expense, user: user, name: "Toothpaste")
        log_in user
        visit root_path
      end

      scenario "should render the user expenses feed" do
        user.expenses_feed.each do |expense|
          expect(page).to have_content(expense.name)
        end
      end
    end
  end

  feature "#about" do
    scenario "should have the title About" do
      visit about_path

      expect(page).to have_title("Expenses | About")
    end

    scenario "should have the content 'About'" do
      visit about_path

      expect(page).to have_content("About")
    end
  end

  feature "#help" do
    scenario "should have the title Help" do
      visit help_path

      expect(page).to have_title("Expenses | Help")
    end

    scenario "should have the content 'Help'" do
      visit help_path

      expect(page).to have_content("Help")
    end
  end

  feature "#contact" do
    scenario "should have the title Contact" do
      visit contact_path

      expect(page).to have_title("Expenses | Contact")
    end

    scenario "should have the content 'Contact'" do
      visit contact_path

      expect(page).to have_content("Contact")
    end
  end

  feature "#faq" do
    scenario "should have the title FAQ" do
      visit faq_path

      expect(page).to have_title("Expenses | FAQ")
    end

    scenario "should have the content 'FAQ'" do
      visit faq_path

      expect(page).to have_content("FAQ")
    end
  end
end
