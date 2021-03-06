class CreateOrderItems < ActiveRecord::Migration[5.0]
  def change
    create_table :order_items do |t|
      t.decimal :unit_price, precision: 12, scale: 3
      t.integer :quantity
      t.decimal :total_price, precision: 12, scale: 3
      t.integer :product_id
      t.integer :order_id

      t.timestamps
    end
    add_index :order_items, :product_id
    add_index :order_items, :order_id
  end
end
