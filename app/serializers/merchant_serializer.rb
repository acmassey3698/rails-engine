class MerchantSerializer

  def self.all_merchants(merchants)
    {
      "data": merchants.map do |merchant|
        {
          "id": "#{merchant.id}",
          "type": "merchant",
          "attributes": {
            "name": merchant.name
          }
        }
      end
    }
  end

  def self.one_merchant(merchant)
    {
      "data": {
        "id": "#{merchant.id}",
        "type": "merchant",
        "attributes": {
          "name": merchant.name
        }
      }
    }
  end

  def self.all_merchants_revenue(merchants)
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

  def self.one_merchant_revenue(merchant)
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
