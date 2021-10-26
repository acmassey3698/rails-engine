FactoryBot.define do
  factory :transaction, class: Transaction do
    credit_card_number { 123456789 }
    credit_card_expiration_date { '' }
  end
end
