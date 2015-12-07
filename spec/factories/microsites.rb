FactoryGirl.define do
  factory :microsite do
    site            "Test Site"
    field_lat       1.5
    field_lon       1.5
    location        "Boston"
    state_province  "MA"
    country         "USA"
    biomimic        "Test biomimic"
    zone            "Test zone"
    sub_zone        "Test sub_zone"
    wave_exp        1.5
    tide_height     1.5

    factory :microsite_with_reading do
      after(:create) do |microsite|
        create(:reading, microsite: microsite)
      end
    end
  end
end
