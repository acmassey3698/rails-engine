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
  end
end
