class ProcessLicenseUpload
  include Sneakers::Worker
  from_queue 'process_license_upload'

  def work(msg)
    message = JSON.parse(msg, :symbolize_names => true)
    license_upload_id = message[:license_upload_id]

    raise ArgumentError, 'msg should have license_upload_id' if license_upload_id.blank?

    license_upload = LicenseUpload.find(license_upload_id)

    ProcessLicensesCsv.call(license_upload)

    notify_certification_center

    ack!
  end

  private

  def notify_certification_center
    errors_count = license_upload.license_upload_errors.count

    mail_data = {
      template: 'certification-center-csv-processed',
      email: license_upload.certification_center.email,
      data: {
        errors_count: errors_count
        license_upload_id: license_upload.id
      }
      # TODO add template data
    }

    MailingService::Mailer.call(mail_data)
  end
end
