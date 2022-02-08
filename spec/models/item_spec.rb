require 'rails_helper'

RSpec.describe Item, type: :model do
  describe 'associations' do
    it { should belong_to :merchant }
  end

  describe 'validations' do
    it { should validate_presence_of :name }
    it { should validate_presence_of :description }
    it { should validate_presence_of :unit_price }
    it { should validate_numericality_of(:unit_price).is_greater_than(0) }
  end

  describe 'factory' do
    it 'can create a factory with name, description, unit_price and merchant' do
      item = create(:item, name: 'Taco', description: 'Street style al pastor taco', unit_price: 1.75)

      expect(item).to be_valid
      expect(item).to be_a(Item)
      expect(item).to have_attributes(name: 'Taco')
      expect(item).to have_attributes(description: 'Street style al pastor taco')
      expect(item).to have_attributes(unit_price: 1.75)
      expect(item.merchant).to be_a(Merchant)
    end
  end
end
