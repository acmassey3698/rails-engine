class Api::V1::MerchantsController < ApplicationController
  def index
    merchants = Merchant.limit(results_per_page).offset(calculate_offset)
    render json: MerchantSerializer.all_merchants(merchants)
  end

  def show
    merchant = Merchant.find(params[:id])
    render json: MerchantSerializer.one_merchant(merchant)
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
