class CreateProducts < ActiveRecord::Migration[8.1]
  def change
    create_table :products do |t|
      t.string :name, null: false
      t.string :sku, null: false
      t.references :category, null: false, foreign_key: true
      t.string :brand
      t.text :description
      t.string :unit
      t.decimal :cost_price, precision: 10, scale: 2, default: 0.0, null: false
      t.decimal :selling_price, precision: 10, scale: 2, default: 0.0, null: false
      t.integer :stock_quantity, default: 0, null: false
      t.integer :min_stock_alert, default: 0, null: false
      t.string :branch

      t.timestamps
    end
    add_index :products, :sku, unique: true
    add_check_constraint :products, "stock_quantity >= 0", name: "stock_quantity_non_negative"
  end
end
