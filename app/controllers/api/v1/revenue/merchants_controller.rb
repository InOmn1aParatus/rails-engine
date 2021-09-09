module Api
  module V1
    module Revenue
      class MerchantsController < ApplicationController
        def index
          render json: MerchantSerializer.new(
            Merchant.top_revenue(params[:quantity])
          )
        end
      end
    end
  end
end
