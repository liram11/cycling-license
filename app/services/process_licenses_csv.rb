require 'csv'

class ProcessLicensesCsv < ApplicationService
  def initialize(license_upload)
    @license_upload = license_upload
  end

  def call
    csv = @license_upload.csv.download

    CSV.parse(csv, headers: true,  col_sep: ';') do |row|
      # TODO extract every pdf generation in separted task
      user_license = GenerateUserLicense.call(
        row.to_h.symbolize_keys.merge({
          license_upload_id: @license_upload.id,
          certification_center_id: @license_upload.certification_center.id
        })
      )

      mail_data = {
        template: 'user-license-processed'
        # TODO add attachment and template data
      }

      MailingService::Mailer.call(mail_data)
    end
  end
end
