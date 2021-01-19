class Reservation < ApplicationRecord
  belongs_to :car

  scope :pending, -> { where( delivered:false ) }
end
