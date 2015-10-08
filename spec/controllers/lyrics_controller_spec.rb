require 'rails_helper'
require 'vcr_setup'

RSpec.describe LyricsController, type: :controller do

  describe "GET #lyric_collection" do

    it "retrieves Bjork lyrics" do
      VCR.use_cassette 'controller/lyric_collection' do
        get :lyric_collection, params: {}
        expect(response.response_code).to eq(200)
      end
    end
  end
end
