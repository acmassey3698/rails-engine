require 'rails_helper'

RSpec.describe "One item's merchant endpoint" do
  it 'gets the merchant for a specific item' do
    merch1 = create(:merchant)

    item1 = create(:item, merchant: merch1)
    item2 = create(:item, merchant: merch1)
    item3 = create(:item, merchant: merch1)
    item4 = create(:item, merchant: merch1)
    item5 = create(:item, merchant: merch1)

    get "/api/v1/items/#{item1.id}/merchant"

    expect(response).to be_successful
    expect(response.status).to eq(200)

    response_body = JSON.parse(response.body, symbolize_names: true)
    merchant = response_body[:data]

    expect(merchant[:id].to_i).to eq(merch1.id)
    expect(merchant[:type]).to eq("merchant")
    expect(merchant[:attributes][:name]).to eq(merch1.name)
  end

  it 'returns a 404 if the item record is not found' do
    merch1 = create(:merchant)

    get "/api/v1/items/1/merchant"

    expect(response).to_not be_successful
    expect(response.status).to eq(404)

    response_body = JSON.parse(response.body, symbolize_names: true)

    expect(response_body[:data][:message]).to eq("Error: Search not completed")
    expect(response_body[:error].first).to eq("no record found with id: 1")
  end 
end
