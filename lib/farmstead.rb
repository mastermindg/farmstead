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

require "kafka"
require "mysql2"
require "json"
require "nokogiri"
require "httparty"
require "open-uri"
require "mechanize"
require "sinatra/base"

require "farmstead/version"
require "farmstead/project"
require "farmstead/cli"
require "farmstead/service"
require "farmstead/pipeline/manage"
require "farmstead/pipeline/extract"
require "farmstead/pipeline/transform"
require "farmstead/pipeline/load"

require "farmstead/api/defaultroutes.rb"
require "farmstead/api/helpers.rb"
require "farmstead/api"

module Farmstead
  # Your code goes here...
end
