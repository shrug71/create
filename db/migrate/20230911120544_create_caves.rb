class CreateCaves < ActiveRecord::Migration[6.0]
  def change
    create_table :caves do |t|
      t.string :name
      t.string :city
      t.string :address
      t.integer :phone
      t.integer :pin_code
      t.string :email
      t.string :password_digest

      t.timestamps
    end
  end
end
