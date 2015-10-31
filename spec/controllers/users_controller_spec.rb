require "rails_helper"

RSpec.describe UsersController, type: :controller do

  let(:user) { FactoryGirl.create(:user) }

  before do
    log_in(user)
  end

  describe "#new" do
    context "logged in user tries to access signup page" do
      it "should be redirected to app home page" do
        get :new

        expect(response).to redirect_to(root_url)
      end

      it "should show an appropriate flash message" do
        get :new

        expect(flash[:danger]).to eq("You have already signed up")
      end
    end
  end

  describe "#update" do
    let(:new_password) { "foobar2" }

    context "password and password_confirmation match" do
      it "should update user password" do
        patch :update, id: user.id,
                       user: { name: user.name,
                               email: user.email,
                               password: new_password,
                               password_confirmation: new_password }

        expect(user.reload.authenticate(new_password)).to_not eql(false)
      end
    end

    context "password and password_confirmation do not match" do
      it "should not update user password" do
        patch :update, id: user.id,
                       user: { name: user.name,
                               email: user.email,
                               password: new_password,
                               password_confirmation: "random" }

        expect(user.reload.authenticate(new_password)).to eql(false)
      end
    end
  end
end
