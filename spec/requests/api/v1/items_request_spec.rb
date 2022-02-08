require 'rails_helper'

RSpec.describe 'Items API', type: :request do
  describe '#index action' do
    it 'returns a successful status' do
      create_list(:item, 3)

      get api_v1_items_path

      expect(response).to have_http_status(200)
    end

    it 'returns a list of all items' do
      create_list(:item, 3)

      get api_v1_items_path

      items = JSON.parse(response.body, symbolize_names: true)

      expect(items).to be_a(Hash)
      expect(items[:data]).to be_a(Array)
      expect(items[:data].count).to eq(3)

      items[:data].each do |item|
        expect(item).to be_a(Hash)
        expect(item).to have_key(:id)
        expect(item[:id]).to be_an(String)

        expect(item).to have_key(:type)
        expect(item[:type]).to be_a(String)

        expect(item[:attributes]).to have_key(:name)
        expect(item[:attributes][:name]).to be_a(String)
        
        expect(item[:attributes]).to have_key(:description)
        expect(item[:attributes][:description]).to be_a(String)

        expect(item[:attributes]).to have_key(:unit_price)
        expect(item[:attributes][:unit_price]).to be_a(Float)

        expect(item[:attributes]).to have_key(:merchant_id)
        expect(item[:attributes][:merchant_id]).to be_a(Integer)
      end
    end

    it 'returns an array of data even if no items' do
      get api_v1_items_path

      items = JSON.parse(response.body, symbolize_names: true)

      expect(items).to be_a(Hash)
      expect(items[:data]).to be_a(Array)
      expect(items[:data].empty?).to eq(true)
    end

    it 'returns an array of data if one item' do
      create(:item)
      get api_v1_items_path

      items = JSON.parse(response.body, symbolize_names: true)

      expect(items).to be_a(Hash)
      expect(items[:data]).to be_a(Array)
      expect(items[:data].count).to eq(1)
      expect(items[:data].empty?).to eq(false)
    end

    it 'does not include dependent data' do
      create_list(:item, 3)

      get api_v1_items_path

      items = JSON.parse(response.body, symbolize_names: true)

      items[:data].each do |item|
        expect(item).to_not have_key(:relationships)
      end
    end
  end
end
