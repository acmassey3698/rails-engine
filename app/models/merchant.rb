class Merchant < ApplicationRecord
  has_many :items
  validates :name, presence: true
  def self.search(name)
    Merchant.where("lower(name) LIKE ?", "%#{name.downcase}%")
            .order(:name)
            .first
  end
end
