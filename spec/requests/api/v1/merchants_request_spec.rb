require 'rails_helper'

describe "Merchants API" do
  context 'happy path' do
    describe 'basic requests' do
      it "sends a list of merchants" do
        create_list(:merchant, 3)
  
        get '/api/v1/merchants'
    
        expect(response).to be_successful
  
        merchants = JSON.parse(response.body, symbolize_names: true)
  
        expect(merchants.count).to eq(3)
  
        merchants.each do |merchant|
          expect(merchant).to have_key(:id)
          expect(merchant[:id]).to be_an(Integer)
  
          expect(merchant).to have_key(:name)
          expect(merchant[:name]).to be_an(String)
        end
      end

      it 'displays specific merchant' do
        id = create(:merchant).id
  
        get "/api/v1/merchants/#{id}"
        
        merchant = JSON.parse(response.body, symbolize_names: true)
    
        expect(response).to be_successful

        expect(merchant).to have_key(:id)
        expect(merchant[:id]).to eq(id)

        expect(merchant).to have_key(:name)
        expect(merchant[:name]).to be_a(String)

      end
    end

    describe 'optional query parameters' do
      it 'displays default of 20 items per page' do
        create_list(:merchant, 30)

        get '/api/v1/merchants'

        expect(response).to be_successful

        merchants = JSON.parse(response.body, symbolize_names: true)

        expect(merchants.count).to eq(20)
      end
      
      it 'displays optional number of items per page' do
        create_list(:merchant, 30)

        get '/api/v1/merchants?per_page=15'

        expect(response).to be_successful

        merchants = JSON.parse(response.body, symbolize_names: true)

        expect(merchants.count).to eq(15)
      end

      it 'can navigate to a specific page' do
        create_list(:merchant, 30)

        get '/api/v1/merchants?page=2'

        expect(response).to be_successful
      end
    end
  end
end