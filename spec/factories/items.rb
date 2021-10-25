FactoryBot.define do
  factory :item, class: Item do
    name { Faker::Commerce.product_name }
    description { Faker::TvShows::Simpsons.quote }
    unit_price  { Faker::Number.within(range: 50..1000) }
  end
end
