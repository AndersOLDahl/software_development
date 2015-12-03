class CreateMicrosites < ActiveRecord::Migration
  def change
    create_table :microsites do |t|
      t.string :site, null: false
      t.float :field_lat, null: false
      t.float :field_lon, null: false
      t.string :location, null: false
      t.string :state_province, null: false
      t.string :country, null: false
      t.string :biomimic, null: false
      t.string :zone
      t.string :sub_zone
      t.string :wave_exp
      t.float :tide_height
    end
  end
end
