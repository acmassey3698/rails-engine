class ItemRevenueSerializer

  def self.all_items(items)
    {
      "data": items.map do |item|
        {
          "id": "#{item.id}",
          "type": "item_revenue",
          "attributes": {
            "name": item.name,
            "description": item.description,
            "unit_price": item.unit_price,
            "merchant_id": item.merchant.id,
            "revenue": item.revenue
          }
        }
      end
    }
  end
end
