class CartItem < ApplicationRecord
  belongs_to :cart
  belongs_to :product

  validates :quantity, numericality: { greater_than: 0 }
  validate :quantity_within_stock

  def subtotal
    product.selling_price * quantity
  end

  private

  def quantity_within_stock
    if quantity > product.stock_quantity
      errors.add(:quantity, "cannot be greater than available stock (#{product.stock_quantity})")
    end
  end
end
