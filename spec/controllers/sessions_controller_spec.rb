require "rails_helper"

RSpec.describe SessionsController, type: :controller do

  describe "#new" do
    it "returns http success" do
      get :new
      expect(response).to have_http_status(:success)
    end

    context "logged in user tries to access login page" do
      it "should be redirected to home page" do
        user = FactoryGirl.create(:user)
        log_in(user)

        get :new

        expect(response).to redirect_to(root_url)
      end

      it "should show an appropriate flash message on" do
        user = FactoryGirl.create(:user)
        log_in(user)

        get :new

        expect(flash[:danger]).to eq("You are already logged in")
      end
    end
  end

end
