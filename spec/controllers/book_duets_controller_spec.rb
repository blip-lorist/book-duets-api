require 'rails_helper'
require 'vcr_setup'

RSpec.describe BookDuetsController, type: :controller do

  describe "GET #custom_duet" do
    it "returns 200 if a custom duet build is successful" do
      VCR.use_cassette 'controllers/custom_duet', :record => :new_episodes do
        get :custom_duet, {author: "Neil Gaiman", musician: "Nickelback"}
        expect(response.response_code).to eq(200)
      end
    end

    it "returns a 204 if there is no content" do
      VCR.use_cassette 'controllers/no_content', :record => :new_episodes do
        get :custom_duet, {author: "Gregory Maguire", musician: "Clint Mansell"}
        expect(response.response_code).to eq(204)
      end
    end

    it "formats artist names into an API-friendly format" do

    end
  end

  describe "GET #suggested_pairing" do
    it "is successful" do
      get :suggested_pairing
      expect(response.response_code).to eq(200)
    end
  end
end
