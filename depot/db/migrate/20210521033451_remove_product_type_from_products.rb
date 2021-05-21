class RemoveProductTypeFromProducts < ActiveRecord::Migration[6.1]
  def change
    remove_column :products, :product_type
  end
end
