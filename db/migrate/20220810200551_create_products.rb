class CreateProducts < ActiveRecord::Migration[7.0]
  def change
    create_table :products do |t|
      t.string :title
      t.string :sub_title
      t.text :description
      t.integer :rating
      t.integer :price
      t.references :user
      
      t.timestamps
    end
  end
end
