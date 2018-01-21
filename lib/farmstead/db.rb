require "sequel"

module Farmstead
  class DB
    def self.pull_variables
      @@mysql_host = ENV["MYSQL_HOST"]
    end
    
    def self.add_source
      self.pull_variables
      @@mysql_host
    end
  end
end
