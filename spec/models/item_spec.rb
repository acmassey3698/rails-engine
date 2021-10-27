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
  end
end
