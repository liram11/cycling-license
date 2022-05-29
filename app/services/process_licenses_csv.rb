require 'csv'

class ProcessLicensesCsv < ApplicationService
  def initialize(license_upload, csv)
    @license_upload = license_upload
    @csv = csv
  end

  def call
    row_count = 0
    CSV.parse(@csv, headers: true,  col_sep: ';') do |row|
      RabbitService::TaskPublisher.call(
        queue_name: 'generate_license',
        data: row.to_h.merge({
          license_upload_id: @license_upload_id
        })
      )
      row_count += 1
    end

    @license_upload.update!(row_count: row_count)
  end
end
