module Api
  module V1
    module Items
      class MerchantController < ApplicationController
        def index
          render json: MerchantSerializer.new(
            Merchant.find(params[:merchant_id])
          )
        end
      end
    end
  end
end
