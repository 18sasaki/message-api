class CreateCustomers < ActiveRecord::Migration
  def change
    create_table :customers do |t|
      t.integer :user_id
      t.string :name
      t.string :mail_address
      t.string :memo

      t.timestamps
    end
  end
end
