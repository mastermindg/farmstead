# Database subcommands

module Farmstead
  class CLIDB < Thor
    desc "setup", "Setup the database"
    def setup
      puts "Setting up the database"
      Farmstead::DB.setup
    end

    desc "list table", "List all records in a table"
    def list(table)
      puts "List all records in a table"
      Farmstead::DB.list(table)
    end
  end
end

