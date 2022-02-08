require 'rails_helper'

RSpec.describe 'Merchants API', type: :request do
  describe '#index action' do
    it 'returns a successful status' do
      create_list(:merchant, 3)

      get api_v1_merchants_path

      expect(response).to have_http_status(200)
    end

    it 'returns a list of all merchants' do
      create_list(:merchant, 3)

      get api_v1_merchants_path

      merchants = JSON.parse(response.body, symbolize_names: true)

      expect(merchants).to be_a(Hash)
      expect(merchants[:data]).to be_a(Array)
      expect(merchants[:data].count).to eq(3)

      merchants[:data].each do |merchant|
        expect(merchant).to be_a(Hash)
        expect(merchant).to have_key(:id)
        expect(merchant[:id]).to be_an(String)

        expect(merchant).to have_key(:type)
        expect(merchant[:type]).to be_a(String)

        expect(merchant[:attributes]).to have_key(:name)
        expect(merchant[:attributes][:name]).to be_a(String)
      end
    end

    it 'returns an array of data even if no merchants' do
      get api_v1_merchants_path

      merchants = JSON.parse(response.body, symbolize_names: true)

      expect(merchants).to be_a(Hash)
      expect(merchants[:data]).to be_a(Array)
      expect(merchants[:data].empty?).to eq(true)
    end

    it 'returns an array of data if one merchant' do
      create(:merchant)
      get api_v1_merchants_path

      merchants = JSON.parse(response.body, symbolize_names: true)

      expect(merchants).to be_a(Hash)
      expect(merchants[:data]).to be_a(Array)
      expect(merchants[:data].count).to eq(1)
      expect(merchants[:data].empty?).to eq(false)
    end

    it 'does not include dependent data' do
      create_list(:merchant, 3)

      get api_v1_merchants_path

      merchants = JSON.parse(response.body, symbolize_names: true)

      merchants[:data].each do |merchant|
        expect(merchant).to_not have_key(:relationships)
      end
    end
  end
end
