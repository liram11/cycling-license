class CreateLicenseUploadErrors < ActiveRecord::Migration[7.0]
  def change
    create_table :license_upload_errors do |t|
      t.belongs_to :license_upload, foreign_key: true, index: true, on_delete: :cascade, null: false

      t.jsonb :data, null: false, default: {}

      t.timestamps
    end
  end
end
