class Reservation < ApplicationRecord

  belongs_to :guest, inverse_of: :reservations

  validates :code, presence: true
  validates :start_date, presence: true, comparison: { less_than: :end_date }
  validates :end_date, presence: true
  validates :nights, presence: true, numericality: { only_integer: true, greater_than: 0 }
  validates :guests, presence: true, numericality: { only_integer: true, greater_than: 0 }
  validates :children, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :adults, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :infants, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :status, presence: true
  validates :security_price, presence: true, numericality: true
  validates :payout_price, presence: true, numericality: true
  validates :total_price, presence: true, numericality: true
  validates :currency, presence: true, inclusion: { in: %w(AUD USD GBP PHP) }

end
