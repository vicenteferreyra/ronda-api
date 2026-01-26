class AddFieldsToVenues < ActiveRecord::Migration[8.0]
  def change
    add_column :venues, :phone_number, :string
    add_column :venues, :website, :string
    add_column :venues, :description, :text
  end
end
