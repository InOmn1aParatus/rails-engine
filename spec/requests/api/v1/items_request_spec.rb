require 'rails_helper'

describe 'Items API' do
  context 'happy path' do
    describe 'basic requests' do
      it 'sends a list of items' do
        create_list(:item, 3)

        get '/api/v1/items'

        expect(response).to be_successful

        items = JSON.parse(response.body, symbolize_names: true)

        expect(items.count).to eq(3)

        items.each do |item|
          expect(item).to have_key(:id)
          expect(item[:id]).to be_an(Integer)

          expect(item).to have_key(:name)
          expect(item[:name]).to be_an(String)

          expect(item).to have_key(:description)
          expect(item[:description]).to be_an(String)

          expect(item).to have_key(:unit_price)
          expect(item[:unit_price]).to be_an(Float)

          expect(item).to have_key(:merchant_id)
          expect(item[:merchant_id]).to be_an(Integer)
        end
      end
    end

    describe 'optional query parameters' do
      it 'displays default of 20 items per page' do
        create_list(:item, 30)

        get '/api/v1/items'

        expect(response).to be_successful

        items = JSON.parse(response.body, symbolize_names: true)

        expect(items.count).to eq(20)
      end

      it 'displays optional number of items per page' do
        create_list(:item, 30)

        get '/api/v1/items?per_page=15'

        expect(response).to be_successful

        items = JSON.parse(response.body, symbolize_names: true)

        expect(items.count).to eq(15)
      end

      it 'can navigate to a specific page' do
        create_list(:item, 30)

        get '/api/v1/items?page=2'

        expect(response).to be_successful

        items = JSON.parse(response.body, symbolize_names: true)

        expect(items.count).to eq(10)
      end
    end
  end
end
