class Api::V1::MerchantItemsController < ApplicationController
  def index
    merchant = Merchant.find(params[:id])
    items = merchant.items
    render json: ItemSerializer.all_items(items)

  rescue ActiveRecord::RecordNotFound
    record_not_found
  end
end
