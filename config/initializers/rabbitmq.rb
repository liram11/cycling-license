require "bunny"

class Rabbitmq
  class << self
    attr_writer :connection

    # TODO: add channel pooling and retry logic
    def connect
      channel.prefetch(1)
      channel
    end

    def connection
      @connection ||= Bunny.new.tap(&:start)
    end

    def channel
      @channel ||= connection.create_channel
    end
  end
end
