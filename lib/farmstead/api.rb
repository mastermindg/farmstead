module Farmstead
  class API < Sinatra::Base
    set :views, settings.root + '/api/views'
    set :port, 3000
    set :bind, "0.0.0.0"

    register Sinatra::V1
    register Sinatra::DefaultRoutes
  end
end
