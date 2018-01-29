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
        puts "Received: #{message.value}"
          # Run the load method of the module referenced by the message
          message = '{"module_name":"StopandShop","result":"Home - stop and shop"}'
          obj = JSON.parse(message)
          project_name = ENV["name"].capitalize
          module_name = obj["module_name"]
          my_module = Object.const_get "#{project_name}::#{module_name}"
          puts obj["result"]
          my_module::load(obj["result"])
      end

      def runs
        @consumer.subscribe("Road")
        trap('TERM') { @consumer.stop }
        @consumer.each_message do |message|
          puts "Received: #{message.value}"
          # Run the load method of the module referenced by the message
          obj = JSON.parse(message.value)
          project_name = ENV["name"].capitalize
          module_name = obj["module_name"]
          my_module = Object.const_get "#{project_name}::#{module_name}"
          puts obj["result"]
          my_module::load(obj["result"])
          @consumer.mark_message_as_processed(message)
        end
      end
    end
  end
end
