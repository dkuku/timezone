require 'sinatra/base'
require 'json'
require 'nearest_time_zone'

module Timezone
  class API < Sinatra::Base
    post '/timezone' do
      request.body.rewind
      data = JSON.parse request.body.read
      lat = data['latitude']
      lng = data['longitude']
      begin
        timezone = NearestTimeZone.to(lat, lng)
        JSON timezone: timezone
      rescue => error
        status 422
        JSON error: error.message
      end
    end
  end
end
