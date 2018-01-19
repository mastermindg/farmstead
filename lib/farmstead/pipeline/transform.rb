# frozen_string_literal: true

# Transform data
#
# Arrange data into usable blocks
#
#
# Running as a Consumer and it will automatically pick up
# messages from the Forest topic and do it's job and then send
# a message as a Producer to the Road topic
#
# Every micro-service inherits the Service class
module Farmstead
  module Transform
    # Does nothing...work is handled by magic_work
    class Producer < Farmstead::Service
      def run!
        loop do
          puts "Do nothing"
          sleep 300
        end
      end
    end

    # Subscribed to the Field topic
    # Works on message
    class Consumer < Farmstead::Service
      def run!
        @consumer.subscribe('Forest')
        trap('TERM') { @consumer.stop }
        @consumer.each_message do |message|
          puts "Received: #{message.value}"
          magic_work(message.value)
          @consumer.mark_message_as_processed(message)
        end
      end

      def magic_work(site)
        hash = JSON.parse(site)
        hash['cowardlylion'] = 'true'
        json = hash.to_json
        puts "Writing: #{json}"
        write_message(json, topic: 'Road')
      end
    end
  end
end
