class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    enable_extension 'citext' unless extension_enabled?('citext')

    create_table :users do |t|
      t.citext :email
      t.string :encrypted_password
      t.string :name
      t.string :last_name
      t.string :status

      t.timestamps
    end

    add_index :users, :email, unique: true
  end
end
