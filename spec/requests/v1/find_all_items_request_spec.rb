require 'rails_helper'

RSpec.describe 'find all items request' do
  it 'finds all items by name' do
    merch1 = create(:merchant)
    create_list(:item, 30, merchant: merch1)
    item1 = create(:item, merchant: merch1, name: "Basket")
    item2 = create(:item, merchant: merch1, name: "Straw Basket")
    item3 = create(:item, merchant: merch1, name: "Awesome Basket")
    item4 = create(:item, merchant: merch1, name: "Soccer Ball")

    get '/api/v1/items/find_all?name=basket'

    expect(response).to be_successful

    response_body = JSON.parse(response.body, symbolize_names: true)
    items = response_body[:data]

    expect(items[0][:id].to_i).to eq(item3.id)
    expect(items[1][:id].to_i).to eq(item1.id)
    expect(items[2][:id].to_i).to eq(item2.id)
    expect(items[0][:attributes][:name]).to eq(item3.name)
    expect(items[1][:attributes][:name]).to eq(item1.name)
    expect(items[2][:attributes][:name]).to eq(item2.name)
    expect(items.include?(item4)).to be(false)
  end

  it 'Is case insensitive when searching by name' do
    merch1 = create(:merchant)
    create_list(:item, 30, merchant: merch1)
    item1 = create(:item, merchant: merch1, name: "Basket")
    item2 = create(:item, merchant: merch1, name: "Straw Basket")
    item3 = create(:item, merchant: merch1, name: "Awesome Basket")
    item4 = create(:item, merchant: merch1, name: "Soccer Ball")

    get '/api/v1/items/find_all?name=bAsKet'

    expect(response).to be_successful

    response_body = JSON.parse(response.body, symbolize_names: true)
    items = response_body[:data]

    expect(items[0][:id].to_i).to eq(item3.id)
    expect(items[1][:id].to_i).to eq(item1.id)
    expect(items[2][:id].to_i).to eq(item2.id)
    expect(items[0][:attributes][:name]).to eq(item3.name)
    expect(items[1][:attributes][:name]).to eq(item1.name)
    expect(items[2][:attributes][:name]).to eq(item2.name)
    expect(items.include?(item4)).to be(false)
  end

  it 'returns an empty collection when no items match the search param' do
    merch1 = create(:merchant)
    create_list(:item, 30, merchant: merch1)

    get '/api/v1/items/find_all?name=fdagegadsvewe'

    expect(response).to be_successful

    response_body = JSON.parse(response.body, symbolize_names: true)
    items = response_body[:data]

    expect(items.blank?).to be(true)
  end

  it 'returns an error when the search param is blank' do
    merch1 = create(:merchant)
    create_list(:item, 30, merchant: merch1)

    get '/api/v1/items/find_all?name= '

    expect(response).to_not be_successful
    expect(response.status).to eq(400)

    response_body = JSON.parse(response.body, symbolize_names: true)

    expect(response_body[:message]).to eq("Error: Bad Request")
  end
end
