require "sinatra/namespace"

module Farmstead
  module V1
    
    self.registered(app)
      app.register Sinatra::Namespace
      app.namespace "/api/v1" do
        get "/source" do
          Farmstead::DB.add_source
        end
      end
    end
  
  end
end
