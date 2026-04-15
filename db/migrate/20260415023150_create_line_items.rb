class CreateLineItems < ActiveRecord::Migration[8.1]
  def change
    create_table :line_items do |t|
      t.references :invoice, null: false, foreign_key: true
      t.string :description, null: false
      t.integer :quantity, default: 1
      t.decimal :unit_price, precision: 10, scale: 2, null: false
      t.integer :position, default: 0

      t.timestamps
    end
  end
end
