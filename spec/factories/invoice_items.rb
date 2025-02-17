FactoryBot.define do
  factory :invoice_item do
    quantity { Faker::Number.between(from: 1, to: 100) }
    unit_price { Faker::Number.between(from: 100, to: 10000) }
    status { Faker::Number.between(from: 0, to: 2) }
  end
end