require 'rails_helper'

RSpec.describe BookDuetsController, type: :controller do

  describe "GET #custom_duet" do
    it "is successful" do
      VCR.use_cassette 'controllers/custom_duet', :record => :new_episodes do
        get :custom_duet, duo: {author: "Neil_Gaiman", musician: "Nickelback"}
        expect(response.response_code).to eq(200)
      end
    end
  end
end
