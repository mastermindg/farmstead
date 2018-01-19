# frozen_string_literal: true

# Extract data from the source
#
# Runs a Consumer and it will automatically pick up
# messages from the Field Topic and do it's job
# and then send a message as a Producer to the Forest Topic
#
# Every micro-service inherits the Service class
module Farmstead
  OPERATION = 1
  module Extract
    class Producer < Farmstead::Service
      def doit
        loop do
          puts "Do something"
          sleep 300
        end
      end
    end

    # Subscribed to the Field topic
    # Works on message
    class Consumer < Farmstead::Service
      def doit
        @consumer.subscribe('Field')
        trap('TERM') { @consumer.stop }
        @consumer.each_message do |message|
          puts "Received: #{message.value}"
          magic_work(message.value)
          @consumer.mark_message_as_processed(message)
        end
      end

      def magic_work(site)
        hash = JSON.parse(site)
        hash['scarecrow'] = 'true'
        json = hash.to_json
        puts "Writing: #{json}"
        write_message(json, topic: 'Forest')
      end
    end
  end
end
