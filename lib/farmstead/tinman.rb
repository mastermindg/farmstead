# frozen_string_literal: true

# Tinman - the Fertilizer
#
# Tinman is responsible for analyzing a site for changes
# and updating site configs
#
# None of the logic has actually been built and
# this may require some AI but for now it's
# just responding that everything is OK
#
# Tinman is running as a Consumer to the Wood topic and it will automatically
# pick up the message, do it's job and then send a message
# as a Producer to the Field topic
#
# Every micro-service inherits the Service class
module Farmstead
  class Tinman < Service
    # Doing nothing...for now
    # thi is handled by magic_work
    def producer
      loop do
        puts 'Doing nothing'
        sleep 300
      end
    end

    # Subscribed to the Wood topic
    # Works on message
    def consumer
      @consumer.subscribe('Wood')
      trap('TERM') { @consumer.stop }
      @consumer.each_message do |message|
        puts "Received: #{message.value}"
        magic_work(message.value)
        @consumer.mark_message_as_processed(message)
      end
    end

    # Do the magic work to determine if the site has changed
    # and update the config
    # Returns JSON String
    def magic_work(site)
      hash = JSON.parse(site)
      hash['tinman'] = 'true'
      json = hash.to_json
      puts "Writing: #{json}"
      write_message(json, topic: 'Field')
    end
  end
end
