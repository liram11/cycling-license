class ProcessLicenseUpload
  include Sneakers::Worker
  from_queue 'process_license_upload'

  def work(msg)
    message = JSON.parse(msg, :symbolize_names => true)
    license_upload_id = message[:license_upload_id]

    raise ArgumentError, 'msg should have license_upload_id' if license_upload_id.blank?

    license_upload = LicenseUpload.find(license_upload_id)

    ProcessLicensesCsv.call(license_upload)

    ack!
  end
end
