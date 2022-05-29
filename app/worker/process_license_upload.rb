class ProcessLicenseUpload
  include Sneakers::Worker
  from_queue 'process_license_upload'

  def work(msg)

    pp msg
    ack!
  end
end
