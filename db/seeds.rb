# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).

Reading.destroy_all
Microsite.destroy_all
(1..10).each do |i|
  microsite = Microsite.new(microsite_id: "ID" + i.to_s,
                            site: "TEST" + i.to_s,
                            field_lat: i,
                            field_lon: i,
                            location: "TEST" + i.to_s,
                            state_province: "TEST" + i.to_s,
                            country: "TEST" + i.to_s,
                            biomimic: "TEST" + i.to_s,
                            zone: "TEST" + i.chr,
                            sub_zone: "TEST" + i.to_s,
                            wave_exp: i,
                            tide_height: i
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
