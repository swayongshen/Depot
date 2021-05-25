class RemoveIndexFromBusinessPermits < ActiveRecord::Migration[6.1]
  def change
    remove_index :business_permits, :permit_number
  end
end
