class AddDescriptionToGenres < ActiveRecord::Migration[6.1]
  def change
    add_column :genres, :description, :string
  end
end
