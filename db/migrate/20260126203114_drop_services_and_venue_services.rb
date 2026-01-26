class DropServicesAndVenueServices < ActiveRecord::Migration[8.0]
  def change
    drop_table :venue_services if table_exists?(:venue_services)
    drop_table :services if table_exists?(:services)
  end
end
