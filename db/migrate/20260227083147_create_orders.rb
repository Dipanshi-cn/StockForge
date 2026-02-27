class CreateOrders < ActiveRecord::Migration[8.1]
  def change
    create_table :orders do |t|
      t.references :user, null: false, foreign_key: true
      t.integer :status, default: 0, null: false
      t.text :delivery_address, null: false
      t.string :contact_number, null: false
      t.text :notes
      t.decimal :total_amount, precision: 12, scale: 2, default: 0.0, null: false
      t.date :expected_delivery_date
      t.datetime :approved_at

      t.timestamps
    end
    add_index :orders, :status
  end
end
