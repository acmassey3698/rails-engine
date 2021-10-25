require 'rails_helper'

RSpec.describe 'items index endpoint' do
  it 'gets all items' do
    merch1 = create(:merchant)
    create_list(:item, 5, merchant: merch1)

    get '/api/v1/items'

    expect(response).to be_successful

    response_body = JSON.parse(response.body, symbolize_names: true)
    items = response_body[:data]

    items.each do |item|
      expect(item[:id]).to be_a(String)
      expect(item[:type]).to eq("item")
      expect(item[:attributes]).to be_a(Hash)
      expect(item[:attributes][:description]).to be_a(String)
      expect(item[:attributes][:unit_price]).to be_a(Float)
      expect(item[:attributes][:merchant_id]).to be_an(Integer)
    end
  end

  it 'defaults to only 20 merchants on a page' do
    merch1 = create(:merchant)
    create_list(:item, 40, merchant: merch1)

    get '/api/v1/items'

    expect(response).to be_successful

    response_body = JSON.parse(response.body, symbolize_names: true)
    items = response_body[:data]

    expect(items.count).to eq(20)
  end

  it 'allows for a specific number of results per page' do
    merch1 = create(:merchant)
    create_list(:item, 40, merchant: merch1)

    get '/api/v1/items', params: { per_page: 10 }

    expect(response).to be_successful

    response_body = JSON.parse(response.body, symbolize_names: true)
    items = response_body[:data]

    expect(items.count).to eq(10)
  end

  it 'can choose a specific page' do
    merch1 = create(:merchant)
    create_list(:item, 40, merchant: merch1)

    get '/api/v1/items', params: { per_page: 10, page: 2 }

    expect(response).to be_successful

    response_body = JSON.parse(response.body, symbolize_names: true)
    items = response_body[:data]
    all_items = Item.all

    expect(items.count).to eq(10)
    expect(items[0][:id].to_i).to eq(all_items[10].id)
  end

  it 'returns the first page if a negative page is input' do
    merch1 = create(:merchant)
    create_list(:item, 40, merchant: merch1)

    get '/api/v1/items', params: { per_page: 10, page: -5 }

    expect(response).to be_successful

    response_body = JSON.parse(response.body, symbolize_names: true)
    items = response_body[:data]

    expect(items.count).to eq(10)
    expect(items[0][:id].to_i).to eq(Item.first.id)
  end
end
