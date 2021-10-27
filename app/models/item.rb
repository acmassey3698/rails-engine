class Item < ApplicationRecord
  belongs_to :merchant
  has_many :invoice_items, dependent: :destroy
  has_many :invoices, through: :invoice_items
  #
  #
  # belongs_to :merchant
  # has_many :invoice_items, dependent: :destroy
  # has_many :invoices, through: :invoice_items

  validates :unit_price, numericality: true
  validates :merchant_id, numericality: true
  validates :name, presence: true
  validates :description, presence: true

  def self.search_by_name(name)
    Item.where("lower(name) LIKE ?", "%#{name.downcase}%")
        .order(:name)
  end

  def self.search_by_min(min_price)
    Item.where('unit_price >= ?', min_price)
        .order(:unit_price)
  end

  def self.search_by_max(max_price)
    Item.where('unit_price <= ?', max_price)
        .order(:unit_price)
  end

  def self.search_within_range(min_price, max_price)
    Item.where("unit_price >= ? and unit_price <= ?", min_price, max_price)
  end

end
