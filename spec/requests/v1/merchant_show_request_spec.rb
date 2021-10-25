require 'rails_helper'

RSpec.describe 'merchant show endpoint' do
  it 'returns info about only one merchant' do
    merchants = create_list(:merchant, 5)

    get "/api/v1/merchants/#{merchants.first.id}"

    expect(response).to be_successful

    response_body = JSON.parse(response.body, symbolize_names: true)
    merchant = response_body[:data]

    expect(merchant[:id].to_i).to eq(merchants.first.id)
    expect(merchant[:type]).to eq("merchant")
    expect(merchant[:attributes][:name]).to eq(merchants.first.name)
  end


end
