require 'rails_helper'

describe 'Items API' do
  context 'happy path' do
    describe 'basic requests' do
      it 'sends a list of items' do
        create_list(:item, 3)

        get '/api/v1/items'

        expect(response).to be_successful

        items = JSON.parse(response.body, symbolize_names: true)

        expect(items[:data].count).to eq(3)

        items[:data].each do |item|
          expect(item[:attributes]).to have_key(:name)
          expect(item[:attributes][:name]).to be_a(String)
          
          expect(item[:attributes]).to have_key(:description)
          expect(item[:attributes][:description]).to be_a(String)
          
          expect(item[:attributes]).to have_key(:unit_price)
          expect(item[:attributes][:unit_price]).to be_a(Numeric)
        end
      end
    end

    describe 'optional query parameters' do
      it 'displays default of 20 items per page' do
        create_list(:item, 30)

        get '/api/v1/items'

        expect(response).to be_successful

        items = JSON.parse(response.body, symbolize_names: true)

        expect(items[:data].count).to eq(20)
      end

      it 'displays optional number of items per page' do
        create_list(:item, 30)

        get '/api/v1/items?per_page=15'

        expect(response).to be_successful

        items = JSON.parse(response.body, symbolize_names: true)

        expect(items[:data].count).to eq(15)
      end

      it 'can navigate to a specific page' do
        create_list(:item, 30)

        get '/api/v1/items?page=2'

        expect(response).to be_successful

        items = JSON.parse(response.body, symbolize_names: true)

        expect(items[:data].count).to eq(10)
      end
    end
  end
end
