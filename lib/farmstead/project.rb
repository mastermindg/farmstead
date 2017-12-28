# frozen_string_literal: true

require "erb"

module Farmstead
  # creates a Farmstead Project
  class Project
    attr_accessor :name
    attr_accessor :config
    attr_accessor :database
    attr_accessor :deploy

    def create
      #create_directory
      generate_files
    end

    def create_directory
      Dir.mkdir(@name) unless Dir.exist?(@name)
    end

    # Generate from templates in scaffold
    def generate_files
      scaffold = Dir.glob("scaffold/**", File::FNM_DOTMATCH) - %w[scaffold/. scaffold/..]
      scaffold.each do |file|
        if File.file?(file)
          p basename = File.basename(file, File.extname(file))
          #template = File.read(file)
          #results = ERB.new(template).result(binding)
          #copy_to_directory(results, basename)
        else
          p basename = File.basename(file)
          #Dir.mkdir("#{@name}/#{basename}")
        end
      end
    end

    # Copies an ERB Template as a file to the destination directory
    def copy_to_directory(str, file_name)
      open("#{@name}/#{file_name}", "a") do |f|
        f.puts str
      end
    end
  end
end
