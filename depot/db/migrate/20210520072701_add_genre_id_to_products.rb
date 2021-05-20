class AddGenreIdToProducts < ActiveRecord::Migration[6.1]
  def change
    add_column :products, :genre_id, :integer
  end
end
