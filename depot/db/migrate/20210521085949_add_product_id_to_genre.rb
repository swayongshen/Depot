class AddProductIdToGenre < ActiveRecord::Migration[6.1]
  def change
    add_column :genres, :product_id, :integer
  end
end
