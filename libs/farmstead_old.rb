# frozen_string_literal: true

#--
# Copyright (c) 2004-2018 Ken Jenney
#
# Permission is hereby granted, free of charge, to any person obtaining
# a copy of this software and associated documentation files (the
# "Software"), to deal in the Software without restriction, including
# without limitation the rights to use, copy, modify, merge, publish,
# distribute, sublicense, and/or sell copies of the Software, and to
# permit persons to whom the Software is furnished to do so, subject to
# the following conditions:
#
# The above copyright notice and this permission notice shall be
# included in all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
# EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
# MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
# NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
# LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
# OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
# WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
#++

# require "rails/rails"
# require "farmstead/version"

Dir[File.dirname(__FILE__) + "/farmstead/*.rb"].each do |f|
  require f
end

module Farmstead
  # extend Rails::API

  autoload :Service, "farmstead/service"

  autoload :Glenda, "farmstead/glenda"
  autoload :Scarecrow, "farmstead/scarecrow"
  autoload :Tinman, "farmstead/tinman"
  autoload :Cowardlylion, "farmstead/cowardlylion"

  autoload :Version, "farmstead/version"
end
