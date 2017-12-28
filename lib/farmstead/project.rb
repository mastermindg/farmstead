# frozen_string_literal: true

require "erb"
# require 'farmstead/cli/net'

module Farmstead
  class Project
    attr_accessor :name
    attr_accessor :config
    attr_accessor :database

    def create
      # create_directory
      generate_files
    end

    def create_directory
      Dir.mkdir(@name) unless Dir.exist?(@name)
    end

    # Generate from templates in scaffold
    def generate_files
      Dir["scaffold/*"].each do |file|
        if File.file?(file)
          basename = File.basename(file, File.extname(file))
          template = File.read(file)
          p results = ERB.new(template).result(binding)
          #copy_to_directory(results, basename)
        end
      end
    end

    # Copies an ERB Template as a file to the destination directory
    def copy_to_directory(str, file_name)
      open("#{@project_name}/#{file_name}", "a") do |f|
        f.puts str
      end
    end
  end
end
