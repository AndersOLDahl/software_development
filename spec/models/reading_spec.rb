require "spec_helper"

describe Reading do
  it { should belong_to :microsite }
  it { should validate_presence_of :timestamp }
  it { should validate_presence_of :temperature }
end
