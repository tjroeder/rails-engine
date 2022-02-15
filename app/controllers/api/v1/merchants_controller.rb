class Api::V1::MerchantsController < ApplicationController
  before_action :set_merchant, only: %i[show]

  def index
    @merchants = Merchant.all

    json_string = MerchantSerializer.new(@merchants)
    json_response(json_string)
  end

  def show
    json_string = MerchantSerializer.new(@merchant)
    json_response(json_string)
  end

  def most_items
    number = params[:quantity]
    if number.present?
      @merchants = Merchant.most_items_sold(number)
      json_string = ItemsSoldSerializer.new(@merchants)
      json_response(json_string)
    else
      json_response({ error: 'Quantity is needed' }, :bad_request)
    end
  end

  private

  def set_merchant
    @merchant = Merchant.find(params[:id])
  end
end
