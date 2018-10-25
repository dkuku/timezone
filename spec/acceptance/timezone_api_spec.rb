require 'rack/test'
require 'json'
require_relative '../../app/api'

module Timezone
  RSpec.describe 'Timezone API' do
    include Rack::Test::Methods

    def app
      Timezone::API.new
    end
    it 'returns timezone of given location' do
      location = {
        latitude: 53,
        longitude: 0
      }

      post '/timezone', JSON.generate(location)

      expect(last_response.status).to eq(200)

      parsed = JSON.parse(last_response.body)
      expect(parsed).to include('timezone' => 'Europe/London')
    end
  end
end
