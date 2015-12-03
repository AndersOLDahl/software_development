class Microsite < ActiveRecord::Base
  has_many :readings
  validates :site, presence: true
  validates :field_lat, presence: true, numericality: true, inclusion: -90..90
  validates :field_lon, presence: true, numericality: true, inclusion: -180..180
  validates :location, presence: true
  validates :state_province, presence: true
  validates :country, presence: true
  validates :biomimic, presence: true
  validates :tide_height, numericality: true
end
