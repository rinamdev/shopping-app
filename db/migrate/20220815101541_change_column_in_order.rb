class ChangeColumnInOrder < ActiveRecord::Migration[7.0]
  def change
    change_column :orders, :total_price, :integer, :default => 0
    change_column :orders, :total_quantity, :integer, :default => 0
  end
end
