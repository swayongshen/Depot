class LineItem < ApplicationRecord
  has_many :order_items
  belongs_to :product
  has_many :cart_items
end
