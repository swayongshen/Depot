class RemoveShippedFromOrders < ActiveRecord::Migration[6.1]
  def change
    remove_column :orders, :shipped
  end
end
