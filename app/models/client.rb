class Client < ApplicationRecord
  belongs_to :user
  has_many :invoices, dependent: :restrict_with_error

  validates :name, presence: true

  scope :ordered, -> { order(id: :desc) }

  scope :search, ->(q) {
    where("name LIKE :q OR country LIKE :q OR email LIKE :q", q: "%#{q}%") if q.present?
  }

  def display_name
    "#{name} (#{country})"
  end
end
