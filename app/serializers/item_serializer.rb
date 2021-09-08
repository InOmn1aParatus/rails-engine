class ItemSerializer
  include FastJsonapi::ObjectSerializer
  attributes :name, :description, :unit_price, :merchant

  def merchant
    MerchantSerializer.new(object.merchant)
  end
end
