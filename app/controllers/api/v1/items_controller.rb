module Api
  module V1
    class ItemsController < ApplicationController
      def index
        @items = Item.results(per_page, page_number)
        render json: ItemSerializer.new(@items)
      end
    end
  end
end
