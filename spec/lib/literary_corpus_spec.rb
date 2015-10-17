require 'rails_helper'
require 'vcr_setup'
require 'literary_corpus'

context "building a literary corpus" do

  before(:each) do
    @corpus = LiteraryCorpus.new
  end

  describe "collect_random_sections" do
    it "collects quote sections (1.x) and their index numbers from wikiquote" do
      VCR.use_cassette "lib/lit_sections" do
        random_sections = @corpus.send(:collect_random_sections, "Neil Gaiman")

        expect(random_sections).to be_an_instance_of(Array)
        expect(random_sections.length).to eq(4)
      end
    end

    it "raises error if author is not found on Wikiquotes" do
      VCR.use_cassette "lib/author_not_found" do
        expect { @corpus.send(:collect_random_sections, "asdf") }.to raise_error("AuthorNotFound")
      end
    end

    it "raises an error if special characters are missing from an authors name" do
      VCR.use_cassette "lib/special_characters_error" do
        expect { @corpus.send(:collect_random_sections, "Anais Nin") }.to raise_error("AuthorNotFound")
      end
    end
  end

  describe "get_lit" do
    it "collects literary quotes in redis" do
      VCR.use_cassette "lib/get_lit", :record => :new_episodes do
        @corpus.send(:get_lit, "Neil Gaiman")

        expect($redis["Neil Gaiman"]).to_not be(nil)
        expect($redis["Neil Gaiman"]).to be_an_instance_of(String)
      end
    end
  end

  describe "clean_lit" do
    it "removes unrelated content from the corpus" do
      VCR.use_cassette "lib/clean_lit", :record => :new_episodes do
        @corpus.send(:get_lit, "Neil Gaiman")
        @corpus.send(:clean_lit, "Neil Gaiman")

        expect($redis["Neil Gaiman"]).to_not include ("<li>")
        expect($redis["Neil Gaiman"]).to_not include ("Chapter")
      end
    end
  end
end
