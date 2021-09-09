FactoryBot.define do
  factory :transaction do
    invoice
    credit_card_number { Faker::Finance.credit_card(:mastercard) }
    credit_card_expiration_date {
      "#{Faker::Number.number(digits: 2)}/#{Faker::Number.number(digits: 2)}" 
    }
    result { 'success' }
  end
end
