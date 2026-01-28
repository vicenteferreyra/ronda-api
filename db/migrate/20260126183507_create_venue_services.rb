class CreateVenueServices < ActiveRecord::Migration[8.0]
  def change
    create_table :venue_services do |t|
      t.references :venue, null: false, foreign_key: true
      t.references :service, null: false, foreign_key: true

      t.timestamps
    end
    add_index :venue_services, [ :venue_id, :service_id ], unique: true
  end
end
