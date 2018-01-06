require "thor"
require "farmstead/cli/test"

module Farmstead
  class HammerTime < Thor
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

    desc "deploy", "Deploys a project"
    def deploy
      Farmstead::Project.deploy
    end

    desc "test COMMANDS", "Test commands"
    subcommand "test", Farmstead::CLITest

    map "-v" => "version"
  end
end
