require 'rails_helper'

describe GenerateUserLicense do

  let(:user) { create(:user) }
  let(:certification_center) { create(:certification_center) }
  let(:license_upload) { create(:license_upload, certification_center: certification_center) }

  context 'when params is valid' do
    let(:params) {
      {
        email: 'test@example.com',
        name: 'foo',
        last_name: 'bar',
        license_upload_id: license_upload.id,
        certification_center_id: certification_center.id,
        expires_at: '2026-10-05T00:00:00.000Z'
       }
    }

    before do
      GenerateUserLicense.new(params).call
    end

    it 'creates user license' do
      expect(UserLicense.all.count).to eq 1
    end
    it 'creates pdf' do
      expect(UserLicense.last.pdf.download).to be_truthy
    end
  end


  context 'when name is missing' do
    let(:params) {
      {
        email: 'test@example.com',
        last_name: 'bar',
        license_upload_id: license_upload.id,
        certification_center_id: certification_center.id,
        expires_at: '2026-10-05T00:00:00.000Z'
       }
    }

    before do
      GenerateUserLicense.new(params).call
    end

    it 'do not create user license' do
      expect(UserLicense.all.count).to eq 0
    end
  end


  context 'when email is invalid' do
    let(:params) {
      {
        email: '+234234234123',
        name: 'foo',
        last_name: 'bar',
        license_upload_id: license_upload.id,
        certification_center_id: certification_center.id,
        expires_at: '2026-10-05T00:00:00.000Z'
       }
    }

    before do
      GenerateUserLicense.new(params).call
    end

    it 'do not create user license' do
      expect(UserLicense.all.count).to eq 0
    end
  end

  context 'when last_name is missing' do
    let(:params) {
      {
        email: 'test@example.com',
        name: 'bar',
        license_upload_id: license_upload.id,
        certification_center_id: certification_center.id,
        expires_at: '2026-10-05T00:00:00.000Z'
       }
    }

    before do
      GenerateUserLicense.new(params).call
    end

    it 'do not create user license' do
      expect(UserLicense.all.count).to eq 0
    end
  end


  context 'when expires_at is missing' do
    let(:params) {
      {
        email: 'test@example.com',
        name: 'bar',
        last_name: 'bar',
        license_upload_id: license_upload.id,
        certification_center_id: certification_center.id,
      }
    }

    before do
      GenerateUserLicense.new(params).call
    end

    it 'do not create user license' do
      expect(UserLicense.all.count).to eq 0
    end
  end
end
