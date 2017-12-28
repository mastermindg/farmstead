# frozen_string_literal: true

require "erb"
# require 'farmstead/cli/net'

module Farmstead
  class New
    def initialize(project_name)
      @project_name = project_name
      #create_directory
      generate_files
    end

    def create_directory
      Dir.mkdir(@project_name) unless Dir.exist?(@project_name)
    end

    def generate_files
      Dir["scaffold/*"].each do |file|
        if File.file?(file)
          p basename = File.basename(file, File.extname(file))
          #template = File.read(file)
          #results = ERB.new(template).result(binding)
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
