FactoryGirl.define do
  factory :reading do
    microsite_id    1
    timestamp       Time.now.utc.to_date
    temperature     1.5
  end
end
