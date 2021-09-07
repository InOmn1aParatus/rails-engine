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
        item = Item.create!(item_params)
        render json: ItemSerializer.new(item)
      end

      def update
        item = Item.update(params[:id], item_params)
        render json: ItemSerializer.new(item)
      end

      def destroy
        render json: Item.delete(params[:id])
      end

      private

      def item_params
        params.require(:item).permit(:name, :description, :unit_price, :merchant_id)
      end
    end
  end
end
