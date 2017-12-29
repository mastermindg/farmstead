require "erb"
require "net/http"

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
      File.chmod(0755, "exec.sh")
      system ("bash exec.sh")
    end

    # Creates OR RE-Creates the Project Directory
    def create_directory
      remove_dir(@name) if Dir.exist?(@name)
      Dir.mkdir(@name)
    end

    # Generate from templates in scaffold
    def generate_files
      ip = get_ip_address_from_locals
      scaffold_path = "#{File.dirname __FILE__}/scaffold"
      scaffold = Dir.glob("#{scaffold_path}/**/*.erb", File::FNM_DOTMATCH)
      scaffold.each do |file|
        basename = File.basename(file)
        folderstruct = file.match("#{scaffold_path}/(.*)")[1]
        if basename != folderstruct
          foldername = File.dirname(folderstruct)
          create_recursive("#{@name}/#{foldername}")
        end
        projectpath = "#{@name}/#{folderstruct}".chomp(".erb")
        template = File.read(file)
        results = ERB.new(template).result(binding)
        copy_to_directory(results, projectpath)
      end
    end

    def get_ip_address_from_local
      response = Net::HTTP.get(URI("http://v4.ifconfig.co/json"))
      json = eval(response)
      json[:ip]
    end

    # Recursive Create
    def create_recursive(path)
      recursive = path.split("/")
      directory = ""
      recursive.each do |sub_directory|
        directory += sub_directory + "/"
        Dir.mkdir("#{directory}") unless (File.directory? directory)
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
