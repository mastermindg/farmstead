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
    
    def self.add_source(payload)
      self.pull_variables
      ds = @@DB[:sources]
      ds.insert(name: payload["name"], type: payload["type"], module: payload["module"])
    end

    def self.setup
      self.pull_variables
      @@DB.create_table :sources do
        primary_key(:id)
        String(:name)
        String(:type)
        String(:module)
      end
      @@DB.create_table :test do
        primary_key(:id)
        String(:result)
      end
    end

    def self.list(table)
      self.pull_variables
      ds = @@DB[table]
      puts ds.all
    end

    # Insert an array of values into a table
    def self.insert(table,array)
      self.pull_variables
      ds = @@DB[table]
      ds.insert(array)
    end

  end
end
