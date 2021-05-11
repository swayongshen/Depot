class Cart < ApplicationRecord
  # Each cart can be associated to many line_items, and the line_items are
  # destroyed if the cart is destroyed
  has_many :line_items, dependent: :destroy

  # Checks if the Product is already a LineItem, if it is, increment quantity associated
  # with the LineItem, else create a new LineItem with quantity 1.
  def add_product(product)
    current_item = line_items.find_by(product_id: product.id)
    if current_item
      current_item.quantity += 1
    else
      current_item = line_items.build(product_id: product.id)
    end
    current_item
  end
end
