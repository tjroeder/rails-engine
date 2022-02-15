class ItemsSoldSerializer
  include JSONAPI::Serializer
  attributes :name

  attributes :count do |obj|
    obj.total_sold
  end
end
