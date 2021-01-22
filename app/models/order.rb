class Order < ApplicationRecord
  belongs_to :car

  scope :from_yesterday, -> { where( "DATE(created_at) = ?", Date.yesterday ) }
end
