class Api::V1::ItemsController < ApplicationController
  before_action :set_item, only: %i[show update]

  def index
    @items = Item.all
    json_string = ItemSerializer.new(@items)
    json_response(json_string)
  end
  
  def show
    json_string = ItemSerializer.new(@item)
    json_response(json_string)
  end
  
  def create
    @item = Item.create!(item_params)
    json_string = ItemSerializer.new(@item)
    json_response(json_string, :created)
  end

  def update
    @item.update!(item_params)
    head :no_content
  end

  private

  def item_params
    params.permit(:name, :description, :unit_price, :merchant_id)
  end

  def set_item
    @item = Item.find(params[:id])
  end
end
