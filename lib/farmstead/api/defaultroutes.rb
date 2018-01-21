module Sinatra
  module DefaultRoutes
    def self.registered(app)
      app.get "/" do
        "Welcome to our API"
      end
      
      app.get "/version" do
          "Farmstead #{Farmstead::VERSION}"
        end

      app.get "/environment" do
        Farmstead::ENVIRONMENT.class
      end

    end
  end
  register DefaultRoutes
end
