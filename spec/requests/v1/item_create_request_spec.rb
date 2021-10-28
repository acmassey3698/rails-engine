require 'rails_helper'

RSpec.describe 'create a new item' do
  it 'creates a new item' do
    merch1 = create(:merchant)
    item_params = {
      name: "Coffee Cup",
      description: "Keeps it hot",
      unit_price: 300.0,
      merchant_id: merch1.id
    }

    post '/api/v1/items', params: { item: item_params }

    expect(response).to be_successful

    response_body = JSON.parse(response.body, symbolize_names: true)
    item = response_body[:data]

    expect(item[:attributes][:name]).to eq(item_params[:name])
    expect(item[:attributes][:description]).to eq(item_params[:description])
    expect(item[:attributes][:unit_price]).to eq(item_params[:unit_price])
    expect(item[:attributes][:merchant_id]).to eq(item_params[:merchant_id])
  end

  it 'does not create an item with invalid input' do
    merch1 = create(:merchant)
    item_params = {
      name: "Coffee Cup",
      description: "Keeps it hot",
      unit_price: "I need more coffe",
      merchant_id: merch1.id
    }

    post '/api/v1/items', params: { item: item_params }

    expect(response).to_not be_successful
    expect(response.status).to eq(400)

    response_body = JSON.parse(response.body, symbolize_names: true)

    expect(response_body[:message]).to eq("Record not found")
    expect(response_body[:error]).to eq("Query missing required information")
  end
end
