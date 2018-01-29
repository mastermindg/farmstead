# frozen_string_literal: true

# Extract data from the source
#
# Runs a Consumer and it will automatically pick up
# messages from the Field Topic and do it's job
# and then send a message as a Producer to the Forest Topic
#
# Every micro-service inherits the Service class
module Farmstead
  module Extract
    class Service < Farmstead::Service
      def run
        message = "StopandShop"
        puts "Received: #{message}"
        project_name = ENV["name"].capitalize
        my_module = Object.const_get "#{project_name}::#{module_name}"
        result = my_module::extract
        puts result.inspect
        Farmstead::DB.insert_test(result)
      end

      def runs
        @consumer.subscribe("Field")
        trap('TERM') { @consumer.stop }
        @consumer.each_message do |message|
          puts "Received: #{message.value}"
          # The Field message only contains the module name
          module_name = message.value
          my_module = Object.const_get "<%= ENV['name'].capitalize %>::#{module_name}"
          result = my_module::extract
          puts result.inspect
          Farmstead::DB.insert_test(result)
          #@producer.produce(result, topic: "Forest")
          #@producer.deliver_messages
          #@consumer.mark_message_as_processed(message)
        end
      end
    end
  end
end

