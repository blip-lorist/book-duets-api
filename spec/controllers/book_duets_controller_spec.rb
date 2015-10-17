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

    it "returns a NoAuthorFound error if an author can't be found" do
      VCR.use_cassette 'controllers/author_not_found', :record => :new_episodes do
        get :custom_duet, {author: "Gregory Maguire", musician: "Clint Mansell"}
        json_response = JSON.parse(response.body)
        expect(json_response["error"]).to eq("AuthorNotFound")
      end
    end

    it "returns a NoLyricsFound error if lyrics can't be found" do
      VCR.use_cassette 'controllers/lyrics_not_found', :record => :new_episodes do
        get :custom_duet, {author: "Neil Gaiman", musician: "asdf"}
        json_response = JSON.parse(response.body)
        expect(json_response["error"]).to eq("LyricsNotFound")
      end
    end

    it "uses encoding that is friendly to spaces and special characters" do
      VCR.use_cassette "controllers/special_character_support", :record => :new_episodes  do
        get :custom_duet, {author: "Anaïs Nin", musician: "Feist"}
        expect(response.body).to_not include("error")
      end
    end
  end

  describe "redis caching" do

    before(:each) do
      VCR.use_cassette "controllers/redis_caching", :record => :new_episodes  do
        get :custom_duet, {author: "J. M. Barrie", musician: "Feist"}
        @cached_lyrical_corpus = $redis["Feist"]
        @cached_literary_corpus = $redis["J. M. Barrie"]
      end
    end

    it "avoids building lyrical_corpus if it is cached in redis" do
      controller.send(:build_corpora)

      expect(@cached_lyrical_corpus).to eq($redis["Feist"])
    end

    it "avoids building literary_corpus if it is cached in redis" do
      controller.send(:build_corpora)

      expect(@cached_literary_corpus).to eq($redis["J. M. Barrie"])
    end
  end
end
