class RevenueSerializer
  include JSONAPI::Serializer
  set_type 'null'

  attributes :revenue do |start_date, end_date|
    Invoice.revenue_across_range(start_date, end_date)
  end
end
