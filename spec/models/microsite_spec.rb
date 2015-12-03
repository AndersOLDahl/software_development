require 'spec_helper'

describe Microsite do
  it { should have_many :readings }
  it { should validate_presence_of :site }
  it { should validate_presence_of :field_lat }
  it { should validate_presence_of :field_lat }
  it { should validate_numericality_of :field_lon }
  it { should validate_numericality_of :field_lon }
  it { should validate_presence_of :location }
  it { should validate_presence_of :state_province }
  it { should validate_presence_of :country }
  it { should validate_presence_of :biomimic }
  it { should validate_numericality_of :tide_height }
end
