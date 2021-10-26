require 'rails_helper'

RSpec.describe 'find one merchant based on search criteria' do
  it 'finds on merchant when you search by name' do
    create_list(:merchant, 15)
    andrew = create(:merchant, name: "Andrew")
    annie = create(:merchant, name: "Annie")
    alex = create(:merchant, name: "Alex")

    get '/api/v1/merchants/find?name=Andrew'

    expect(response).to be_successful

    response_body = JSON.parse(response.body, symbolize_names: true)
    merchant = response_body[:data]

    expect(merchant[:id].to_i).to eq(andrew.id)
    expect(merchant[:type]).to eq("merchant")
    expect(merchant[:attributes][:name]).to eq(andrew.name)
  end
end
