class MerchantSerializer
  include FastJsonapi::ObjectSerializer
  attributes :name, :items

  def items
    object.items.map do |item|
      ItemSerializer.new(item)
    end
  end
end
