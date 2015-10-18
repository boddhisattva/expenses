require "rails_helper"

RSpec.describe "StaticPages", type: :request do
  describe "#home" do
    it "should have the title Home" do
      visit "/static_pages/home"

      expect(page).to have_title("Expenses | Home")
    end

    it "should have basic info about the app" do
      visit "/static_pages/home"

      expect(page).to have_content("Tracking expenses made easy")
    end
  end

  describe "#about" do
    it "should have the title About" do
      visit "/static_pages/about"

      expect(page).to have_title("Expenses | About")
    end

    it "should have the content 'About'" do
      visit "/static_pages/about"

      expect(page).to have_content("About")
    end
  end

  describe "#help" do
    it "should have the title Help" do
      visit "/static_pages/help"

      expect(page).to have_title("Expenses | Help")
    end

    it "should have the content 'Help'" do
      visit "/static_pages/help"

      expect(page).to have_content("Help")
    end
  end
end
