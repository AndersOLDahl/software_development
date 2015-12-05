class CreateMicrosites < ActiveRecord::Migration
  def change
    create_table :microsites do |t|
      t.string :site
      t.float :field_lat
      t.float :field_lon
      t.string :location
      t.string :state_province
      t.string :country
      t.string :biomimic
      t.string :zone
      t.string :sub_zone
      t.string :wave_exp
      t.float :tide_height
    end
  end
end
