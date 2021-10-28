class ApplicationController < ActionController::API
  def record_not_found
    render json: ErrorSerializer.not_found(params[:id]), status: 404
  end

  def bad_request
    render json: ErrorSerializer.bad_request, status: 400
  end

  def results_per_page
    if params[:per_page].to_i.positive?
      per_page = params[:per_page]
    else
      per_page = 20
    end
  end

  def calculate_offset
    if params[:page].to_i.positive?
      page = results_per_page * (params[:page].to_i - 1)
    else
      page = 0
    end
  end
end
