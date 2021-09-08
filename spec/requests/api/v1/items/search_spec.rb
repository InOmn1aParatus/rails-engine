require 'rails_helper'

RSpec.describe 'Item search' do
  context 'happy path' do
    describe 'find one result' do
      it 'returns one item by case-sensitive search params' do
        # get '/api/vi/items/find?name=test'
      end
    end

    describe 'find all results' do
      it 'returns all items with matching string segment' do
        # get '/api/vi/items/find_all?name=test'
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