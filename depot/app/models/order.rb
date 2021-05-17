class Order < ApplicationRecord
  has_many :line_items, dependent: :destroy
  has_many :products, through: :line_items
  has_many :users, through: :products

  enum pay_type: {
    "Check" => 0,
    "Credit card" => 1,
    "Purchase order" => 2
  }

  validates :name, :address, :email, presence: true
  validates :pay_type, inclusion: pay_types.keys

  def add_line_items_from_cart(cart)
    cart.line_items.each do |item|
      item.cart_id = nil
      line_items << item
    end
  end

  def total_price
    sum = 0
    line_items.each { |item| sum += item.total_price}
    sum
  end

  def ordered_line_items_of_user(user_id)
    line_items.includes(product: [:user])
              .where(products: { users: user_id })
  end

  def is_user_products_shipped?(user_id)
    ordered_line_items_of_user(user_id).all? {|item| item.shipped?}
  end

  def mark_user_products_shipped(user_id)
    ordered_line_items_of_user(user_id).each do |item|
      item.shipped = true
      unless item.save
        return false
      end
    end
    true
  end

end
