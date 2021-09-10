FactoryBot.define do
  factory :transaction do
    invoice
    credit_card_number { Faker::Finance.credit_card(:mastercard) }
    credit_card_expiration_date do
      "#{Faker::Number.number(digits: 2)}/#{Faker::Number.number(digits: 2)}"
    end
    result { 'success' }
  end
end
