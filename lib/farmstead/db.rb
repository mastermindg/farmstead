require "sequel"

module Farmstead
  class DB
    def self.pull_variables
      @@mysql_host = ENV["MYSQL_HOST"]
      @@mysql_password = ENV["MYSQL_PASSWORD"]
      @@mysql_user = ENV["MYSQL_USER"]
      @@mysql_database = ENV["MYSQL_DATABASE"]
      @@DB = Sequel.connect(adapter: "mysql2", host: @@mysql_host, database: @@mysql_database, user: @@mysql_user, password: @@mysql_password)
    end
    
    def self.add_source
      self.pull_variables
      puts "Add source"
    end

    def self.setup
      self.pull_variables
      @@DB.create_table :sources do
        primary_key(:id)
        String(:name)
        String(:type)
      end
    end

  end
end
