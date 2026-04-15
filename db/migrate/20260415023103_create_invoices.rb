class CreateInvoices < ActiveRecord::Migration[8.1]
  def change
    create_table :invoices do |t|
      t.references :client, null: false, foreign_key: true
      t.string :invoice_number, null: false
      t.date :invoice_date, null: false
      t.string :status, default: "draft"

      # Event details
      t.string :event_type
      t.string :event_location
      t.date :event_date

      # Schedule / itinerary notes
      t.text :schedule_notes

      # Tax
      t.string :tax_label, default: "Aruba Health Tax/Fees"
      t.decimal :tax_amount, precision: 10, scale: 2, default: 0.0

      t.timestamps
    end

    add_index :invoices, :invoice_number, unique: true
    add_index :invoices, :status
  end
end
