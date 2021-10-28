class Api::V1::MerchantsController < ApplicationController
  def index
    merchants = Merchant.limit(results_per_page).offset(calculate_offset)
    render json: MerchantSerializer.all_merchants(merchants)
  end

  def show
    merchant = Merchant.find(params[:id])
    render json: MerchantSerializer.one_merchant(merchant)

  rescue ActiveRecord::RecordNotFound
    record_not_found
  end

  def find
    if !params[:name].blank?
      merchant = Merchant.search(params[:name])
      if merchant.nil?
        render json: {
        data: { message: "no merchant name found including '#{params[:name]}'" }
      }, status: 404
      else
        render json: MerchantSerializer.one_merchant(merchant)
      end
    else
      bad_request
    end
  end
end
