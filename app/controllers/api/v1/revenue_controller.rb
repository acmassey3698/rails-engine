class Api::V1::RevenueController < ApplicationController
  def top_merchants
    if params[:quantity].blank? || !params[:quantity] || params[:quantity].to_i.negative?
      bad_request
    else
      merchants = Merchant.top_merchants(params[:quantity])
      render json: MerchantSerializer.all_merchants_revenue(merchants)
    end
  end

  def show
    merchant = Merchant.find(params[:id])
    merchant_rev = merchant.merchant_revenue
    render json: MerchantSerializer.one_merchant_revenue(merchant_rev)
  end
end
