class CreateLicenseUploads < ActiveRecord::Migration[7.0]
  def change
    create_table :license_uploads do |t|
      t.belongs_to :certification_center, foreign_key: true, index: true, on_delete: :cascade, null: false
      t.timestamps
    end
  end
end
