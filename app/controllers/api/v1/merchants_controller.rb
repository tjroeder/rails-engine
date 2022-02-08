class Api::V1::MerchantsController < ApplicationController
  def index
    @merchants = Merchant.all

    json_string = MerchantSerializer.new(@merchants)
    render json: json_string
  end

  def show
    @merchant = find_merchant
    json_string = MerchantSerializer.new(@merchant)
    render json: json_string
  end

  private

  def find_merchant
    id = params.permit(:id)[:id]
    Merchant.find(id)
  end
end
