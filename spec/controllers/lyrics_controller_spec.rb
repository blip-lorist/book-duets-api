require 'rails_helper'
require 'vcr_setup'

RSpec.describe LyricsController, type: :controller do

  describe "collect_tracks" do
    it "retrieves tracks by Nickelback" do
      VCR.use_cassette 'controller/artist_collection' do
        tracks = (controller.send(:collect_tracks))
        expect(tracks).to be_an_instance_of Array
        expect(tracks.length).to be(5)
      end
    end
  end
end
