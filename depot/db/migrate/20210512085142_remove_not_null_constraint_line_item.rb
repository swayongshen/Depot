class RemoveNotNullConstraintLineItem < ActiveRecord::Migration[6.1]
  def up
    change_column_null :line_items, :cart_id, true
  end

  def down
    change_column_null :line_items, :cart_id, false
  end

end
