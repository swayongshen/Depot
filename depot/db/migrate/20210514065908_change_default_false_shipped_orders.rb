class ChangeDefaultFalseShippedOrders < ActiveRecord::Migration[6.1]
  def change
    add_column :orders, :shipped, :boolean
    change_column_default :orders, :shipped, false
  end
end
