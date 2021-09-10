module Api
  module V1
    module Items
      class MerchantController < ApplicationController
        before_action :set_item, only: [:show]

        def show
          render json: MerchantSerializer.new(@item.merchant) if @item
        end

        private

        def set_item
          @item = Item.find(params[:item_id]) if params[:item_id]
        end
      end
    end
  end
end
