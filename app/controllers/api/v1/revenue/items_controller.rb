class Api::V1::Revenue::ItemsController < ApplicationController
  def index
    qty = params.fetch(:quantity, 10).to_i
    if qty != 0
      if qty.positive?
        items = Item.revenue_ranked(qty)
        render json: ItemRevenueSerializer.all_items(items)
      else
        bad_request
      end
    else
      bad_request
    end
  end
end
