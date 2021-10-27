class Merchant < ApplicationRecord
  has_many :items, dependent: :destroy
  # has_many :invoice_items, through: :items
  # has_many :invoices, dependent: :destroy
  # has_many :transactions, through: :invoices
  # has_many :customers, through: :invoices

  validates :name, presence: true

  def self.search(name)
    Merchant.where("lower(name) LIKE ?", "%#{name.downcase}%")
            .order(:name)
            .first
  end

  def self.top_merchants(qty)
    joins(items: {invoice_items: {invoice: :transactions}})
    .select("merchants.*, SUM(invoice_items.unit_price * invoice_items.quantity) AS revenue")
    .where('transactions.result = ?', 'success')
    .where('invoices.status = ?', 'shipped')
    .group(:id)
    .order(revenue: :desc)
    .limit(qty)
  end
end
