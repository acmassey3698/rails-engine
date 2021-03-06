class Api::V1::Merchants::MostItemsController < ApplicationController
  def index
    if params[:quantity].to_i > 0
      merchants = Merchant.items_sold(params[:quantity])
      render json: ItemsSoldSerializer.top_merchants(merchants)
    else
      bad_request
    end
  end
end
