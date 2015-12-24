require 'rails_helper'

RSpec.describe EventsController, type: :controller do
  describe "GET #index" do
    it "redirect to /users/sign_in" do

      get :index
      expect(get :index).to redirect_to("/users/sign_in")
    end

    it "be success" do
      @request.env["devise.mapping"] = Devise.mappings[:admin]
      user = FactoryGirl.create(:user)
      sign_in :user, user

      get :index
      expect(get :index).to be_success
    end
  end
end
