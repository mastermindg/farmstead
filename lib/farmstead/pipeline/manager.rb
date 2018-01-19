# Manager
#
# It works off of the DB when
# 1) A new site is added
# 2) A scheduled site pull is configured to happen
#
# It then takes the config from the DB and passed it to the Wood topic
#
# Tinman is running as a Consumer and it will automatically pick up the message
# and do it's job and then send a message (as a Producer) to the Field topic
#
# Scarecrow is running as a Consumer and it will automatically pick up the
# message and do it's job and then send a message (as a Producer)
# to the Forest topic
#
# CowardlyLion is running as a Consumer and it will automatically pick up the
# message and do it's job and then send a message (as a Producer)
# to the Road topic
#
# Glenda is running as a Consumer and it will automatically pick up messages
# from the Road topic. This is the final product of scraping a site. It's stored
# in a Hash. Glenda imports the Hash into the MySQL database where it is
# presented by Dorothy
#
# Topics are created when Kafka comes up
# HINT: See .env
# Every micro-service inherits the Service class
module Farmstead
  module Manager
    class Producer < Farmstead::Service
      def run!
        loop do
          puts 'Checking sites'
          check_sites
          puts 'Checking tasks'
          # regular_tasks
          sleep 3
        end
      end

      # Checks for any new sites to be processed
      # Adds them to the message queue
      def check_sites
        sites = @mysql.query("SELECT * FROM sites WHERE pickedup = 'false'")
        return false if sites.count.zero?
        sites.each do |site|
          json = site.to_json
          siteid = get_from_json(json, 'id')
          # import_site(json, siteid)
          write_message(json, topic: 'Wood')
          mark_pickedup(siteid)
        end
      end
    end

    # Subscribed to the Road topic
    # Imports Hash into MySQL Database for each message
    class Consumer < Farmstead::Service
      def run!
        @consumer.subscribe('Road')
        trap('TERM') { @consumer.stop }
        @consumer.each_message do |message|
          puts "Received: #{message.value}"
          hash = JSON.parse(message.value)
          import_site(hash, hash[:id])
          mark_processed(hash[:id])
          @consumer.mark_message_as_processed(message)
        end
      end

      # Checks for any new sites to be processed
      # Adds them to the message queue
      def check_sites
        sites = @mysql.query("SELECT * FROM sites WHERE pickedup = 'false'")
        return false if sites.count.zero?
        sites.each do |site|
          json = site.to_json
          siteid = get_from_json(json, 'id')
          # import_site(json, siteid)
          write_message(json, topic: 'Wood')
          mark_pickedup(siteid)
        end
      end

      # Sets the value of pickedup to true
      def mark_pickedup(siteid)
        @mysql.query("UPDATE sites SET pickedup = 'true' WHERE id = #{siteid}")
      end

      # Sets the value of processed to true
      def mark_processed(siteid)
        @mysql.query("UPDATE sites SET processed = 'true' WHERE id = #{siteid}")
      end

      # Checks for any processing tasks that need to be
      # completed at speicifc times
      def regular_tasks
        tasks = @mysql.query("SELECT * FROM tasks WHERE processed = 'false'")
        return false if tasks.count.zero?
        tasks.each do |task|
          json = task.to_json
          taskid = get_id(task)
          write_message(json, topic: 'Wood')
          mark_pickedup(taskid)
        end
      end

      # Imports site data as a Hash into MySQL DB
      def import_site(sitehash, siteid)
        sitehash
      end
    end
  end
end

