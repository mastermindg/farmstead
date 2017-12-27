myclass = ARGV[0]
mymethod = ARGV[1]
Dir[File.dirname(__FILE__) + "/sites/*.rb"].each do |filename|
  filename = filename.match(/app\/lib\/(.*)/)[1]
  require_relative filename
end

require_relative "service.rb"
require_relative "#{myclass}.rb"

myclass = myclass.capitalize
instance = Object.const_get(myclass).new

instance.send(mymethod)
