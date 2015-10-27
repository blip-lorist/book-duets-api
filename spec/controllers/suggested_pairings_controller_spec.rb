require 'rails_helper'

RSpec.describe SuggestedPairingsController, type: :controller do

  # Be sure to run rake db:reset RAILS_ENV=test to get the seed data in

  # Skip the authentication for testing porpoises
  before(:each) do
    SuggestedPairingsController.skip_before_filter :authenticate
  end

  describe "GET #random_pairing" do
    it "is a success" do
      get :random_pairing
      expect(response.response_code).to eq(200)
    end

    it "returns json" do
      get :random_pairing
      expect(response.header['Content-Type']).to include 'application/json'
    end
  end

    context "the JSON object" do
      before (:each) do
        get :random_pairing, filter_level: "none"
        @response = JSON.parse(response.body)
      end

      it "includes author, musician, news source, and book duet keys" do
        keys = ["author", "musician", "news_source", "book_duet"]
        keys.each do |key|
          expect(@response.keys).to include(key)
        end
      end
    end
end
