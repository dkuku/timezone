require_relative '../../../app/api'

module Timezone
  RSpec.describe API do
    include Rack::Test::Methods

    def app
      API.new
    end
    let(:poland) do
      {latitude: 53, longitude: 15}
    end
    let(:wrong) do
      {latitude: 300, longitude: ''}
    end
    describe 'POST /timezone' do
      context 'when the position is correct' do
        before do
          post '/timezone', JSON.generate(poland)
        end
        it 'returns with the timezone for position' do
        parsed = JSON.parse(last_response.body)
        expect(parsed).to include('timezone' => 'Europe/Warsaw')
        end

        it 'responds with 200 (OK)' do
          expect(last_response.status).to eq(200)
        end
      end
      context 'when the position is wrong or missing' do
        before do
          post '/timezone', JSON.generate(wrong)
        end
        it 'returns an error message' do
          parsed = JSON.parse(last_response.body)
          expect(parsed).to include('error' => be_kind_of(String))
        end
        it 'responds with 422 (Unprocessable entity)' do
          expect(last_response.status).to eq(422)
        end
      end
    end
  end
end
