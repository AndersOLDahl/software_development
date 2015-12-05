class Reading < ActiveRecord::Base
    belongs_to :microsite
    validates :timestamp, presence: true
    validates :temperature, presence: true

    def self.csv_header
        CSV::Row.new([:timestamp, :temperature, :site, :field_lat, :field_lon, :location, :state_province, :country, :biomimic, :zone, :sub_zone, :wave_exp, :tide_height],
                     ['Time', 'Temperature', 'Site', 'Latitude', 'Longitude', 'Location', 'State/Province', 'Country', 'Biomimic', 'Zone', 'Sub-Zone', 'Wave Exposure', 'Tide Height'],
                     true)
    end

    def to_csv_row
        microsite = Microsite.find(microsite_id)
        CSV::Row.new([:timestamp, :temperature, :site, :field_lat, :field_lon, :location, :state_province, :country, :biomimic, :zone, :sub_zone, :wave_exp, :tide_height],
                     [timestamp.strftime("%m/%d/%Y %H:%M"),
                      temperature,
                      microsite.site,
                      microsite.field_lat,
                      microsite.field_lon,
                      microsite.location,
                      microsite.state_province,
                      microsite.country,
                      microsite.biomimic,
                      microsite.zone,
                      microsite.sub_zone,
                      microsite.wave_exp,
                      microsite.tide_height])
    end
end
