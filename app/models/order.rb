class Order < ApplicationRecord
  belongs_to :user
  has_many :order_items, dependent: :destroy
  has_many :products, through: :order_items

  enum :status, { pending: 0, approved: 1, rejected: 2 }

  validates :delivery_address, :contact_number, presence: true
end
