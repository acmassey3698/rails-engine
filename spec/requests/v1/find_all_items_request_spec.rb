require 'rails_helper'

RSpec.describe 'find all items request' do
  describe 'find by name' do
    it 'finds all items by name' do
      merch1 = create(:merchant)
      create_list(:item, 30, merchant: merch1)
      item1 = create(:item, merchant: merch1, name: "Basket")
      item2 = create(:item, merchant: merch1, name: "Straw Basket")
      item3 = create(:item, merchant: merch1, name: "Awesome Basket")
      item4 = create(:item, merchant: merch1, name: "Soccer Ball")

      get '/api/v1/items/find_all?name=basket'

      expect(response).to be_successful

      response_body = JSON.parse(response.body, symbolize_names: true)
      items = response_body[:data]

      expect(items[0][:id].to_i).to eq(item3.id)
      expect(items[1][:id].to_i).to eq(item1.id)
      expect(items[2][:id].to_i).to eq(item2.id)
      expect(items[0][:attributes][:name]).to eq(item3.name)
      expect(items[1][:attributes][:name]).to eq(item1.name)
      expect(items[2][:attributes][:name]).to eq(item2.name)
      expect(items.include?(item4)).to be(false)
    end

    it 'Is case insensitive when searching by name' do
      merch1 = create(:merchant)
      create_list(:item, 30, merchant: merch1)
      item1 = create(:item, merchant: merch1, name: "Basket")
      item2 = create(:item, merchant: merch1, name: "Straw Basket")
      item3 = create(:item, merchant: merch1, name: "Awesome Basket")
      item4 = create(:item, merchant: merch1, name: "Soccer Ball")

      get '/api/v1/items/find_all?name=bAsKet'

      expect(response).to be_successful

      response_body = JSON.parse(response.body, symbolize_names: true)
      items = response_body[:data]

      expect(items[0][:id].to_i).to eq(item3.id)
      expect(items[1][:id].to_i).to eq(item1.id)
      expect(items[2][:id].to_i).to eq(item2.id)
      expect(items[0][:attributes][:name]).to eq(item3.name)
      expect(items[1][:attributes][:name]).to eq(item1.name)
      expect(items[2][:attributes][:name]).to eq(item2.name)
      expect(items.include?(item4)).to be(false)
    end

    it 'returns an empty collection when no items match the search param' do
      merch1 = create(:merchant)
      create_list(:item, 30, merchant: merch1)

      get '/api/v1/items/find_all?name=fdagegadsvewe'

      expect(response).to be_successful

      response_body = JSON.parse(response.body, symbolize_names: true)
      items = response_body[:data]

      expect(items.blank?).to be(true)
    end

    it 'returns an error when the search param is blank' do
      merch1 = create(:merchant)
      create_list(:item, 30, merchant: merch1)

      get '/api/v1/items/find_all?name= '

      expect(response).to_not be_successful
      expect(response.status).to eq(400)

      response_body = JSON.parse(response.body, symbolize_names: true)

      expect(response_body[:message]).to eq("Record not found")
      expect(response_body[:error]).to eq("Query missing required information")
    end
  end

  describe 'find by min_price' do
    it 'finds items that meet a minimum price threshold' do
      merch1 = create(:merchant)

      item1 = create(:item, merchant: merch1, unit_price: 4.00)
      item2 = create(:item, merchant: merch1, unit_price: 5.50)
      item3 = create(:item, merchant: merch1, unit_price: 6.50)
      item4 = create(:item, merchant: merch1, unit_price: 7.50)
      item5 = create(:item, merchant: merch1, unit_price: 8.50)
      item6 = create(:item, merchant: merch1, unit_price: 9.50)

      get '/api/v1/items/find_all?min_price=4.50'

      expect(response).to be_successful

      response_body = JSON.parse(response.body, symbolize_names: true)
      items = response_body[:data]

      expect(items[0][:id].to_i).to eq(item2.id)
      expect(items[1][:id].to_i).to eq(item3.id)
      expect(items[2][:id].to_i).to eq(item4.id)
      expect(items[3][:id].to_i).to eq(item5.id)
      expect(items[4][:id].to_i).to eq(item6.id)
    end

    it 'returns an empty collection when no items meet the minimum threshold' do
      merch1 = create(:merchant)

      item1 = create(:item, merchant: merch1, unit_price: 4.00)
      item2 = create(:item, merchant: merch1, unit_price: 5.50)
      item3 = create(:item, merchant: merch1, unit_price: 6.50)
      item4 = create(:item, merchant: merch1, unit_price: 7.50)
      item5 = create(:item, merchant: merch1, unit_price: 8.50)
      item6 = create(:item, merchant: merch1, unit_price: 9.50)

      get '/api/v1/items/find_all?min_price=55.00'

      expect(response).to be_successful

      response_body = JSON.parse(response.body, symbolize_names: true)
      items = response_body[:data]

      expect(items.empty?).to be(true)
    end

    it 'sends an error when no value is given for min_price' do
      merch1 = create(:merchant)

      item1 = create(:item, merchant: merch1, unit_price: 4.00)
      item2 = create(:item, merchant: merch1, unit_price: 5.50)
      item3 = create(:item, merchant: merch1, unit_price: 6.50)
      item4 = create(:item, merchant: merch1, unit_price: 7.50)
      item5 = create(:item, merchant: merch1, unit_price: 8.50)
      item6 = create(:item, merchant: merch1, unit_price: 9.50)

      get '/api/v1/items/find_all?min_price= '

      expect(response).to_not be_successful
      expect(response.status).to eq(400)

      response_body = JSON.parse(response.body, symbolize_names: true)

      expect(response_body[:message]).to eq("Record not found")
      expect(response_body[:error]).to eq("Query missing required information")
    end
  end

  describe 'find by max_price' do
    it 'finds items that dont break a max price threshold' do
      merch1 = create(:merchant)

      item1 = create(:item, merchant: merch1, unit_price: 4.00)
      item2 = create(:item, merchant: merch1, unit_price: 4.25)
      item3 = create(:item, merchant: merch1, unit_price: 6.50)
      item4 = create(:item, merchant: merch1, unit_price: 7.50)
      item5 = create(:item, merchant: merch1, unit_price: 8.50)
      item6 = create(:item, merchant: merch1, unit_price: 9.50)

      get '/api/v1/items/find_all?max_price=4.50'

      expect(response).to be_successful

      response_body = JSON.parse(response.body, symbolize_names: true)
      items = response_body[:data]

      expect(items[0][:id].to_i).to eq(item1.id)
      expect(items[1][:id].to_i).to eq(item2.id)
    end

    it 'returns an empty collection when all items are above the max price' do
      merch1 = create(:merchant)

      item1 = create(:item, merchant: merch1, unit_price: 4.00)
      item2 = create(:item, merchant: merch1, unit_price: 5.50)
      item3 = create(:item, merchant: merch1, unit_price: 6.50)
      item4 = create(:item, merchant: merch1, unit_price: 7.50)
      item5 = create(:item, merchant: merch1, unit_price: 8.50)
      item6 = create(:item, merchant: merch1, unit_price: 9.50)

      get '/api/v1/items/find_all?max_price=1.00'

      expect(response).to be_successful

      response_body = JSON.parse(response.body, symbolize_names: true)
      items = response_body[:data]

      expect(items.empty?).to be(true)
    end

    it 'sends an error when no value is given for max_price' do
      merch1 = create(:merchant)

      item1 = create(:item, merchant: merch1, unit_price: 4.00)
      item2 = create(:item, merchant: merch1, unit_price: 5.50)
      item3 = create(:item, merchant: merch1, unit_price: 6.50)
      item4 = create(:item, merchant: merch1, unit_price: 7.50)
      item5 = create(:item, merchant: merch1, unit_price: 8.50)
      item6 = create(:item, merchant: merch1, unit_price: 9.50)

      get '/api/v1/items/find_all?max_price= '

      expect(response).to_not be_successful
      expect(response.status).to eq(400)

      response_body = JSON.parse(response.body, symbolize_names: true)

      expect(response_body[:message]).to eq("Record not found")
      expect(response_body[:error]).to eq("Query missing required information")
    end
  end

  describe 'max and min price given in the search' do
    it 'finds items within the two thresholds' do
      merch1 = create(:merchant)

      item1 = create(:item, merchant: merch1, unit_price: 4.00)
      item2 = create(:item, merchant: merch1, unit_price: 4.25)
      item3 = create(:item, merchant: merch1, unit_price: 6.50)
      item4 = create(:item, merchant: merch1, unit_price: 7.50)
      item5 = create(:item, merchant: merch1, unit_price: 8.50)
      item6 = create(:item, merchant: merch1, unit_price: 9.50)

      get '/api/v1/items/find_all?min_price=4.15&max_price=7.00'

      expect(response).to be_successful

      response_body = JSON.parse(response.body, symbolize_names: true)
      items = response_body[:data]

      expect(items[0][:id].to_i).to eq(item2.id)
      expect(items[1][:id].to_i).to eq(item3.id)
    end

    it 'returns an empty collection when all items are outside of the price range' do
      merch1 = create(:merchant)

      item1 = create(:item, merchant: merch1, unit_price: 4.00)
      item2 = create(:item, merchant: merch1, unit_price: 5.50)
      item3 = create(:item, merchant: merch1, unit_price: 6.50)
      item4 = create(:item, merchant: merch1, unit_price: 7.50)
      item5 = create(:item, merchant: merch1, unit_price: 8.50)
      item6 = create(:item, merchant: merch1, unit_price: 9.50)

      get '/api/v1/items/find_all?min_price=0.50&max_price=1.00'

      expect(response).to be_successful

      response_body = JSON.parse(response.body, symbolize_names: true)
      items = response_body[:data]

      expect(items.empty?).to be(true)
    end

    it 'sends an error when no value is given for max_price' do
      merch1 = create(:merchant)

      item1 = create(:item, merchant: merch1, unit_price: 4.00)
      item2 = create(:item, merchant: merch1, unit_price: 5.50)
      item3 = create(:item, merchant: merch1, unit_price: 6.50)
      item4 = create(:item, merchant: merch1, unit_price: 7.50)
      item5 = create(:item, merchant: merch1, unit_price: 8.50)
      item6 = create(:item, merchant: merch1, unit_price: 9.50)

      get '/api/v1/items/find_all?min_price=0.50&max_price= '

      expect(response).to_not be_successful
      expect(response.status).to eq(400)

      response_body = JSON.parse(response.body, symbolize_names: true)

      expect(response_body[:message]).to eq("Record not found")
      expect(response_body[:error]).to eq("Query missing required information")
    end

    it 'sends an error when no value is given for min_price' do
      merch1 = create(:merchant)

      item1 = create(:item, merchant: merch1, unit_price: 4.00)
      item2 = create(:item, merchant: merch1, unit_price: 5.50)
      item3 = create(:item, merchant: merch1, unit_price: 6.50)
      item4 = create(:item, merchant: merch1, unit_price: 7.50)
      item5 = create(:item, merchant: merch1, unit_price: 8.50)
      item6 = create(:item, merchant: merch1, unit_price: 9.50)

      get '/api/v1/items/find_all?min_price= &max_price=100.00'

      expect(response).to_not be_successful
      expect(response.status).to eq(400)

      response_body = JSON.parse(response.body, symbolize_names: true)

      expect(response_body[:message]).to eq("Record not found")
      expect(response_body[:error]).to eq("Query missing required information")
    end

    it 'sends an error when no value is given for either min or max_price' do
      merch1 = create(:merchant)

      item1 = create(:item, merchant: merch1, unit_price: 4.00)
      item2 = create(:item, merchant: merch1, unit_price: 5.50)
      item3 = create(:item, merchant: merch1, unit_price: 6.50)
      item4 = create(:item, merchant: merch1, unit_price: 7.50)
      item5 = create(:item, merchant: merch1, unit_price: 8.50)
      item6 = create(:item, merchant: merch1, unit_price: 9.50)

      get '/api/v1/items/find_all?min_price= &max_price= '

      expect(response).to_not be_successful
      expect(response.status).to eq(400)

      response_body = JSON.parse(response.body, symbolize_names: true)

      expect(response_body[:message]).to eq("Record not found")
      expect(response_body[:error]).to eq("Query missing required information")
    end
  end

  describe 'Name cannot be sent along with any combination of max/min values' do
    it 'doesnt allow for a name with a min value' do
      merch1 = create(:merchant)

      item1 = create(:item, merchant: merch1, unit_price: 4.00)
      item2 = create(:item, merchant: merch1, unit_price: 5.50)
      item3 = create(:item, merchant: merch1, unit_price: 6.50)
      item4 = create(:item, merchant: merch1, unit_price: 7.50)
      item5 = create(:item, merchant: merch1, unit_price: 8.50)
      item6 = create(:item, merchant: merch1, unit_price: 9.50)

      get '/api/v1/items/find_all?name=a&min_price=1.50'

      expect(response).to_not be_successful
      expect(response.status).to eq(400)

      response_body = JSON.parse(response.body, symbolize_names: true)

      expect(response_body[:message]).to eq("Record not found")
      expect(response_body[:error]).to eq("Query missing required information")
    end

    it 'doesnt allow for a name with a max value' do
      merch1 = create(:merchant)

      item1 = create(:item, merchant: merch1, unit_price: 4.00)
      item2 = create(:item, merchant: merch1, unit_price: 5.50)
      item3 = create(:item, merchant: merch1, unit_price: 6.50)
      item4 = create(:item, merchant: merch1, unit_price: 7.50)
      item5 = create(:item, merchant: merch1, unit_price: 8.50)
      item6 = create(:item, merchant: merch1, unit_price: 9.50)

      get '/api/v1/items/find_all?name=a&max_price=1.50'

      expect(response).to_not be_successful
      expect(response.status).to eq(400)

      response_body = JSON.parse(response.body, symbolize_names: true)

      expect(response_body[:message]).to eq("Record not found")
      expect(response_body[:error]).to eq("Query missing required information")
    end

    it 'doesnt allow for a name with a max and min value' do
      merch1 = create(:merchant)

      item1 = create(:item, merchant: merch1, unit_price: 4.00)
      item2 = create(:item, merchant: merch1, unit_price: 5.50)
      item3 = create(:item, merchant: merch1, unit_price: 6.50)
      item4 = create(:item, merchant: merch1, unit_price: 7.50)
      item5 = create(:item, merchant: merch1, unit_price: 8.50)
      item6 = create(:item, merchant: merch1, unit_price: 9.50)

      get '/api/v1/items/find_all?name=a&min_price=0.50&max_price=1.50'

      expect(response).to_not be_successful
      expect(response.status).to eq(400)

      response_body = JSON.parse(response.body, symbolize_names: true)

      expect(response_body[:message]).to eq("Record not found")
      expect(response_body[:error]).to eq("Query missing required information")
    end
  end
end
