require "rails_helper"

RSpec.describe "StaticPages", type: :request do
  describe "#home" do
    it "should have the title Home" do
      visit root_path

      expect(page).to have_title("Expenses | Home")
    end

    it "should have basic info about the app" do
      visit root_path

      expect(page).to have_content("Welcome to the Expenses App where tracking your expenses is made easy")
    end
  end

  describe "#about" do
    it "should have the title About" do
      visit about_path

      expect(page).to have_title("Expenses | About")
    end

    it "should have the content 'About'" do
      visit about_path

      expect(page).to have_content("About")
    end
  end

  describe "#help" do
    it "should have the title Help" do
      visit help_path

      expect(page).to have_title("Expenses | Help")
    end

    it "should have the content 'Help'" do
      visit help_path

      expect(page).to have_content("Help")
    end
  end

  describe "#contact" do
    it "should have the title Contact" do
      visit contact_path

      expect(page).to have_title("Expenses | Contact")
    end

    it "should have the content 'Contact'" do
      visit contact_path

      expect(page).to have_content("Contact")
    end
  end

  describe "#faq" do
    it "should have the title FAQ" do
      visit faq_path

      expect(page).to have_title("Expenses | FAQ")
    end

    it "should have the content 'FAQ'" do
      visit faq_path

      expect(page).to have_content("FAQ")
    end
  end
end
