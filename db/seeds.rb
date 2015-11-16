# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).

Reading.destroy_all
Microsite.destroy_all
10.times do
  microsite = Microsite.new(site: "TEST" + rand(65...70).chr,
                            field_lat: rand(-90...91),
                            field_lon: rand(-180...191),
                            location: "TEST" + rand(65...70).chr,
                            state_province: "TEST" + rand(65...70).chr,
                            country: "TEST" + rand(65...70).chr,
                            biomimic: "TEST" + rand(65...70).chr,
                            zone: "TEST" + rand(65...70).chr,
                            sub_zone: "TEST" + rand(65...70).chr,
                            wave_exp: rand(0...100),
                            tide_height: rand(0...100)
                           )
  microsite.save!

  5.times do
      reading = Reading.new(microsite_id: microsite.id,
                            timestamp: Time.at(Time.now().to_f - rand(0...500000000)),
                            temperature: rand(-5...30))
      reading.save!
  end
end

User.new(:email => "user@name.com", :password => 'password', :password_confirmation => 'password').save
User.new(:email => "dahl.a@husky.neu.edu", :password => 'password', :password_confirmation => 'password').save
User.new(:email => "abraham.emi@husky.neu.edu", :password => 'password', :password_confirmation => 'password').save
