require 'rails_helper'

RSpec.describe BookDuetsController, type: :controller do

  describe "GET #custom_duet" do
    it "is successful" do
      get :custom_duet, duo: {author: "Neil Gaiman", musician: "Nickelback"}
    end
  end
end
