class Lineitem < ApplicationRecord
  belongs_to :user
  belongs_to :order
  #belongs_to :Cart
  #belongs_to :product
end
