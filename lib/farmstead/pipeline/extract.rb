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
        @consumer.subscribe("Field")
        trap('TERM') { @consumer.stop }
        @consumer.each_message do |message|
          puts "Received: #{message.value}"
          # Run the extract method of the module referenced by the message
          obj = JSON.parse(message.value)
          my_module = Object.const_get "<%= ENV['name'].capitalize %>::#{obj["module"]}"
          result = my_module::extract
          Farmstead::DB.insert("test",result: result)
          @producer.produce(result, topic: "Forest")
          @producer.deliver_messages
          @consumer.mark_message_as_processed(message)
        end
      end
    end
  end
end

