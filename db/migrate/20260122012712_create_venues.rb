class CreateVenues < ActiveRecord::Migration[8.0]
  def change
    create_table :venues do |t|
      t.string :name
      t.string :price_range
      t.string :address
      t.decimal :latitude
      t.decimal :longitude

      t.timestamps
    end
    add_index :venues, [ :latitude, :longitude ]
  end
end
