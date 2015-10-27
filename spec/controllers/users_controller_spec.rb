require "rails_helper"

RSpec.describe UsersController, type: :controller do

  describe "#update" do
    let(:user) { FactoryGirl.create(:user) }
    let(:new_password) { "foobar2" }

    before do
      log_in(user)
    end

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
