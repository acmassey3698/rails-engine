require 'rails_helper'

RSpec.describe 'find one merchant based on search criteria' do
  it 'finds on merchant when you search by name' do
    create_list(:merchant, 15)
    andrew = create(:merchant, name: "Andrew")
    andrea = create(:merchant, name: "Andrea")
    alex = create(:merchant, name: "Alex")

    get '/api/v1/merchants/find?name=Andre'
    expect(response).to be_successful

    response_body = JSON.parse(response.body, symbolize_names: true)
    merchant = response_body[:data]

    expect(merchant[:attributes][:name]).to eq(andrea.name)
    expect(merchant[:id].to_i).to eq(andrea.id)
    expect(merchant[:type]).to eq("merchant")
  end
end
