require 'rails_helper'

RSpec.describe "LicenseUploads", type: :request do
  describe "GET /create" do
    it "returns http success" do
      get "/license_uploads/create"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /show" do
    it "returns http success" do
      get "/license_uploads/show"
      expect(response).to have_http_status(:success)
    end
  end

end
