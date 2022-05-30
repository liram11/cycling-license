namespace :admin_stat do
  desc 'notify admin about daily activity'
  task send: :environment do
    processed_licenses_count = ::UserLicense.where(created_at: (Time.now - 1.day)...Time.now).count

    errors_count = LicenseUploadError.where(created_at: (Time.now - 1.day)...Time.now).count

    mail_data = {
      template: 'bu-admin-notification',
      email: 'admin@test.com', #TODO extract
      data: {
        processed_licenses_count: processed_licenses_count,
        errors_count: errors_count
      }
      # TODO add template data
    }

    MailingService::Mailer.call(mail_data)
  end
end
