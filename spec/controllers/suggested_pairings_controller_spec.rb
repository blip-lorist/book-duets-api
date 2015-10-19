require 'rails_helper'

RSpec.describe SuggestedPairingsController, type: :controller do

  #Be sure to run rake db:seed RAILS_ENV=test to get the seed data in

  describe "GET #random_pairing" do
    it "is a success" do
      get :random_pairing
      
    end
  end
end
