class ChangeUserIdOfUsers < ActiveRecord::Migration
  def change
    change_column :users, :user_id, :string
  end
end
