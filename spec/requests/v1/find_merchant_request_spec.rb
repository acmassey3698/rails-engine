require 'rails_helper'

RSpec.describe 'find one merchant based on search criteria' do
  it 'finds on merchant when you search by name' do
    create_list(:merchant, 15)
    andrew = create(:merchant, name: "Andrew")
    andrea = create(:merchant, name: "Andrea")
    alex = create(:merchant, name: "Alex")

    get '/api/v1/merchants/find?name=andre'
    expect(response).to be_successful

    response_body = JSON.parse(response.body, symbolize_names: true)
    merchant = response_body[:data]

    expect(merchant[:attributes][:name]).to eq(andrea.name)
    expect(merchant[:id].to_i).to eq(andrea.id)
    expect(merchant[:type]).to eq("merchant")
  end

  it 'is case insensitive for searching merchants' do
    create_list(:merchant, 15)
    andrew = create(:merchant, name: "Andrew")
    andrea = create(:merchant, name: "Andrea")
    alex = create(:merchant, name: "Alex")

    get '/api/v1/merchants/find?name=aNdRe'
    expect(response).to be_successful

    response_body = JSON.parse(response.body, symbolize_names: true)
    merchant = response_body[:data]

    expect(merchant[:attributes][:name]).to eq(andrea.name)
    expect(merchant[:id].to_i).to eq(andrea.id)
    expect(merchant[:type]).to eq("merchant")
  end

  it 'returns the not found error when there is no merchant that matches the search' do
    create_list(:merchant, 15)

    get '/api/v1/merchants/find?name=onwfonweoano'
    expect(response).to_not be_successful
    expect(response.status).to eq(404)

    response_body = JSON.parse(response.body, symbolize_names: true)
    error = response_body[:data]

    expect(error[:message]).to eq("Error: Search not completed")
    expect(error[:errors].first).to eq("no record found with id: ")
  end
end
