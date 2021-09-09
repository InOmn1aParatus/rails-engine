require 'rails_helper'

RSpec.describe 'Merchant search' do
  context 'happy path' do
    describe 'find one result' do
      it 'returns one merchant by case-sensitive search params' do
        valid = create(:merchant, name: 'test1')
        invalid1 = create(:merchant, name: 'test2')
        invalid2 = create(:merchant, name: 'test3')
        
        get '/api/v1/merchants/find?name=test'

        expect(response).to be_successful
        merchant = JSON.parse(response.body, symbolize_names: true)
        # require 'pry'; binding.pry
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