require 'spec_helper'

describe PagesController do
  describe "GET home" do
    it "assigns @microsites" do
      get :home
      expect(assigns(:microsites)).not_to be_nil
    end

    it "assigns @hash" do
      get :home
      expect(assigns(:hash)).not_to be_nil
    end
  end
end
