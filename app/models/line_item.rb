class LineItem < ApplicationRecord
  belongs_to :invoice, inverse_of: :line_items

  validates :description, presence: true
  validates :quantity, numericality: { greater_than: 0 }
  validates :unit_price, numericality: { greater_than_or_equal_to: 0 }

  def subtotal
    (quantity || 0) * (unit_price || 0)
  end
end
