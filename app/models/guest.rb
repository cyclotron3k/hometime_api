class Guest < ApplicationRecord
  has_many :reservations, inverse_of: :guest
  has_many :phone_numbers, inverse_of: :guest

  validates :email, presence: true, uniqueness: { case_sensitive: false }
end
