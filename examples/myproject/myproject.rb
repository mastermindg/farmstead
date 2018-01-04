# frozen_string_literal: true

# Primary script to kick off services in project
# Pass two arguments to this script
# 1st - the class you want to call
# 2nd - the method you want to call

dynamic_class = ARGV[0]
dynamic_method = ARGV[1]

# Extend Farmstead
require "farmstead"

# Load project classes
require_relative "extract/extracter"
require_relative "load/loader"
require_relative "transform/transformer"

module MyProject
  include Farmstead
end

klass = Object.const_get "MyProject::#{dynamic_class}"
service = klass.new
service.send(dynamic_method)
