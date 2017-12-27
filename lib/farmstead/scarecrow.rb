# frozen_string_literal: true

# Scarecrow - the Harvester
#
# Scarecrow is responsible for extracting data from a source
#
# Scarecrow is running as a Consumer and it will automatically pick up
# messages from the Field Topic and do it's job
# and then send a message as a Producer to the Forest Topic
#
# Every micro-service inherits the Service class
module Farmstead
  class Scarecrow < Service
    # Picks up JSON generated by WebDriver and save it to Forest topic
    def producer
      loop do
        puts 'Do something'
        sleep 300
      end
    end

    # Subscribed to the Field topic
    # Works on message
    def consumer
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

    # Call the Site Class
    def call_class
      puts 'this'
    end

    def selenium
      browser = Watir::Browser.new :chrome
      browser.goto 'http://www.stackoverflow.com'
      puts browser.title
      # browser.text_field(title: 'Search').set 'Hello World!'
      # browser.button(type: 'submit').click
      # puts browser.title
      browser.quit
    end
  end
end
