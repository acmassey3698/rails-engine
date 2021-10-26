require 'rails_helper'

RSpec.describe 'item show endpoint' do
  it 'returns info about only one item' do
    merch1 = create(:merchant)

    item1 = create(:item, merchant: merch1)
    item2 = create(:item, merchant: merch1)
    item3 = create(:item, merchant: merch1)
    item4 = create(:item, merchant: merch1)
    item5 = create(:item, merchant: merch1)

    get "/api/v1/items/#{item1.id}"

    expect(response).to be_successful

    response_body = JSON.parse(response.body, symbolize_names: true)
    item = response_body[:data]

    expect(item[:id].to_i).to eq(item1.id)
    expect(item[:type]).to eq("item")
    expect(item[:attributes][:name]).to eq(item1.name)
    expect(item[:attributes][:description]).to eq(item1.description)
    expect(item[:attributes][:unit_price]).to eq(item1.unit_price)
    expect(item[:attributes][:merchant_id]).to eq(item1.merchant.id)
  end

  it 'does not return a record if the ID does not exist' do
    merch1 = create(:merchant)

    item1 = create(:item, merchant: merch1)
    item2 = create(:item, merchant: merch1)
    item3 = create(:item, merchant: merch1)
    item4 = create(:item, merchant: merch1)
    item5 = create(:item, merchant: merch1)

    get "/api/v1/items/1"

    expect(response).to_not be_successful
    expect(response.status).to eq(404)

    response_body = JSON.parse(response.body, symbolize_names: true)

    expect(response_body[:data][:message]).to eq("Error: Search not completed")
    expect(response_body[:error].first).to eq("no record found with id: 1")
  end
end
