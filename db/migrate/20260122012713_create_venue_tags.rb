class CreateVenueTags < ActiveRecord::Migration[8.0]
  def change
    create_table :venue_tags do |t|
      t.references :venue, null: false, foreign_key: true
      t.references :tag, null: false, foreign_key: true

      t.timestamps
    end
    add_index :venue_tags, [ :venue_id, :tag_id ], unique: true
  end
end
