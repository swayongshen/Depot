class RemoveGenreIdFromProducts < ActiveRecord::Migration[6.1]
  def change
    remove_columns :products, :genre_id, :image_url
  end
end
