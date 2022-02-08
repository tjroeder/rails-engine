class Api::V1::MerchantsController < ApplicationController
  def index
    @merchants = Merchant.all

    json_string = MerchantSerializer.new(@merchants)
    render json: json_string
  end
end
