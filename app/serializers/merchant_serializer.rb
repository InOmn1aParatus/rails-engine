class MerchantSerializer
  include FastJsonapi::ObjectSerializer
  attributes :name, :items

  def items
    object.items.map do |item|
      ::MerchantSerializer.new(item).attributes
    end
  end
end
