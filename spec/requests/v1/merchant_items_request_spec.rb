require 'rails_helper'

RSpec.describe 'merchant items index request' do
  it 'returns all of the items for a given merchant' do
    merch1 = create(:merchant)
    item1 = create(:item, merchant: merch1)
    item2 = create(:item, merchant: merch1)
    item3 = create(:item, merchant: merch1)

    get "/api/v1/merchants/#{merch1.id}/items"

    expect(response).to be_successful

    response_body = JSON.parse(response.body, symbolize_names: true)
    items = response_body[:data]

    expect(response_body).to have_key(:data)
    expect(response_body[:data]).to be_an(Array)

    items.each do |item|
      expect(item[:id]).to be_a(String)
      expect(item[:type]).to be_a(String)
      expect(item[:attributes]).to be_a(Hash)
      expect(item[:attributes][:name]).to be_a(String)
      expect(item[:attributes][:description]).to be_a(String)
      expect(item[:attributes][:unit_price]).to be_a(Float)
      expect(item[:attributes][:merchant_id]).to be_an(Integer)
    end
  end

  it 'does not return another merchants items' do
    merch1 = create(:merchant)
    merch2 = create(:merchant)
    item1 = create(:item, merchant: merch1)
    item2 = create(:item, merchant: merch1)
    item3 = create(:item, merchant: merch1)
    item4 = create(:item, merchant: merch2)

    get "/api/v1/merchants/#{merch1.id}/items"

    expect(response).to be_successful

    response_body = JSON.parse(response.body, symbolize_names: true)
    items = response_body[:data]

    items.each do |item|
      expect(item[:attributes][:name]).to_not eq(item4.name)
      expect(item[:attributes][:merchant_id]).to_not eq(merch2.id)
    end
  end

  it 'does not return items if the merchant is not found' do
    merch1 = create(:merchant)
    merch2 = create(:merchant)
    item1 = create(:item, merchant: merch1)
    item2 = create(:item, merchant: merch1)
    item3 = create(:item, merchant: merch1)
    item4 = create(:item, merchant: merch2)

    get "/api/v1/merchants/1/items"

    expect(response).to_not be_successful
    expect(response.status).to eq(404)

    response_body = JSON.parse(response.body, symbolize_names: true)


    expect(response_body[:data][:message]).to eq("Error: Search not completed")
    expect(response_body[:error].first).to eq("no record found with id: 1")
  end
end
