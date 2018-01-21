module Farmstead
  class API < Sinatra::Base
    register Sinatra::Namespace
    register Sinatra::DefaultRoutes
    set :port, 3000
    set :bind, "0.0.0.0"
  end
end
