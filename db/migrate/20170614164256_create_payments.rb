class CreatePayments < ActiveRecord::Migration[5.0]
  def change
    create_table :payments do |t|
      t.decimal :amount
      t.text :description
      t.string :address
      t.integer :user_id

      t.timestamps
    end
    add_index :payments, :user_id
  end
end
