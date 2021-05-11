class CreateOrders < ActiveRecord::Migration[6.1]
  def change
    create_table :orders do |t|
      t.string :buyer_name
      t.string :buyer_email
      t.string :address

      t.timestamps
    end
  end
end
