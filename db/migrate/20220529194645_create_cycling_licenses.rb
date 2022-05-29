class CreateCyclingLicenses < ActiveRecord::Migration[7.0]
  def change
    create_table :cycling_licenses do |t|
      t.belongs_to :user, foreign_key: true, index: true, on_delete: :cascade, null: false
      t.belongs_to :certification_center, foreign_key: true, index: true, null: false

      t.datetime :expires_at, null: false
      t.timestamps
    end
  end
end
