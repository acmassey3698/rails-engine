class Api::V1::Revenue::MerchantsController < ApplicationController
  def index
    if params[:quantity].blank? || !params[:quantity] || params[:quantity].to_i.negative?
      bad_request
    else
      merchants = Merchant.top_merchants(params[:quantity])
      render json: MerchantNameRevenueSerializer.all_merchants(merchants)
    end
  end

  def show
    merchant = Merchant.find(params[:id])
    merchant_rev = merchant.merchant_revenue
    render json: MerchantRevenueSerializer.one_merchant(merchant_rev)

  rescue ActiveRecord::RecordNotFound
    record_not_found
  end
end
