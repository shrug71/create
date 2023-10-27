class CreateMenus < ActiveRecord::Migration[6.0]
  def change
    create_table :menus do |t|
      t.string :name
      t.float :price
      t.integer :quantity

      t.timestamps
    end
  end
end
