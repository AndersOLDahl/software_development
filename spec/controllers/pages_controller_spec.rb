require 'spec_helper'

describe PagesController do
    before do
        RSpec::Mocks.configuration.allow_message_expectations_on_nil = true
        user = build(:user)
        allow(request.env['warden']).to receive(:authenticate!).and_return(user)
        allow(controller).to receive(:current_user).and_return(user)
    end
    describe "GET home" do
    it "assigns @microsite" do
      get :home
      expect(assigns(:microsites)).not_to be_nil
    end

    it "assigns @microsites" do
      get :home
      expect(assigns(:microsites)).not_to be_nil
    end

    it "assigns @hash" do
      get :home
      expect(assigns(:hash)).not_to be_nil
    end
  end
  describe "myinfowindow" do
    it "structures an infowindow" do
      testempty = PagesController.new.myinfowindow("", "", "", "")
      testempty.length.equal?(197)

      testa12b = PagesController.new.myinfowindow("aaa", "111", "222", "bbb")
      expect(testa12b).to include "aaa" and include "111" and include "222" and include "bbb"
      testa12b.length.equal?(testempty.length + "aaabbbcccddd".length)
    end
  end
end
