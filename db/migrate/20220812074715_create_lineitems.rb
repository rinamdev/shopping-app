class CreateLineitems < ActiveRecord::Migration[7.0]
  def change
    create_table :lineitems do |t|
      t.references :user
      t.references :product
      t.references :order
      t.integer :price
      t.integer :quantity
      t.datetime :canceled_at

      t.timestamps
    end
  end
end
