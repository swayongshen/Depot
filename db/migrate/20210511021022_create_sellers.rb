class CreateSellers < ActiveRecord::Migration[6.1]
  def change
    create_table :sellers do |t|
      t.string :username
      t.string :password

      t.timestamps
    end

    add_index(:sellers, [:username], :unique => true)
  end
end
