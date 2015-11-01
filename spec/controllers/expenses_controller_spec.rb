require "rails_helper"

RSpec.describe ExpensesController, type: :controller do
  let(:user1) { FactoryGirl.create(:user) }
  let(:user2) { FactoryGirl.create(:user) }
  let(:expense1) { FactoryGirl.create(:expense, user: user1) }

  describe "#create" do
    context "user is not logged in" do
      before do
        post :create
      end

      it "should redirect the user to login page" do
        expect(response).to redirect_to(login_url)
      end

      it "should show the appropriate flash message" do
        expect(flash[:danger]).to eq("Please log in to continue")
      end
    end
  end

  describe "#edit" do
    context "user is not logged in" do
      before do
        get :edit, id: expense1.id
      end

      it "should redirect the user to login page" do
        expect(response).to redirect_to(login_url)
      end

      it "should show the appropriate flash message" do
        expect(flash[:danger]).to eq("Please log in to continue")
      end
    end

    context "user is logged in" do
      before do
        log_in(user2)
        get :edit, id: expense1.id
      end

      context "user tries to edit an expense that they have not created" do
        it "should redirect the user to app home page" do
          expect(response).to redirect_to(root_url)
        end

        it "should show an appropriate flash message" do
          expect(flash[:danger]).to eq("Your are not authorized to perform this action")
        end
      end
    end
  end

  describe "#update" do
    context "user is not logged in" do
      before do
        patch :update, id: expense1.id
      end

      it "should redirect the user to login page" do
        expect(response).to redirect_to(login_url)
      end

      it "should show the appropriate flash message" do
        expect(flash[:danger]).to eq("Please log in to continue")
      end
    end

    context "user is logged in" do
      context "user tries to update an expense that they have not created" do
        before do
          log_in(user2)
          patch :update, id: expense1.id
        end

        it "should redirect the user to app home page" do
          expect(response).to redirect_to(root_url)
        end

        it "should show an appropriate flash message" do
          expect(flash[:danger]).to eq("Your are not authorized to perform this action")
        end
      end
    end
  end

  describe "#destroy" do
    context "user is not logged in" do
      before do
        delete :destroy, id: expense1.id
      end
      it "should redirect the user to login page" do
        expect(response).to redirect_to(login_url)
      end

      it "should show the appropriate flash message" do
        expect(flash[:danger]).to eq("Please log in to continue")
      end
    end


    context "user is logged in" do
      context "user tries to destroy an expense that they have not created" do
        before do
          log_in(user2)
          delete :destroy, id: expense1.id
        end
        it "should redirect the user to app home page" do
          expect(response).to redirect_to(root_url)
        end

        it "should show an appropriate flash message" do
          expect(flash[:danger]).to eq("Your are not authorized to perform this action")
        end
      end
    end
  end

end
