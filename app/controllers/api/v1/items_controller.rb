class Api::V1::ItemsController < ApplicationController
  def index
    @items = Item.all
    json_string = ItemSerializer.new(@items)
    render json: json_string
  end

  def show
    @item = find_item
    json_string = ItemSerializer.new(@item)
    render json: json_string
  end

  private

  def find_item
    id = params.permit(:id)[:id]
    Item.find(id)
  end
end
