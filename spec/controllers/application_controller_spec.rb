require 'rails_helper'

RSpec.describe ApplicationController, type: :controller do
  context "when no one is logged in" do
    controller(ApplicationController) do
      before_action :authenticate
      def auth_test
        render text: 'response'
      end
    end

    before do
      routes.draw { get 'auth_test' => 'anonymous#auth_test' }
      get 'auth_test'
    end

    it "returns nothing" do
      expect(response.body).to be_blank
    end

    it "returns an unauthorized status (401)" do
      expect(response.status).to eq(401)
    end
  end
end
