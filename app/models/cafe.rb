class Cafe < ApplicationRecord
  # Associations
         
  has_many :cafe_menus
  has_many :orders, dependent: :destroy
  has_many :menus, through: :cafe_menus, dependent: :destroy
  has_one_attached :image
  has_many :menus, dependent: :destroy
  belongs_to :user
  
  # Password encryption (using has_secure_password)
 has_secure_password
  # Validation for email uniqueness
  # validates :email, uniqueness: true
end