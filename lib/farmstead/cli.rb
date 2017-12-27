# frozen_string_literal: true

require "thor"
# require 'farmstead/cli/net'

module Farmstead
  class CLI < Thor
    desc "new projectname", "Create a new project"
    def new(projectname)
      p projectname
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

    # desc "net COMMANDS", "Net control Module"
    # subcommand "net", Socialinvestigator::CLI::Net
  end
end
