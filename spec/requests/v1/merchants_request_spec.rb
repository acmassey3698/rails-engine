require 'rails_helper'

describe 'merchants index endpoint' do
  it 'gets all merchants' do
    create_list(:merchant, 5)

    get '/api/v1/merchants'

    expect(response).to be_successful

    merchants = JSON.parse(response.body, symbolize_names: true)

    merchants[:data].each do |merchant|
      expect(merchant[:id]).to be_a(String)
      expect(merchant[:type]).to eq("merchant")
      expect(merchant[:attributes]).to be_a(Hash)
      expect(merchant[:attributes].length).to eq(1)
      expect(merchant[:attributes][:name]).to be_a(String)
    end
  end

  it 'defaults to only 20 merchants on a page' do
    create_list(:merchant, 40)

    get '/api/v1/merchants'

    expect(response).to be_successful

    merchants = JSON.parse(response.body, symbolize_names: true)

    expect(merchants[:data].count).to eq(20)
  end

  it 'allows for a specific number of results per page' do
    create_list(:merchant, 40)

    get '/api/v1/merchants', params: { per_page: 10 }

    expect(response).to be_successful

    merchants = JSON.parse(response.body, symbolize_names: true)

    expect(merchants[:data].count).to eq(10)
  end

  it 'can choose a specific page' do
    create_list(:merchant, 30)

    get '/api/v1/merchants', params: { per_page: 10, page: 2 }

    expect(response).to be_successful

    merchants = JSON.parse(response.body, symbolize_names: true)

    all_merchants = Merchant.all

    expect(merchants[:data].count).to eq(10)
    expect(merchants[:data][0][:id].to_i).to eq(all_merchants[10].id)
  end

  it 'returns the first page if a negative page is input' do
    create_list(:merchant, 30)

    get '/api/v1/merchants', params: { per_page: 10, page: -5 }

    expect(response).to be_successful

    merchants = JSON.parse(response.body, symbolize_names: true)

    expect(merchants[:data].count).to eq(10)
    expect(merchants[:data][0][:id].to_i).to eq(Merchant.first.id)
  end
end
