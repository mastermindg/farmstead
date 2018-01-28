# frozen_string_literal: true

# Load data into database
#
# Runs a Consumer and it will automatically pick up
# messages from the Road Topic and load the message into
# the database
#
# Every micro-service inherits the Service class
module Farmstead
  module Load
    class Service < Farmstead::Service
      def run
        @consumer.subscribe("Road")
        trap('TERM') { @consumer.stop }
        @consumer.each_message do |message|
          puts "Received: #{message.value}"
          # Run the load method of the module referenced by the message
          obj = JSON.parse(message.value)
          my_module = Object.const_get "<%= ENV['name'].capitalize %>::#{obj["module"]}"
          result = my_module::load
          Farmstead::DB.insert("test",result: result)
          @consumer.mark_message_as_processed(message)
        end
      end
    end
  end
end
