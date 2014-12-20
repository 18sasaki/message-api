class CreateStores < ActiveRecord::Migration
  def change
    create_table :stores do |t|
      t.integer :user_id
      t.string :name
      t.string :address
      t.string :geo_data
      t.string :mail_address
      t.string :memo

      t.timestamps
    end
  end
end
