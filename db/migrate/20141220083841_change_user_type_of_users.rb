class ChangeUserTypeOfUsers < ActiveRecord::Migration
  def change
    change_column :users, :user_type, :integer
  end
end
