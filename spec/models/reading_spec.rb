require "spec_helper"

describe Reading do
  #subject { create(:reading) }
  it { should belong_to :microsite }
end
