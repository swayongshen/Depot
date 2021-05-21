class CreateGenresProductsJoinTable < ActiveRecord::Migration[6.1]
  def change
    create_join_table :products, :genres do |t|
      t.index :product_id
      t.index :genre_id
    end
  end
end
