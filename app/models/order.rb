class Order < ApplicationRecord
  belongs_to :user
  has_many :lineitems

  enum :status, [:cart, :payment, :delivery, :shipped, :canceled]
end
