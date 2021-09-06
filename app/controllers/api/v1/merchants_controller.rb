module Api
  module V1
    class MerchantsController < ApplicationController
      def index
        render json: Merchant.results(per_page, page_number)
      end

      def show
        render json: Merchant.find(params[:id])
      end
    end
  end
end