# frozen_string_literal: true

require "erb"
# require 'farmstead/cli/net'

module Farmstead
  class New
    template = ERB.new File.read "../scaffold/Dockerfile.erb"
    p template.result
  end
end
