module Api
  module V1
    module Items
      class SearchController < ApplicationController
        def index
          render json: ItemSerializer.new(
            Item.find_all(params[:name])
          )
        end

        def show
          render json: ItemSerializer.new(
            Item.find_one(params[:name])
          )
        end
      end
    end
  end
end
