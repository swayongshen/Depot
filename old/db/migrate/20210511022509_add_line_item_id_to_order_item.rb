class AddLineItemIdToOrderItem < ActiveRecord::Migration[6.1]
  def change
    add_column :order_items, :line_item_id, :integer
  end
end
