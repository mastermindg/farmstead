require "erb"
require "net/http"
require "socket"
require "yaml"
require "os"

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
    end

    def self.deploy
      # Dir.chdir @name
      self.read_yml_into_env
      File.chmod(0755, "exec.sh")
      system ("bash exec.sh")
    end

    # Creates OR RE-Creates the Project Directory
    def create_directory
      remove_dir(@name) if Dir.exist?(@name)
      Dir.mkdir(@name)
    end

    # Takes the project.yml file and generates an .env file for docker
    def self.read_yml_into_env
      cnf = YAML::load(File.open('project.yml'))
      File.open('.env', 'w') do |file|
        cnf.each do |key, value|
          if value.kind_of?(Array)
            value.each do |element|
              element.each do |ykey, yvalue|
                if yvalue.kind_of?(Array)
                  element.each do |zkey, zvalue|
                    zvalue = zvalue.join(' ') if zvalue.kind_of?(Array)
                    file.puts "#{zkey}=#{zvalue}"
                  end
                else
                  file.puts "#{ykey}=#{yvalue}"
                end
              end
            end
          else
            file.puts "#{key}=#{value}"
          end
        end
      end
    end

    # Generate from templates in scaffold
    def generate_files
      ip = local_ip
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

    def local_ip
      addr_infos = Socket.getifaddrs
      addr_infos.each do |addr_info|
        if addr_info.addr && addr_info.addr.ipv4? && addr_info.name == interface_from_arch
          return addr_info.addr.ip_address
        end
      end
    end

    def interface_from_arch
      return "Ethernet" if OS.windows?
      return "en0" if OS.mac?
      return "eth0" if OS.linux?
    end

    def public_ip
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
