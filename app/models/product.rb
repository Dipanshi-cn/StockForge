class Product < ApplicationRecord
  belongs_to :category
  has_many :cart_items, dependent: :destroy
  has_many :order_items, dependent: :destroy

  validates :name, :sku, presence: true
  validates :sku, uniqueness: true
  validates :stock_quantity, numericality: { greater_than_or_equal_to: 0 }
  validates :cost_price, :selling_price, numericality: { greater_than_or_equal_to: 0 }

  def low_stock?
    stock_quantity <= min_stock_alert
  end

  def available_stock
    stock_quantity
  end
end
