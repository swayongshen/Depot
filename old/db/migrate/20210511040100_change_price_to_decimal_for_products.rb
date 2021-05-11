class ChangePriceToDecimalForProducts < ActiveRecord::Migration[6.1]
  change_table :products do |table|
    table.change :price, :decimal, :precision => 8, :scale => 2
  end
end
