class AddEnableFlgToMatchings < ActiveRecord::Migration
  def change
    add_column :matchings, :enable_flg, :integer
  end
end
