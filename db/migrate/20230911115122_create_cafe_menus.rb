class CreateCafeMenus < ActiveRecord::Migration[6.0]
  def change
    create_table :cafe_menus do |t|
      t.references :cafe, null: false, foreign_key: true
      t.references :menu, null: false, foreign_key: true

      t.timestamps
    end
  end
end
