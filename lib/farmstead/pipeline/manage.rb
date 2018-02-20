# Manage
#
# It works off of the DB when
# 1) A new source is added
# 2) A scheduled source pull is configured to happen
#
# Field --> Forest --> Road
#
# It then takes the config from the DB and passed it to the Field topic
# 
# The Extract class pulls the source config from the Field Topic and then pushes
# source data to the Forest topic.
# 
# The Transform class pulls the source data from teh Forest topic and then pushes 
# to the Road topic.
# 
# The Load class pulls data from the Road topic and loads it into the database.
#
# Topics are created when Kafka comes up
# HINT: See .env
# Every micro-service inherits the Service class
module Farmstead
  module Manage
    class Service < Farmstead::Service
      def run
        puts "Starting Manager"
        # Cycle thru sources, pull config and pass to Kafka
        sources = Farmstead::DB.select_all("sources")
        puts sources.inspect
        sources.each do |source|
          module_name = source[:module]
          puts module_name
          @producer.produce(module_name, topic: "Field")
          @producer.deliver_messages
          Farmstead::DB.mark_pickedup(module_name)
        end
      end

      # Checks for any new sources to be processed
      # Adds them to the message queue
      def check_sources
        sources = @mysql.query("SELECT * FROM sources WHERE pickedup = 'false'")
        return false if sources.count.zero?
        sources.each do |source|
          json = source.to_json
          sourceid = get_from_json(json, 'id')
          # import_source(json, sourceid)
          write_message(json, topic: 'Wood')
          mark_pickedup(sourceid)
        end
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

      # Imports source data as a Hash into MySQL DB
      def import_source(sourcehash, sourceid)
        sourcehash
      end
    end
  end
end

