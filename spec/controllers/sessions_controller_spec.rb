require 'rails_helper'

RSpec.describe SessionsController, type: :controller do

  describe "GET #new" do
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
    end
  end

end
