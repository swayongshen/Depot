class AddShippedToLineItems < ActiveRecord::Migration[6.1]
  def change
    add_column :line_items, :shipped, :boolean, default: false
  end
end
