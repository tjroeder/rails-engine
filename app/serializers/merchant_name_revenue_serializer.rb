class MerchantNameRevenueSerializer
  include JSONAPI::Serializer
  attributes :name

  attributes :revenue do |obj|
    obj.total_revenue
  end
end
