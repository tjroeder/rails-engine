class Api::V1::ItemsController < ApplicationController
  def index
    @items = Item.all
    json_string = ItemSerializer.new(@items)
    json_response(json_string)
  end
  
  def show
    @item = set_item
    json_string = ItemSerializer.new(@item)
    json_response(json_string)
  end
  
  def create
    @item = Item.create!(item_params)
    json_string = ItemSerializer.new(@item)
    json_response(json_string, :created)
  end

  private

  def item_params
    params.permit(:name, :description, :unit_price, :merchant_id)
  end

  def set_item
    Item.find(params[:id])
  end
end
