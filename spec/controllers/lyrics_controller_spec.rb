require 'rails_helper'
require 'vcr_setup'

RSpec.describe LyricsController, type: :controller do

  describe "GET #find_artist" do

    it "retrieves Bjork's artist_id" do
      VCR.use_cassette 'controller/artist_collection' do
        get :find_artist, params: {}
        expect(response.response_code).to eq(200)
      end
    end
  end
end
