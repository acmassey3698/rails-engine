require 'rails_helper'

RSpec.describe 'Update item endpoint' do
  it 'Updates an item that is already existing' do
    merch1 = create(:merchant)

    item1 = create(:item, merchant: merch1)
    item2 = create(:item, merchant: merch1)
    item3 = create(:item, merchant: merch1)
    item4 = create(:item, merchant: merch1)
    item5 = create(:item, merchant: merch1)

    put "/api/v1/items/#{item1.id}", params: { item: { name: "Bookend"}}

    expect(response).to be_successful

    response_body = JSON.parse(response.body, symbolize_names: true)
    item = response_body[:data]

    expect(item[:attributes][:name]).to eq("Bookend")
  end

  it 'does not update if the data input is invalid' do
    merch1 = create(:merchant)

    item1 = create(:item, merchant: merch1)
    item2 = create(:item, merchant: merch1)
    item3 = create(:item, merchant: merch1)
    item4 = create(:item, merchant: merch1)
    item5 = create(:item, merchant: merch1)

    put "/api/v1/items/#{item1.id}", params: { item: { unit_price: "Bookend"}}

    expect(response).to_not be_successful
    expect(response.status).to eq(400)

    response_body = JSON.parse(response.body, symbolize_names: true)

    expect(response_body[:message]).to eq("Error: Bad Request")
  end

  it 'does not update if the item does not exist' do
    merch1 = create(:merchant)

    put "/api/v1/items/1", params: { item: { unit_price: "Bookend"}}

    expect(response).to_not be_successful
    expect(response.status).to eq(404)

    response_body = JSON.parse(response.body, symbolize_names: true)
    expect(response_body[:data][:message]).to eq("Error: Search not completed")
    expect(response_body[:error].first).to eq("no record found with id: 1")
  end
end
