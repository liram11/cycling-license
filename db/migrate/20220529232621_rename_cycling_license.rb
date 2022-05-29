class RenameCyclingLicense < ActiveRecord::Migration[7.0]
  def change
    add_column :cycling_licenses, :license_type, :string, null: false

    rename_table :cycling_licenses, :user_licenses
  end
end
