require 'rails_helper'

RSpec.describe Item, type: :model do
  describe 'relationships' do
    it { should belong_to(:merchant) }
    it { should have_many(:invoice_items) }
    it { should have_many(:invoices).through(:invoice_items) }
  end

  describe 'validations' do
    it { should validate_numericality_of(:unit_price) }
    it { should validate_numericality_of(:merchant_id) }
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:description) }
  end

  before :each do
    @merch1 = create(:merchant)
    create_list(:item, 30, merchant: @merch1, unit_price: 10.00)
    @item1 = create(:item, merchant: @merch1, name: "Basket", unit_price: 15.00)
    @item2 = create(:item, merchant: @merch1, name: "Straw Basket", unit_price: 20.00)
    @item3 = create(:item, merchant: @merch1, name: "Awesome Basket", unit_price: 25.00)
    @item4 = create(:item, merchant: @merch1, name: "Soccer Ball", unit_price: 30.00)
    @item5 = create(:item, merchant: @merch1, name: "Dinosaur", unit_price: 5.00)
  end

  describe 'class methods' do
    it '#search_by_name' do
      expect(Item.search_by_name("Basket")).to eq([@item3, @item1, @item2])
    end

    it '#search_by_min' do
      expect(Item.search_by_min(15.00)).to eq([@item1, @item2, @item3, @item4])
    end

    it '#search_by_max' do
      expect(Item.search_by_max(9.50)).to eq([@item5])
    end

    it '#search_within_range' do
      expect(Item.search_within_range(11.00, 25.00)).to eq([@item1, @item2, @item3])
    end

    it '#revenue_ranked' do
      merch1 = create(:merchant)
      merch2 = create(:merchant)
      merch3 = create(:merchant)
      merch4 = create(:merchant)
      merch5 = create(:merchant)
      merch6 = create(:merchant)
      merch7 = create(:merchant)
      merch8 = create(:merchant)
      cust1 = create(:customer)
      cust2 = create(:customer)
      cust3 = create(:customer)
      cust4 = create(:customer)
      cust5 = create(:customer)
      cust6 = create(:customer)
      item1 = create(:item, merchant: merch4)
      item2 = create(:item, merchant: merch5)
      item3 = create(:item, merchant: merch6)
      item4 = create(:item, merchant: merch4)
      item5 = create(:item, merchant: merch5)
      item6 = create(:item, merchant: merch6)
      item7 = create(:item, merchant: merch7)
      item8 = create(:item, merchant: merch8)
      item9 = create(:item, merchant: merch1)
      item10 = create(:item, merchant: merch1)
      item11 = create(:item, merchant: merch1)
      invoice1 = create(:invoice, customer: cust1, merchant: merch4)
      invoice2 = create(:invoice, customer: cust2, merchant: merch5)
      invoice3 = create(:invoice, customer: cust3, merchant: merch6)
      invoice4 = create(:invoice, customer: cust4, merchant: merch4)
      invoice5 = create(:invoice, customer: cust5, merchant: merch5)
      invoice6 = create(:invoice, customer: cust6, merchant: merch6)
      invoice7 = create(:invoice, customer: cust6, merchant: merch7)
      invoice8 = create(:invoice, customer: cust6, merchant: merch8)
      invoice9 = create(:invoice, customer: cust6, merchant: merch1)
      invoice10 = create(:invoice, customer: cust6, merchant: merch1)
      invoice11 = create(:invoice, customer: cust6, merchant: merch1)
      InvoiceItem.create(item: item1, invoice: invoice1, unit_price: 1000, quantity: 10)
      InvoiceItem.create(item: item2, invoice: invoice2, unit_price: 1000, quantity: 40)
      InvoiceItem.create(item: item3, invoice: invoice3, unit_price: 1000, quantity: 50)
      InvoiceItem.create(item: item4, invoice: invoice4, unit_price: 1000, quantity: 55)
      InvoiceItem.create(item: item5, invoice: invoice5, unit_price: 1000, quantity: 60)
      InvoiceItem.create(item: item6, invoice: invoice6, unit_price: 1000, quantity: 65)
      InvoiceItem.create(item: item7, invoice: invoice7, unit_price: 1000, quantity: 70)
      InvoiceItem.create(item: item8, invoice: invoice8, unit_price: 1000, quantity: 75)
      InvoiceItem.create(item: item9, invoice: invoice9, unit_price: 1000, quantity: 80)
      InvoiceItem.create(item: item10, invoice: invoice10, unit_price: 1000, quantity: 85)
      InvoiceItem.create(item: item11, invoice: invoice11, unit_price: 1000, quantity: 90)
      create(:transaction, invoice: invoice1)
      create(:transaction, invoice: invoice2)
      create(:transaction, invoice: invoice3)
      create(:transaction, invoice: invoice4)
      create(:transaction, invoice: invoice5)
      create(:transaction, invoice: invoice6)
      create(:transaction, invoice: invoice7)
      create(:transaction, invoice: invoice8)
      create(:transaction, invoice: invoice9)
      create(:transaction, invoice: invoice10)
      create(:transaction, invoice: invoice11)

      expect(Item.revenue_ranked(5).length).to eq(5)
      expect(Item.revenue_ranked(5).first).to eq(item11)
      expect(Item.revenue_ranked(5).last).to eq(item7)
      expect(Item.revenue_ranked.length).to eq(10)
      expect(Item.revenue_ranked.first).to eq(item11)
      expect(Item.revenue_ranked.last).to eq(item2)
    end
  end
end
