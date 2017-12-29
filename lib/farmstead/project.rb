require "erb"

module Farmstead
  # creates a Farmstead Project
  class Project
    attr_accessor :name
    attr_accessor :config
    attr_accessor :database
    attr_accessor :deploy

    def create
      create_directory
      generate_files
      start_deploy
    end

    def start_deploy
      Dir.chdir @name
      system ("bash exec.sh")
    end

    # Creates OR RE-Creates the Project Directory
    def create_directory
      remove_dir(@name) if Dir.exist?(@name)
      Dir.mkdir(@name)
    end

    # Generate from templates in scaffold
    def generate_files
      #erbfiles = File.join("**", "*.erb")
      scaffold_path = "#{File.dirname __FILE__}/scaffold/"
      Dir.chdir scaffold_path
      files = Dir.glob("**/*")
      p files.inspect
      #scaffold = Dir.glob(erbfiles, File::FNM_DOTMATCH)
      # scaffold.each do |file|
      #   filename = file.match('lib\/farmstead\/scaffold\/(.*)')[1]
      #   foldername = File.dirname(filename)
      #   # Create folder structure of subdirectories
      #   if foldername != "."
      #     create_recursive(foldername)
      #   end
      #   projectpath = "#{@name}/#{filename}".chomp(".erb")
      #   scaffoldpath = "lib/farmstead/scaffold/#{filename}"
      #   template = File.read(scaffoldpath)
      #   results = ERB.new(template).result(binding)
      #   copy_to_directory(results, projectpath)
      # end
    end

    # Recursive Create
    def create_recursive(path)
      recursive = path.split("/")
      directory = ""
      recursive.each do |sub_directory|
        directory += sub_directory + "/"
        Dir.mkdir("#{@name}/#{directory}") unless (File.directory? directory)
      end
    end

    # Recursive Remove
    def remove_dir(path)
      if File.directory?(path)
        Dir.foreach(path) do |file|
          if ((file.to_s != ".") && (file.to_s != ".."))
            remove_dir("#{path}/#{file}")
          end
        end
        Dir.delete(path)
      else
        File.delete(path)
      end
    end

    # Copies an ERB Template as a file to the destination directory
    def copy_to_directory(str, file_name)
      open(file_name, "a") do |f|
        f.puts str
      end
    end
  end
end
