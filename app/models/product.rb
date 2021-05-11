class Product < ApplicationRecord
  belongs_to :seller
  has_many :line_items
end
