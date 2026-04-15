class CreateClients < ActiveRecord::Migration[8.1]
  def change
    create_table :clients do |t|
      t.string :name, null: false
      t.string :country
      t.string :phone
      t.string :email
      t.text :notes
      t.string :company

      t.timestamps
    end

    add_index :clients, :name
    add_index :clients, :company
  end
end
