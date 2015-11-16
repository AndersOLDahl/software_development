class CreateReadings < ActiveRecord::Migration
  def change
    create_table :readings do |t|
      t.integer :microsite_id
      t.timestamp :timestamp, null: false
      t.float :temperature, null: false
    end

    add_foreign_key :readings, :microsites
  end
end
