class CreateCertificationCenters < ActiveRecord::Migration[7.0]
  def change
    enable_extension 'citext' unless extension_enabled?('citext')

    create_table :certification_centers do |t|
      t.string :name
      t.citext :email
      t.string :encrypted_password

      t.timestamps
    end

    add_index :certification_centers, :email, unique: true
  end
end
