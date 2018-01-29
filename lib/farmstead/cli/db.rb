# Database subcommands

module Farmstead
  class CLIDB < Thor
    desc "create", "Create the database tables"
    def create
      puts "Create database tables"
      Farmstead::DB.create
    end

    desc "setup", "Add sources (if present)"
    def setup
      puts "Add sources (if present)"
      Dir[File.join(Dir.pwd, "/sources/*.rb")].each do |file|
        require file
        array = File.readlines(file)
        matches = []
        array.each do |line|
          if line =~ /module/ then
            matches.push(line)
          end
        end
        # Nested modules
        parentmodule = matches[0]
        submodule = matches[1]
        # Get the module name
        suby = submodule.split.last
        topy = parentmodule.split.last

        module_name = Object.const_get "#{topy}::#{suby}::MYNAME"
        module_type = Object.const_get "#{topy}::#{suby}::TYPE"
        Farmstead::DB.add_source(module_name, module_type, suby)
      end
    end

    desc "list table", "List all records in a table"
    def list(table)
      puts "List all records in a table"
      Farmstead::DB.list(table)
    end
  end
end

