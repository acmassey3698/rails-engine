require 'rails_helper'

RSpec.describe 'one merchants revenue endpoint' do
  before(:each) do
    @merch1 = create(:merchant)
    @merch2 = create(:merchant)
    @merch3 = create(:merchant)
    @cust1 = create(:customer)
    @cust2 = create(:customer)
    @cust3 = create(:customer)
    @cust4 = create(:customer)
    @cust5 = create(:customer)
    @cust6 = create(:customer)
    @item1 = create(:item, merchant: @merch1)
    @item2 = create(:item, merchant: @merch2)
    @item3 = create(:item, merchant: @merch3)
    @invoice1 = create(:invoice, customer: @cust1, merchant: @merch1)
    @invoice2 = create(:invoice, customer: @cust2, merchant: @merch2)
    @invoice3 = create(:invoice, customer: @cust3, merchant: @merch3)
    @invoice4 = create(:invoice, customer: @cust4, merchant: @merch1)
    @invoice5 = create(:invoice, customer: @cust5, merchant: @merch1)
    @invoice6 = create(:invoice, customer: @cust6, merchant: @merch1)
    InvoiceItem.create(item: @item1, invoice: @invoice1, unit_price: 1000, quantity: 1)
    InvoiceItem.create(item: @item2, invoice: @invoice2, unit_price: 2000, quantity: 1)
    InvoiceItem.create(item: @item3, invoice: @invoice3, unit_price: 3000, quantity: 1)
    InvoiceItem.create(item: @item1, invoice: @invoice4, unit_price: 4000, quantity: 1)
    InvoiceItem.create(item: @item1, invoice: @invoice5, unit_price: 5000, quantity: 1)
    InvoiceItem.create(item: @item1, invoice: @invoice6, unit_price: 6000, quantity: 1)
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
  end

  it 'returns the revenue for one specific merchant' do
    get "/api/v1/revenue/merchants/#{@merch1.id}"

    expect(response).to be_successful

    response_body = JSON.parse(response.body, symbolize_names: true)
    merchant = response_body[:data]

    expect(merchant[:id].to_i).to eq(@merch1.id)
  end
end
