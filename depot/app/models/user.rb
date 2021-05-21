class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :products, dependent: :delete_all
  has_many :line_items, through: :products
  has_many :orders, through: :line_items
  has_one :business_permit

  def self.get_all_orders_by_user(user_id)
    Order.includes(line_items: [product: [:user]])
         .where(line_items: { products: { users: user_id} }).order("order_id ASC")
  end

end
