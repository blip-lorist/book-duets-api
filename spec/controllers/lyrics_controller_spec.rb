require 'rails_helper'
require 'vcr_setup'

RSpec.describe LyricsController, type: :controller do

  describe "collect_tracks" do
    it "retrieves five track_ids for Nickelback" do
      VCR.use_cassette 'controller/artist_collection' do
        tracks = (controller.send(:collect_tracks))

        expect(tracks).to be_an_instance_of Array
        expect(tracks.length).to be(5)
      end
    end
  end

  describe "get_lyrics" do
    it "collects lyrics in a txt file" do
      VCR.use_cassette 'controller/get_lyrics' do
        controller.send(:get_lyrics)

        expect(File).to exist("lyrical_corpus.txt")
        expect(File.zero?("lyrical_corpus.txt")).to be(false)
        # Ensures that the file isn't empty. Difficult to test actual
        # content since it's randomly selected
      end
    end
  end

  describe "clean_lyrics" do
    it "removes non-lyrical content from the corpus" do
      controller.send(:clean_lyrics)
      corpus = File.open("lyrical_corpus.txt")

      expect(corpus.read).to_not include("******* This Lyrics is NOT for Commercial use *******")
      expect(corpus.read).to_not include("...")

      corpus.close
    end
  end
end
