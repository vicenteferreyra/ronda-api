class CreateUsers < ActiveRecord::Migration[8.0]
  def change
    create_table :users do |t|
      t.string :email, null: false
      t.string :password_digest
      t.string :name, null: false
      t.string :provider, default: "email"
      t.string :provider_uid

      t.timestamps
    end

    add_index :users, :email, unique: true
    add_index :users, [:provider, :provider_uid]
  end
end
