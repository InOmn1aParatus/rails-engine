require 'rails_helper'

RSpec.describe 'Revenue requests' do
  context 'happy path' do
    describe 'Merchants' do
      before :each do
        merchant_1 = create(:merchant)
        items_1 = create_list(:item, 2, unit_price: 1.0, merchant_id: merchant_1.id)
        invoice_1 = create(:invoice, status: 'shipped', merchant_id: merchant_1.id)
        invoice_2 = create(:invoice, status: 'shipped', merchant_id: merchant_1.id)
        create_list(:invoice_item, 2, unit_price: 1.0, item: items_1[0], invoice: invoice_1, quantity: 1)
        create_list(:invoice_item, 2, unit_price: 1.0, item: items_1[1], invoice: invoice_2, quantity: 1)
        create(:transaction, result: 'success', invoice: invoice_1)
        create(:transaction, result: 'success', invoice: invoice_1)
        
        merchant_2 = create(:merchant)
        items_2 = create_list(:item, 2, unit_price: 1.0, merchant_id: merchant_2.id)
        invoice_3 = create(:invoice, status: 'shipped', merchant_id: merchant_2.id)
        invoice_4 = create(:invoice, status: 'packaged', merchant_id: merchant_2.id)
        create_list(:invoice_item, 2, unit_price: 1.0, item: items_2[0], invoice: invoice_3, quantity: 1)
        create_list(:invoice_item, 2, unit_price: 1.0, item: items_2[1], invoice: invoice_4, quantity: 1)
        create(:transaction, result: 'success', invoice: invoice_3)
        create(:transaction, result: 'failed', invoice: invoice_4)
      end

      describe 'variable revenue endpoint' do
        it 'returns a variable number of merchants ranked by total revenue' do
          get '/api/v1/revenue/merchants', params: { quantity: 3 }
  
          expect(response).to be_successful
          merchants_array = JSON.parse(response.body, symbolize_names: true)[:data]
          require 'pry'; binding.pry
          expect(merchants_array.count).to eq(2)
  
        end
      end
    end
  end
  
  context 'sad path' do
    describe '' do
      it '' do
    
      end
    end
  end
end