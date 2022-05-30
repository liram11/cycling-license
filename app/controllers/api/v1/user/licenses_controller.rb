class Api::V1::User::LicensesController < ApplicationController

  def index
    user_licenses = current_user.user_licenses

    render json: user_licenses, each_serializer: Api::V1::LicenseUploadSerializer
  end

  def show
    license = current_user.user_licenses.find(params[:id])

    if (license.present?)
      send_file(
        pdf_path(license.pdf),
        :filename => "cycling_license.pdf",
        :type => "application/pdf"
      )
    end

    render plain: 'Not found'
  end

  private

  #TODO fix url generation
  def pdf_path(pdf)
    Rails.application.routes.url_helpers.rails_blob_path(pdf)
  end
end
