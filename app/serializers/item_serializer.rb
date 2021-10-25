class ItemSerializer
  def self.all_items(items)
    {
      "data": items.map do |item|
        {
          "id": "#{item.id}",
          "type": "item",
          "attributes": {
            "name": item.name,
            "description": item.description,
            "unit_price": item.unit_price,
            "merchant_id": item.merchant.id
          }
        }
      end
    }
  end

  def self.one_item(item)
    {
      "data": {
        "id": "#{item.id}",
        "type": "item",
        "attributes": {
          "name": item.name,
          "description": item.description,
          "unit_price": item.unit_price,
          "merchant_id": item.merchant.id,
        }
      }
    }
  end
end
