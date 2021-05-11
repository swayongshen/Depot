class AddLineItemIdToCartItems < ActiveRecord::Migration[6.1]
  def change
    add_column :cart_items, :line_item_id, :integer
  end
end
