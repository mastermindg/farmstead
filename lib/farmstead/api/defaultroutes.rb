module Sinatra
  module DefaultRoutes
    def self.registered(app)
      app.set :views, Dir.pwd + '/api/views'
      app.get "/" do
        "Welcome to our API"
      end
      
      app.get "/version" do
          "Farmstead #{Farmstead::VERSION}"
        end

      app.get "/environment" do
        erb :environment
      end

    end
  end
  register DefaultRoutes
end
