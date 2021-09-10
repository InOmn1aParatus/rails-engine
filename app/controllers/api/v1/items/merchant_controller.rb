module Api
  module V1
    module Items
      class MerchantController < ApplicationController
        before_action :set_item, only: [:show]

        def show
          if @item
            render json: MerchantSerializer.new(@item.merchant)
          else
            render json: MerchantSerializer.new(
              Merchant.find(params[:merchant_id])
            )
          end
        end

        private

        def set_item
          @item = Item.find(params[:item_id]) if params[:item_id]
        end
      end
    end
  end
end
