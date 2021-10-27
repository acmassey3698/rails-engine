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

  def self.items_sold(qty = 5)
    joins(items: {invoice_items: {invoice: :transactions}})
    .select("merchants.*, SUM(invoice_items.quantity) AS items_sold")
    .where('transactions.result = ?', 'success')
    .where('invoices.status = ?', 'shipped')
    .group(:id)
    .order(items_sold: :desc)
    .limit(qty)
  end

  def merchant_revenue
    Merchant.joins(items: {invoice_items: {invoice: :transactions}})
            .group(:id)
            .where(id: id)
            .where('transactions.result = ?', 'success')
            .where('invoices.status = ?', 'shipped')
            .select("merchants.*, SUM(invoice_items.unit_price * invoice_items.quantity) AS revenue")
            .first
  end
end
