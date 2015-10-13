require 'rails_helper'
require 'vcr_setup'
# Specs in this file have access to a helper object that includes
# the BookDuetsHelper. For example:
#
# describe BookDuetsHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       expect(helper.concat_strings("this","that")).to eq("this that")
#     end
#   end
# end
RSpec.describe BookDuetsHelper, type: :helper do

  context "building a lyrical corpus" do
    describe "collect_tracks" do
      it "retrieves five track_ids for Nickelback" do
        VCR.use_cassette 'helper/artist_collection' do
          tracks = (helper.send(:collect_tracks))

          expect(tracks).to be_an_instance_of(Array)
          expect(tracks.length).to be(5)
        end
      end
    end

    describe "get_lyrics" do
      it "collects lyrics in a txt file" do
        VCR.use_cassette 'helper/get_lyrics' do
          helper.send(:get_lyrics)

          expect(File).to exist("lyrical_corpus.txt")
          expect(File.zero?("lyrical_corpus.txt")).to be(false)
          # Ensures that the file isn't empty. Difficult to test actual
          # content since it's randomly selected
        end
      end
    end

    describe "clean_lyrics" do
      it "removes non-lyrical content from the corpus" do
        helper.send(:clean_lyrics)
        corpus = File.open("lyrical_corpus.txt")

        expect(corpus.read).to_not include("******* This Lyrics is NOT for Commercial use *******")
        expect(corpus.read).to_not include("...")

        corpus.close
      end
    end
  end

  context "building a literary corpus" do
    describe "collect_random_sections" do
      it "collects quote sections (1.x) and their index numbers from wikiquote" do
        VCR.use_cassette "helper/lit_sections" do
          random_sections = helper.send(:collect_random_sections)

          expect(random_sections).to be_an_instance_of(Array)
          expect(random_sections.length).to eq(5)
        end
      end
    end

    describe "get_lit" do
      it "collects literary quotes in a txt file" do
        VCR.use_cassette "helper/get_lit" do
          helper.send(:get_lit)

          expect(File).to exist("literary_corpus.txt")
          expect(File.zero?("literary_corpus.txt")).to be(false)
        end
      end
    end

    describe "clean_lit" do
      it "removes unrelated content from the corpus" do
        helper.send(:clean_lit)
        # corpus = File.open("literary_corpus.txt")
        #
        # expect(corpus.read).to_not include('\\n')
        # expect(corpus.read).to_not include("<")
        # expect(corpus.read).to_not include("  ")
        #
        # corpus.close
      end
    end
  end
end
