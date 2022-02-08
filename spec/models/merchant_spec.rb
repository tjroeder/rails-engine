require 'rails_helper'

RSpec.describe Merchant, type: :model do
  describe 'associations' do
    it { should have_many :items }
  end

  describe 'validations' do
    it { should validate_presence_of :name }
  end

  describe 'factory' do
    it 'can create a factory with name' do
      merchant = create(:merchant, name: 'Wacky Wally World')

      expect(merchant).to be_valid
      expect(merchant).to be_a(Merchant)
      expect(merchant).to have_attributes(name: 'Wacky Wally World')
    end
  end
end
