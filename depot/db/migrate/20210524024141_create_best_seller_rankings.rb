class CreateBestSellerRankings < ActiveRecord::Migration[6.1]
  def change
    create_table :best_seller_rankings do |t|
      t.string :category
      t.integer :rank
      t.belongs_to :product, null: false, foreign_key: true

      t.timestamps
    end
  end
end
