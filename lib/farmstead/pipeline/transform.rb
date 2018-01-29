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
    class Service < Farmstead::Service
      def run
        @consumer.subscribe("Forest")
        trap('TERM') { @consumer.stop }
        @consumer.each_message do |message|
          puts "Received: #{message.value}"
          # Run the load method of the module referenced by the message
          obj = JSON.parse(message.value)
          project_name = ENV["name"].capitalize
          module_name = obj["module_name"]
          my_module = Object.const_get "#{project_name}::#{module_name}"
          result = my_module::transform(obj["result"])
          Farmstead::DB.insert("test",result: result)
          @producer.produce(result, topic: "Road")
          @producer.deliver_messages
          @consumer.mark_message_as_processed(message)
        end
      end
    end
  end
end
