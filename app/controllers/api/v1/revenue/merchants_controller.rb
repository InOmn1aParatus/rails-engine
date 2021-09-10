module Api
  module V1
    module Revenue
      class MerchantsController < ApplicationController
        def index
          render json: MerchantRevenueSerializer.new(
            Merchant.top_revenue(params[:quantity])
          )
        end

        def show
          render json: MerchantRevenueSerializer.new(
            Merchant.total_revenue(params[:id])
          )
        end
      end
    end
  end
end
