class FixInvoiceNumberUniqueIndexToScopeByUser < ActiveRecord::Migration[8.1]
  def change
    remove_index :invoices, :invoice_number
    add_index :invoices, [:invoice_number, :user_id], unique: true
  end
end
