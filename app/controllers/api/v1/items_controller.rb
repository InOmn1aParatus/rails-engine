module Api
  module V1
    class ItemsController < ApplicationController
      def index
        render json: Item.results(per_page, page_number)
      end
    end
  end
end
