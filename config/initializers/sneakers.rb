require 'sneakers'

Sneakers.configure  connection: Bunny.new,
                    ack: true
