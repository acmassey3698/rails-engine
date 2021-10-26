FactoryBot.define do
  factory :invoice, class: Invoice do
    status { 'completed' }
  end
end
