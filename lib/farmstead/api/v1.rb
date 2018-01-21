require "sinatra/base"
require "sinatra/namespace"

module Sinatra
  module V1
    
    def self.registered(app)
      app.register Sinatra::Namespace
      app.namespace "/api/v1" do
        before do
          content_type 'application/json'
        end
        
        get "/source" do
          Farmstead::DB.add_source
        end
      end
    end
    
  end
  register V1
end
