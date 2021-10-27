require 'rails_helper'

RSpec.describe Merchant, type: :model do
  describe 'relationships' do
    it { should have_many(:items) }
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }
  end

  describe 'class methods' do
    it '#search' do
      create_list(:merchant, 20)
      andrew = create(:merchant, name: "Andrew")
      andrea = create(:merchant, name: "Andrea")

      expect(Merchant.search("Andre")).to eq(andrea)
      expect(Merchant.search("Andrew")).to eq(andrew)
    end

    it '#top_merchants' do
      merch1 = create(:merchant)
      merch2 = create(:merchant)
      merch3 = create(:merchant)
      merch4 = create(:merchant)
      merch5 = create(:merchant)
      merch6 = create(:merchant)
      cust1 = create(:customer)
      cust2 = create(:customer)
      cust3 = create(:customer)
      cust4 = create(:customer)
      cust5 = create(:customer)
      cust6 = create(:customer)
      item1 = create(:item, merchant: merch1)
      item2 = create(:item, merchant: merch2)
      item3 = create(:item, merchant: merch3)
      item4 = create(:item, merchant: merch4)
      item5 = create(:item, merchant: merch5)
      item6 = create(:item, merchant: merch6)
      invoice1 = create(:invoice, customer: cust1, merchant: merch1)
      invoice2 = create(:invoice, customer: cust2, merchant: merch2)
      invoice3 = create(:invoice, customer: cust3, merchant: merch3)
      invoice4 = create(:invoice, customer: cust4, merchant: merch4)
      invoice5 = create(:invoice, customer: cust5, merchant: merch5)
      invoice6 = create(:invoice, customer: cust6, merchant: merch6)
      InvoiceItem.create(item: item1, invoice: invoice1, unit_price: 1000, quantity: 1)
      InvoiceItem.create(item: item2, invoice: invoice2, unit_price: 2000, quantity: 1)
      InvoiceItem.create(item: item3, invoice: invoice3, unit_price: 3000, quantity: 1)
      InvoiceItem.create(item: item4, invoice: invoice4, unit_price: 4000, quantity: 1)
      InvoiceItem.create(item: item5, invoice: invoice5, unit_price: 5000, quantity: 1)
      InvoiceItem.create(item: item6, invoice: invoice6, unit_price: 6000, quantity: 1)
      create(:transaction, invoice: invoice1)
      create(:transaction, invoice: invoice2)
      create(:transaction, invoice: invoice3)
      create(:transaction, invoice: invoice4)
      create(:transaction, invoice: invoice5)
      create(:transaction, invoice: invoice6)
      create(:transaction, invoice: invoice1)
      create(:transaction, invoice: invoice2)
      create(:transaction, invoice: invoice3)
      create(:transaction, invoice: invoice4)
      create(:transaction, invoice: invoice5)
      create(:transaction, invoice: invoice6)
      expect(Merchant.top_merchants(3)).to eq([merch6, merch5, merch4])
      expect(Merchant.top_merchants(3).first.revenue).to eq(12000.0)
    end
  end

  describe 'instance methods' do
    it '#merchant_revenue' do
      merch1 = create(:merchant)
      merch2 = create(:merchant)
      merch3 = create(:merchant)
      cust1 = create(:customer)
      cust2 = create(:customer)
      cust3 = create(:customer)
      cust4 = create(:customer)
      cust5 = create(:customer)
      cust6 = create(:customer)
      item1 = create(:item, merchant: merch1)
      item2 = create(:item, merchant: merch2)
      item3 = create(:item, merchant: merch3)
      invoice1 = create(:invoice, customer: cust1, merchant: merch1)
      invoice2 = create(:invoice, customer: cust2, merchant: merch2)
      invoice3 = create(:invoice, customer: cust3, merchant: merch3)
      invoice4 = create(:invoice, customer: cust4, merchant: merch1)
      invoice5 = create(:invoice, customer: cust5, merchant: merch1)
      invoice6 = create(:invoice, customer: cust6, merchant: merch1)
      InvoiceItem.create(item: item1, invoice: invoice1, unit_price: 1000, quantity: 1)
      InvoiceItem.create(item: item2, invoice: invoice2, unit_price: 2000, quantity: 1)
      InvoiceItem.create(item: item3, invoice: invoice3, unit_price: 3000, quantity: 1)
      InvoiceItem.create(item: item1, invoice: invoice4, unit_price: 4000, quantity: 1)
      InvoiceItem.create(item: item1, invoice: invoice5, unit_price: 5000, quantity: 1)
      InvoiceItem.create(item: item1, invoice: invoice6, unit_price: 6000, quantity: 1)
      create(:transaction, invoice: invoice1)
      create(:transaction, invoice: invoice2)
      create(:transaction, invoice: invoice3)
      create(:transaction, invoice: invoice4)
      create(:transaction, invoice: invoice5)
      create(:transaction, invoice: invoice6)
      create(:transaction, invoice: invoice1)
      create(:transaction, invoice: invoice2)
      create(:transaction, invoice: invoice3)
      create(:transaction, invoice: invoice4)
      create(:transaction, invoice: invoice5)
      create(:transaction, invoice: invoice6)

      expect(merch1.merchant_revenue.revenue).to eq(32000.0)
    end
  end
end
