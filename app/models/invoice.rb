class Invoice < ApplicationRecord
  belongs_to :merchant
  belongs_to :customer
  has_many :invoice_items
  has_many :items, through: :invoice_items, dependent: :destroy
  has_many :transactions

  validates :status, presence: true

  def self.revenue_across_range(start_date, end_date)
    joins(:invoice_items, :transactions)
    .where(transactions: { result: 'success' }, invoices: { status: 'shipped' }).where('invoices.created_at::date BETWEEN ? AND ?', start_date.to_date, end_date.to_date)
    .sum('invoice_items.quantity * invoice_items.unit_price')
  end
end

