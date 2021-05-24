class RemoveIndexFromGenres < ActiveRecord::Migration[6.1]
  def change
    remove_index :genres, :name
  end
end
