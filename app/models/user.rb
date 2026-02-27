class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  enum :role, { customer: 0, dealer: 1, admin: 2 }

  has_one :cart, dependent: :destroy
  has_many :orders, dependent: :destroy

  after_create :create_cart_if_not_exists

  private

  def create_cart_if_not_exists
    create_cart unless cart
  end
end
