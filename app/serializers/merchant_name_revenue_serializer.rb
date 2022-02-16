class MerchantNameRevenueSerializer
  include JSONAPI::Serializer
  attribute :name

  attribute :revenue do |obj|
    obj.total_revenue
  end
end
