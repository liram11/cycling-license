
FactoryBot.define do
  factory :license_upload do
    csv { Rack::Test::UploadedFile.new "#{Rails.root}/spec/fixtures/license_upload/correct.csv" }
    certification_center_id { 1 }
  end
end
