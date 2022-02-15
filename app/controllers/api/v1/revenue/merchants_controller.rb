class Api::V1::Revenue::MerchantsController < ApplicationController
  def index
    if params[:quantity]
      number = params[:quantity]
      @merchants = Merchant.top_merchants_by_revenue(number)

      json_string = MerchantNameRevenueSerializer.new(@merchants)
      json_response(json_string)
    else
      json_response({ error: 'Quantity is needed' }, :bad_request)
    end
  end
end
