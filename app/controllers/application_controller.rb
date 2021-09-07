class ApplicationController < ActionController::API
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
  rescue_from ActiveRecord::RecordInvalid, with: :unprocessable_entity

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

  def record_not_found(exception)
    render json:
      {
        message: 'The specified record could not be found',
        errors: [exception.message]
      },
      status: :not_found
  end
  
  def unprocessable_entity(exception)
    render json:
      {
        message: 'That request failed',
        errors: exception.record.errors.full_messages
      },
      status: :unprocessable_entity
  end

end
