module Api
  module V1
    class ItemsController < ApplicationController
      def index
        @items = Item.results(per_page, page_number)
        render json: ItemSerializer.new(@items)
      end
      
      def show
        @item = Item.find(params[:id])
        render json: ItemSerializer.new(@item)
      end

      def create
        render json: Item.create(item_params)
      end

      private

      def item_params
        params.require(:item).permit(:name, :description, :unit_price, :merchant_id)
      end
    end
  end
end
