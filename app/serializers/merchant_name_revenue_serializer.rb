class MerchantNameRevenueSerializer
  def self.all_merchants(merchants)
    {
      "data": merchants.map do |merchant|
        {
          "id": "#{merchant.id}",
          "type": "merchant_name_revenue",
          "attributes": {
            "name": merchant.name,
            "revenue": merchant.revenue
          }
        }
      end
    }
  end
end
