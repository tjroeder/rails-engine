class Api::V1::RevenueController < ApplicationController
  before_action :params_valid, only: [:index]
  before_action :end_date_lt_start_date, only: [:index]
  require "active_support"

  def index
    if params[:start].present? && params[:end].present?
      start_date = params[:start]
      end_date = params[:end]
      require 'pry'; binding.pry
      json_string = RevenueSerializer.new(start_date, end_date)
      json_response(json_string)
    else
      json_response({ error: 'start and end date are needed' }, :bad_request)
    end
  end

  private

  def params_valid
    json_response({ error: 'start date can not be greater than end date' }, :bad_request) unless params[:start].present? && params[:end].present?
  end

  def end_date_lt_start_date
    json_response({ error: 'start date can not be greater than end date' }, :bad_request) if params[:start].to_date > params[:end].to_date
  end
end
