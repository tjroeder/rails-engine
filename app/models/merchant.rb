class Merchant < ApplicationRecord
  has_many :items
  has_many :invoices
  has_many :invoice_items, through: :items
  has_many :transactions, through: :invoices
  has_many :customers, through: :invoices

  validates :name, presence: true

  def self.find_one_by_name(sel_name)
    where('merchants.name ILIKE ?', "%#{sel_name}%").order(:name).first
  end

  def self.top_merchants_by_revenue(number)
    joins(invoices: [:invoice_items, :transactions])
      .where(transactions: { result: 'success' }, invoices: { status: 'shipped' })
      .select('SUM(invoice_items.unit_price * invoice_items.quantity) AS total_revenue, merchants.id, merchants.name')
      .group(:id)
      .order(total_revenue: :desc)
      .limit(number)
  end

  def self.most_items_sold(number)
    joins(invoices: [:invoice_items, :transactions])
      .where(transactions: { result: 'success' }, invoices: { status: 'shipped' })
      .select('SUM(invoice_items.quantity) AS total_sold, merchants.id, merchants.name')
      .group(:id)
      .order(total_sold: :desc)
      .limit(number)
  end
end
