require 'spec_helper'

describe Microsite do
  #subject { create(:microsite) }
  it { should have_many :readings }
end
