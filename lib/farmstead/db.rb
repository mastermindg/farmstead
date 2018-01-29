require "sequel"

module Farmstead
  class DB
    def self.pull_variables
      @@mysql_host = ENV["MYSQL_HOST"]
      @@mysql_password = ENV["MYSQL_PASSWORD"]
      @@mysql_user = ENV["MYSQL_USER"]
      @@mysql_database = ENV["MYSQL_DATABASE"]
      @@mysql_port = ENV["MYSQL_PORT"]
      @@DB = Sequel.connect(adapter: "mysql2", host: @@mysql_host, port: @@mysql_port, database: @@mysql_database, user: @@mysql_user, password: @@mysql_password)
    end

    def self.select_all(table)
      self.pull_variables
      @@DB[:sources]
    end

    # Create tables
    def self.create
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

    def self.add_source(module_name, module_type, module_call)
      self.pull_variables
      ds = @@DB[:sources]
      ds.insert([:name, :type, :module], [module_name,module_type,module_call])
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

    def self.create_table(table, hash)
      self.pull_variables
        @@DB.create_table? [table] do
        #primary_key(:id) if hash[:primary_key] 
          String(:name)
          String(:type)
          String(:module)
      end
    end

    # Insert an array of values into a table
    def self.insert_test(result)
      self.pull_variables
      ds = @@DB[:test]
      ds.insert(result: result)
    end

  end
end
