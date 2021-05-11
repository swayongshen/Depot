class Cart < ApplicationRecord
  # Each cart can be associated to many line_items, and the line_items are
  # destroyed if the cart is destroyed
  has_many :line_items, dependent: :destroy
end
