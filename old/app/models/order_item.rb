class OrderItem < ApplicationRecord
  belongs_to :line_item
  belongs_to :order
end
