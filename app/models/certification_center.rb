class CertificationCenter < ApplicationRecord
  has_many :cycling_licenses
  has_many :license_uploads
end
