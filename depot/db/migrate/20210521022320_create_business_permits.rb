class CreateBusinessPermits < ActiveRecord::Migration[6.1]
  def change
    create_table :business_permits do |t|
      t.integer :permit_number,
      t.timestamps
    end
    add_index :business_permits, :permit_number, unique: true
  end
end
