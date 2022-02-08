class Api::V1::ItemsController < ApplicationController
  def index
    @items = Item.all

    json_string = ItemSerializer.new(@items)
    render json: json_string
  end
end
