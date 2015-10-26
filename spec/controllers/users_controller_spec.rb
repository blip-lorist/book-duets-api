require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  describe "new #POST" do
    before(:each) do
      post :new, email: "noreply@example.com"
    end
    it "creates a new user" do
      expect(User.count). to eq(1)
    end

    it "renders a JSON response" do
      expect(response.header['Content-Type']).to include 'application/json'
    end

    it "contains an API key" do
      parsed_response = JSON.parse(response.body)
      expect(parsed_response.keys).to include("api_key")
    end
  end

end
