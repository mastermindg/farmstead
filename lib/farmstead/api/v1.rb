require "sinatra/base"
require "sinatra/namespace"
require "json"

module Sinatra
  module V1
    
    def self.registered(app)
      app.register Sinatra::Namespace
      app.namespace "/api/v1" do
        before do
          content_type 'application/json'
        end
        
        put "/source" do
          request.body.read
          #payload = JSON.parse(request.body.read)
          #Farmstead::DB.add_source(payload)
        end
      end
    end
    
  end
  register V1
end
