require 'spec_helper'

describe MicrositesController do
  subject { create(:microsite) }
  describe "POST create" do
    it "it should not redirect back to the homepage, unless
    a microsite saves" do
      expect(response).to_not redirect_to(root_path)
    end
  end
end
