# Manage
#
# It works off of the DB when
# 1) A new site is added
# 2) A scheduled site pull is configured to happen
#
# Field --> Forest --> Road
#
# It then takes the config from the DB and passed it to the Wood topic
# 
# The Extract class pulls the site config from the Field Topic and then pushes
# site data to the Forest topic.
# 
# The Transform class pulls the site data from teh Forest topic and then pushes 
# to the Road topic.
# 
# The Load class pulls data from the Road topic and loads it into the database.
#
# Topics are created when Kafka comes up
# HINT: See .env
# Every micro-service inherits the Service class
module Farmstead
  module Manage
    class Producer < Farmstead::Service
      def run
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
      def run
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

