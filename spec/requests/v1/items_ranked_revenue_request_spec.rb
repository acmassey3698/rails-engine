require 'rails_helper'

RSpec.describe 'Items ranked by revenue endpoint' do
    before(:each) do
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
      @item9 = create(:item, merchant: @merch1)
      @item10 = create(:item, merchant: @merch1)
      @item11 = create(:item, merchant: @merch1)
      @invoice1 = create(:invoice, customer: @cust1, merchant: @merch4)
      @invoice2 = create(:invoice, customer: @cust2, merchant: @merch5)
      @invoice3 = create(:invoice, customer: @cust3, merchant: @merch6)
      @invoice4 = create(:invoice, customer: @cust4, merchant: @merch4)
      @invoice5 = create(:invoice, customer: @cust5, merchant: @merch5)
      @invoice6 = create(:invoice, customer: @cust6, merchant: @merch6)
      @invoice7 = create(:invoice, customer: @cust6, merchant: @merch7)
      @invoice8 = create(:invoice, customer: @cust6, merchant: @merch8)
      @invoice9 = create(:invoice, customer: @cust6, merchant: @merch1)
      @invoice10 = create(:invoice, customer: @cust6, merchant: @merch1)
      @invoice11 = create(:invoice, customer: @cust6, merchant: @merch1)
      InvoiceItem.create(item: @item1, invoice: @invoice1, unit_price: 1000, quantity: 10)
      InvoiceItem.create(item: @item2, invoice: @invoice2, unit_price: 1000, quantity: 40)
      InvoiceItem.create(item: @item3, invoice: @invoice3, unit_price: 1000, quantity: 50)
      InvoiceItem.create(item: @item4, invoice: @invoice4, unit_price: 1000, quantity: 55)
      InvoiceItem.create(item: @item5, invoice: @invoice5, unit_price: 1000, quantity: 60)
      InvoiceItem.create(item: @item6, invoice: @invoice6, unit_price: 1000, quantity: 65)
      InvoiceItem.create(item: @item7, invoice: @invoice7, unit_price: 1000, quantity: 70)
      InvoiceItem.create(item: @item8, invoice: @invoice8, unit_price: 1000, quantity: 75)
      InvoiceItem.create(item: @item9, invoice: @invoice9, unit_price: 1000, quantity: 80)
      InvoiceItem.create(item: @item10, invoice: @invoice10, unit_price: 1000, quantity: 85)
      InvoiceItem.create(item: @item11, invoice: @invoice11, unit_price: 1000, quantity: 90)
      create(:transaction, invoice: @invoice1)
      create(:transaction, invoice: @invoice2)
      create(:transaction, invoice: @invoice3)
      create(:transaction, invoice: @invoice4)
      create(:transaction, invoice: @invoice5)
      create(:transaction, invoice: @invoice6)
      create(:transaction, invoice: @invoice7)
      create(:transaction, invoice: @invoice8)
      create(:transaction, invoice: @invoice9)
      create(:transaction, invoice: @invoice10)
      create(:transaction, invoice: @invoice11)
    end

    it 'returns the items ranked by the revenue generated' do
      get '/api/v1/revenue/items?quantity=3'

      expect(response).to be_successful

      response_body = JSON.parse(response.body, symbolize_names: true)
      items = response_body[:data]

      expect(items[0][:id].to_i).to eq(@item11.id)
      expect(items[0][:attributes][:revenue]).to be_a(Float)
      expect(items[1][:id].to_i).to eq(@item10.id)
      expect(items[1][:attributes][:revenue]).to be_a(Float)
      expect(items[2][:id].to_i).to eq(@item9.id)
      expect(items[2][:attributes][:revenue]).to be_a(Float)
    end

    it 'returns an error if the quantity is a string' do
      get '/api/v1/revenue/items?quantity=fdafe'

      expect(response).to_not be_successful
      expect(response.status).to eq(400)
    end

    it 'does not allow negative quantity' do
      get '/api/v1/revenue/items?quantity=-1'

      expect(response).to_not be_successful
      expect(response.status).to eq(400)
    end

    it 'returns ten items if quantity is not specified' do
      get '/api/v1/revenue/items'

      expect(response).to be_successful

      response_body = JSON.parse(response.body, symbolize_names: true)
      items = response_body[:data]

      expect(items.length).to eq(10)

      expect(items[0][:id].to_i).to eq(@item11.id)
      expect(items[0][:attributes][:revenue]).to be_a(Float)
      expect(items[1][:id].to_i).to eq(@item10.id)
      expect(items[1][:attributes][:revenue]).to be_a(Float)
      expect(items[2][:id].to_i).to eq(@item9.id)
      expect(items[2][:attributes][:revenue]).to be_a(Float)
      expect(items[3][:id].to_i).to eq(@item8.id)
      expect(items[3][:attributes][:revenue]).to be_a(Float)
      expect(items[4][:id].to_i).to eq(@item7.id)
      expect(items[4][:attributes][:revenue]).to be_a(Float)
      expect(items[5][:id].to_i).to eq(@item6.id)
      expect(items[5][:attributes][:revenue]).to be_a(Float)
      expect(items[6][:id].to_i).to eq(@item5.id)
      expect(items[6][:attributes][:revenue]).to be_a(Float)
      expect(items[7][:id].to_i).to eq(@item4.id)
      expect(items[7][:attributes][:revenue]).to be_a(Float)
      expect(items[8][:id].to_i).to eq(@item3.id)
      expect(items[8][:attributes][:revenue]).to be_a(Float)
      expect(items[9][:id].to_i).to eq(@item2.id)
      expect(items[9][:attributes][:revenue]).to be_a(Float)
    end
end
