class CartItem < ApplicationRecord
  belongs_to :line_item
  belongs_to :cart
end
