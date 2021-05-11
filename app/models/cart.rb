class Cart < ApplicationRecord
  #Cart should not have 2 of the same line_items.
  has_many :cart_items
end
