module MailingService
  class Mailer < ApplicationService
    def initialize(data)
      @data = data
    end

    def call
      # Assuming we have email service listening RabbitMQ somewhere
      RabbitService::TaskPublisher.call(
        queue_name: 'mandrill',
        data: {
          # ...
          # some template data
        }
      )
    end
  end
end
