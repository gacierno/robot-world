class ChangeOrder < ApplicationRecord
  belongs_to :order

  scope :from_yesterday, -> { where( "DATE(created_at) = ?", Date.yesterday ) }
end
