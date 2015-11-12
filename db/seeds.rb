# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Microsite.destroy_all
10.times do
  microsite = Microsite.new(site: "TEST",
                            field_lat: rand(-90...91),
                            field_lon: rand(-180...191),
                            location: "TEST",
                            state_province: "TEST",
                            country: "TEST",
                            biomimic: "TEST",
                            zone: "TEST",
                            sub_zone: "TEST",
                            wave_exp: rand(0...100),
                            tide_height: rand(0...100)
                           )
  microsite.save!
end

User.new(:email => "user@name.com", :password => 'password', :password_confirmation => 'password').save
User.new(:email => "dahl.a@husky.neu.edu", :password => 'password', :password_confirmation => 'password').save
