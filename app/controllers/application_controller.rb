class ApplicationController < ActionController::API
  # rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

  def per_page
    if params[:per_page].to_i.positive?
      params[:per_page].to_i
    else
      20
    end
  end

  def page_number
    if params[:page].to_i >= 1
      params[:page].to_i
    else
      1
    end
  end

  private

  # def record_not_found(exception)
  #   render json: {error: exception.message}.to_json, status: 404
  #   return
  # end

end
