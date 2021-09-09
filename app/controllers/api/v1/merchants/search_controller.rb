class SearchController < ApplicationController
  def show
    render json: MerchantSerializer.new(
      Merchant.find_one(params[:name])
    )
  end
end