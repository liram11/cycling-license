class ApplicationController < ActionController::Base
  protect_from_forgery with: :null_session

  def current_user
    CertificationCenter.find_by(email: "cc@gmail.com")
  end
end
