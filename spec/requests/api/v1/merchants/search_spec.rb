require 'rails_helper'

RSpec.describe 'Merchant search' do
  context 'happy path' do
    describe 'find one result' do
      it 'returns one merchant by case-sensitive search params, ordered alphabetically' do
        valid = create(:merchant, name: 'test1')
        invalid1 = create(:merchant, name: 'test2')
        invalid2 = create(:merchant, name: 'test3')

        get '/api/v1/merchants/find', params: { name: 'test' }

        expect(response).to be_successful
        merchant = JSON.parse(response.body, symbolize_names: true)[:data].first[:attributes]

        expect(merchant[:name]).to eq(valid[:name])
      end
    end

    describe 'find all results' do
      it 'returns all merchants with matching string segment' do
        valid1 = create(:merchant, name: 'test1')
        valid2 = create(:merchant, name: 'test2')
        valid3 = create(:merchant, name: 'test3')
        invalid = create(:merchant, name: 'James')

        get '/api/v1/merchants/find_all', params: { name: 'test' }

        expect(response).to be_successful
        merchants = JSON.parse(response.body, symbolize_names: true)[:data]

        expect(merchants[0][:id]).to eq(valid1[:id].to_s)
        expect(merchants[1][:id]).to eq(valid2[:id].to_s)
        expect(merchants[2][:id]).to eq(valid3[:id].to_s)

        merchants.each do |merchant|
          expect(merchant).to have_key(:id)
          expect(merchant[:id]).to be_an(String)

          expect(merchant).to have_key(:attributes)
          expect(merchant[:attributes]).to be_a(Hash)

          expect(merchant[:attributes]).to have_key(:name)
          expect(merchant[:attributes][:name]).to be_a(String)

          expect(merchant[:attributes][:name]).to_not eq(invalid[:name])
        end
      end
    end
  end

  context 'sad path' do
    describe 'find one result' do
      before :each do
        valid1 = create(:merchant, name: 'test1')
        valid2 = create(:merchant, name: 'test2')
        valid3 = create(:merchant, name: 'test3')
      end

      it 'throws 400 error if no params given' do
        get '/api/v1/merchants/find?name='

        expected_errors = {
          errors: 'ActionController::BadRequest',
          message: 'Something is off about your request...'
        }
        thrown_errors = JSON.parse(response.body, symbolize_names: true)

        expect(response).to_not be_successful
        expect(thrown_errors).to eq(expected_errors)
      end

      # it 'throws 404 error if no match is found' do
      #   get '/api/v1/merchants/find?name=NOMATCH'

      #   expected_errors = {
      #     errors: ["ActiveRecord::RecordNotFound"],
      #     message: "Uh, oh... I couldn't find that record"
      #   }
      #   thrown_errors = JSON.parse(response.body, symbolize_names: true)

      #   expect(response).to_not be_successful
      #   expect(thrown_errors).to eq(expected_errors)
      # end
    end
  end
end
