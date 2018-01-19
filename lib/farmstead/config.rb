module Farmstead
  config_yaml = YAML.load_file 'itinerary.yml'
  Config = OpenStruct.new(itinerary_yaml)
end
