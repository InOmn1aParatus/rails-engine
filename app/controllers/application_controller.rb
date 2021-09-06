class ApplicationController < ActionController::API
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
end
