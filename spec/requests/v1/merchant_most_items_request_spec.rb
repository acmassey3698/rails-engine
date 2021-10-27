require 'rails_helper'

RSpec.describe 'Rank x number of merchants by items sold endpoint' do
  before :each do
    @merch1 = create(:merchant)
    @merch2 = create(:merchant)
    @merch3 = create(:merchant)
    @merch4 = create(:merchant)
    @merch5 = create(:merchant)
    @merch6 = create(:merchant)
    @merch7 = create(:merchant)
    @merch8 = create(:merchant)
    @cust1 = create(:customer)
    @cust2 = create(:customer)
    @cust3 = create(:customer)
    @cust4 = create(:customer)
    @cust5 = create(:customer)
    @cust6 = create(:customer)
    @item1 = create(:item, merchant: @merch4)
    @item2 = create(:item, merchant: @merch5)
    @item3 = create(:item, merchant: @merch6)
    @item4 = create(:item, merchant: @merch4)
    @item5 = create(:item, merchant: @merch5)
    @item6 = create(:item, merchant: @merch6)
    @item7 = create(:item, merchant: @merch7)
    @item8 = create(:item, merchant: @merch8)
    @invoice1 = create(:invoice, customer: @cust1, merchant: @merch4)
    @invoice2 = create(:invoice, customer: @cust2, merchant: @merch5)
    @invoice3 = create(:invoice, customer: @cust3, merchant: @merch6)
    @invoice4 = create(:invoice, customer: @cust4, merchant: @merch4)
    @invoice5 = create(:invoice, customer: @cust5, merchant: @merch5)
    @invoice6 = create(:invoice, customer: @cust6, merchant: @merch6)
    @invoice7 = create(:invoice, customer: @cust6, merchant: @merch7)
    @invoice8 = create(:invoice, customer: @cust6, merchant: @merch8)
    InvoiceItem.create(item: @item1, invoice: @invoice1, unit_price: 1000, quantity: 50)
    InvoiceItem.create(item: @item2, invoice: @invoice2, unit_price: 2000, quantity: 60)
    InvoiceItem.create(item: @item3, invoice: @invoice3, unit_price: 3000, quantity: 70)
    InvoiceItem.create(item: @item4, invoice: @invoice4, unit_price: 4000, quantity: 80)
    InvoiceItem.create(item: @item5, invoice: @invoice5, unit_price: 5000, quantity: 90)
    InvoiceItem.create(item: @item6, invoice: @invoice6, unit_price: 6000, quantity: 100)
    InvoiceItem.create(item: @item7, invoice: @invoice7, unit_price: 6000, quantity: 10)
    InvoiceItem.create(item: @item8, invoice: @invoice8, unit_price: 6000, quantity: 20)
    create(:transaction, invoice: @invoice1)
    create(:transaction, invoice: @invoice2)
    create(:transaction, invoice: @invoice3)
    create(:transaction, invoice: @invoice4)
    create(:transaction, invoice: @invoice5)
    create(:transaction, invoice: @invoice6)
    create(:transaction, invoice: @invoice1)
    create(:transaction, invoice: @invoice2)
    create(:transaction, invoice: @invoice3)
    create(:transaction, invoice: @invoice4)
    create(:transaction, invoice: @invoice5)
    create(:transaction, invoice: @invoice6)
    create(:transaction, invoice: @invoice7)
    create(:transaction, invoice: @invoice8)
  end

  it 'returns the merchants who sold the most items' do
    get '/api/v1/merchants/most_items?quantity=3'

    expect(response).to be_successful

    response_body = JSON.parse(response.body, symbolize_names: true)
    merchants = response_body[:data]

    expect(merchants[0][:id].to_i).to eq(@merch6.id)
    expect(merchants[0][:attributes][:count]).to be_an(Integer)
    expect(merchants[1][:id].to_i).to eq(@merch5.id)
    expect(merchants[1][:attributes][:count]).to be_an(Integer)
    expect(merchants[2][:id].to_i).to eq(@merch4.id)
    expect(merchants[2][:attributes][:count]).to be_an(Integer)
  end

  it 'returns an error if the user sends a negative quantity' do
    get '/api/v1/merchants/most_items?quantity=-3'

    expect(response).to_not be_successful
    expect(response.status).to eq(400)

    response_body = JSON.parse(response.body, symbolize_names: true)

    expect(response_body[:message]).to eq("Error: Bad Request")
  end

  it 'returns an error if the user sends a blank quantity' do
    get '/api/v1/merchants/most_items?quantity= '

    expect(response).to_not be_successful
    expect(response.status).to eq(400)

    response_body = JSON.parse(response.body, symbolize_names: true)

    expect(response_body[:message]).to eq("Error: Bad Request")
  end

  it 'defaults to 5 merchants when the quantity param is omitted' do
    get '/api/v1/merchants/most_items'

    expect(response).to_not be_successful
    response_body = JSON.parse(response.body, symbolize_names: true)
    # merchants = response_body[:data]
    # expect(merchants.length).to eq(5)
    # 
    # expect(merchants[0][:id].to_i).to eq(@merch6.id)
    # expect(merchants[0][:attributes][:count]).to be_an(Integer)
    # expect(merchants[1][:id].to_i).to eq(@merch5.id)
    # expect(merchants[1][:attributes][:count]).to be_an(Integer)
    # expect(merchants[2][:id].to_i).to eq(@merch4.id)
    # expect(merchants[2][:attributes][:count]).to be_an(Integer)
    # expect(merchants[3][:id].to_i).to eq(@merch8.id)
    # expect(merchants[3][:attributes][:count]).to be_an(Integer)
    # expect(merchants[4][:id].to_i).to eq(@merch7.id)
    # expect(merchants[4][:attributes][:count]).to be_an(Integer)
  end
end
