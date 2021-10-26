class Api::V1::ItemsMerchantController < ApplicationController
  def show
    merchant = Item.find(params[:id]).merchant
    render json: MerchantSerializer.one_merchant(merchant)

    rescue ActiveRecord::RecordNotFound
      record_not_found
  end
end
