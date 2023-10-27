class CreateOrderMenus < ActiveRecord::Migration[6.0]
  def change
    create_table :order_menus do |t|
      t.references :menu, null: false, foreign_key: true
      t.references :order, null: false, foreign_key: true
      t.integer :quantity
      t.float :subtotal
      t.float :total

      t.timestamps
    end
  end
end
