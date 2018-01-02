# frozen_string_literal: true

# Extend Farmstead
require "farmstead"

# Load project classes
require_relative "extract/extracter"
require_relative "load/loader"
require_relative "transform/transformer"
require_relative "serve/server"

module MyProject
  include "farmstead"
end
