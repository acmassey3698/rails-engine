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

  def create
    item = Item.new(item_params)
    if item.save
      render json: ItemSerializer.one_item(item), status: 201
    else
      bad_request
    end
  end

  def destroy
    item = Item.find(params[:id])
    item.destroy
  rescue ActiveRecord::RecordNotFound
    record_not_found
  end

  def update
    item = Item.find(params[:id])
    item.update(item_params)

    if item.save
      render json: ItemSerializer.one_item(item), status: 201
    else
      bad_request
    end

  rescue ActiveRecord::RecordNotFound
    record_not_found
  end

  def find_all
    if !params[:name].blank? && !params[:min_price] && !params[:max_price]
      items = Item.search_by_name(params[:name])
      render json: ItemSerializer.all_items(items)
    elsif !params[:name] && !params[:min_price].blank? && !params[:max_price]
      items = Item.search_by_min(params[:min_price])
      render json: ItemSerializer.all_items(items)
    elsif !params[:name] && !params[:min_price] && !params[:max_price].blank?
      items = Item.search_by_max(params[:max_price])
      render json: ItemSerializer.all_items(items)
    elsif !params[:name] && !params[:min_price].blank? && !params[:max_price].blank?
      items = Item.search_within_range(params[:min_price], params[:max_price])
      render json: ItemSerializer.all_items(items)
    else
      bad_request
    end
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

  def item_params
    params.require(:item).permit(:name, :description, :unit_price, :merchant_id)
  end
end
