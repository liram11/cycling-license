class ApplicationController < ActionController::Base
  protect_from_forgery with: :null_session

  # mock for now
  def current_certification_center
    CertificationCenter.find_by(email: "cc@gmail.com")
  end

  # mock for now
  def current_user
    User.find_by(email: "test1@gmail.com")
  end
end
