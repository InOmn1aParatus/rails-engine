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

          expect(item[:attributes]).to have_key(:merchant_id)
          expect(item[:attributes][:merchant_id]).to be_a(Numeric)
        end
      end

      it 'displays specific merchant' do
        id = create(:item).id

        get "/api/v1/items/#{id}"

        item = JSON.parse(response.body, symbolize_names: true)

        expect(response).to be_successful

        expect(item[:data]).to have_key(:id)
        expect(item[:data][:id]).to be_a(String)

        expect(item[:data]).to have_key(:attributes)
        expect(item[:data][:attributes]).to be_a(Hash)

        expect(item[:data][:attributes]).to have_key(:name)
        expect(item[:data][:attributes][:name]).to be_a(String)

        expect(item[:data][:attributes]).to have_key(:description)
        expect(item[:data][:attributes][:description]).to be_a(String)

        expect(item[:data][:attributes]).to have_key(:unit_price)
        expect(item[:data][:attributes][:unit_price]).to be_a(Numeric)

        expect(item[:data][:attributes]).to have_key(:merchant_id)
        expect(item[:data][:attributes][:merchant_id]).to be_a(Numeric)
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

    describe 'RESTful actions' do
      it 'can create a new item' do
        merchant_id = create(:merchant).id

        item_params = {
          name: 'Banana',
          description: 'Quite banana',
          unit_price: 1.11,
          merchant_id: merchant_id
        }
        headers = { 'CONTENT_TYPE' => 'application/json' }

        post '/api/v1/items', headers: headers, params: JSON.generate(item: item_params)
        created_item = Item.last

        expect(response).to be_successful
        expect(created_item.name).to eq(item_params[:name])
        expect(created_item.description).to eq(item_params[:description])
        expect(created_item.unit_price).to eq(item_params[:unit_price])
        expect(created_item.merchant_id).to eq(item_params[:merchant_id])
      end

      it 'can update an existing item' do
        id = create(:item).id
        previous_name = Item.last.name
        item_params = { name: 'Banana' }
        headers = { 'CONTENT_TYPE' => 'application/json' }

        # We include this header to make sure that these params are passed as JSON rather than as plain text
        patch "/api/v1/items/#{id}", headers: headers, params: JSON.generate({ item: item_params })
        item = Item.find_by(id: id)

        expect(response).to be_successful
        expect(item.name).to_not eq(previous_name)
        expect(item.name).to eq('Banana')
      end

      it 'can destroy an item' do
        item = create(:item)

        expect(Item.count).to eq(1)

        expect { delete "/api/v1/items/#{item.id}" }.to change(Item, :count).by(-1)

        expect(response).to be_successful
        expect { Item.find(item.id) }.to raise_error(ActiveRecord::RecordNotFound)
      end
    end
  end

  context 'sad path' do
    describe 'basic requests' do
      it 'throws custom 404 error when a record cannot be found' do
        nonexistent_item_id = 101_101_101
        get "/api/v1/items/#{nonexistent_item_id}"

        expected_errors = {
          message: "Uh, oh... I couldn't find that record",
          errors: ["Couldn't find Item with 'id'=#{nonexistent_item_id}"]
        }
        thrown_errors = JSON.parse(response.body, symbolize_names: true)

        expect(response).to_not be_successful
        expect(thrown_errors).to eq(expected_errors)
      end
    end

    describe 'RESTful actions' do
      it 'throws an error when attempting to create incomplete item' do
        merchant_id = create(:merchant).id
        item_params = {
          name: 'Banana',
          unit_price: 1.11,
          # Description is missing
          merchant_id: merchant_id
        }
        headers = { 'CONTENT_TYPE' => 'application/json' }

        post '/api/v1/items', headers: headers, params: JSON.generate(item: item_params)

        expected_errors = {
          message: 'That request failed',
          errors: ["Description can't be blank"]
        }
        thrown_errors = JSON.parse(response.body, symbolize_names: true)

        expect(response).to_not be_successful
        expect(thrown_errors).to eq(expected_errors)
      end
    end
  end
end
