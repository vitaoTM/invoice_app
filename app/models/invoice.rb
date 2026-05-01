class Invoice < ApplicationRecord
  belongs_to :client
  belongs_to :user
  has_many :line_items, -> { order(:position) }, dependent: :destroy, inverse_of: :invoice

  # This is the key line — it lets the invoice form manage line items
  # as nested fields. `allow_destroy: true` lets us remove rows.
  accepts_nested_attributes_for :line_items, allow_destroy: true,
    reject_if: proc { |attrs| attrs["description"].blank? && attrs["unit_price"].blank? }

  validates :invoice_number, presence: true, uniqueness: { scope: :user_id }
  validates :invoice_date, presence: true
  validates :status, inclusion: { in: %w[draft sent paid cancelled] }

  before_validation :assign_invoice_number, on: :create

  scope :by_status, ->(status) { where(status: status) if status.present? }
  scope :recent_first, -> { order(invoice_date: :desc, created_at: :desc) }

  STATUSES = %w[draft sent paid cancelled].freeze

  def subtotal
    line_items.sum { |li| li.subtotal }
  end

  def total
    subtotal + (tax_amount || 0)
  end

  def status_badge_class
    case status
    when "draft"     then "bg-slate-100 text-slate-700 border-slate-200"
    when "sent"      then "bg-blue-50 text-blue-700 border-blue-200"
    when "paid"      then "bg-emerald-50 text-emerald-700 border-emerald-200"
    when "cancelled" then "bg-rose-50 text-rose-700 border-rose-200"
    end
  end

  private

  # Auto-generates invoice numbers like INV-2026-001, INV-2026-002, etc.
  def assign_invoice_number
    return if invoice_number.present?

    year = (invoice_date || Date.current).year
    last = Invoice.where(user: user).where("invoice_number LIKE ?", "INV-#{year}-%").order(:invoice_number).last
    seq = last ? last.invoice_number.split("-").last.to_i + 1 : 1
    self.invoice_number = "INV-#{year}-#{seq.to_s.rjust(3, '0')}"
  end
end
