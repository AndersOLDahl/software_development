class AddMicrositeIdToColumnToMicrosites < ActiveRecord::Migration
  def change
    add_column :microsites, :microsite_id, :string
  end
end
