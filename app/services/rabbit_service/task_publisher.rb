module RabbitService
  class TaskPublisher < ApplicationService
    def initialize(queue_name:, data:)
      raise ArgumentError, 'queue_name should be a String' unless queue_name.is_a?(String)
      raise ArgumentError, 'data should be a Hash' unless data.is_a?(Hash)

      @queue_name = queue_name
      @message = data.to_json
    end

    def call
      channel = Rabbitmq.connect
      queue = channel.queue(@queue_name, durable: true)

      queue.publish(@message, persistent: true)
    end
  end
end
