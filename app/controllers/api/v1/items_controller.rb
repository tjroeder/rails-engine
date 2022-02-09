class Api::V1::ItemsController < ApplicationController
  before_action :set_item, only: %i[show update destroy]

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
    @item = Item.new(item_params)
    if @item.save
      json_string = ItemSerializer.new(@item)
      json_response(json_string, :created)
    else
      json_response(@item, :unprocessable_entity)
    end
  end

  def update
    if @item.update!(item_params)
      json_string = ItemSerializer.new(@item)
      json_response(json_string)
    else
      json_response(@item, :not_found)
    end
  end

  def destroy
    @item.destroy
    head :no_content
  end

  private

  def item_params
    params.require(:item).permit(:name, :description, :unit_price, :merchant_id)
  end

  def set_item
    @item = Item.find(params[:id])
  end
end
