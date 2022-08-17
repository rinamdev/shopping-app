class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  has_many :products, dependent: :destroy
  has_many :lineitems
  has_many :orders 
  has_one_attached :profile_image
  devise :database_authenticatable, :registerable,:recoverable, :rememberable, :validatable
end
