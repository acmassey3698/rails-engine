class ApplicationController < ActionController::API
def record_not_found
  render json: ErrorSerializer.not_found(params[:id]), status: 404
end
end
