require 'rails_helper'

RSpec.describe 'Item search' do
  context 'happy path' do
    describe 'find one result' do
      it 'returns one item by case-sensitive search params' do
        valid = create(:item, name: 'test1')
        invalid1 = create(:item, name: 'test2')
        invalid2 = create(:item, name: 'test3')
        
        get '/api/v1/items/find', params: {name: 'test'}

        expect(response).to be_successful
        item = JSON.parse(response.body, symbolize_names: true)[:data].first[:attributes]
        
        expect(item[:name]).to eq(valid[:name])
      end
    end

    describe 'find all results' do
      it 'returns all items with matching string segment' do
        valid1 = create(:item, name: 'test1')
        valid2 = create(:item, name: 'test2')
        valid3 = create(:item, name: 'test3')
        invalid = create(:item, name: 'James')
        
        get '/api/v1/items/find_all', params: {name: 'test'}

        expect(response).to be_successful
        items = JSON.parse(response.body, symbolize_names: true)[:data]
        
        expect(items[0][:id]).to eq(valid1[:id].to_s)
        expect(items[1][:id]).to eq(valid2[:id].to_s)
        expect(items[2][:id]).to eq(valid3[:id].to_s)

        items.each do |item|
          expect(item).to have_key(:id)
          expect(item[:id]).to be_an(String)

          expect(item).to have_key(:attributes)
          expect(item[:attributes]).to be_a(Hash)

          expect(item[:attributes]).to have_key(:name)
          expect(item[:attributes][:name]).to be_a(String)
          
          expect(item[:attributes]).to have_key(:description)
          expect(item[:attributes][:description]).to be_a(String)
          
          expect(item[:attributes]).to have_key(:unit_price)
          expect(item[:attributes][:unit_price]).to be_a(Numeric)
          
          expect(item[:attributes]).to have_key(:merchant_id)
          expect(item[:attributes][:merchant_id]).to be_a(Numeric)
          
          expect(item[:attributes][:name]).to_not eq(invalid[:name])
        end
      end
    end

    describe 'price search' do
      it 'allows searching by min and max price' do
        # get '/api/v1/items/find?min_price=50'
        # get '/api/v1/items/find?max_price=150'
        # get '/api/v1/items/find?max_price=150&min_price=50'
      end
    end
  end

  context 'sad path' do
    
  end
end