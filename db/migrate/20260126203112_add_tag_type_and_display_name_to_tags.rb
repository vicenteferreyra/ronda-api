class AddTagTypeAndDisplayNameToTags < ActiveRecord::Migration[8.0]
  def change
    add_column :tags, :tag_type, :integer, default: 0, null: false
    add_column :tags, :display_name, :string
  end
end
