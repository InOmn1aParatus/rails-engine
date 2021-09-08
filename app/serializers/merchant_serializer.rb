class MerchantSerializer
  include FastJsonapi::ObjectSerializer
  attributes :name

  has_many :items

  attribute :item_count do |merchant|
    merchant.items.count
  end
end
