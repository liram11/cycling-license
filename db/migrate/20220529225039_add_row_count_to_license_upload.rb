class AddRowCountToLicenseUpload < ActiveRecord::Migration[7.0]
  def change
    add_column :license_uploads, :row_count, :integer
  end
end
