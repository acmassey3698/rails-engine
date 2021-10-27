class ItemsSoldSerializer
  def self.top_merchants(merchants)
    {
      "data": merchants.map do |merchant|
        {
          "id": "#{merchant.id}",
          "type": "items_sold",
          "attributes": {
            "name": merchant.name,
            "count": merchant.items_sold
          }
        }
      end
    }
  end
end
