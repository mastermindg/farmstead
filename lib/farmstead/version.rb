# frozen_string_literal: true

require_relative "gem_version"

module Farmstead
  # Returns the version of the currently loaded Farmstead as a <tt>Gem::Version</tt>
  def self.version
    gem_version
  end
end
