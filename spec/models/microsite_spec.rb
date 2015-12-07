require 'spec_helper'

describe Microsite do
  it { should have_many :readings }
  it { should validate_presence_of :microsite_id }
  it { should validate_uniqueness_of :microsite_id }
  it { should validate_presence_of :site }
  it { should validate_presence_of :field_lat }
  it { should validate_numericality_of :field_lat }
  it { should validate_inclusion_of(:field_lat).in_range(-90..90) }
  it { should validate_presence_of :field_lon }
  it { should validate_numericality_of :field_lon }
  it { should validate_inclusion_of(:field_lon).in_range(-180..180) }
  it { should validate_presence_of :location }
  it { should validate_presence_of :state_province }
  it { should validate_presence_of :country }
  it { should validate_presence_of :biomimic }
  it { should validate_numericality_of :tide_height }
end
