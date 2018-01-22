# Database subcommands

module Farmstead
  class DBTest < Thor
    desc "setup", "Setup the database"
    def setup
      puts "Setting up the database"
      Farmstead::DB.setup
    end

    desc "list", "List the sources"
    def list
      puts "List the sources"
    end
  end
end

