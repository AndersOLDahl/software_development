class CreateReadings < ActiveRecord::Migration
  def change
    create_table :readings do |t|
      t.integer :microsite_id
      t.timestamp :timestamp
      t.float :temperature
    end

    add_foreign_key :readings, :microsites
  end
end
