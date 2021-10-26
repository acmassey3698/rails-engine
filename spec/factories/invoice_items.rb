FactoryBot.define do
  factory :invoice_item, class: InvoiceItem do
    status { 'shipped' }
  end
end
