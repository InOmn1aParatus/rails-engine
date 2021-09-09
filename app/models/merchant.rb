class Merchant < ApplicationRecord
  has_many :items
  has_many :invoices
  has_many :transactions, through: :invoices
  has_many :invoice_items, through: :invoices
  has_many :customers, through: :invoices

  def self.top_revenue(qty)
    joins(invoices: %i[transactions invoice_items])
      .select('merchants.*, SUM(invoice_items.quantity * invoice_items.unit_price) AS revenue')
      .where(transactions: { result: 'success' }, invoices: { status: 'shipped' })
      .group(:id)
      .order(revenue: :desc)
      .limit(qty)
  end
end
