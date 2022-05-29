class LicenseUpload < ApplicationRecord
  belongs_to :certification_center
  has_many :license_upload_errors

  has_one_attached :csv
end
