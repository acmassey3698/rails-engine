class Api::V1::ItemsController < ApplicationController
  def index
    items = Item.limit(results_per_page).offset(calculate_offset)
    render json: ItemSerializer.all_items(items)
  end

  def show
    item = Item.find(params[:id])
    render json: ItemSerializer.one_item(item)

  rescue ActiveRecord::RecordNotFound
    record_not_found
  end

  private
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
