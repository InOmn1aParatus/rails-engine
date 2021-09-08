require 'rails_helper'

describe 'Merchants API' do
  context 'happy path' do
    describe 'basic requests' do
      it 'sends a list of merchants' do
        create_list(:merchant, 3)

        get '/api/v1/merchants'

        expect(response).to be_successful

        merchants = JSON.parse(response.body, symbolize_names: true)

        expect(merchants[:data].count).to eq(3)

        merchants[:data].each do |merchant|
          expect(merchant).to have_key(:id)
          expect(merchant[:id]).to be_an(String)

          expect(merchant).to have_key(:attributes)
          expect(merchant[:attributes]).to be_a(Hash)

          expect(merchant[:attributes]).to have_key(:name)
          expect(merchant[:attributes][:name]).to be_a(String)
        end
      end

      it 'displays specific merchant' do
        id = create(:merchant).id

        get "/api/v1/merchants/#{id}"

        merchant = JSON.parse(response.body, symbolize_names: true)

        expect(response).to be_successful

        expect(merchant[:data]).to have_key(:id)
        expect(merchant[:data][:id]).to be_a(String)

        expect(merchant[:data]).to have_key(:attributes)
        expect(merchant[:data][:attributes]).to be_a(Hash)

        expect(merchant[:data][:attributes]).to have_key(:name)
        expect(merchant[:data][:attributes][:name]).to be_a(String)
      end

      it 'displays items associated with specific merchant' do
        id = create(:merchant).id
        create_list(:item, 10, merchant_id: id)

        get "/api/v1/merchants/#{id}"
        merchant = JSON.parse(response.body, symbolize_names: true)
        expect(response).to be_successful

        expect(merchant[:data]).to have_key(:relationships)
        items = merchant[:data][:relationships][:items][:data]

        expect(items.count).to eq(10)
      end
    end

    describe 'optional query parameters' do
      it 'displays default of 20 merchants per page' do
        create_list(:merchant, 30)

        get '/api/v1/merchants'

        expect(response).to be_successful

        merchants = JSON.parse(response.body, symbolize_names: true)

        expect(merchants[:data].count).to eq(20)
      end

      it 'displays optional number of merchants per page' do
        create_list(:merchant, 30)

        get '/api/v1/merchants?per_page=15'

        expect(response).to be_successful

        merchants = JSON.parse(response.body, symbolize_names: true)

        expect(merchants[:data].count).to eq(15)
      end

      it 'can navigate to a specific page' do
        create_list(:merchant, 30)

        get '/api/v1/merchants?page=2'

        expect(response).to be_successful

        merchants = JSON.parse(response.body, symbolize_names: true)

        expect(merchants[:data].count).to eq(10)
      end
    end
  end

  context 'sad path' do
    describe 'basic requests' do
      it 'throws custom 404 error when a record cannot be found' do
        nonexistent_merchant_id = 101
        get "/api/v1/merchants/#{nonexistent_merchant_id}"

        expected_errors = {
          message: "Uh, oh... I couldn't find that record",
          errors: ["Couldn't find Merchant with 'id'=#{nonexistent_merchant_id}"]
        }
        thrown_errors = JSON.parse(response.body, symbolize_names: true)

        expect(response).to_not be_successful
        expect(thrown_errors).to eq(expected_errors)
      end
    end
  end
end
