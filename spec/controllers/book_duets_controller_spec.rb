require 'rails_helper'
require 'vcr_setup'

RSpec.describe BookDuetsController, type: :controller do

  describe "GET #custom_duet" do
    it "returns 200 if a custom duet build is successful" do
      VCR.use_cassette 'controllers/custom_duet', :record => :new_episodes do
        get :custom_duet, {author: "Neil_Gaiman", musician: "Nickelback"}
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
        get :custom_duet, {author: "Anaïs Nin", musician: "Mötorhead"}
        expect(response.body).to_not include("error")
      end
    end

    it "standardizes redis artist name keys so that they don't include underscores" do
      VCR.use_cassette 'controllers/custom_duet', :record => :new_episodes do
        get :custom_duet, {author: "Neil_Gaiman", musician: "Nickelback"}
        expect($redis.exists("Neil_Gaiman")).to eq(false)
        expect($redis.exists("Neil Gaiman")).to eq(true)
      end
    end
  end

  describe "corpora caching" do

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

    it "will not persist musician keys in redis" do
      expect($redis.ttl("Feist")).to_not eq(-1)
    end

    it "will not persist author keys in redis" do
      expect($redis.ttl("J. M. Barrie")).to_not eq(-1)
    end

    it "caches musician keys for at least 300 seconds (5 min)" do
      expect($redis.ttl("Feist")).to be <=(300)
    end

    it "caches author keys for at least 300 seconds (5 min)" do
      expect($redis.ttl("J. M. Barrie")).to be <=(300)
    end
  end

  describe "logging corpora build frequency" do

    before(:each) do
      VCR.use_cassette "controllers/build_frequency", :record => :new_episodes  do
        get :custom_duet, {author: "Octavia Butler", musician: "Sleater-Kinney"}
      end
    end

    it "creates a sorted set entry once a corpus is build" do
      expect($redis.zscore("Musicians", "Sleater-Kinney")).to eq(1.0)
      expect($redis.zscore("Authors", "Octavia Butler")).to eq(1.0)
    end

  end
end
