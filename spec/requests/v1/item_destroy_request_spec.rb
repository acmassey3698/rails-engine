require 'rails_helper'

RSpec.describe 'Item destroy endpoint' do
  it 'destroys the item record' do
    merch1 = create(:merchant)

    item1 = create(:item, merchant: merch1)
    item2 = create(:item, merchant: merch1)
    item3 = create(:item, merchant: merch1)
    item4 = create(:item, merchant: merch1)
    item5 = create(:item, merchant: merch1)

    delete "/api/v1/items/#{item1.id}"

    expect(response).to be_successful
    expect(response.status).to eq(204)
  end

  it 'does not destroy an item that does not exist' do
    merch1 = create(:merchant)

    item1 = create(:item, merchant: merch1)
    item2 = create(:item, merchant: merch1)
    item3 = create(:item, merchant: merch1)
    item4 = create(:item, merchant: merch1)
    item5 = create(:item, merchant: merch1)

    delete "/api/v1/items/1"

    expect(response).to_not be_successful
    expect(response.status).to eq(404)
  end
end
