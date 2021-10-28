class MerchantRevenueSerializer
  def self.one_merchant(merchant)
    {
      "data": {
        "id": "#{merchant.id}",
        "type": "merchant_revenue",
        "attributes": {
          "revenue": merchant.revenue
        }
      }
    }
  end
end
