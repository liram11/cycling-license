class Api::V1::CertificationCenter::LicenseUploadsController < ApplicationController

# curl -H 'Content-Type: multipart/form-data' -F license_upload[file]=@/Users/liram/work/cycling-license-interview-task/cycling-license/spec/fixtures/license_upload/correct.csv http://localhost:3000/api/v1/certification_center/license_uploads
  def create
    license_upload = LicenseUpload.create!(
      certification_center: current_user
    )

    license_upload.csv.attach(license_upload_params[:file])

    RabbitService::TaskPublisher.call(
      queue_name: 'process_license_upload',
      data: {
        license_upload_id: license_upload.id
      }
    )

    render json: license_upload, serializer: Api::V1::LicenseUploadSerializer
  end

  # TODO
  def show
  end

  private

  def license_upload_params
    params.require(:license_upload).permit(:file)
  end
end
