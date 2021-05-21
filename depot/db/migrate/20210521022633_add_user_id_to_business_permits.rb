class AddUserIdToBusinessPermits < ActiveRecord::Migration[6.1]
  def change
    add_column :business_permits, :user_id, :integer
  end
end
