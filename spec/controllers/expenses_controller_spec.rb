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
          expect(flash[:danger]).to eq("You cannot perform this action")
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
          expect(flash[:danger]).to eq("You cannot perform this action")
        end
      end
    end
  end

  describe "#destroy" do
    context "user is not logged in" do
      before do
        xhr :delete, :destroy, id: expense1.id
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
      end

      context "user tries to destroy an expense that they have not created" do
        it "should show an appropriate flash message" do
          xhr :delete, :destroy, id: expense1.id

          expect(flash[:danger]).to eq("You cannot perform this action")
        end
      end

      context "tries to delete the same expense twice" do
        it "should show an appropriate message" do
          expense2 = FactoryGirl.create(:expense, user: user2)

          xhr :delete, :destroy, id: expense2.id
          xhr :delete, :destroy, id: expense2.id

          expect(flash[:danger]).to eq("You cannot perform this action")
        end
      end

    end

  end

end
