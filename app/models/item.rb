class Item < ApplicationRecord
  belongs_to :merchant

  validates :unit_price, numericality: true
  validates :merchant_id, numericality: true
  validates :name, presence: true
  validates :description, presence: true

end
