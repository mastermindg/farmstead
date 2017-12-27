# frozen_string_literal: true

# Base Class for all micro-services
module Farmstead
  class Service
    def initialize
      read_environment
      mysql_init
      @kafka = Kafka.new(
        seed_brokers: ["#{@broker_host}:9092"],
        client_id: @service_name
      )
      @producer = @kafka.producer
      @consumer = @kafka.consumer(group_id: @service_name)
      @logfile = "/tmp/farmlog"
    end

    def read_environment
      @broker_host = ENV['KAFKA_ADVERTISED_HOST_NAME']
      @mysql_host = ENV['MYSQL_HOST']
      @mysql_pass = ENV['MYSQL_PASSWORD']
      @mysql_user = ENV['MYSQL_USER']
      @mysql_db = ENV['MYSQL_DATABASE']
      @service_name = ENV['SERVICE']
      #@selenium_hub = ENV['SELENIUM_HUB']
    end

    def mysql_init
      @mysql = Mysql2::Client.new(
        host: @mysql_host,
        username: @mysql_user,
        password: @mysql_pass,
        database: @mysql_db
      )
    end

    # Runs on an infinite loop processing records
    # on MySQL DB and writing messages accordingly
    def producer
      loop do
        puts 'Producing'
      end
    end

    # Subscribes to a Topic
    # Works on the message
    def consumer
      loop do
        puts 'Consuming'
      end
    end

    # Each Farmstead site has a Class that defines it
    # Each service runs one or more methods on that Class
    def find_definitions(site, service)
      mysite = @mysql.query("SELECT * FROM sites WHERE name = '#{site}'")
      return false if mysite.count.zero?
      mysite.each do |sited|
        json = sited.to_json
        config = get_from_json(json, 'config')
        # Convert to hash where each element is a service and then associate it
        # with the service name passed to this method
      end
    end

    def doit
      find_definitions('Yahoo', 'scarecrow')
    end

    def write_message(message, topic)
      @producer.produce(message, topic)
      @producer.deliver_messages
    end

    # Appends to existing file
    def write_file(filename, text)
      File.open(filename, 'a') { |file| file.write("#{text}\n") }
    end

    # Gets the value of an element from json
    def get_from_json(json, element)
      hash = JSON.parse(json)
      hash[element]
    end

    def print_time
      time1 = Time.new
      write_file(@logfile, "Current Time : #{time1.inspect}")
    end
  end
end
