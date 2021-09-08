require 'rails_helper'

RSpec.describe 'Merchant search' do
  context 'happy path' do
    describe 'find one result' do
      it 'returns one merchant by case-sensitive search params' do
        # get '/api/vi/merchants/find?name=test'
      end
    end

    describe 'find all results' do
      it 'returns all merchants with matching string segment' do
        # get '/api/vi/merchants/find_all?name=test'
      end
    end
  end

  context 'sad path' do
    
  end
end