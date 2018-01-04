require "thor"
# require 'farmstead/cli/net'

module Farmstead
  class CLI < Thor
    class_option :verbose, aliases: "--v", type: "boolean", desc: "Be verbose"
    class_option :config, aliases: "-c", type: "string", desc: "Config file"
    class_option :database, aliases: "-d", type: "string", desc: "Database"
    class_option :deploy, aliases: "-x", type: "string", desc: "Deployment Method"

    desc "version", "Get the gem version"
    def version
      puts "Farmstead #{Farmstead::VERSION}"
    end

    desc "new project_name", "Create a new project"
    def new(project_name)
      project = Farmstead::Project.new
      project.name = project_name
      project.database = options[:database] if options[:database]
      project.config = options[:config] if options[:config]
      project.deploy = options[:deploy] if options[:deploy]
      project.create
    end

    desc "tinman command", "Send a command to tinman"
    def tinman(command)
      instance = Farmstead::Tinman.new
      instance.send(command)
    end

    desc "scarecrow command", "Send a command to scarecrow"
    def scarecrow(command)
      instance = Farmstead::Scarecrow.new
      instance.send(command)
    end

    desc "cowardlylion command", "Send a command to cowardlylion"
    def cowardlylion(command)
      instance = Farmstead::Cowardlylion.new
      instance.send(command)
    end

    desc "glenda command", "Send a command to glenda"
    def glenda(command)
      instance = Farmstead::Glenda.new
      instance.send(command)
    end

    desc "foo", "Test foo"
    def foo
      true
    end

    desc "bar", "Test bar"
    def bar
      true
    end

    # desc "net COMMANDS", "Net control Module"
    # subcommand "net", Socialinvestigator::CLI::Net

    map "-v" => "version"
  end
end
