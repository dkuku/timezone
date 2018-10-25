require 'sinatra/base'
require 'json'
require 'nearest_time_zone'

module Timezone
  class API < Sinatra::Base
    post '/timezone' do
      begin
        request.body.rewind
        data = JSON.parse request.body.read
        lat = data['latitude'].to_i
        lng = data['longitude'].to_i
        timezone = NearestTimeZone.to(lat, lng)
        JSON timezone: timezone
      rescue => error
        status 422
        JSON error: error.message
      end
    end

    get '/timezone/:lat/:lng' do
      begin
        lat = params[:lat].to_i
        lng = params[:lng].to_i
        timezone = NearestTimeZone.to(lat, lng)
        JSON timezone: timezone
      rescue => error
        status 422
        JSON error: error.message
      end

      get "/" do
        %q{
     <html>
       <head></head>
       <body>
         <div>
          <h1>Timezone api</h1>
           <p>Usage:</p>
           <p>send a get request to /timezone/:latitude/:longitude</p>
           <p>It is possible also to send a post request - please check the
            <a href="https://github.com/dkuku/timezone">source code</a>on github</p>
         </div>
       </body>
     </html>
     }
      end
    end
  end
end
