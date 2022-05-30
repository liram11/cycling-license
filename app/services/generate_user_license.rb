

class GenerateUserLicense < ApplicationService
  def initialize(license_params)
    @params = license_params
  end

  def call
    unless is_params_valid?(@params)
      LicenseUploadError.create!(license_upload_id: @params[:license_upload_id], data: @params)
      return
    end

    user = User.find_or_initialize_by(email: @params[:email])

    if user.new_record?
      user.name = @params[:name]
      user.last_name = @params[:last_name]
      user.save!
    end

    generate_license(user, @params)
  end

  private

  # TODO check if params valid
  def is_params_valid?(params)
    return false if params[:name].blank? || params[:last_name].blank?
    return false unless params[:email].include?('@')
    return false if params[:expires_at].blank?

    true
  end

  def generate_license(user, params)
    cycling_license = UserLicense.create!(
      user_id: user.id,
      certification_center_id: params[:certification_center_id],
      expires_at: params[:expires_at],
      license_type: 'cycling'
    )

    cycling_license.pdf.attach(io: generate_pdf, filename: 'cycling.pdf', content_type: 'application/pdf')

    cycling_license
  end

  # TODO validate paramsgenerate pdf
  def generate_pdf
    File.open(Rails.root + "spec/fixtures/license/sample.pdf")
  end
end
