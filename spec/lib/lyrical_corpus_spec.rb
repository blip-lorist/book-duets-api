require 'rails_helper'
require 'vcr_setup'
require 'lyrical_corpus'

context "building a lyrical corpus" do
  before(:each) do
    @corpus = LyricalCorpus.new
  end

  describe "collect_tracks" do
    it "retrieves five random tracks for Nickelback" do
      VCR.use_cassette 'lib/random_track_collection' do
        tracks = (@corpus.send(:collect_random_tracks, "Nickelback"))

        expect(tracks).to be_an_instance_of(Array)
        expect(tracks.length).to be(5)
      end
    end

    it "raises an error if musician tracks aren't found on Musixmatch" do
      VCR.use_cassette 'lib/no_tracks' do
        expect { @corpus.send(:collect_random_tracks, "asdf") }.to raise_error("NoLyricsFound")
      end
    end
  end

  describe "get_lyrics" do
    it "collects lyrics in a txt file" do
      VCR.use_cassette 'lib/get_lyrics', :record => :new_episodes do
        @corpus.send(:get_lyrics, "Nickelback")

        expect(File).to exist("lyrical_corpus.txt")
        expect(File.zero?("lyrical_corpus.txt")).to be(false)
        # Ensures that the file isn't empty. Difficult to test actual
        # content since it's randomly selected
      end
    end
  end

  describe "clean_lyrics" do
    it "removes non-lyrical content from the corpus" do
      @corpus.send(:clean_lyrics)
      corpus = File.open("lyrical_corpus.txt")
      lyrics = corpus.read
      expect(lyrics).to_not include("******* This Lyrics is NOT for Commercial use *******")
      expect(lyrics).to_not include("...")

      corpus.close
    end
  end
end
